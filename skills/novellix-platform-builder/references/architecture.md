# Architecture Baseline

## System Shape

Use one authoritative domain API with separate consumer and operator clients:

```text
Web / iOS / Android ----\
                         -> Domain API -> MySQL
Admin ------------------/        |
                                 +-> object storage / media / payment adapters
```

The API owns authentication, permissions, content publication, progress, entitlements, balances, orders, transactions, and third-party callbacks. Clients own presentation, navigation, local preferences, and temporary UI state.

## Repository Shape

```text
project/
|-- server/
|   |-- src/modules/         domain-oriented routes/services/repositories/schemas
|   `-- prisma/              schema, migrations, development seed
|-- admin/
|   |-- src/app/             routes
|   |-- src/components/      operational UI
|   `-- src/lib/             API client, auth, locale, generated types
|-- app/
|   |-- app/                 Expo Router screens
|   |-- src/components/
|   |-- src/services/        API and platform adapters
|   |-- src/store/           client state
|   `-- assets/              app-owned brand resources
|-- design-system/
|   |-- tokens.json          theme source of truth
|   `-- generated/           CSS and React Native adapters
|-- deploy/nginx/
|-- docs/
`-- docker-compose.prod.yml
```

An existing repository may use different folders. Preserve local conventions while retaining the boundaries.

## Dependency Direction

```text
screen/page -> use case or store -> typed API client -> HTTP
HTTP -> route/controller -> service -> repository/Prisma -> MySQL
```

- Pages do not construct production base URLs.
- Stores do not reproduce server authorization or pricing rules.
- Routes stay thin once rules are reused, transactional, or integrated with external systems.
- Database access remains behind the server.
- Admin and consumer clients share generated contracts, not runtime imports.

## Recommended Server Module

```text
src/modules/series/
|-- series.router.ts
|-- series.service.ts
|-- series.repository.ts
|-- series.schema.ts
|-- series.types.ts
`-- series.test.ts
```

Use schema validation at the HTTP boundary. Services express use cases and transaction boundaries. Repositories encapsulate nontrivial persistence queries. Small modules may omit a repository if direct Prisma use remains clear.

## Cross-Platform Client

Expo Router is the default consumer shell:

- Web uses React Native Web and browser storage adapters.
- iOS/Android use SecureStore for credentials and native-safe media/navigation primitives.
- Put platform differences in adapters rather than scattering `Platform.OS` throughout screens.
- Keep fixed-format media stable with aspect ratios and constrained sizes.
- Use a dedicated Next.js consumer web app instead when SEO, server rendering, desktop workflows, or web-specific performance dominates reuse.

## API Conventions

- Base path: `/api`; introduce `/api/v2` for breaking contracts.
- Bearer access token or secure HttpOnly session, according to client.
- ISO 8601 UTC timestamps.
- Opaque string IDs.
- Lists have bounded pagination and explicit sort/filter parameters.
- Errors include stable `code`, localized UI maps the code, and `message` is diagnostic rather than control flow.
- Generate client types from OpenAPI or another single contract.
- Native releases require additive responses and server compatibility with existing app versions.

Example envelope:

```json
{
  "success": false,
  "error": {
    "code": "EPISODE_LOCKED",
    "message": "Episode requires an entitlement",
    "details": { "priceCoins": 10 }
  },
  "requestId": "req_..."
}
```

## Data Rules

- Use database uniqueness for business identities such as `(seriesId, episodeNumber)` and `(userId, contentId)`.
- Cascade only when deletion semantics are intentional; preserve financial and audit records.
- Store money in integer minor units with a currency.
- Model entitlements explicitly rather than inferring them solely from a transaction description.
- Counters are derived caches; define how they are updated, deduplicated, and repaired.
- Migrations follow expand, backfill, switch, contract for live systems.

## Production Topology

The simple default is Docker Compose on one host:

```text
Nginx :443
  api.domain -> 127.0.0.1:3101 -> api:3002
  admin.domain -> 127.0.0.1:3102 -> admin:3003
  app.domain -> 127.0.0.1:3103 -> web:80
api -> db:3306
```

Only Nginx exposes public ports. MySQL stays on the internal network and persists to a named volume. Scale beyond this topology only when availability, traffic, organizational, or workload evidence requires it.

## Architecture Decisions

- Prefer a modular monolith before microservices.
- Prefer one API over duplicated backend-for-client rules until client needs genuinely diverge.
- Prefer a dedicated Admin because operator density and release cadence differ from consumer UX.
- Prefer managed media/payment providers over custom transcoding or payment logic.
- Prefer explicit adapters around providers so domain services are not coupled to one vendor.
