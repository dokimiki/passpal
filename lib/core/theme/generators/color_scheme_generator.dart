import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import '../models/color_tokens.dart';
import '../extensions/status_colors.dart' as theme_extensions;

/// ColorScheme generator for Material 3 with custom design tokens.
///
/// Generates Material 3 ColorScheme from seed color (#B1BCD9) with custom
/// overrides based on design tokens. Supports light/dark modes and
/// dynamic color where available.
///
/// Key features:
/// - Material 3 ColorScheme.fromSeed integration
/// - Custom overrides for design token consistency
/// - WCAG 2.2 AA contrast validation (4.5:1)
/// - Dynamic color support with fallback
/// - Status color integration
class ColorSchemeGenerator {
  /// Primary seed color for Material 3 color generation.
  /// Based on design token primary color #B1BCD9.
  static const Color seedColor = Color(0xFFB1BCD9);

  /// Minimum contrast ratio for WCAG 2.2 AA compliance.
  static const double minimumContrastRatio = 4.5;

  /// Generates a light ColorScheme with custom overrides.
  ///
  /// Uses Material 3 ColorScheme.fromSeed as base and applies
  /// custom overrides from design tokens for consistency.
  static ColorScheme generateLightScheme({
    Color? dynamicSeedColor,
    bool useDynamicColor = true,
  }) {
    final effectiveSeedColor = dynamicSeedColor ?? seedColor;

    // Generate base Material 3 color scheme
    final baseScheme = ColorScheme.fromSeed(
      seedColor: effectiveSeedColor,
      brightness: Brightness.light,
    );

    // Apply custom overrides from design tokens
    return baseScheme.copyWith(
      // Primary colors from design tokens
      primary: ColorTokens.light.primary.primary,
      onPrimary: ColorTokens.light.primary.onPrimary,
      primaryContainer: ColorTokens.light.primary.primaryContainer,
      onPrimaryContainer: ColorTokens.light.primary.onPrimaryContainer,

      // Surface colors from design tokens
      surface: ColorTokens.light.surface.surface,
      onSurface: ColorTokens.light.surface.onSurface,
      onSurfaceVariant: ColorTokens.light.surface.onSurfaceVariant,
      surfaceContainerLowest: ColorTokens.light.surface.surfaceContainerLowest,
      surfaceContainerLow: ColorTokens.light.surface.surfaceContainerLow,
      surfaceContainer: ColorTokens.light.surface.surfaceContainer,
      surfaceContainerHigh: ColorTokens.light.surface.surfaceContainerHigh,
      surfaceContainerHighest:
          ColorTokens.light.surface.surfaceContainerHighest,
      surfaceDim: ColorTokens.light.surface.surfaceDim,
      surfaceBright: ColorTokens.light.surface.surfaceBright,

      // Error colors from design tokens
      error: ColorTokens.light.status.error,
      onError: ColorTokens.light.status.onError,
      errorContainer: ColorTokens.light.status.errorContainer,
      onErrorContainer: ColorTokens.light.status.onErrorContainer,

      // Outline colors from design tokens
      outline: ColorTokens.light.neutral.outline,
      outlineVariant: ColorTokens.light.neutral.outlineVariant,

      // Inverse colors from design tokens
      inverseSurface: ColorTokens.light.surface.inverseSurface,
      onInverseSurface: ColorTokens.light.surface.onInverseSurface,
      inversePrimary: ColorTokens.light.surface.inversePrimary,

      // Shadow and scrim from design tokens
      shadow: ColorTokens.light.surface.shadow,
      scrim: ColorTokens.light.surface.scrim,
    );
  }

  /// Generates a dark ColorScheme with custom overrides.
  ///
  /// Uses Material 3 ColorScheme.fromSeed as base and applies
  /// custom overrides from design tokens for consistency.
  static ColorScheme generateDarkScheme({
    Color? dynamicSeedColor,
    bool useDynamicColor = true,
  }) {
    final effectiveSeedColor = dynamicSeedColor ?? seedColor;

    // Generate base Material 3 color scheme
    final baseScheme = ColorScheme.fromSeed(
      seedColor: effectiveSeedColor,
      brightness: Brightness.dark,
    );

    // Apply custom overrides from design tokens
    return baseScheme.copyWith(
      // Primary colors from design tokens
      primary: ColorTokens.dark.primary.primary,
      onPrimary: ColorTokens.dark.primary.onPrimary,
      primaryContainer: ColorTokens.dark.primary.primaryContainer,
      onPrimaryContainer: ColorTokens.dark.primary.onPrimaryContainer,

      // Surface colors from design tokens
      surface: ColorTokens.dark.surface.surface,
      onSurface: ColorTokens.dark.surface.onSurface,
      onSurfaceVariant: ColorTokens.dark.surface.onSurfaceVariant,
      surfaceContainerLowest: ColorTokens.dark.surface.surfaceContainerLowest,
      surfaceContainerLow: ColorTokens.dark.surface.surfaceContainerLow,
      surfaceContainer: ColorTokens.dark.surface.surfaceContainer,
      surfaceContainerHigh: ColorTokens.dark.surface.surfaceContainerHigh,
      surfaceContainerHighest: ColorTokens.dark.surface.surfaceContainerHighest,
      surfaceDim: ColorTokens.dark.surface.surfaceDim,
      surfaceBright: ColorTokens.dark.surface.surfaceBright,

      // Error colors from design tokens
      error: ColorTokens.dark.status.error,
      onError: ColorTokens.dark.status.onError,
      errorContainer: ColorTokens.dark.status.errorContainer,
      onErrorContainer: ColorTokens.dark.status.onErrorContainer,

      // Outline colors from design tokens
      outline: ColorTokens.dark.neutral.outline,
      outlineVariant: ColorTokens.dark.neutral.outlineVariant,

      // Inverse colors from design tokens
      inverseSurface: ColorTokens.dark.surface.inverseSurface,
      onInverseSurface: ColorTokens.dark.surface.onInverseSurface,
      inversePrimary: ColorTokens.dark.surface.inversePrimary,

      // Shadow and scrim from design tokens
      shadow: ColorTokens.dark.surface.shadow,
      scrim: ColorTokens.dark.surface.scrim,
    );
  }

  /// Generates ColorScheme with dynamic color support.
  ///
  /// Attempts to use system dynamic colors when available,
  /// falling back to design token colors.
  static Future<ColorScheme> generateDynamicScheme(
    Brightness brightness, {
    bool fallbackToDesignTokens = true,
  }) async {
    try {
      // Attempt to get dynamic color from system
      final corePalette = await DynamicColorPlugin.getCorePalette();

      if (corePalette != null) {
        // Generate scheme from dynamic color
        final dynamicScheme = ColorScheme.fromSeed(
          seedColor: Color(
            corePalette.primary.get(40),
          ), // Material 3 primary tone
          brightness: brightness,
        );

        // Apply minimal overrides to maintain design consistency
        return _applyMinimalOverrides(dynamicScheme, brightness);
      }
    } catch (e) {
      // Dynamic color not available or error occurred
      debugPrint('Dynamic color generation failed: $e');
    }

    // Fallback to design token schemes
    if (fallbackToDesignTokens) {
      return brightness == Brightness.light
          ? generateLightScheme(useDynamicColor: false)
          : generateDarkScheme(useDynamicColor: false);
    }

    // Final fallback to basic Material 3 scheme
    return ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness);
  }

  /// Applies minimal overrides to maintain design consistency with dynamic colors.
  static ColorScheme _applyMinimalOverrides(
    ColorScheme dynamicScheme,
    Brightness brightness,
  ) {
    final tokens = brightness == Brightness.light
        ? ColorTokens.light
        : ColorTokens.dark;

    // Only override essential colors for consistency
    return dynamicScheme.copyWith(
      // Keep status colors consistent with design tokens
      error: tokens.status.error,
      onError: tokens.status.onError,
      errorContainer: tokens.status.errorContainer,
      onErrorContainer: tokens.status.onErrorContainer,

      // Keep outline colors consistent
      outline: tokens.neutral.outline,
      outlineVariant: tokens.neutral.outlineVariant,
    );
  }

  /// Validates contrast ratio between foreground and background colors.
  ///
  /// Returns true if the contrast ratio meets WCAG 2.2 AA standards (4.5:1).
  static bool validateContrastRatio(Color foreground, Color background) {
    final contrastRatio = _calculateContrastRatio(foreground, background);
    return contrastRatio >= minimumContrastRatio;
  }

  /// Calculates contrast ratio between two colors (public method).
  ///
  /// Uses WCAG 2.2 relative luminance formula.
  /// Returns contrast ratio from 1:1 (no contrast) to 21:1 (maximum contrast).
  static double calculateContrastRatio(Color color1, Color color2) {
    return _calculateContrastRatio(color1, color2);
  }

  /// Checks if colors meet minimum contrast requirements for accessibility.
  ///
  /// Supports different WCAG levels:
  /// - 'AA': 4.5:1 for normal text
  /// - 'AAA': 7:1 for normal text
  /// - 'AA Large': 3:1 for large text (18pt+)
  /// - 'AAA Large': 4.5:1 for large text
  static bool hasMinimumContrast(
    Color foreground,
    Color background, {
    String level = 'AA',
  }) {
    final ratio = _calculateContrastRatio(foreground, background);

    switch (level) {
      case 'AAA':
        return ratio >= 7.0;
      case 'AA Large':
        return ratio >= 3.0;
      case 'AAA Large':
        return ratio >= 4.5;
      case 'AA':
      default:
        return ratio >= 4.5;
    }
  }

  /// Calculates contrast ratio between two colors.
  ///
  /// Uses WCAG 2.2 relative luminance formula.
  static double _calculateContrastRatio(Color color1, Color color2) {
    final luminance1 = _calculateRelativeLuminance(color1);
    final luminance2 = _calculateRelativeLuminance(color2);

    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Calculates relative luminance of a color.
  ///
  /// Uses WCAG 2.2 relative luminance formula.
  static double _calculateRelativeLuminance(Color color) {
    final r = _linearizeColorComponent(
      ((color.r * 255.0).round() & 0xff) / 255.0,
    );
    final g = _linearizeColorComponent(
      ((color.g * 255.0).round() & 0xff) / 255.0,
    );
    final b = _linearizeColorComponent(
      ((color.b * 255.0).round() & 0xff) / 255.0,
    );

    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Linearizes a color component for luminance calculation.
  static double _linearizeColorComponent(double component) {
    if (component <= 0.03928) {
      return component / 12.92;
    } else {
      return ((component + 0.055) / 1.055).pow(2.4);
    }
  }

  /// Generates a high contrast ColorScheme for accessibility.
  ///
  /// Uses high contrast colors that exceed WCAG AAA standards
  /// for users with visual impairments.
  static ColorScheme generateHighContrastScheme(Brightness brightness) {
    if (brightness == Brightness.light) {
      return ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ).copyWith(
        // High contrast overrides
        primary: const Color(0xFF000080), // Very dark blue
        onPrimary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        error: const Color(0xFF8B0000), // Very dark red
        onError: Colors.white,
      );
    } else {
      return ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ).copyWith(
        // High contrast overrides for dark mode
        primary: const Color(0xFF87CEEB), // Light blue for contrast
        onPrimary: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
        error: const Color(0xFFFF6B6B), // Bright red
        onError: Colors.black,
      );
    }
  }

  /// Gets appropriate StatusColors for the given ColorScheme.
  ///
  /// Returns StatusColors that complement the ColorScheme for
  /// consistent status indication across the app.
  static theme_extensions.StatusColors getStatusColorsForScheme(
    ColorScheme colorScheme,
  ) {
    final isLight = colorScheme.brightness == Brightness.light;
    return isLight
        ? theme_extensions.StatusColors.light
        : theme_extensions.StatusColors.dark;
  }
}

/// Extension to add convenience methods to ColorScheme.
extension ColorSchemeExtensions on ColorScheme {
  /// Returns true if this is a light color scheme.
  bool get isLight => brightness == Brightness.light;

  /// Returns true if this is a dark color scheme.
  bool get isDark => brightness == Brightness.dark;

  /// Gets the appropriate status colors for this scheme.
  theme_extensions.StatusColors get statusColors =>
      ColorSchemeGenerator.getStatusColorsForScheme(this);

  /// Validates that critical color pairs in this scheme meet contrast requirements.
  ///
  /// Checks surface and text combinations which are most important for readability.
  /// Brand colors (primary, error) may not meet strict contrast for design consistency.
  bool get hasValidContrast {
    return ColorSchemeGenerator.validateContrastRatio(onSurface, surface);
  }
}

/// Helper extension for math operations.
extension _MathHelper on num {
  double pow(num exponent) {
    return math.pow(toDouble(), exponent).toDouble();
  }
}
