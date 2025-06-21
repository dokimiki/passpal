---
applyTo: "lib/core/background/**"
---

# Background Layer – Copilot Instructions

> **Purpose**  Teach GitHub Copilot how to generate cross‑platform background–processing code (WorkManager on Android, BGTaskScheduler on iOS) that fits the **ぱすぱる** architecture.
>
> You’re writing _developer prompts_ for Copilot, not production code. Keep sentences imperative, mention desired API shape, and always remind Copilot to write tests first.

---

## 1. Scope & Responsibilities

-   **Schedule & execute** periodic and one‑off tasks for: timetable refresh (24 h), campus‑timeblock sync (7 d), cache sweep, fallback polling when FCM fails.
-   **Handle push** via FCM `onBackgroundMessage` isolate (Android) & native callback (iOS/macOS). FCM must _update local Isar DB_ then trigger Riverpod providers.
-   **Respect platform constraints**: Doze/Standby buckets on Android  and iOS opportunistic windows for `BGAppRefreshTask`.
-   **Expose a single Dart façade** (`BackgroundScheduler`) so upper layers never import `workmanager` or `background_fetch` directly.

---

## 2. Folder & File Anatomy

```
features/background/
 ├─ data/
 │   ├─ datasources/
 │   │   ├─ workmanager_adapter.dart   // Android
 │   │   └─ bg_task_adapter.dart       // iOS
 │   └─ models/background_task_dto.dart
 ├─ domain/
 │   ├─ entities/background_task.dart
 │   └─ repositories/background_repo.dart
 ├─ application/
 │   └─ provider/background_scheduler.dart   // @riverpod
 ├─ presentation/      // none (headless)
 └─ test/
     ├─ background_scheduler_test.dart
     └─ fake_workmanager.dart
```

_Place this tree at the top of every Copilot prompt so it knows where to write files._

---

## 3. Scheduler API Contract

```dart
/// Schedules a periodic sync. Returns true if OS accepted the request.
Future<bool> schedulePeriodic(
  {@Duration required NetworkType network = NetworkType.connected,
   required Duration frequency,
   @visibleForTesting String tag = 'timetableSync'})
```

-   Have Copilot include method overloads for one‑off tasks & immediate reschedule.
-   Return a boolean for easier integration tests; _never_ swallow exceptions.

---

## 4. Android – WorkManager Guidelines

1. Use `workmanager`≥0.5.1 with `ExistingWorkPolicy.replace`.
2. Pass input data _only_ via JSON map to avoid type issues on background isolates .
3. Set `BackoffPolicy.EXPONENTIAL` and initial delay 30 s (override with env var)
4. Apply constraints: battery‐not‐low, network‑connected, storage‑not‑low .
5. Use `WorkManager.cancelUniqueWork(tag)` before re‑registering to prevent duplicates.

---

## 5. iOS – BGTaskScheduler Guidelines

1. Register identifiers in `Info.plist` and `application(_:didFinishLaunchingWithOptions:)` .
2. Prefer `BGAppRefreshTask` (15 min–6 h) for lightweight sync; fall back to `BGProcessingTask` for heavy I/O .
3. Flutter side: call `flutter_workmanager` ← Copilot must add `ios/NSTaskSchedulerPermittedIdentifier`.
4. Respect iOS _earliestBeginDate_; don’t hard‑code exact intervals .

---

## 6. Riverpod Integration

-   Wrap the scheduler in a `Provider<BackgroundScheduler>` so tests can inject fakes .
-   Expose a `Stream<void>` notifier that UI widgets can listen to for immediate refresh.

---

## 7. Stale‑While‑Revalidate Workflow

1. Show cached data instantly from Isar.
2. Kick `BackgroundScheduler.syncNow()` if cache _older_ than TTL.
3. When sync completes, emit Riverpod state → UI rebuilds.

This mirrors HTTP’s `stale‑while‑revalidate` semantics

---

## 8. Testing & CI

-   Unit‑test adapters with fake channels; simulate success/failure & verify exponential back‑off.
-   Use `adb shell cmd jobscheduler run` + Xcode BGTask debug menu in integration tests.
-   Create Golden test ensuring timetable stays fresh after 24 h simulated time advance.

---

## 9. Copilot Prompt Examples

> **🎯 Goal:** Generate WorkManager adapter implementing `BackgroundTaskDataSource` above.
>
> ```text
> // 📄 features/background/data/datasources/workmanager_adapter.dart
> // Copilot: Create a singleton class WorkmanagerAdapter that
> // ① registers callers in main(); ② schedules periodic tasks with
> //    EXPONENTIAL back‑off; ③ parses JSON payload; ④ logs errors with
> //    FirebaseCrashlytics. Include thorough DartDoc and unit tests.
> ```
>
> _Always finish the prompt with “Write tests first, then the implementation.”_

Repeat similar prompts for `bg_task_adapter.dart`, fake adapters and provider.

---

### 10. Style Rules Recap

-   **Null‑safety** (`late` only where absolutely required).
-   **Avoid platform channel boilerplate** – rely on plugins.
-   **No UI code** in background layer.
-   **Prefer `Logger()` package** over `print`.
-   Always add `@visibleForTesting` for helpers.
-   Follow _Effective Dart_ & project‑wide `analysis_options.yaml`.
