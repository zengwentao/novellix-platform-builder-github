---
name: novellix-platform-builder
description: "Build or extend branded multi-platform content products using the Novellix architecture and design system: TypeScript API, MySQL, Admin, Expo Web/iOS/Android, Docker, and semantic theme tokens. Use for novel, short-drama, manga, course, audio, membership-content, or similar catalog-and-consumption systems. Do not trigger for isolated UI tweaks or unrelated single-service work unless the user explicitly invokes this skill."
metadata:
  short-description: Build products from the Novellix architecture
---

# Novellix Platform Builder

Build a working product, not an architecture proposal, when the user asks to create or implement a system. Preserve the user's requested domain, brand, scope, deployment target, and existing technology choices.

## Start

1. Inspect the workspace before deciding whether this is a greenfield build, a Novellix-derived project, or an existing application that only needs selected patterns.
2. State the inferred product shape and material assumptions briefly. Ask only when a missing decision would change cost, compliance, external accounts, or the core domain. Reasonable UI, naming, and local-development defaults should not block implementation.
3. For a full product, create a short execution plan that covers domain/data, API, Admin, user client, theme, verification, and deployment. Then implement end to end.
4. Keep external mutations within the user's authorization. Payment accounts, media providers, domains, production deployment, app signing, and store submission require the relevant credentials or explicit scope.

## Choose References

Read only what the task needs, but read each selected reference completely.

- For any full system or major architecture work, read [references/architecture.md](references/architecture.md).
- For frontend, branding, theme creation, Admin, Web, or App UI, read [references/design-system.md](references/design-system.md) and use [assets/design-tokens.json](assets/design-tokens.json) as the theme contract.
- For domain design, especially short drama, novel, manga, course, or audio, read [references/domain-blueprints.md](references/domain-blueprints.md).
- For implementation sequencing, testing, handoff, or project completion, read [references/delivery-playbook.md](references/delivery-playbook.md).
- For production, authentication, payments, media security, Docker, domains, or mobile release, read [references/security-and-deployment.md](references/security-and-deployment.md).

## Default Architecture

Use this baseline for a greenfield multi-platform content product unless the workspace or user requires another stack:

- `server`: Node.js, TypeScript, Express, Prisma, MySQL.
- `admin`: Next.js, React, TypeScript, Tailwind CSS, Lucide icons.
- `app`: Expo, React Native, Expo Router, React Native Web, Zustand, Axios.
- `infra`: Docker Compose, MySQL 8, Nginx, HTTPS.
- One domain API for Admin, Web, iOS, and Android.
- UI supports Chinese and English when requested; business content remains in its stored language unless content translation is explicitly part of the product.

Do not replace an established stack merely to match this baseline. Adapt the architecture principles to the existing codebase.

## Non-Negotiable Boundaries

- Clients never connect directly to MySQL or enforce authoritative entitlement, payment, balance, inventory, or role rules.
- Admin frontend checks improve UX but are not security boundaries; the API enforces Admin permissions.
- Public client environment variables may contain API URLs, never secrets.
- Money uses integer minor units in production. Balance, entitlement, and payment changes use transactions and idempotency keys.
- Uploaded video, audio, and large images belong in object storage/CDN or a media service, not MySQL or the application container.
- A simulated payment flow must be visibly marked development-only and disabled in production.
- Default credentials, prefilled passwords, fabricated production metrics, and UI controls without backing APIs are not acceptable deliverables.
- Native clients remain backward compatible with at least the currently released API contract; use additive migrations and version breaking APIs.

## Product Behavior

For a complete content product, normally include:

- Authentication and session restoration.
- Discover/home, search, category, detail, consumption/player/reader, favorites or shelf, progress, history, profile, and purchase/membership surfaces as required by the domain.
- Admin authentication, dashboard, content lifecycle, user management, orders/entitlements, banners, and operational settings.
- Loading, empty, error, retry, unauthorized, locked, and offline states.
- Real representative media assets or clearly licensed placeholders stored through an intentional asset path.
- Environment examples, seed strategy, migrations, local start commands, production topology, and health checks.

Do not add monetization, social features, gamification, or translation merely because Novellix has them. Include only what matches the user's product.

## Design Contract

- Keep component semantics, hierarchy, spacing, typography roles, interaction states, responsive behavior, and accessibility stable across projects.
- Change brand appearance through semantic color tokens, fonts, icon, splash, favicon, wordmark, and media direction.
- Components reference roles such as `primary`, `surface`, `onSurface`, `secondaryContainer`, and `error`; they do not own raw brand hex values.
- Generate or adapt React Native tokens and CSS variables from one theme source. Do not maintain unrelated palettes by hand.
- The first screen is the usable product, not a marketing landing page. Admin is dense and operational; consumer surfaces may be more expressive.

## Completion Gate

Before handing off a full build:

- Run relevant type checks, lint, tests, database migration checks, and production builds.
- Smoke-test the API and primary authenticated flow.
- Verify frontend screenshots at representative mobile and desktop sizes; verify native startup on a simulator/device when native delivery is in scope.
- Check responsive layout, text overflow, empty/error/loading states, image/media loading, and theme contrast.
- Report what is implemented, what is intentionally mocked, commands/URLs, required credentials, and remaining production blockers.
