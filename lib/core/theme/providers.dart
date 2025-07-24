/// Theme Core Module - Unified Provider Exports
///
/// This file provides a single entry point for all theme-related providers,
/// extensions, and utilities used throughout the PassPal application.
///
/// ## Usage
///
/// Import this file to access all theme functionality:
/// ```dart
/// import 'package:passpal/core/theme/providers.dart';
///
/// class MyWidget extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final theme = ref.watch(currentThemeDataProvider);
///     final spacing = ref.watch(spacingProvider);
///
///     return Container(
///       padding: spacing.all.md,
///       child: Text('Hello'),
///     );
///   }
/// }
/// ```
library;

// Core Theme Providers
export 'providers/theme_providers.dart';
export 'providers/theme_mode_provider.dart';
export 'providers/accessibility_providers.dart';

// Theme Extensions
export 'extensions/status_colors.dart';
export 'extensions/spacing_tokens.dart';
export 'extensions/radius_tokens.dart';
export 'extensions/elevation_tokens.dart';
export 'extensions/motion_tokens.dart';

// Theme Builders & Generators
export 'builders/theme_builder.dart';
export 'generators/color_scheme_generator.dart';
export 'generators/typography_generator.dart';

// Theme Models & Interfaces
export 'models/color_tokens.dart' hide StatusColors;
export 'models/typography_tokens.dart';
export 'models/spacing_tokens.dart';
export 'models/radius_tokens.dart';
export 'models/elevation_tokens.dart';
export 'models/motion_tokens.dart';

export 'interfaces/interfaces.dart';
export 'interfaces/status_colors_extension.dart';
export 'interfaces/spacing_extension.dart';
export 'interfaces/radius_extension.dart';
export 'interfaces/elevation_extension.dart';
export 'interfaces/motion_extension.dart';

// Testing Utilities (conditional export for testing environment)
// Note: These are only available when running tests
// export '../../../test/core/theme/mocks/theme_test_utils.dart';
// export '../../../test/core/theme/golden/theme_golden_test.dart';

/// Core Theme Provider Extensions
///
/// Extensions that can be accessed via BuildContext or WidgetRef.
/// All extensions are automatically registered with the main theme data.

/// Status Colors Extension
/// Provides semantic colors for success, warning, error, and info states.
/// Access via: `Theme.of(context).extension<StatusColors>()`
/// Or via provider: `ref.watch(statusColorsProvider)`

/// Spacing Tokens Extension
/// Provides 8px-based spacing system with responsive variants.
/// Access via: `Theme.of(context).extension<SpacingTokensExtension>()`
/// Or via provider: `ref.watch(spacingProvider)`

/// Radius Tokens Extension
/// Provides Material 3 border radius tokens for components.
/// Access via: `Theme.of(context).extension<RadiusTokensExtension>()`
/// Or via provider: `ref.watch(radiusProvider)`

/// Elevation Tokens Extension
/// Provides Material 3 elevation and shadow utilities.
/// Access via: `Theme.of(context).extension<ElevationTokensExtension>()`
/// Or via provider: `ref.watch(elevationProvider)`

/// Motion Tokens Extension
/// Provides animation durations, curves, and accessibility-aware motion.
/// Access via: `Theme.of(context).extension<MotionTokensExtension>()`
/// Or via provider: `ref.watch(motionProvider)`

/// Main Theme Providers Reference
///
/// ## Core Providers
/// - `currentThemeDataProvider`: Current theme data (AsyncValue<ThemeData>)
/// - `lightThemeProvider`: Light theme data
/// - `darkThemeProvider`: Dark theme data
/// - `themeModeProvider`: Theme mode management
/// - `effectiveThemeModeProvider`: Resolved theme mode (system → light/dark)
/// - `isDarkModeProvider`: Dark mode detection (bool)
///
/// ## Extension Providers
/// - `statusColorsProvider`: StatusColors extension
/// - `spacingProvider`: SpacingTokensExtension
/// - `radiusProvider`: RadiusTokensExtension
/// - `elevationProvider`: ElevationTokensExtension
/// - `motionProvider`: MotionTokensExtension
///
/// ## Utility Providers
/// - `systemBrightnessProvider`: System brightness detection
/// - `themeModeDisplayNameProvider`: User-friendly theme mode names
/// - `themeColorSchemeProvider`: Current ColorScheme
/// - `themeTextThemeProvider`: Current TextTheme
/// - `themeBrightnessProvider`: Current brightness
///
/// ## Accessibility Providers
/// - `accessibilitySettingsProvider`: Accessibility settings
/// - `accessibilityAwareThemeProvider`: Accessibility-enhanced theme
/// - `highContrastThemeProvider`: High contrast theme variants
/// - `colorBlindFriendlyThemeProvider`: Color blind friendly themes
/// - `systemHighContrastProvider`: System high contrast detection
/// - `systemReducedMotionProvider`: System reduced motion detection
///
/// ## Performance Notes
///
/// - Theme providers are cached and only recompute when dependencies change
/// - Use specific extension providers instead of full theme data when possible
/// - Theme extensions are lazy-loaded for optimal performance
/// - All providers support dependency injection and testing overrides
///
/// ## Migration Guide
///
/// From direct theme access:
/// ```dart
/// // Old
/// final theme = Theme.of(context);
/// final primaryColor = theme.colorScheme.primary;
///
/// // New
/// final colorScheme = ref.watch(themeColorSchemeProvider);
/// final primaryColor = colorScheme.primary;
/// ```
///
/// From extension access:
/// ```dart
/// // Old
/// final spacing = Theme.of(context).extension<SpacingTokensExtension>()!;
///
/// // New
/// final spacing = ref.watch(spacingProvider);
/// ```
