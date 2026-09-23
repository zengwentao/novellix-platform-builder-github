# Cross-Platform Design System

## Intent

Reuse a coherent visual language across consumer Web, iOS/Android, and Admin while allowing each project to establish a distinct brand through a semantic palette, fonts, and media direction.

The baseline character is editorial, calm, content-first, and premium without becoming decorative. Adapt the visual tone to the user's domain; do not force a literary appearance onto a product that needs another character.

## One Theme Source

Use `assets/design-tokens.json` as the contract. A project should have one editable token file and generated or thin adapters for:

- React Native/Expo color and spacing objects.
- CSS custom properties and Tailwind theme aliases.
- Optional chart, overlay, and data-visualization palettes.

Screen and component files must not own brand hex values. Controlled exceptions include media gradients and platform-native transparent overlays, which should still be named tokens when repeated.

## Semantic Color Roles

- `primary`, `primaryContainer`, `onPrimary`, `onPrimaryContainer`: identity, navigation, primary actions, immersive sections.
- `secondary`, `secondaryContainer`, corresponding `on*`: selected, premium, highlight, conversion.
- `background`, `surface`, `surfaceContainer*`, `onSurface*`: page hierarchy and readable content.
- `outline`, `outlineVariant`: necessary boundaries, usually with low opacity.
- `error`, `errorContainer`, corresponding `on*`: destructive and failure states.

Generate a complete light and dark set. Validate text contrast at 4.5:1 for normal text and 3:1 for large text. Do not use color alone to communicate state.

## Typography

Define role families, not per-screen fonts:

- Display/Headline: brand and editorial personality.
- Body/Label: high-legibility workhorse for UI and operations.
- Content Body: domain-appropriate long-form reading or subtitles.
- Mono: IDs, order numbers, technical values.

Use stable tiers rather than viewport-scaled typography. Typical tiers are display 40-56, page title 28-36, section title 20-24, body 15-18, label 11-13. Compact Admin panels and tables use smaller, tighter headings than consumer heroes.

## Layout and Shape

- Base spacing scale: `4, 8, 12, 16, 20, 24, 32, 40, 48, 64`.
- Phone horizontal page padding usually 20-24.
- Stable media dimensions use `aspect-ratio`, constrained tracks, or explicit min/max sizes.
- Use 4-8 radius for compact controls, 8-12 for buttons/inputs/tools, and 8-16 for item cards.
- Pills are reserved for tags, avatars, and segmented state.
- Do not place cards inside cards or turn entire page sections into floating cards.
- Prefer surface shifts and spacing to repeated opaque divider borders.
- Shadows are subtle and reserved for genuinely floating controls or media.

## Consumer Experience

- The first screen is the usable product: discovery catalog, feed, library, or player, not a marketing landing page.
- Brand may be expressive on splash, authentication, featured content, and media details.
- Search, library, reader/player, checkout, and settings prioritize task clarity.
- Keep a hint of following content in media-first first viewports when a hero is used.
- Use real representative posters, covers, stills, or product content. Do not obscure primary content with dark stock-like imagery.

## Admin Experience

- Desktop-first, quiet, dense, and operational.
- Stable sidebar/top bar, scannable tables, compact filters, and clear bulk or destructive actions.
- Cards are acceptable for KPI summaries and repeated entities, not every page section.
- Use tables for comparison; retain horizontal scrolling at narrow widths instead of crushing columns.
- Every visible action needs a real handler, authorization, progress state, result, and error behavior.

## Component Contract

Every reusable control has default, hover/pressed, focus, disabled, loading, error, and where relevant selected states.

| Component | Required behavior |
| --- | --- |
| Primary button | Clear command, semantic primary colors, no layout shift while loading |
| Icon button | Familiar library icon, 44/48 minimum target, tooltip for unfamiliar actions |
| Input | Persistent label, focus ring, inline error; placeholder is not a label |
| Content card | Stable media ratio, bounded title, secondary metadata, predictable action |
| Tabs/segments | Switch views inside one task, never replace global navigation ambiguously |
| Empty state | Explain absence and offer the next valid action |
| Error state | Preserve context and provide retry/recovery |
| Skeleton/loading | Match final dimensions to prevent content shift |
| Modal/drawer | One focused task, keyboard/screen-reader support, clear dismissal |

Use Lucide in Web/Admin and the established native icon library in Expo. Do not hand-draw common symbols.

## Motion

- Fast feedback: ~150ms; normal transition: ~220ms; deliberate reveal: 300-400ms.
- A branded intro may be longer, but cannot delay access unnecessarily.
- Respect reduced-motion settings.
- Cap stagger animations for lists.
- Native splash is static, fast, safely padded, and visually hands off to the first JS screen.

## Responsive and Accessibility Gate

Verify at minimum a small phone, modern phone, tablet or wide consumer Web, and desktop Admin. Check longest localized strings, dynamic counts, missing images, network errors, keyboard navigation, focus visibility, screen-reader names, safe areas, and text resizing.

## Rebrand Procedure

1. Change brand name, seed colors, light/dark semantic roles, and optional font families in the token source.
2. Generate the Expo and CSS adapters.
3. Replace icon, splash, favicon, wordmark, posters/covers/stills direction, and metadata.
4. Run automated contrast checks and screenshot regression.
5. Search for raw colors; map each remaining repeated value to a semantic token.

Do not globally replace hex codes in application source.

