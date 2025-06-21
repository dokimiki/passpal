---
applyTo: "**"
---

### TL;DR

If you only read one section: generate Flutter code following Clean Architecture 4‑layers + feature‑first folders, inject dependencies with Riverpod, write tests first, and prefer null‑safe, idiomatic Dart.

## 1. Project Context

-   This repository implements "ぱすぱる", a Flutter app that wraps university portals (MaNaBo, ALBO) and adds notifications, timetable widgets, etc.
-   Frameworks & libs: Flutter >=3.32, Riverpod v3, Dio, Isar, firebase\_\*, workmanager, flutter_secure_storage, http_certificate_pinning.

## 2. High‑Level Architecture

```
lib/
 ├─ core/              // cross‑cutting modules
 └─ features/
     ├─ timetable/
     │   ├─ data/
     │   ├─ domain/
     │   ├─ application/
     │   └─ presentation/
     ├─ assignments/
     ...
```

-   Layers: **data → domain → application → presentation** (outward deps only).
-   Each feature owns its four layers (feature‑first).

## 3. Coding Conventions

-   File names: snake_case.dart
-   Class names: PascalCase
-   Providers: `<noun>Provider`
-   Use `freezed` for immutable classes & sealed unions.
-   One public class per file.

## 4. Data Layer Rules

1. Wrap remote calls in `Dio` subclass `BaseApiClient` with:

    - `RetryInterceptor` (exponential back‑off, jitter, max 3) for 503 & network errors.
    - Automatic Cookie refresh if last auth > 55 min.

2. Split into `RemoteDataSource`, `LocalDataSource`, and DTO ↔ Entity mappers.
3. Use `Isar` for persistent cache; prefer `putAll` batch writes.

## 5. Domain Layer

-   Pure Dart, no Flutter imports.
-   Entities are value‑based (`==` & `hashCode` overridden).
-   Each `UseCase` is a top‑level function accepting a `ref` or injected repos.

## 6. Application Layer

-   Riverpod `Notifier` or `AsyncNotifier` orchestrates UseCases.
-   Central schedulers:

    -   `workmanager` (Android)
    -   `BGAppRefreshTask` (iOS)

-   All FCM handlers live here.

## 7. Presentation Layer

-   Only UI widgets & routing.
-   Follow Material 3 + Cupertino.
-   Provide fallback error widget with retry button.

## 8. Security Checklist

-   TLS certificate pinning via `http_certificate_pinning`.
-   Store credentials in `flutter_secure_storage` (encrypted).
-   Purge cookies on logout.

## 9. Caching Strategy

-   UI reads from local DB first (Single Source of Truth).
-   Background tasks revalidate stale data (age > TTL) and update DB.
-   Timetable TTL 24h, class‐periods TTL 7 d.

## 10. Testing Policy

-   ALWAYS write tests before production code.
-   Data & parsing tests use fixture HTML under `test/fixtures/html/`.
-   Use `ProviderContainer(overrides: …)` for mocks.

## 11. ADRs

-   ALWAYS write ADRs documents after create / edit code.
-   Store decision records in `docs/adr` using MADR template (`make adr-new` helper).

## 12. Copilot Prompt Tips

-   Start completion at the highest‑level function or class comment.
-   Include TODO markers (`// TODO(copilot): ...`) to steer generation.
-   Ask Copilot for tests first (`/// write tests`).
-   Prefer short snippets; large files in steps.

## 13. File Templates

-   `tool/templates/feature_gen.dart.mdt` contains code skeleton for new features (data/domain/app/presentation).

## 14. Do & Don't

-   **Do**: null‑safety, sealed classes, async/await, log errors.
-   **Don't**: write business logic in UI layer, hard‑code API URLs, ignore test coverage.
