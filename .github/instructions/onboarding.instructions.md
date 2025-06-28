---
applyTo: "lib/features/onboarding/**"
---

# PassPal – Onboarding Feature Instructions

> Covers the three‐screen first-run flow
> **Campus → Notification → Start** ( `/setup/campus`, `/setup/notification`, `/setup/start` )

---

## 1. Folder Skeleton

```
lib/features/onboarding/
 ├─ data/
 │   ├─ models/
 │   │   ├─ campus.dart                 # enum Campus { nagoya, toyota }
 │   │   └─ onboarding_status.dart      # Freezed { campus?, notificationsGranted, completed }
 │   ├─ sources/
 │   │   └─ user_prefs_onboarding_ds.dart # read/write via userPrefsProvider
 │   ├─ repository/
 │   │   └─ onboarding_repository_impl.dart
 │   └─ onboarding_data_providers.dart   # Riverpod delegates
 ├─ domain/
 │   ├─ entities/
 │   │   └─ campus.dart  <-- re-export data/models/campus.dart
 │   ├─ value_objects/
 │   │   └─ notification_permission.dart # granted | denied | provisional
 │   ├─ use_cases/
 │   │   ├─ select_campus.dart
 │   │   ├─ request_notification_permission.dart
 │   │   └─ complete_onboarding.dart
 │   └─ onboarding_domain_providers.dart
 ├─ application/
 │   ├─ onboarding_controller.dart     # StateNotifier<OnboardingStatus>
 │   ├─ onboarding_providers.dart      # setupCompletedProvider, etc.
 │   └─ post_onboarding_tasks.dart     # schedules BG sync (period master, timetable)
 └─ presentation/
     ├─ pages/
     │   ├─ campus_page.dart
     │   ├─ notification_page.dart
     │   └─ start_page.dart
     ├─ widgets/
     │   ├─ campus_select_card.dart
     │   └─ permission_explainer_banner.dart
     └─ routing_helpers.dart           # pushCampus(), popToStart() …
```

### Why

* Mirrors the **vertical slice** rule (data → domain → application → presentation).
* Makes the **`setupCompletedProvider`** (Bool) available to **Setup Guard** in core/routing .
* Persists choices via **UserPrefs** layer defined in core/storage .

---

## 2. Dependency Injection

| What you need                                        | Get it from                                      | Notes                                           |
| ---------------------------------------------------- | ------------------------------------------------ | ----------------------------------------------- |
| User settings storage                                | `userPrefsProvider`                              | write `pref.onboarding.*` keys                  |
| Remote feature flags (e.g. enableNotificationScreen) | `configStreamProvider`                           | use fallback “false”                            |
| Theming tokens                                       | `Theme.of(context).extension<PasspalThemeExt>()` | NEVER ad-hoc colors                             |
| Routing                                              | `goRouterProvider`                               | push after successful step                      |
| Background scheduler                                 | `backgroundSchedulerProvider`                    | register `period_master.sync` after completion  |
| Error overlay                                        | `errorNotifierProvider`                          | propagate unexpected failures                   |

---

## 3. Data Layer Rules

* **user\_prefs\_onboarding\_ds.dart**

  ```dart
  class UserPrefsOnboardingDataSource {
    const UserPrefsOnboardingDataSource(this._prefs);
    final UserPrefs _prefs;

    Future<OnboardingStatus> read() async => _prefs.getJson('pref.onboarding')
        ?.let(OnboardingStatus.fromJson) ?? const OnboardingStatus();

    Future<void> save(OnboardingStatus s) =>
        _prefs.setJson('pref.onboarding', s.toJson());
  }
  ```
* TTL/Cache not required—values are definitive.

---

## 4. Domain Layer Rules

* Each **use-case** is pure & returns `Result<void, AppException>`.
* `request_notification_permission.dart` must call `await Permission.notification.request()` (wrapped in a platform abstraction), map OS result → domain enum.
* Throw only `AppException` subclasses so the core/error pipeline stays unified .

---

## 5. Application Layer

```dart
class OnboardingController extends _$OnboardingController {
  @override
  FutureOr<OnboardingStatus> build() async =>
      _repo.readStatus(); // injected repo

  Future<void> selectCampus(Campus c) async =>
      _update((s) => s.copyWith(campus: c));

  Future<void> requestPush() async {
    final granted = await _requestPermission();
    _update((s) => s.copyWith(notificationsGranted: granted));
  }

  Future<void> finish() async {
    _update((s) => s.copyWith(completed: true));
    await _postTasks();        // schedule BG sync etc.
  }

  void _update(OnboardingStatus Function(OnboardingStatus) updater) async {
    final next = updater(state.value!);
    state = AsyncData(next);
    await _repo.saveStatus(next);
  }
}
```

*Expose*

```dart
final setupCompletedProvider =
    Provider<bool>((ref) => ref.watch(onboardingControllerProvider).value?.completed ?? false);
```

> Routing guard already watches this provider .

---

## 6. Presentation Layer

* Use **Material 3** components only; respect spacing/radius tokens .
* Each page is a **ConsumerWidget** loading controller state; show `CircularProgressIndicator()` during first read.
* Auto-advance when current page’s requirement is satisfied.

| Page         | Exit condition                                          | Next Route            |
| ------------ | ------------------------------------------------------- | --------------------- |
| Campus       | `state.campus != null`                                  | `/setup/notification` |
| Notification | `state.notificationsGranted != denied` OR flag disabled | `/setup/start`        |
| Start        | Button tap → `finish()`                                 | `/main` ShellRoute    |

---

## 7. Post-Onboarding Background Tasks

* After `finish()`, register:

  ```dart
  backgroundScheduler.registerUnique(
    BackgroundTask(
      id: 'period_master.sync',
      periodic: const Duration(days: 7),
      constraints: const TaskConstraints(networkRequired: true),
      handler: (ctx) => ctx.read(periodMasterRepositoryProvider).sync(),
    ),
  );
  ```

  Follows ADR-0007 retry/backoff spec .

---

## 8. Testing Checklist

| Layer                         | Must test                                            |
| ----------------------------- | ---------------------------------------------------- |
| **domain**                    | campus selection / permission mapping logic          |
| **application**               | state transitions, setupCompletedProvider            |
| **presentation**              | navigation on success, disabled next-button states   |
| **routing guard integration** | overrides of `setupCompletedProvider` drive redirect |

Use `riverpod_test` with `ProviderContainer(overrides:[userPrefsProvider.overrideWith(...fake...)])`.

---

## 9. Coding Style Quick Rules

1. Freezed everywhere (`part 'xxx.freezed.dart';`)
2. No mutable state outside `Notifier`.
3. No direct `SharedPreferences` calls outside **data/sources**.
4. No navigation strings—use `AppRoute.setupNotification.path`.

---

## 10. Done Criteria

* Route guard no longer redirects authenticated users to `/setup/*`.
* `pref.onboarding.completed == true` stored.
* `BackgroundTask` present and visible in DeveloperMenu debug console (if feature flag on).
* All tests green; golden shots for three pages.

---

👋 **Copilot**—follow this document, plus the global `features/instructions.md`. Any PR that deviates will be blocked in review.
