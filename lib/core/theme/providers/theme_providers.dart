import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../builders/theme_builder.dart';
import '../extensions/elevation_tokens.dart';
import '../extensions/motion_tokens.dart';
import '../extensions/radius_tokens.dart';
import '../extensions/spacing_tokens.dart';
import '../extensions/status_colors.dart';
import 'theme_mode_provider.dart';

part 'theme_providers.g.dart';

/// Provider for light theme data.
///
/// Generates a complete ThemeData with Material 3 configuration,
/// all theme extensions, and light mode color scheme.
@riverpod
ThemeData lightTheme(Ref ref) {
  return ThemeBuilder.buildTheme(Brightness.light);
}

/// Provider for dark theme data.
///
/// Generates a complete ThemeData with Material 3 configuration,
/// all theme extensions, and dark mode color scheme.
@riverpod
ThemeData darkTheme(Ref ref) {
  return ThemeBuilder.buildTheme(Brightness.dark);
}

/// Provider for current theme data based on effective theme mode.
///
/// Automatically switches between light and dark themes based on
/// the current effective theme mode (resolving system mode).
@riverpod
ThemeData currentThemeData(Ref ref) {
  final themeMode = ref.watch(effectiveThemeModeProvider);

  switch (themeMode) {
    case ThemeMode.light:
      return ref.watch(lightThemeProvider);
    case ThemeMode.dark:
      return ref.watch(darkThemeProvider);
    case ThemeMode.system:
      // This should never happen as effectiveThemeMode resolves system
      final systemBrightness = ref.watch(systemBrightnessProvider);
      return systemBrightness == Brightness.dark
          ? ref.watch(darkThemeProvider)
          : ref.watch(lightThemeProvider);
  }
}

/// Provider for StatusColors extension from current theme.
///
/// Provides easy access to status colors (success, warning, error, info)
/// without needing to manually extract from theme extensions.
@riverpod
StatusColors statusColors(Ref ref) {
  final theme = ref.watch(currentThemeDataProvider);
  return theme.extension<StatusColors>()!;
}

/// Provider for SpacingTokensExtension from current theme.
///
/// Provides easy access to spacing tokens and utilities
/// without needing to manually extract from theme extensions.
@riverpod
SpacingTokensExtension spacing(Ref ref) {
  final theme = ref.watch(currentThemeDataProvider);
  return theme.extension<SpacingTokensExtension>()!;
}

/// Provider for RadiusTokensExtension from current theme.
///
/// Provides easy access to border radius tokens and utilities
/// without needing to manually extract from theme extensions.
@riverpod
RadiusTokensExtension radius(Ref ref) {
  final theme = ref.watch(currentThemeDataProvider);
  return theme.extension<RadiusTokensExtension>()!;
}

/// Provider for ElevationTokensExtension from current theme.
///
/// Provides easy access to elevation tokens and utilities
/// without needing to manually extract from theme extensions.
@riverpod
ElevationTokensExtension elevation(Ref ref) {
  final theme = ref.watch(currentThemeDataProvider);
  return theme.extension<ElevationTokensExtension>()!;
}

/// Provider for MotionTokensExtension from current theme.
///
/// Provides easy access to motion tokens and utilities
/// without needing to manually extract from theme extensions.
@riverpod
MotionTokensExtension motion(Ref ref) {
  final theme = ref.watch(currentThemeDataProvider);
  return theme.extension<MotionTokensExtension>()!;
}

/// Provider for theme initialization status.
///
/// Tracks whether the theme system has been properly initialized
/// and is ready for use. Useful for splash screens or loading states.
@riverpod
bool isThemeInitialized(Ref ref) {
  try {
    // Attempt to access the current theme to verify initialization
    final theme = ref.watch(currentThemeDataProvider);
    return theme.extensions.isNotEmpty;
  } catch (e) {
    return false;
  }
}

/// Provider for theme brightness information.
///
/// Returns the current brightness of the active theme,
/// useful for conditional UI elements or icons.
@riverpod
Brightness themeBrightness(Ref ref) {
  final theme = ref.watch(currentThemeDataProvider);
  return theme.brightness;
}

/// Provider for theme color scheme.
///
/// Provides direct access to the current color scheme
/// for advanced color operations or custom components.
@riverpod
ColorScheme themeColorScheme(Ref ref) {
  final theme = ref.watch(currentThemeDataProvider);
  return theme.colorScheme;
}

/// Provider for theme text theme.
///
/// Provides direct access to the current text theme
/// for typography operations or custom text widgets.
@riverpod
TextTheme themeTextTheme(Ref ref) {
  final theme = ref.watch(currentThemeDataProvider);
  return theme.textTheme;
}
