---
applyTo: "lib/core/theme/**"
---

# Theme Component — GitHub Copilot Instructions

> **Audience:** GitHub Copilot (and other code‑gen AIs) assisting developers in `ぱすぱる`.
> **Goal:** Generate maintainable, test‑driven Flutter theming code that fulfils the app’s brand, campus differentiation, accessibility, and runtime‑config requirements.

---

## 1. Architectural Principles

1. **Layered Placement**

    - **Data layer** → persistence & remote‑config fetch (Isar + Firebase Remote Config).
    - **Domain layer** → `ThemeSettings` entity (seed color, brightness, campusId) & `ThemeRepository` interface.
    - **Application layer** → `ThemeController` (Riverpod Notifier) exposes `ThemeData`/`ColorScheme` streams.
    - **Presentation layer** → widgets read the controller via `Consumer`. No widget accesses storage/network directly.

2. **Feature‑first Folder**: `lib/features/theme/…` mirrors the 4 layers.
   Keep all theme code _out of_ other features.
3. **Stateless UI**: Widgets depend only on `Theme.of(context)` or `ThemeController` providers — no mutable fields, no side‑effects.

---

## 2. Design Tokens & Color Generation

| Token             | Source                                                  | Notes                                           |
| ----------------- | ------------------------------------------------------- | ----------------------------------------------- |
| `seedColor`       | Brand color per campus (hard‑coded Map in domain tests) | Used when dynamic color unavailable.            |
| `colorScheme`     | Generated via `ColorScheme.fromSeed()`                  | Must cover both light & dark.                   |
| `extraColors`     | `ThemeExtension<AppColors>`                             | Store tertiary brand, gradients, status colors. |
| `textScaleFactor` | System preference                                       | Respect accessibility.                          |

-   **Dynamic Color (Android 12+)**: Use `dynamic_color` package; gracefully fall back to seed.
-   **Dark Mode**: Provide separate `ColorScheme` seeded from same base; ensure WCAG AA contrast ≥ 4.5.

---

## 3. Public API Surface

```dart
final themeControllerProvider = NotifierProvider<ThemeController, ThemeState>(...
```

### ThemeController

-   Exposes: `ThemeData theme`, `ThemeMode mode`, `Campus currentCampus`.
-   Methods: `setCampus(Campus c)`, `toggleBrightness()`, `load()`, `refreshFromRemote()`.
-   Emits new state only when values change (use `equatable`).

### ThemeRepository

```dart
abstract class ThemeRepository {
  Future<ThemeSettings> fetch();      // Remote Config → Domain
  Future<void> save(ThemeSettings s); // Persist in Isar
}
```

---

## 4. Persistence & Remote Config

-   **Isar Collection** `theme_settings` → single row (id = 0).
-   Remote payload: `{ "seedColor": "#34a853", "campus": "toyota" }`.
-   Update flow: background worker polls weekly; manual pull via Settings.

---

## 5. Riverpod Wiring Example

```dart
final sharedIsar = Provider<Isar>((ref) => Isar.instance);

final themeRepoProvider = Provider<ThemeRepository>((ref) {
  final isar = ref.read(sharedIsar);
  final remote = ref.read(remoteConfigProvider);
  return ThemeRepositoryImpl(isar, remote);
});
```

---

## 6. Testing Guidelines

| Test type       | Focus                                     | Tools                                                |
| --------------- | ----------------------------------------- | ---------------------------------------------------- |
| Unit            | `ColorScheme` generation, repo read/write | `flutter_test`, `mocktail`                           |
| Widget (Golden) | Light/Dark & each campus palette          | `golden_toolkit`, golden files under `test/goldens/` |
| Integration     | Remote‑config fetch & runtime switch      | `integration_test`                                   |

-   Always generate golden images **after** approving visual diff in CI.

---

## 7. Accessibility & UX

-   **Contrast**: Validate all foreground/background pairs with `dart_a11y` matcher.
-   **Motion**: Keep animations subtle; respect "Reduce motion" OS flag.

---

## 8. Don’ts

-   ❌ Hard‑code hex colors inside widgets.
-   ❌ Use `setState` for theming.
-   ❌ Block UI while fetching Remote Config — show non‑blocking banner.

---

## 9. Sample File Tree

```
features/
 └─ theme/
     ├─ data/
     │   ├─ local/theme_local_ds.dart
     │   ├─ remote/theme_remote_ds.dart
     │   └─ repo/theme_repo_impl.dart
     ├─ domain/
     │   ├─ entities/theme_settings.dart
     │   └─ repo/theme_repository.dart
     ├─ application/
     │   └─ controller/theme_controller.dart
     └─ presentation/
         ├─ widgets/theme_switch.dart
         └─ pages/theme_debug_page.dart
```

---

## 10. Reference Snippets

```dart
// Example ThemeExtension
class AppColors extends ThemeExtension<AppColors> { ... }

// Provide ThemeData in MaterialApp
return MaterialApp.router(
  theme: state.theme.light,
  darkTheme: state.theme.dark,
  themeMode: state.mode,
  ...
);
```

Follow these instructions verbatim; add only the boilerplate needed to compile. Keep comments concise and in English unless the business text must be Japanese.
