---
applyTo: "lib/features/**"
---

---

# PassPal Feature-Layer Rules

## 0. Scope & Philosophy

* **Feature-first, vertical slices.** Each folder owns its own `data → domain → application → presentation` stack.
* **Depend on `core/*`, never the reverse.** No feature may import another feature. Circular deps forbidden.
* Follow Clean Architecture; treat **domain** layer as framework-free and pure.

## 1. Standard Directory Skeleton

```
lib/features/<feature>/
 ├─ data/            # remote/local sources, DTOs, repository impls
 ├─ domain/          # entities, value objects, use-cases
 ├─ application/     # Riverpod providers, services, Notifiers
 └─ presentation/    # pages, widgets, navigation helpers
```

*Sub-features go in a nested folder that repeats the same 4 layers.*
*Always add `*_test.dart` in the same layer you test.*

## 2. Dependency & DI Rules

* **Riverpod only.** Provide everything via Providers placed in `application/`.
* To access platform services, pull them from the corresponding `core` provider:

| Need                   | Provider                                                                  | Notes                           |
| ---------------------- | ------------------------------------------------------------------------- | ------------------------------- |
| HTTP client            | `networkClientProvider(NetworkTarget.xxx)`                                | Never build Dio by hand.        |
| Secure / cache / prefs | `credentialStorageProvider`, `keyValueCacheProvider`, `userPrefsProvider` | Respect TTLs.                   |
| Config                 | `configServiceProvider` or `configStreamProvider`                         | Remote Config > .env.           |
| Auth                   | `authFacadeProvider`, `authStateProvider`                                 | Don’t hold cookies locally.     |
| Background             | `backgroundSchedulerProvider`                                             | Register unique IDs.            |
| Theme                  | `Theme.of(context).extension<PasspalThemeExt>()`                          | No ad-hoc colors.               |
| Routing                | `goRouterProvider`                                                        | Use helpers in `core/routing`.  |
| Errors                 | throw `AppException`; surface via `errorNotifierProvider`.                |                                 |

## 3. Coding Conventions

1. **Freezed + json\_serializable** for every DTO/entity.
2. **UseCases** are pure; return plain data, not Widgets or Dio.
3. Every Riverpod Notifier must expose **immutable state** (Freezed/Sealed).
4. Presentational Widgets get data **only** through consumers / hooks.
5. For background work, wrap your async function in a `BackgroundTask` and register via `registerUnique()`; honour platform constraints and retry policy.&#x20;
6. Emit domain-level exceptions upward; don’t `try/catch` and swallow. Core error layer will map & display.&#x20;
7. All hard-coded strings belong in `l10n`. All numbers that imply design belong in `core/theme/tokens`.

## 4. Routing Rules

* Never instantiate `GoRouter`; call `ref.read(goRouterProvider)…`.
* **Deep links**: parse URI in `core/routing` then navigate.
* When pushing, use the typed helper extension in your feature (e.g. `pushAssignmentDetail`).
* Guards (Force-Update → Maintenance → Auth → Setup) are already enforced globally; don’t duplicate.&#x20;

## 5. Storage & Caching

* Respect entity TTLs defined in ADR-0002; stale-while-revalidate pattern is mandatory.&#x20;
* Key namespace:

  * Cache → `cache.<feature>.<entity>`
  * Prefs → `pref.<feature>.<key>`
* Never store credentials or cookies outside `CredentialStorage`.

## 6. Network

* Choose `NetworkTarget` that matches the portal or `palapi`; call paths only (`/foo/bar`), never host.
* Retry logic, connectivity, maintenance detection, logging are already in interceptors—don’t reinvent.&#x20;
* Map any unexpected `DioException` via `NetworkErrorMapper.mapDioException` then `rethrow`.

## 7. Config & Feature Flags

* Wrap every experimental branch behind a `FeatureFlags` bool obtained from `configStreamProvider`. **Never** reference Remote Config directly.&#x20;
* Provide safe fallback UI for `false`.

## 8. Background Tasks

* Name pattern: `<feature>.<verb>`, e.g. `assignments.sync`.
* Supply `TaskConstraints(networkRequired: true)` when hitting network.
* Honour exponential backoff table in ADR-0007.&#x20;

## 9. Error Handling

* Throw subclasses of `AppException`.
* Show user-visible errors only through `ErrorOverlay`; background tasks just log to Crashlytics and decide retry/fail as per table in ADR-0001.&#x20;

## 10. Tests

| Layer        | Must test                | Typical tools                        |
| ------------ | ------------------------ | ------------------------------------ |
| domain       | pure logic, validation   | `test`, `freezed_test`               |
| application  | providers, Notifiers     | `riverpod_test`, mock core providers |
| presentation | Golden & widget behavior | `flutter_test`, golden\_toolkit      |
| background   | handler + retry policy   | `workmanager_test`, fake scheduler   |

## 11. ADR & Docs

* Each feature that introduces a significant architectural choice must add an ADR in `docs/adr/` using MADR format and include a **feature-side usage example**.&#x20;
* Title pattern: `xxxx-<feature>-<topic>.md`, incremental number.

Add the following block **verbatim** at the end of `instructions.md`.

## 12. Portal-Data Transformation & Test Fixtures

* **Source formats**: the university portals return either raw **HTML** or **JSON**.
* **Fixtures path**: every canonical response is stored under **`/test/fixtures/data/`**.
* **Request catalog**: consult **`/test/fixtures/data/_list.csv`** to know which fixture to load.

  * Columns are **`title,file_name,url,method,content_type,payload`** — one HTTP request per line.
* **Usage rule**:

  1. In unit tests, pick the matching `file_name` from the CSV and read it from the same folder.
  2. Never hit the real portal in tests; always deserialize the fixture, then pipe it through the feature’s **parser/mapper** to get a domain entity.
  3. Keep parsers pure and deterministic; snapshot-test them against the fixture so CI detects markup breaks.
* **Naming**: parser files live in `data/parsers/`, suffixed `*_parser.dart`; their output DTOs must live in `data/dto/`.
* **Fallback**: if HTML parsing fails at runtime, follow ADR-0006 rule 2 → extract the title via RegExp and open the task in WebView.

---

### Quick Example – creating **assignments** feature

```bash
mkdir -p lib/features/assignments/{data,domain,application,presentation}
```

* `data/assignments_remote_ds.dart` – fetch via `networkClientProvider(NetworkTarget.albo)`.
* `domain/assignment.dart` – Freezed entity.
* `application/assignments_notifier.dart` – Riverpod `AsyncNotifier`.
* `presentation/assignment_list_page.dart` – uses Consumer & navigation helper.
* Register BG task `assignments.sync` to refresh every 6 h respecting TTL 1 h.

---

Follow these rules strictly; Copilot code that violates them should be rejected in review.
