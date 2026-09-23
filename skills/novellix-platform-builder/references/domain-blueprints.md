# Domain Blueprints

Choose the blueprint that matches the user's product. Preserve the common architecture while replacing domain language and rules; do not cosmetically rename a novel schema.

## Common Platform Domains

Most products need some subset of:

- Identity: User, Session, Role, DeviceSession.
- Discovery: Category, Tag, Banner, RecommendationSlot.
- Content: the domain-specific container and consumable unit.
- Consumption: progress, history, favorites/library, bookmarks.
- Access: Entitlement, Subscription, Purchase, VirtualCurrencyLedger.
- Operations: publication workflow, moderation, audit, configuration.

Monetization and gamification are optional. Remove them when not requested.

## Short-Drama Blueprint

### Core entities

| Entity | Purpose |
| --- | --- |
| `Series` | Drama title, synopsis, poster, genres, status, publication metadata |
| `Episode` | Ordered playable unit, title, duration, access policy, preview status |
| `MediaAsset` | Provider ID, HLS/DASH URL, poster frame, duration, processing state |
| `SubtitleTrack` | Language, label, WebVTT/SRT resource, default status |
| `CastMember` / `SeriesCast` | Performer metadata and credited role |
| `WatchProgress` | User position, completed state, last watched time |
| `Favorite` | User-series collection |
| `WatchEvent` | Append-only analytics event or queued event reference |
| `Entitlement` | User access to episode, series, plan, or time window |

Recommended uniqueness:

- `Episode(seriesId, number)`.
- `WatchProgress(userId, episodeId)`.
- `Favorite(userId, seriesId)`.
- Idempotent entitlement by user, source type, and source ID.

### Required product surfaces

- Home: featured banner, continue watching, trending, categories.
- Search and category catalog.
- Series detail: poster, synopsis, cast, episode list, access indicators.
- Player: HLS playback, resume, next episode, subtitles, quality, orientation, error recovery.
- Library: favorites, history, downloaded items only if offline DRM is explicitly supported.
- Membership/purchase surface when monetized.
- Admin: series metadata, episode ordering, media processing state, subtitles, publication scheduling, banners, users, orders, analytics.

### Media rules

- Do not store video bytes in MySQL or a repository.
- Use object storage plus CDN and a transcoding pipeline, or a managed VOD provider.
- Production playback should use adaptive bitrate HLS/DASH.
- Private media uses short-lived signed playback authorization; hiding a raw URL in the app is not access control.
- Upload is asynchronous: `UPLOADING -> PROCESSING -> READY | FAILED`.
- The API stores provider identifiers and state, not provider secrets in clients.
- Track playback starts, meaningful progress, completion, buffering, and errors without writing a database row on every second.
- Respect content licensing, age rating, territory, takedown, privacy, and platform in-app purchase rules.

If the user has not chosen a media provider, create a `MediaProvider` interface and a development adapter using public or local sample HLS. Do not claim the development adapter is production delivery.

## Novel Blueprint

- `Book` -> `Chapter`.
- `UserBook`, `ReadProgress`, `Bookmark`, `ReadHistory`.
- Chapter content may use long text for MVP; large content can move to object storage or a content service.
- Reader settings are local preferences; entitlement remains server authoritative.
- UI can be bilingual while novel content remains in its original stored language.

## Manga / Comic Blueprint

- `Series` -> `Chapter` -> ordered `PageAsset`.
- Page assets live in object storage/CDN, never database blobs.
- Preserve dimensions for stable layout and prefetch the next limited page range.
- Support reading direction, long-strip versus paged mode, chapter entitlement, and image anti-hotlink controls.

## Course Blueprint

- `Course` -> `Module` -> `Lesson`.
- `Enrollment`, `LessonProgress`, `Assessment`, `Submission`, `Certificate` as required.
- Video rules follow the short-drama media blueprint.
- Separate completion from watch position; define prerequisites and instructor/admin roles.

## Audio Blueprint

- `Show` or `Book` -> `Track` / `Episode`.
- `AudioAsset`, transcript, chapter markers, playback progress, queue, speed preference.
- Use streaming/CDN and signed URLs for private audio.

## Domain Mapping Procedure

Before coding:

1. Identify the catalog container, ordered consumable unit, media/content asset, user progress, collection, and entitlement.
2. Define publication states and who may transition them.
3. Define free, paid, subscribed, territorial, and time-limited access.
4. Define which events require strong transactions and which may be asynchronous analytics.
5. Map user and Admin journeys to entities and API use cases.
6. Remove Novellix-specific models that have no domain justification.
