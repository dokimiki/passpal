import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../builders/theme_builder.dart';
import '../generators/color_scheme_generator.dart';
import '../extensions/status_colors.dart';
import '../extensions/spacing_tokens.dart';
import '../extensions/radius_tokens.dart';
import '../extensions/elevation_tokens.dart';
import '../extensions/motion_tokens.dart';
import 'theme_mode_provider.dart';

part 'accessibility_providers.g.dart';

/// Color blind simulation type for theme adaptation.
enum ColorBlindType {
  /// No color blindness.
  none,

  /// Protanopia (missing L-cones, red-blind).
  protanopia,

  /// Deuteranopia (missing M-cones, green-blind).
  deuteranopia,

  /// Tritanopia (missing S-cones, blue-blind).
  tritanopia,

  /// Protanomaly (anomalous L-cones).
  protanomaly,

  /// Deuteranomaly (anomalous M-cones).
  deuteranomaly,

  /// Tritanomaly (anomalous S-cones).
  tritanomaly,
}

/// Model for accessibility settings state.
///
/// Holds current accessibility preferences and system-detected
/// accessibility features for theme adaptation.
class AccessibilitySettings {
  const AccessibilitySettings({
    required this.highContrast,
    required this.reduceMotion,
    required this.largeText,
    required this.boldText,
    required this.disableAnimations,
    required this.accessibleNavigation,
    required this.colorBlindType,
  });

  /// Whether high contrast mode is enabled.
  final bool highContrast;

  /// Whether reduced motion is requested.
  final bool reduceMotion;

  /// Whether large text scaling is requested.
  final bool largeText;

  /// Whether bold text is requested.
  final bool boldText;

  /// Whether to disable animations completely.
  final bool disableAnimations;

  /// Whether to use accessible navigation patterns.
  final bool accessibleNavigation;

  /// Color blind simulation type for theme adaptation.
  final ColorBlindType colorBlindType;

  /// Creates a copy of this settings with the given fields replaced.
  AccessibilitySettings copyWith({
    bool? highContrast,
    bool? reduceMotion,
    bool? largeText,
    bool? boldText,
    bool? disableAnimations,
    bool? accessibleNavigation,
    ColorBlindType? colorBlindType,
  }) {
    return AccessibilitySettings(
      highContrast: highContrast ?? this.highContrast,
      reduceMotion: reduceMotion ?? this.reduceMotion,
      largeText: largeText ?? this.largeText,
      boldText: boldText ?? this.boldText,
      disableAnimations: disableAnimations ?? this.disableAnimations,
      accessibleNavigation: accessibleNavigation ?? this.accessibleNavigation,
      colorBlindType: colorBlindType ?? this.colorBlindType,
    );
  }

  /// Default accessibility settings with all features disabled.
  static const AccessibilitySettings defaultSettings = AccessibilitySettings(
    highContrast: false,
    reduceMotion: false,
    largeText: false,
    boldText: false,
    disableAnimations: false,
    accessibleNavigation: false,
    colorBlindType: ColorBlindType.none,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessibilitySettings &&
          runtimeType == other.runtimeType &&
          highContrast == other.highContrast &&
          reduceMotion == other.reduceMotion &&
          largeText == other.largeText &&
          boldText == other.boldText &&
          disableAnimations == other.disableAnimations &&
          accessibleNavigation == other.accessibleNavigation &&
          colorBlindType == other.colorBlindType;

  @override
  int get hashCode =>
      highContrast.hashCode ^
      reduceMotion.hashCode ^
      largeText.hashCode ^
      boldText.hashCode ^
      disableAnimations.hashCode ^
      accessibleNavigation.hashCode ^
      colorBlindType.hashCode;

  @override
  String toString() {
    return 'AccessibilitySettings('
        'highContrast: $highContrast, '
        'reduceMotion: $reduceMotion, '
        'largeText: $largeText, '
        'boldText: $boldText, '
        'disableAnimations: $disableAnimations, '
        'accessibleNavigation: $accessibleNavigation, '
        'colorBlindType: $colorBlindType'
        ')';
  }
}

/// Provider for current accessibility settings.
///
/// Combines system-detected accessibility preferences with user
/// settings to provide comprehensive accessibility configuration.
@riverpod
class AccessibilitySettingsNotifier extends _$AccessibilitySettingsNotifier {
  @override
  AccessibilitySettings build() {
    // Start with default settings
    var settings = AccessibilitySettings.defaultSettings;

    try {
      // Update with platform accessibility features
      final context = navigatorKey.currentContext;
      if (context != null) {
        final mediaQuery = MediaQuery.maybeOf(context);
        if (mediaQuery != null) {
          settings = settings.copyWith(
            highContrast: mediaQuery.highContrast,
            reduceMotion: mediaQuery.disableAnimations,
            largeText: mediaQuery.textScaler.scale(1.0) > 1.2,
            boldText: mediaQuery.boldText,
            disableAnimations: mediaQuery.disableAnimations,
            accessibleNavigation: mediaQuery.accessibleNavigation,
          );
        }
      }
    } catch (e) {
      // Fallback to default settings if platform detection fails
      // This is expected in test environment
    }

    return settings;
  }

  /// Updates high contrast setting.
  void setHighContrast(bool enabled) {
    state = state.copyWith(highContrast: enabled);
  }

  /// Updates motion reduction setting.
  void setReduceMotion(bool enabled) {
    state = state.copyWith(reduceMotion: enabled);
  }

  /// Updates large text setting.
  void setLargeText(bool enabled) {
    state = state.copyWith(largeText: enabled);
  }

  /// Updates bold text setting.
  void setBoldText(bool enabled) {
    state = state.copyWith(boldText: enabled);
  }

  /// Updates animation disable setting.
  void setDisableAnimations(bool enabled) {
    state = state.copyWith(disableAnimations: enabled);
  }

  /// Updates accessible navigation setting.
  void setAccessibleNavigation(bool enabled) {
    state = state.copyWith(accessibleNavigation: enabled);
  }

  /// Updates color blind type setting.
  void setColorBlindType(ColorBlindType type) {
    state = state.copyWith(colorBlindType: type);
  }

  /// Refreshes settings from platform.
  void refreshFromPlatform() {
    // Trigger rebuild to re-detect platform settings
    ref.invalidateSelf();
  }
}

/// Global navigator key for accessing context in providers.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Provider for system high contrast detection.
///
/// Detects if the system has high contrast enabled and provides
/// reactive updates when the setting changes.
@riverpod
bool systemHighContrast(Ref ref) {
  try {
    final context = navigatorKey.currentContext;
    if (context != null) {
      final mediaQuery = MediaQuery.maybeOf(context);
      return mediaQuery?.highContrast ?? false;
    }
    return false;
  } catch (e) {
    // In test environment, return false
    return false;
  }
}

/// Provider for system reduced motion detection.
///
/// Detects if the system has reduced motion enabled and provides
/// reactive updates when the setting changes.
@riverpod
bool systemReducedMotion(Ref ref) {
  try {
    final context = navigatorKey.currentContext;
    if (context != null) {
      final mediaQuery = MediaQuery.maybeOf(context);
      return mediaQuery?.disableAnimations ?? false;
    }
    return false;
  } catch (e) {
    // In test environment, return false
    return false;
  }
}

/// Provider for high contrast light theme.
///
/// Generates a high contrast variant of the light theme with
/// enhanced color contrast ratios for accessibility.
@riverpod
ThemeData highContrastLightTheme(Ref ref) {
  final colorScheme = ColorSchemeGenerator.generateHighContrastScheme(
    Brightness.light,
  );

  return ThemeData(
    // Material 3 configuration with high contrast
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,

    // Enhanced visual density for accessibility
    visualDensity: VisualDensity.comfortable,
    platform: TargetPlatform.android,

    // Theme extensions with high contrast adjustments
    extensions: <ThemeExtension<dynamic>>[
      StatusColors.light,
      SpacingTokensExtension.expanded, // More spacing for touch targets
      RadiusTokensExtension.rounded, // Enhanced border visibility
      ElevationTokensExtension.enhancedLight, // Higher contrast shadows
      MotionTokensExtension.disabled, // Reduced motion by default
    ],

    // High contrast component overrides
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4, // Higher elevation for visibility
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        minimumSize: const Size(88, 56), // Larger minimum touch target
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Less rounded for clarity
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
      ),
    ),

    // High contrast input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colorScheme.outline, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colorScheme.primary, width: 3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colorScheme.error, width: 3),
      ),
    ),

    // High contrast cards
    cardTheme: CardThemeData(
      elevation: 4,
      color: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: colorScheme.outline, width: 1),
      ),
      margin: const EdgeInsets.all(8),
    ),
  );
}

/// Provider for high contrast dark theme.
///
/// Generates a high contrast variant of the dark theme with
/// enhanced color contrast ratios for accessibility.
@riverpod
ThemeData highContrastDarkTheme(Ref ref) {
  final colorScheme = ColorSchemeGenerator.generateHighContrastScheme(
    Brightness.dark,
  );

  return ThemeData(
    // Material 3 configuration with high contrast
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,

    // Enhanced visual density for accessibility
    visualDensity: VisualDensity.comfortable,
    platform: TargetPlatform.android,

    // Theme extensions with high contrast adjustments
    extensions: <ThemeExtension<dynamic>>[
      StatusColors.dark,
      SpacingTokensExtension.expanded, // More spacing for touch targets
      RadiusTokensExtension.rounded, // Enhanced border visibility
      ElevationTokensExtension.enhancedDark, // Higher contrast shadows
      MotionTokensExtension.disabled, // Reduced motion by default
    ],

    // High contrast component overrides
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4, // Higher elevation for visibility
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        minimumSize: const Size(88, 56), // Larger minimum touch target
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Less rounded for clarity
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
      ),
    ),

    // High contrast input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colorScheme.outline, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colorScheme.primary, width: 3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: colorScheme.error, width: 3),
      ),
    ),

    // High contrast cards
    cardTheme: CardThemeData(
      elevation: 4,
      color: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: colorScheme.outline, width: 1),
      ),
      margin: const EdgeInsets.all(8),
    ),
  );
}

/// Provider for accessibility-aware theme data.
///
/// Returns appropriate theme based on current accessibility settings,
/// automatically switching to high contrast themes when needed.
@riverpod
ThemeData accessibilityThemeData(Ref ref) {
  final accessibilitySettings = ref.watch(
    accessibilitySettingsNotifierProvider,
  );
  final effectiveThemeMode = ref.watch(effectiveThemeModeProvider);

  // Use high contrast theme if enabled
  if (accessibilitySettings.highContrast) {
    switch (effectiveThemeMode) {
      case ThemeMode.light:
        return ref.watch(highContrastLightThemeProvider);
      case ThemeMode.dark:
        return ref.watch(highContrastDarkThemeProvider);
      case ThemeMode.system:
        // This shouldn't happen as effectiveThemeMode resolves system
        final systemBrightness = ref.watch(systemBrightnessProvider);
        return systemBrightness == Brightness.dark
            ? ref.watch(highContrastDarkThemeProvider)
            : ref.watch(highContrastLightThemeProvider);
    }
  }

  // Fall back to regular theme if high contrast not needed
  switch (effectiveThemeMode) {
    case ThemeMode.light:
      return ThemeBuilder.buildTheme(Brightness.light);
    case ThemeMode.dark:
      return ThemeBuilder.buildTheme(Brightness.dark);
    case ThemeMode.system:
      // This shouldn't happen as effectiveThemeMode resolves system
      final systemBrightness = ref.watch(systemBrightnessProvider);
      return ThemeBuilder.buildTheme(systemBrightness);
  }
}

/// Provider for checking if high contrast mode is active.
///
/// Combines user preference and system settings to determine
/// if high contrast mode should be used.
@riverpod
bool isHighContrastActive(Ref ref) {
  final accessibilitySettings = ref.watch(
    accessibilitySettingsNotifierProvider,
  );
  final systemHighContrast = ref.watch(systemHighContrastProvider);

  return accessibilitySettings.highContrast || systemHighContrast;
}

/// Provider for checking if reduced motion is active.
///
/// Combines user preference and system settings to determine
/// if motion should be reduced.
@riverpod
bool isReducedMotionActive(Ref ref) {
  final accessibilitySettings = ref.watch(
    accessibilitySettingsNotifierProvider,
  );
  final systemReducedMotion = ref.watch(systemReducedMotionProvider);

  return accessibilitySettings.reduceMotion || systemReducedMotion;
}

/// Provider for effective motion tokens.
///
/// Returns appropriate motion tokens based on accessibility settings,
/// automatically switching to reduced motion variants when needed.
@riverpod
MotionTokensExtension effectiveMotionTokens(Ref ref) {
  final isReducedMotion = ref.watch(isReducedMotionActiveProvider);
  final accessibilitySettings = ref.watch(
    accessibilitySettingsNotifierProvider,
  );

  if (accessibilitySettings.disableAnimations || isReducedMotion) {
    return MotionTokensExtension.disabled;
  } else if (isReducedMotion) {
    return MotionTokensExtension.relaxed;
  } else {
    return MotionTokensExtension.standard;
  }
}

/// Provider for effective spacing tokens.
///
/// Returns appropriate spacing tokens based on accessibility settings,
/// automatically switching to expanded spacing for better touch targets.
@riverpod
SpacingTokensExtension effectiveSpacingTokens(Ref ref) {
  final accessibilitySettings = ref.watch(
    accessibilitySettingsNotifierProvider,
  );

  if (accessibilitySettings.accessibleNavigation ||
      accessibilitySettings.largeText) {
    return SpacingTokensExtension.expanded;
  } else {
    return SpacingTokensExtension.standard;
  }
}

/// Provider for accessibility theme recommendations.
///
/// Provides recommendations for theme adjustments based on
/// current accessibility needs and settings.
@riverpod
List<String> accessibilityRecommendations(Ref ref) {
  final settings = ref.watch(accessibilitySettingsNotifierProvider);
  final recommendations = <String>[];

  if (!settings.highContrast) {
    final systemHighContrast = ref.watch(systemHighContrastProvider);
    if (systemHighContrast) {
      recommendations.add('システムでハイコントラストが有効です。アプリでも有効にしますか？');
    }
  }

  if (!settings.reduceMotion) {
    final systemReducedMotion = ref.watch(systemReducedMotionProvider);
    if (systemReducedMotion) {
      recommendations.add('システムでアニメーション削減が有効です。アプリでも有効にしますか？');
    }
  }

  if (settings.largeText && !settings.accessibleNavigation) {
    recommendations.add('大きな文字を使用する場合、アクセシブルナビゲーションも有効にすることをお勧めします。');
  }

  return recommendations;
}

/// Color manipulation utilities for colorblind-friendly themes.
class ColorBlindUtilities {
  const ColorBlindUtilities._();

  /// Simulates protanopia (red-blindness) color transformation.
  static Color simulateProtanopia(Color color) {
    final r = ((color.r * 255.0).round() & 0xff) / 255.0;
    final g = ((color.g * 255.0).round() & 0xff) / 255.0;
    final b = ((color.b * 255.0).round() & 0xff) / 255.0;

    // Protanopia transformation matrix
    final newR = 0.567 * r + 0.433 * g + 0.0 * b;
    final newG = 0.558 * r + 0.442 * g + 0.0 * b;
    final newB = 0.0 * r + 0.242 * g + 0.758 * b;

    return Color.fromARGB(
      (color.a * 255.0).round() & 0xff,
      (newR * 255).round().clamp(0, 255),
      (newG * 255).round().clamp(0, 255),
      (newB * 255).round().clamp(0, 255),
    );
  }

  /// Simulates deuteranopia (green-blindness) color transformation.
  static Color simulateDeuteranopia(Color color) {
    final r = ((color.r * 255.0).round() & 0xff) / 255.0;
    final g = ((color.g * 255.0).round() & 0xff) / 255.0;
    final b = ((color.b * 255.0).round() & 0xff) / 255.0;

    // Deuteranopia transformation matrix
    final newR = 0.625 * r + 0.375 * g + 0.0 * b;
    final newG = 0.7 * r + 0.3 * g + 0.0 * b;
    final newB = 0.0 * r + 0.3 * g + 0.7 * b;

    return Color.fromARGB(
      (color.a * 255.0).round() & 0xff,
      (newR * 255).round().clamp(0, 255),
      (newG * 255).round().clamp(0, 255),
      (newB * 255).round().clamp(0, 255),
    );
  }

  /// Simulates tritanopia (blue-blindness) color transformation.
  static Color simulateTritanopia(Color color) {
    final r = ((color.r * 255.0).round() & 0xff) / 255.0;
    final g = ((color.g * 255.0).round() & 0xff) / 255.0;
    final b = ((color.b * 255.0).round() & 0xff) / 255.0;

    // Tritanopia transformation matrix
    final newR = 0.95 * r + 0.05 * g + 0.0 * b;
    final newG = 0.0 * r + 0.433 * g + 0.567 * b;
    final newB = 0.0 * r + 0.475 * g + 0.525 * b;

    return Color.fromARGB(
      (color.a * 255.0).round() & 0xff,
      (newR * 255).round().clamp(0, 255),
      (newG * 255).round().clamp(0, 255),
      (newB * 255).round().clamp(0, 255),
    );
  }

  /// Applies colorblind simulation to a ColorScheme.
  static ColorScheme applyColorBlindSimulation(
    ColorScheme scheme,
    ColorBlindType type,
  ) {
    switch (type) {
      case ColorBlindType.none:
        return scheme;
      case ColorBlindType.protanopia:
      case ColorBlindType.protanomaly:
        return _applyTransformation(scheme, simulateProtanopia);
      case ColorBlindType.deuteranopia:
      case ColorBlindType.deuteranomaly:
        return _applyTransformation(scheme, simulateDeuteranopia);
      case ColorBlindType.tritanopia:
      case ColorBlindType.tritanomaly:
        return _applyTransformation(scheme, simulateTritanopia);
    }
  }

  /// Applies a color transformation to all colors in a ColorScheme.
  static ColorScheme _applyTransformation(
    ColorScheme scheme,
    Color Function(Color) transform,
  ) {
    return scheme.copyWith(
      primary: transform(scheme.primary),
      onPrimary: transform(scheme.onPrimary),
      primaryContainer: transform(scheme.primaryContainer),
      onPrimaryContainer: transform(scheme.onPrimaryContainer),
      secondary: transform(scheme.secondary),
      onSecondary: transform(scheme.onSecondary),
      secondaryContainer: transform(scheme.secondaryContainer),
      onSecondaryContainer: transform(scheme.onSecondaryContainer),
      tertiary: transform(scheme.tertiary),
      onTertiary: transform(scheme.onTertiary),
      tertiaryContainer: transform(scheme.tertiaryContainer),
      onTertiaryContainer: transform(scheme.onTertiaryContainer),
      error: transform(scheme.error),
      onError: transform(scheme.onError),
      errorContainer: transform(scheme.errorContainer),
      onErrorContainer: transform(scheme.onErrorContainer),
      surface: transform(scheme.surface),
      onSurface: transform(scheme.onSurface),
      onSurfaceVariant: transform(scheme.onSurfaceVariant),
      outline: transform(scheme.outline),
      outlineVariant: transform(scheme.outlineVariant),
      shadow: transform(scheme.shadow),
      scrim: transform(scheme.scrim),
      inverseSurface: transform(scheme.inverseSurface),
      onInverseSurface: transform(scheme.onInverseSurface),
      inversePrimary: transform(scheme.inversePrimary),
      surfaceTint: transform(scheme.surfaceTint),
    );
  }

  /// Creates a colorblind-friendly palette with high contrast colors.
  static Map<String, Color> createColorBlindFriendlyPalette() {
    return {
      // Colors selected for good contrast and distinguishability for all color blind types
      'primary': const Color(0xFF1E3A5F), // Dark blue
      'secondary': const Color(0xFF8E5A2B), // Brown/orange
      'success': const Color(0xFF2E7D32), // Dark green
      'warning': const Color(0xFFFFB300), // Amber/yellow
      'error': const Color(0xFFD32F2F), // Red
      'info': const Color(0xFF1976D2), // Blue
      // Additional colorblind-friendly colors
      'accent1': const Color(0xFF7B1FA2), // Purple
      'accent2': const Color(0xFF388E3C), // Green
      'accent3': const Color(0xFFF57C00), // Orange
      'neutral': const Color(0xFF424242), // Gray
    };
  }
}

/// Provider for colorblind-friendly theme variants.
///
/// Returns a theme adapted for the specified color blind type
/// with improved color distinguishability.
@riverpod
ThemeData colorBlindFriendlyTheme(
  Ref ref,
  Brightness brightness,
  ColorBlindType colorBlindType,
) {
  // Start with base theme
  final baseTheme = brightness == Brightness.light
      ? ThemeBuilder.buildTheme(Brightness.light)
      : ThemeBuilder.buildTheme(Brightness.dark);

  // Apply colorblind simulation if needed
  if (colorBlindType == ColorBlindType.none) {
    return baseTheme;
  }

  final adaptedColorScheme = ColorBlindUtilities.applyColorBlindSimulation(
    baseTheme.colorScheme,
    colorBlindType,
  );

  // Use colorblind-friendly palette for better distinguishability
  final friendlyPalette = ColorBlindUtilities.createColorBlindFriendlyPalette();

  final enhancedColorScheme = adaptedColorScheme.copyWith(
    primary: friendlyPalette['primary'],
    secondary: friendlyPalette['secondary'],
    error: friendlyPalette['error'],
  );

  return baseTheme.copyWith(
    colorScheme: enhancedColorScheme,

    // Enhanced component themes for better distinguishability
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: enhancedColorScheme.primary,
        foregroundColor: enhancedColorScheme.onPrimary,
        elevation: 2, // Slightly higher elevation for better visibility
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: enhancedColorScheme.outline, width: 1),
        ),
      ),
    ),

    // Enhanced chips with better contrast
    chipTheme: baseTheme.chipTheme.copyWith(
      side: BorderSide(color: enhancedColorScheme.outline, width: 1),
      backgroundColor: enhancedColorScheme.surfaceContainer,
      selectedColor: enhancedColorScheme.primaryContainer,
    ),
  );
}
