---
applyTo: "lib/features/settings/**"
---

> **Purpose**
> Provide Copilot with clear, *feature-local* guidelines so it can scaffold and complete the **Settings** screen family while staying consistent with the core ADRs and the global *feature-first × layered* architecture.

---

#### 1. Folder layout (under `lib/features/settings/`)

| Path                                   | Why / Notes                                                                   |
| -------------------------------------- | ----------------------------------------------------------------------------- |
| `presentation/`                        | UI only. - The feature delegates all heavy logic to existing *core* services. |
|   `pages/settings_page.dart`           | Entry point pushed from `/settings` route.                                    |
|   `widgets/`                           | Re-usable tiles, section headers, dialogs.                                    |
| `application/settings_controller.dart` | A `Notifier` bridging UI ↔ core; contains *no* storage/network code.          |

> No `data/` or `domain/` layer is created here because every action simply calls a core façade (auth, storage, theme, etc.). This keeps the feature lightweight and testable.

---

#### 2. Required actions & how to wire them

| UI tile                     | Call sequence (inside `SettingsController`)                                                                                                                                    | Core contract     |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------- |
| **Show current student ID** | `ref.watch(authStateProvider)` and extract `session.studentId`.                                                                                                                | Core-Auth state   |
| **Logout**                  | `await ref.read(authFacadeProvider).logout()`; then `router.go('/login')`.                                                                                                     | Core-Auth façade  |
| **Force clear cache**       | `await ref.read(cacheServiceProvider).clear(excludeCredentials:true);` then fire a toast. *(CacheService lives in `core/storage`; exclude flag must skip `CredentialStorage`)* |                   |
| **Change campus**           | `await ref.read(userPrefsProvider).setCampus(newCampus);` → pop dialog → `ScaffoldMessenger` toast.                                                                            |                   |
| **Re-fetch timetable**      | `await ref.read(timetableSyncProvider.notifier).refreshNow();` shows loading sheet until `AsyncValue` completes.                                                               |                   |
| **Toggle Dark mode**        | `ref.read(themeModeProvider.notifier).toggle();`                                                                                                                               |                   |
| **Open PassPal homepage**   | Use `url_launcher`: `launchUrl(Uri.parse(kHomepageUrl))`. URL comes from `configServiceProvider.getApiUrl('HOMEPAGE')`                                                         |                   |

*All calls must be wrapped in `guardAsync` (see ADR-0001 error architecture) so every exception surfaces through `errorNotifierProvider` .*

---

#### 3. UX rules

* **Material 3 list style**, one *ListSection* per logical group (“Account”, “Data”, “Appearance”, “About”).
* Every destructive action shows a Cupertino-style confirmation sheet.
* When loading (`AsyncValue.isLoading`), replace the trailing icon with a `SizedBox.square(dimension:24, child:CircularProgressIndicator(strokeWidth:2))`.
* After success, emit a one-shot `Snackbar` via `ScaffoldMessenger` (“Cache cleared”, “Timetable updated” …).
* Follow the global **non-blocking error overlay** pattern (simply call `errorNotifier.show(e)`) .

---

#### 4. State management & DI

```dart
final settingsControllerProvider =
    NotifierProvider<SettingsController, AsyncValue<void>>(SettingsController.new);

class SettingsController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {} // idle

  Future<void> logout() => _runGuarded(
        () => ref.read(authFacadeProvider).logout(),
      );

  Future<void> clearCache() => _runGuarded(
        () => ref.read(cacheServiceProvider).clear(excludeCredentials: true),
      );

  // …more methods
}
```

*Use the private `_runGuarded` helper to forward failures to `errorNotifierProvider`.*

---

#### 5. Testing checklist

1. **Widget test**: tapping each tile triggers the correct `SettingsController` method.
2. **Golden**: Light vs. Dark after toggling theme.
3. **Unit**: `SettingsController.logout` propagates `AuthenticationException` to `errorNotifier`.
4. **Integration**: after “Change campus”, reopening the app shows the updated timetable endpoint (uses `configServiceProvider`).

Mocks: prefer `ProviderContainer(overrides:[authFacadeProvider.overrideWith(mock)])` as shown in ADR-0005 examples .
