---
applyTo: "**"
---

## 0 – Purpose

`passpal` wraps the MaNaBo / ALBO / Cubics portals for Chukyo University and enriches them with native features (push notifications, timetable widgets, etc.).

The document defines _project-wide_ rules only; each feature has its own spec.

Follow **Clean Architecture + feature-first folders** so every slice owns its **data → domain → application → presentation** stack.

---

## 1 – Top-Level Layout

```
lib/
 ├─ core/           # shared infrastructure (no feature logic)
 └─ features/
     └─ <feature>/  # e.g. timetable/, assignments/, …
         ├─ data/
         ├─ domain/
         ├─ application/
         └─ presentation/

```

_Only_ downstream dependencies are allowed (data→domain→application→presentation).

`core/` must stay Flutter-agnostic where feasible (pure Dart utilities).

---

## 2 – Cross-Cutting Conventions

| Topic              | Rule                                                                                            |
| ------------------ | ----------------------------------------------------------------------------------------------- |
| **State Mgmt**     | Use **Riverpod 2+ Notifier / AsyncNotifier**; no `setState`, no `provider` package.             |
| **DI**             | Always inject via Riverpod `ProviderScope` / `ProviderContainer` with `overrideWith…` in tests. |
| **Naming**         | file =`snake_case.dart`; class =`PascalCase`; provider =`<Noun>Provider`.                       |
| **Immutables**     | Generate models with **freezed**, including sealed unions, `copyWith`, and json helpers.        |
| **Secure Storage** | Persist credentials with `flutter_secure_storage` (AES-256).                                    |
| **Code gen**       | Run `dart run build_runner watch --delete-conflicting-outputs`.                                 |
| **Tests first**    | Write the failing test _before_ production code.                                                |
| **ADR**            | Record every architectural decision using **MADR** under `docs/adr/NNNN-*.md`.                  |
| **Dependencies**   | Add via `flutter pub add`; never hand-edit `pubspec.yaml`.                                      |

---

## 3 – Layer Guidelines

### 3.1 Data Layer

-   **Responsibility:** Fetch, cache, and map raw portal/REST/HTML data into DTOs.
-   **Structure:**
    -   `fetch/` – dio wrappers, WorkManager callbacks.
    -   `parse/` – HTML or JSON → DTO (`.g.dart`).
    -   `repository/` – exposes typed methods for domain.
-   **Rules:**
    -   Wrap all HTTP with **dio Interceptors**; retry once on `401`, surface custom `NetworkException`.
    -   Handle portal 503 maintenance windows gracefully.
    -   Store long-lived caches in **sqflite**; adopt “stale-while-revalidate”.
    -   Provide test fixtures under `test/fixtures/html/`.

### 3.2 Domain Layer

-   **Pure Dart** – zero Flutter imports.
-   **Entities / ValueObjects** model university concepts (Assignment, Period).
-   **Use Cases** expose single business verbs; return plain values or `Either<Failure,T>`.

### 3.3 Application Layer

-   **Co-ordinates use-cases** and converts them to UI-friendly state.
-   Use Riverpod `AsyncNotifier`, exposing `AsyncValue<State>`.
-   Schedule background sync via **WorkManager** (Android) or **BGAppRefreshTask** (iOS).
-   React to FCM in `firebaseMessagingBackgroundHandler`.

### 3.4 Presentation Layer

-   **Flutter UI only**; no business logic.
-   Theme derived from `core/theme/`, supports light/dark.
-   Navigation through a single **GoRouter** instance inside `core/routing/`.
-   Display errors using the shared overlay component; never leave spinners indefinitely.

---

## 4 – Core Services

| Service         | Responsibilities                                                                          |
| --------------- | ----------------------------------------------------------------------------------------- |
| **network/**    | Dio setup, base URLs, cookie refresh.                                                     |
| **auth/**       | SSO login, token refresh, Google account linkage.                                         |
| **background/** | Register periodic / one-shot tasks; respect Android **Doze** and cancel on app uninstall. |
| **error/**      | Centralized `FlutterError.onError`, Crashlytics forwarding, Remote Config kill-switch.    |
| **storage/**    | `sqflite` + `flutter_secure_storage` wrappers.                                            |
| **routing/**    | Declarative routes + deep links; guarded sub-trees for auth.                              |
| **theme/**      | ColorScheme, radius, text scale.                                                          |

---

## 5 – Testing Strategy

1. **Unit tests** for each layer (fast, no platform I/O).
2. **Widget tests** for interactive UI.
3. **Integration tests** covering login, assignment submission (WebView).
4. CI fails if coverage < 80 %.
5. Simulate background tasks with WorkManager’s test harness.

---

## 6 – Background & Notification Rules

-   Use **FCM → onBackgroundMessage** to trigger local refresh; never poll unless push fails (back-off exponential).
-   iOS widgets refresh via Timeline reload inside the same BG task slot.
-   Android tasks must be `expedited` only when user-visible.
-   Always enqueue with unique names to avoid duplication.

---

## 7 – Error-Resilience Playbook

1. **Network 401:** perform single silent re-login, then replay original request; else bubble `AuthenticationException`.
2. **Parser failure:** fall back to regex scrape, log to Crashlytics with `fatal=false`.
3. **Background job failure:** WorkManager auto-retries with exponential delay.

---

## 8 – Commit Hygiene

-   `dart format .` & `flutter analyze` must pass pre-commit.
-   Each PR includes updated ADR when architecture changes.
-   Keep instruction files lean; prefer linking to in-repo docs instead of inline duplication.
