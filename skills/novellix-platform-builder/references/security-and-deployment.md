# Security and Deployment

## Authentication

- Hash passwords with an established adaptive password hash.
- Validate and normalize login/registration input and rate-limit abuse-sensitive endpoints.
- Prefer short access tokens plus rotating, revocable refresh sessions for native clients.
- Prefer HttpOnly, Secure, SameSite cookies plus CSRF protection for browser Admin sessions.
- Store native credentials in platform secure storage, not AsyncStorage.
- API authorization is mandatory for every protected resource and object identifier.
- Admin should support MFA and auditable role changes before production operation.

Validate required secrets at process startup. Never log passwords, database URLs, tokens, payment secrets, signed playback URLs, or complete authorization headers.

## Payments and Entitlements

- Use a payment-provider adapter and verified server callback/webhook.
- Never grant production value because a client called `purchase` successfully.
- Verify callback signatures, environment, amount, currency, product, user mapping, and replay/idempotency key.
- Persist provider events before processing and make retries safe.
- In one transaction, move order state and grant the explicit entitlement or ledger entry.
- Respect Apple/Google in-app purchase policy for digital content in native apps.
- Store amounts in minor units; retain immutable financial and audit records.

## Media Security

- Store provider credentials only on the server.
- Use short-lived signed upload/playback authorization.
- Validate file type, size, duration, ownership, and processing callbacks.
- Treat DRM, download, watermark, territory, age rating, and licensing as product/legal decisions requiring explicit scope.
- CDN hotlink controls do not replace user entitlement checks.

## Environment Classes

Maintain local, staging, and production. Public client values such as API URLs are build-time configuration; database, JWT, payment, storage, and media keys are server runtime secrets.

Typical server variables:

```text
PORT
DATABASE_URL
ACCESS_TOKEN_SECRET
REFRESH_TOKEN_SECRET
ALLOWED_ORIGINS
MEDIA_PROVIDER_*
PAYMENT_PROVIDER_*
```

Typical public build values:

```text
NEXT_PUBLIC_API_URL
EXPO_PUBLIC_API_URL
```

Never put secrets in public-prefixed variables.

## Docker and Nginx

- Multi-stage images, lockfile installs, non-root runtime where practical.
- API runs migrations with a controlled release step; do not run destructive reset commands in production.
- Bind application ports to loopback on a single host and expose only Nginx 80/443.
- MySQL remains internal and uses an application user, not root.
- Redirect HTTP to HTTPS after ACME challenge handling.
- Forward host, real IP, forwarded-for, and scheme headers.
- Add body limits, proxy timeouts, request IDs, security headers, and rate limits appropriate to uploads and APIs.

## Release and Rollback

- Build immutable images tagged by commit.
- Back up before migrations and test restoration regularly.
- Use additive/compatible migrations so application rollback remains possible.
- Record previous image tags and migration state.
- Verify API health, Admin, Web, and a real authenticated journey after release.
- Collect structured logs, request latency/errors, container/DB metrics, frontend crashes, provider callback failures, and backup freshness.

## Native Release

- API URL, bundle/package ID, scheme, icon, splash, privacy metadata, and version/build number are project-specific.
- Development signing is not production distribution. Use the proper Apple/Google developer programs and store workflows.
- Verify the production API embedded in the final bundle.
- Test cold start, upgrade, session restoration, media, purchases, deep links, dark mode, safe areas, and poor network on real devices.

## Production Gate

Block production when any of these remains:

- Fixed default credentials or prefilled real login forms.
- Simulated payment that grants value.
- Missing authorization or object-level ownership checks.
- Unvalidated public uploads or permanent private media URLs.
- No backup/restore plan.
- Admin actions that lack server endpoints or auditability.
- Fabricated operational metrics presented as real.
- Secrets in source, images, logs, or public build variables.

