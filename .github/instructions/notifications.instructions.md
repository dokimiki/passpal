---
applyTo: "lib/features/notifications/**"
---

# Copilot Instructions — **notifications** component (ぱすぱる)

> **What to generate?**
> Complete, idiomatic Flutter/Dart code for _all notification‑related logic_ in the ぱすぱる app. Follow Clean Architecture (data/domain/application/presentation) **inside the `features/notifications/` folder** and integrate seamlessly with Riverpod DI.
>
> **How to think?**
> Assume the rest of the project already follows the guidelines in `general.instructions.md`. Stay consistent with those conventions.

---

## 1. Responsibilities & Scope

-   Handle **remote push** via **Firebase Cloud Messaging (FCM)** for:
    `assignment_added`, `assignment_removed`, "deadline_tomorrow", `system_maintenance` topics.
    Map each FCM data payload to a domain `NotificationEvent` entity.
-   Issue **local notifications** using `flutter_local_notifications` for:
    • Deadline‑1‑day reminders (when the server forgot)
    • On‑device schedule alarms (e.g., "class in 10 min")
    • Token refresh fallback
-   **Permission UX**: call `requestPermission()` after onboarding, show a _non‑blocking_ banner if denied (see UX spec §1‑1).
-   **Settings**: per‑topic enable/disable, quiet hours (22:00–07:00). Persist in Isar DB, expose via `NotificationSettingsProvider`.
-   **Background tasks**:
    • iOS: `BGAppRefreshTask` to sync missed pushes
    • Android: `WorkManager` one‑shot retry with exponential back‑off when FCM fails.
-   **Security**: TLS pinning is **already configured** in `core/network`; just reuse Dio singleton. Never store FCM token unencrypted.

## 2. Folder Layout

```
features/notifications/
 ├─ data/
 │   ├─ datasource/
 │   │   ├─ fcm_remote_datasource.dart
 │   │   └─ local_notification_datasource.dart
 │   ├─ dto/
 │   │   └─ fcm_payload_dto.dart
 │   ├─ repository/
 │   │   └─ notification_repository_impl.dart
 │   └─ mappers/
 ├─ domain/
 │   ├─ entity/notification_event.dart
 │   ├─ repository/notification_repository.dart
 │   └─ usecase/
 │       ├─ register_fcm_token.dart
 │       ├─ schedule_deadline_reminder.dart
 │       └─ fetch_missed_notifications.dart
 ├─ application/
 │   ├─ provider/notification_settings_provider.dart
 │   └─ notifier/notification_notifier.dart
 └─ presentation/
     ├─ widgets/notification_banner.dart
     └─ pages/notification_settings_page.dart
```

## 3. Coding Directives

1. **Null‑safe Dart** (`sdk: ">=3.0.0 <4.0.0"`).
2. Use **Riverpod Generator** (`@riverpod`) for providers where possible.
3. Inject dependencies via constructor + `ref.read()` in providers — _never_ use global singletons beyond Riverpod.
4. All public functions **MUST** have Dart‑doc comments with _Japanese_ summaries and English parameter/return details.
5. Expose **immutable** domain entities; mutate state only inside Notifiers.
6. FCM token lifecycle:

    ```dart
    FirebaseMessaging.instance.onTokenRefresh.listen((t) {
      ref.read(registerFcmTokenUsecaseProvider).call(t);
    });
    ```

7. For local notifications, schedule with _timezone‑aware_ IDs to avoid duplicates (`flutter_local_notifications` + `timezone` packages).
8. Respect **quiet hours**: if a push arrives during quiet hours, enqueue as a local notification for 07:00.
9. **Logging**: use `logger` package; log level ≥WARNING only in production builds.

## 4. Testing Guidelines

-   **Unit tests** (100 % UseCase coverage):
    → Mock `NotificationRepository`, verify `scheduleDeadlineReminder` schedules _exactly one_ notification when `dueDate.difference(now) ≤ 24h`.
-   **Widget tests**: verify `notification_banner.dart` appears when permission is denied.
-   **Integration tests**:
    • Use `firebase_testlab` or `flutter_driver` + mocked FCM.
    • Simulate doze mode and confirm WorkManager retry.
-   Provide **fixtures** (`test/fixtures/fcm_assignment_added.json`) for every FCM payload variant.

## 5. Sample Prompts for Copilot

-   "Generate a Riverpod notifier that wraps `FlutterLocalNotificationsPlugin` and exposes a `Future<void> schedule(DateTime when, NotificationDetails details)` API."
-   "Write a unit test for `registerFcmToken` that mocks Dio and asserts HTTP 200 + token saved to Isar."
-   "Create a BGAppRefreshTask handler that calls `fetchMissedNotificationsUsecase` and reschedules itself."
    _(Include iOS 13+ availability check!)_
-   "Implement presentation banner that slides down with Framer Motion when notification permission == denied."

## 6. Edge Cases & Error Handling

| Case                                       | Expected behaviour                                                                         |
| ------------------------------------------ | ------------------------------------------------------------------------------------------ |
| User disables notifications in OS settings | Show persistent banner, but **do not** re‑prompt system dialog automatically               |
| FCM returns 401 (token expired)            | Call `registerFcmToken` once; if still 401 → log out user as per authentication retry flow |
| Device offline                             | Schedule retry WorkManager (Android) / BGProcessingTask (iOS) with exponential back‑off    |
| Server sends duplicate `assignment_added`  | Deduplicate by `assignmentId` in Isar _before_ raising banner or local notification        |

## 7. Performance Targets

-   End‑to‑end push latency **< 2 s** (FCM arrival → banner rendered) in foreground.
-   Battery impact ≤ **4 %/day** for background tasks (measured via Android Vitals).
    → Use **push first, polling fallback** only when FCM fails **3×**.
