---
applyTo: "lib/features/settings/**"
---

# GitHub Copilot Instructions – **settings** Feature

> **Purpose** → Teach Copilot how to scaffold, extend, and maintain the _settings_ feature module of the “ぱすぱる” Flutter app so that every generated file obeys our Clean Architecture × Feature‑First conventions, Riverpod DI rules, UX guidelines, security policies, and testing strategy.

---

## 0. Quick‑start cheatsheet

| 🏗️ Layer         | Typical file                                        | Code generation cribs              | 1‑liner hint to Copilot                                                             |
| ---------------- | --------------------------------------------------- | ---------------------------------- | ----------------------------------------------------------------------------------- |
| **Domain**       | `entity/app_settings.dart`                          | sealed immutable class + equatable | “Generate an immutable `AppSettings` record with default values and copyWith”       |
|                  | `repository/app_settings_repository.dart`           | abstract repo interface            | “Define read/write methods returning `AppSettings` inside repo interface”           |
| **Data**         | `local/app_settings_data_source.dart`               | reads/writes Isar + SecureStorage  | “Implement persistence with Isar box + `flutter_secure_storage` for sensitive keys” |
|                  | `repository_impl/app_settings_repository_impl.dart` | adapter → Domain                   | “Convert DTO ↔︎ Entity; inject data source through constructor”                     |
| **Application**  | `provider/app_settings_notifier.dart`               | `AsyncNotifier<AppSettings>`       | “Expose state, update methods; debounce disk writes (300 ms)”                       |
| **Presentation** | `pages/settings_page.dart`                          | Adaptive (Material 3 / Cupertino)  | “Build ListView of `SettingTile` instances mapped from providers”                   |
|                  | `widgets/setting_tile.dart`                         | stateless common tile              | “Wrap in `PlatformListTile` util for iOS/Android parity”                            |

Copilot can reuse this table as a lookup when user asks for any settings‑related snippet.

---

## 1. Functional scope

1. **Campus selection** – picker dialog + persisted `campusId` (drives timetable & bus widgets).
2. **Theme** – light / dark / system toggle.
3. **Notifications** – master enable/disable + "+1 day deadline reminders" switch; surfacing runtime permission status.
4. **Background refresh** – frequency slider (15 min – 6 h). Write to `RemoteConfig` when “auto” selected.
5. **Language stub** – only 🇯🇵 now, but keep dropdown ready (`supportedLocales`).
6. **Security** – “Reset stored credentials” destructive action (wipes `flutter_secure_storage`).
7. **About & Licenses** – show `package_info_plus` version & OSS licenses.

_Out of scope_ here: login credentials screen (auth feature), debug flags (developer menu).

---

## 2. Folder layout (feature‑first)

```
lib/
 └─ features/
     └─ settings/
         ├─ data/
         │   ├─ dto/
         │   ├─ local/
         │   └─ repository_impl/
         ├─ domain/
         │   ├─ entity/
         │   ├─ repository/
         │   └─ usecase/
         ├─ application/
         │   └─ provider/
         └─ presentation/
             ├─ pages/
             └─ widgets/
```

Copilot **must** nest all new files beneath this path. Never mingle with other features.

---

## 3. Key API contracts

### 3.1 `AppSettings` entity (domain)

```dart
@immutable
class AppSettings extends Equatable {
  final int campusId;              // 0=Toyota,1=Nagoya,…
  final ThemeMode themeMode;       // light/dark/system
  final bool notificationsEnabled; // master switch (stored)
  final bool deadlineReminder;     // +1 day deadline push
  final Duration bgRefresh;        // 15 min–6 h
  const AppSettings({...});
  // Add copyWith, toJson/fromJson for persistence helpers.
}
```

### 3.2 Repository interface

```dart
abstract interface class AppSettingsRepository {
  Future<AppSettings> fetch();              // read from cache or disk
  Future<void> save(AppSettings value);     // persist & emit stream
  Stream<AppSettings> watch();              // hot stream for provider
}
```

### 3.3 Application provider

Use **Riverpod 3** `AsyncNotifier` (or `Notifier` when sync) pattern:

```dart
final appSettingsProvider = AsyncNotifierProvider<AppSettingsNotifier, AppSettings>(() {
  return AppSettingsNotifier(ref.read);
});
```

The notifier loads via repository on `build`, exposes `updateXxx()` methods that merge copyWith & persist.

### 3.4 Presentation widgets

-   `SettingTile` generalises Label + Subtitle + trailing Switch/Navigation arrow.
-   Use **adaptive_platform_widgets** or a simple `PlatformListTile` util to match iOS style.
-   On Android 13+ & iOS 15+, if notification permission is denied, show a non‑blocking banner with “Enable” button that opens OS settings.

---

## 4. Persistence rules

| Field                                            | Storage                      | Notes            |
| ------------------------------------------------ | ---------------------------- | ---------------- |
| themeMode, campusId, bgRefresh, deadlineReminder | Isar collection `user_prefs` | plain json       |
| notificationsEnabled (source of truth)           | SecureStorage                | avoids tampering |

Load order during splash:

1. SecureStorage → notifications flag
2. Isar → rest
3. Merge → Provider state (stale‑while‑revalidate: disk → later Firebase RemoteConfig overrides defaults).

---

## 5. UX guidelines for Copilot

1. **Material 3 List semantics**: one preference per tile; group with Section header; use `SwitchListTile.adaptive` for toggles.
2. Place destructive actions at bottom; color them `Colors.red`.
3. Follow \[Material Settings pattern] (m1.material.io/patterns/settings.html) for spacing & typography.
4. Adapt to Cupertino using `CupertinoListSection.insetGrouped` when `Platform.isIOS`.
5. When changing a value, `Navigator.pop(context)` after picker then show `SnackBar` “保存しました”.
6. Performance: Wrap large `ListView` with `AutomaticKeepAliveClientMixin` so tab switching keeps scroll.

---

## 6. Testing notes

1. **Unit tests (domain)** – Validate `copyWith`, default values.
2. **Repository tests (data)** – use _in‑memory_ Isar + `MockSecureStorage`.
3. **Provider tests (application)** – `ProviderContainer` override repo with fake; expect emits in order.
4. **Widget tests (presentation)** – Golden tests for dark/light; use `pumpWidgetWithProvider` helper.

Copilot should auto‑scaffold a test when a new class is created (`_test.dart` suffix) and prefer _Arrange‑Act‑Assert_ comments.

---

## 7. Security levers exposed to user

-   **Reset credentials** tile executes `authRepository.logout(…)`; after success navigate to login screen.
-   **Export diagnostic log** (future). For now stub action with TODO.

---

## 8. Internationalization stub

```dart
AppLocalizations.of(context)!.settingsTheme
```

Generate keys inside `intl/arb/`. Copilot: _When you add a new string, also append to both `app_ja.arb` and `app_en.arb`._

---

## 9. How to write prompts to Copilot (meta)

> “Generate an immutable value object for AppSettings with copyWith and proper defaults following equatable.”
> “Inside provider, debounce disk writes by 300 ms using Timer+cancel.”
> “Create SettingsPage with ListView, one tile per enum item, and persist selection.”

Copy these _imperative_, _context‑rich_, _file‑path‑prefixed_ comments at top of each new file so Copilot knows exactly what to emit.

---

## 10. Future‑proof hooks

-   When **Remote Config** pushes new campus list, provider must refresh dropdown items.
-   Add `betaFlags` map inside entity for feature toggles; keep but ignore for now.
