# Delivery Playbook

## Modes

### Greenfield

Create the complete repository shape, theme source, environment examples, migrations, development seed, and local orchestration. Deliver a vertical primary journey before broad secondary features.

### Novellix-derived

Inventory reusable identity, commerce, deployment, locale, and design code. Replace the domain model deliberately. Remove obsolete routes, UI labels, seed data, and fake metrics rather than leaving compatibility debris.

### Existing application

Preserve framework, conventions, and user changes. Import only architecture or design practices that solve the requested problem. Avoid a stack rewrite unless explicitly requested.

## Execution Order

1. **Discover**: repository, package versions, current services, dirty files, environment examples, design assets, and deployment state.
2. **Define**: product parameters, actors, primary journey, domain map, access rules, theme direction, platforms, and external providers.
3. **Foundation**: workspace structure, shared contracts, semantic tokens, configuration validation, database, health endpoint, and local orchestration.
4. **Primary vertical slice**: data migration -> API -> client state -> consumer UI -> Admin operation -> tests.
5. **Secondary slices**: discovery, search, collection, progress, monetization, analytics, settings according to scope.
6. **Hardening**: permissions, idempotency, validation, rate limits, logging, backups, responsive states, accessibility.
7. **Verification**: builds, tests, smoke flows, screenshots, native startup where relevant.
8. **Handoff**: commands, URLs, credentials needed, implemented/mocked boundaries, deployment notes, and remaining blockers.

## Default MVP Scope

For a full content platform, default to:

- Email/password authentication and session restoration.
- Published catalog, home/discovery, search, category, detail.
- Domain consumption screen: reader, player, viewer, or lesson.
- Favorites/library, progress, and recent history.
- Profile and language/theme preferences when requested.
- Admin login, dashboard using real data, content lifecycle, unit ordering, banners, users, and entitlements/orders when monetized.
- Docker local/production topology and API health.

Do not silently include social login, chat, reviews, recommendations, push, offline DRM, or real payments. Add them when requested or necessary and call out external dependencies.

## Vertical Slice Definition of Done

- Database constraints and migration exist.
- HTTP input and output are schema-validated and typed.
- Authorization, transactions, idempotency, and error codes are defined.
- Consumer UI includes loading, empty, success, failure, retry, and locked/unauthorized states.
- Admin can perform required lifecycle operations.
- Tests cover success, invalid input, unauthenticated, unauthorized, and critical concurrent behavior.
- Metrics/log events and operational impact are documented.

## Verification Matrix

| Layer | Minimum verification |
| --- | --- |
| Database | Migration from empty DB; constraint and transaction tests |
| API | Typecheck, unit/integration tests, health and main-flow smoke requests |
| Admin | Lint/build, login/permission checks, CRUD flow, desktop/narrow screenshots |
| Consumer Web | Build, auth/discovery/detail/consumption flow, mobile/desktop screenshots |
| Native | Bundle uses correct API; simulator/device cold start and main flow when in scope |
| Design | Token use, contrast, text overflow, media failure, light/dark, localization |
| Deployment | Compose config, health checks, migration, backup/restore plan, no exposed DB |

Do not declare a provider integration complete with only mocked responses. Distinguish UI simulation, sandbox integration, and production-ready integration.

## Documentation to Leave Behind

- Root README with system map and local commands.
- Architecture overview and domain model.
- API contract or generated OpenAPI.
- Environment variable reference without secrets.
- Design tokens and rebrand instructions.
- Deployment, backup, rollback, and native release notes.
- Current limitations and production readiness checklist.

