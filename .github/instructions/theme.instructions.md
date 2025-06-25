---
applyTo: "lib/core/theme/**"
---

# Theme Layer Instructions (Passpal)

## 1. Purpose

-   **Consistent Branding:** All screens/components must use the same colors, typography, and spacing. Use Flutter `ThemeData` as the single source of truth.
-   **Accessibility:** Meet WCAG 2.2 min-contrast 4.5:1. Support dark mode and high-contrast.
-   **Clean Architecture:** Theme logic in `core/theme` only. No circular dependencies; features depend on core, not vice versa.

## 2. Scope

| Item                          | Included | Excluded                      |
| ----------------------------- | -------- | ----------------------------- |
| Design tokens (color, space…) | Yes      | —                             |
| `ThemeData`/`ColorScheme` gen | Yes      | —                             |
| ThemeMode storage/Riverpod    | Yes      | —                             |
| ErrorOverlay/Snackbar Theme   | Yes      | —                             |
| Image/icon mgmt               | —        | Use `core/assets`             |
| Feature-specific overrides    | —        | Use ThemeExtension in feature |

## 3. Design Tokens

### 3.1 Colors

-   **Seed:** `Brand.primary = #0057D9` (Material3 `ColorScheme.fromSeed`)
-   **Status:** `success`, `warning`, `error`, `info`
-   **Surface:** `surface1-surface5` (Elevation-based)
-   **Text:** `onPrimary`, `onError` (auto-tested for 4.5:1 contrast)

Dynamic color via `dynamic_color` package if enabled by Remote Config; else fallback to seed color.

### 3.2 Spacing/Radius/Motion

-   **Spacing:** `xxs=2`, `xs=4`, `sm=8`, `md=16` (powers of 2)
-   **Radius:** `card=16`, `button=12`, `overlay=28`
-   **Motion:** `fast=150ms`, `normal=250ms`, `slow=400ms` (Material spec)

All values defined as `static const` in `tokens/`, hot-reloadable.

## 4. ThemeData Builder

```dart
// core/theme/builders/app_theme.dart
class AppTheme {
  static ThemeData light(Color seed) => _base(seed, Brightness.light);
  static ThemeData dark(Color seed)  => _base(seed, Brightness.dark);

  static ThemeData _base(Color seed, Brightness bright) {
    final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: bright);
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusTokens.button),
          ),
          padding: EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.sm),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.errorContainer,
        contentTextStyle: TextStyle(color: scheme.onErrorContainer),
      ),
      extensions: const [PasspalThemeExt()],
    );
  }
}
```

-   Use `useMaterial3: true`
-   Global ElevatedButton theme only in ThemeData, not per-widget.
-   Use ThemeExtension (`PasspalThemeExt`) for error/maintenance backgrounds, so ThemeData is not polluted.
-   If dynamic color fails, fallback to `Brand.primary`.

## 5. ThemeMode Provider & Persistence

```dart
final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  late final SharedPreferences _prefs;
  static const _kKey = 'theme_mode';

  @override
  ThemeMode build() {
    _prefs = ref.watch(sharedPrefsProvider);
    final index = _prefs.getInt(_kKey) ?? ThemeMode.system.index;
    return ThemeMode.values[index];
  }
  Future<void> toggle(ThemeMode mode) async {
    state = mode;
    await _prefs.setInt(_kKey, mode.index);
  }
}
```

-   Use `sharedPrefsProvider` from `core/storage`.
-   Switch dynamic color via Remote Config (`dynamic_color_enabled=false` falls back to seed).
-   Riverpod for DI/testing (see Theme Switcher pattern on Medium).

## 6. Error & Routing Integration

| Widget/Screen        | Color Source                    |
| -------------------- | ------------------------------- |
| ErrorOverlay         | `PasspalThemeExt.errorBg`       |
| MaintenancePage      | `PasspalThemeExt.maintenanceBg` |
| SnackBar             | `SnackBarThemeData`             |
| GoRouter Transitions | `colorScheme.background`        |

Core error/routing depend on core/theme only.

## 7. Testing Strategy

| Type        | Details                                                     |
| ----------- | ----------------------------------------------------------- |
| Golden      | Capture Light/Dark/HC; compare via CI                       |
| Contrast    | WidgetTest with `expect(colorContrast(a, b) >= 4.5, true)`  |
| Widget      | Override `themeModeProvider`, check UI changes on toggle    |
| Integration | Use Remote Config to toggle dynamic color, test persistence |

## 8. Directory Structure

```
lib/core/theme/
 ├─ tokens/
 │   ├─ colors.dart
 │   ├─ spacing.dart
 │   ├─ radii.dart
 │   └─ durations.dart
 ├─ builders/app_theme.dart
 ├─ extensions/passpal_theme_ext.dart
 ├─ providers/theme_mode_provider.dart
```

-   Use Freezed for all models, support (de)serialization.

## 9. Usage Example (Feature Layer: Assignments)

```dart
final colors = Theme.of(context).extension<PasspalThemeExt>()!;
return Scaffold(
  backgroundColor: colors.warningBg,
  body: AssignmentListView(),
);
```

-   Features _read_ from `core/theme` only. No color logic inside features.
