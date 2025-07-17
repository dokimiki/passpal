# Theme Implementation Plan

## Purpose & Positioning

* **Brand Consistency:** Faithfully reproduce the PassPal Figma Design System in Flutter. All features must reference the same tokens to minimize UI implementation cost.
* **Accessibility:** Support light/dark/high-contrast themes, meeting at least WCAG 2.2 AA (contrast 4.5:1).
* **Core Isolation:** Complete all ThemeData and design tokens under `core/theme`. Features may **only read**.
* **Extensibility:** Use Material 3’s `ThemeExtension<T>` to expose custom tokens (StatusColor/Spacing) with type safety.

---

## Design Token System — Full Version

### Color

| Category | Token          | Light   | Dark    | Notes               |
| -------- | -------------- | ------- | ------- | ------------------- |
| Primary  | `primary`      | #B1BCD9 | #B1BCD9 | Accent (seed color) |
|          | `primaryLight` | #F0EDFF | #282438 | ≥4.5:1 contrast     |
|          | `primaryDark`  | #8B87BB | #D5D3F5 | ≥3:1 contrast       |
| Status   | `success`      | #69C085 | #8ED2A4 | For banners         |
|          | `warning`      | #F5C842 | #F9D86E | For snackbar        |
|          | `error`        | #E75273 | #FF8FA4 | For ErrorOverlay    |
|          | `info`         | #91C7D4 | #A6D9E3 | For tips            |
| Neutral  | `black`        | #2D2D30 | #F3F3F4 | Text color          |
|          | `gray600`      | #8B8B8B | #B8B8B8 | Label color         |
|          | `gray400`      | #B8B8B8 | #8B8B8B | Border color        |
|          | `gray200`      | #E8E9E9 | #3A3A3D | Card background     |
|          | `white`        | #FFFFFF | #2D2D30 | Surface color       |

### Typography — Inter (Google Fonts)

| Role             | Style   | Size / Weight | Use-case        |
| ---------------- | ------- | ------------- | --------------- |
| `displayLarge`   | H1      | 32px / 700    | Screen title    |
| `headlineMedium` | H2      | 24px / 700    | Section heading |
| `headlineSmall`  | H3      | 20px / 700    | Card heading    |
| `bodyLarge`      | Body    | 16px / 400    | Main text       |
| `bodyMedium`     | Body-SM | 14px / 400    | Caption/label   |

### Spacing — 8px Base Scale

| Token    | px | Use-case         |
| -------- | -- | ---------------- |
| `space1` | 8  | Minimal spacing  |
| `space2` | 16 | Standard padding |
| `space3` | 24 | Card margin      |
| `space4` | 32 | Section margin   |

### Radius / Elevation / Motion

**RadiusTokens**

* `card`: 16px corner radius (card)
* `button`: 12px (button)
* `overlay`: 28px (overlay)

**ElevationTokens**

* `level1`: 1.0 (light shadow)
* `level2`: 3.0 (standard shadow)
* `level3`: 6.0 (modal/drawer shadow)

**MotionTokens**

* `fast`: 150ms (quick animation)
* `normal`: 250ms (standard)
* `slow`: 400ms (slow)

### Iconography

* **Library:** Lucide Icons
* **Official sizes:** 16 / 20 / 24 / 32px
* Button/IconButton: 24px; BottomNavigation: 32px (active), 24px (inactive)

---

## ThemeData Generation — Implementation Policy

1. **ColorScheme Generation**

   * Use `ColorScheme.fromSeed` with `#B1BCD9` as seed.
   * Overwrite scheme with table values for Light/Dark via `copyWith`.
   * Use same `primary` for both, switch `onPrimary` between white/black.
   * Properly set `background` and `surfaceVariant`.

2. **ThemeData Build Function (`buildTheme`)**

   * Accepts Brightness; switches schemes per theme.
   * Enable Material 3 (`useMaterial3: true`).
   * Base typography on `GoogleFonts.interTextTheme()`, customize with table.
   * ElevatedButtonTheme: 12px radius, min 56x40px, fontWeight 600.
   * SnackBarTheme: floating, 16px radius, appropriate text color.
   * Add StatusColors & SpacingTokens as extensions.

### ThemeExtension Implementation Policy

**StatusColors Class**

* Holds success/warning/error/info as immutable fields.
* Static constants for Light/Dark (per table).
* Implements `copyWith`, `lerp`, and ThemeExtension protocol.

### Riverpod Provider Policy

**themeProvider**

* Reads ThemeMode from `preferenceStorageProvider`.
* Decides Brightness per system settings.
* Returns appropriate ThemeData by calling buildTheme.

---

## Interface with Other Core Modules

| Scene                    | Provided Tokens       | Dependency Core     |
| ------------------------ | --------------------- | ------------------- |
| ErrorOverlay/Snackbar    | `StatusColors`        | error               |
| Onboarding: theme change | `ThemeModeProvider`   | storage             |
| Button styles            | `ElevatedButtonTheme` | all features        |
| Spacing constants        | `SpacingTokens`       | layout/presentation |

---

## Testability

* Use `golden_toolkit` for bulk golden tests (Light/Dark/HC).
* Use `colorblind_simulator` for automatic Protanopia/Deuteranopia checks.
* In `flutter_test`, swap `themeProvider` and snapshot feature widgets for color validation.
