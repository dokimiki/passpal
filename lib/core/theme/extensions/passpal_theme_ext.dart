import 'package:flutter/material.dart';

/// Custom theme extension for Passpal-specific colors and styling
class PasspalThemeExt extends ThemeExtension<PasspalThemeExt> {
  const PasspalThemeExt({
    required this.errorBg,
    required this.warningBg,
    required this.successBg,
    required this.infoBg,
    required this.maintenanceBg,
    required this.surfaceVariant,
    required this.surface1,
  });

  final Color errorBg;
  final Color warningBg;
  final Color successBg;
  final Color infoBg;
  final Color maintenanceBg;
  final Color surfaceVariant;
  final Color surface1;

  /// Create theme extension from ColorScheme
  factory PasspalThemeExt.fromColorScheme(ColorScheme colorScheme) {
    return PasspalThemeExt(
      errorBg: colorScheme.errorContainer,
      warningBg: _adjustColor(colorScheme.tertiary, 0.1),
      successBg: _adjustColor(colorScheme.primary, 0.8),
      infoBg: colorScheme.primaryContainer,
      maintenanceBg: _adjustColor(colorScheme.secondary, 0.1),
      surfaceVariant: colorScheme.surfaceContainerHighest,
      surface1: colorScheme.surface,
    );
  }

  /// Adjust color brightness for better visual hierarchy
  static Color _adjustColor(Color color, double factor) {
    return Color.lerp(color, Colors.white, factor) ?? color;
  }

  @override
  PasspalThemeExt copyWith({
    Color? errorBg,
    Color? warningBg,
    Color? successBg,
    Color? infoBg,
    Color? maintenanceBg,
    Color? surfaceVariant,
    Color? surface1,
  }) {
    return PasspalThemeExt(
      errorBg: errorBg ?? this.errorBg,
      warningBg: warningBg ?? this.warningBg,
      successBg: successBg ?? this.successBg,
      infoBg: infoBg ?? this.infoBg,
      maintenanceBg: maintenanceBg ?? this.maintenanceBg,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      surface1: surface1 ?? this.surface1,
    );
  }

  @override
  PasspalThemeExt lerp(ThemeExtension<PasspalThemeExt>? other, double t) {
    if (other is! PasspalThemeExt) {
      return this;
    }

    return PasspalThemeExt(
      errorBg: Color.lerp(errorBg, other.errorBg, t) ?? errorBg,
      warningBg: Color.lerp(warningBg, other.warningBg, t) ?? warningBg,
      successBg: Color.lerp(successBg, other.successBg, t) ?? successBg,
      infoBg: Color.lerp(infoBg, other.infoBg, t) ?? infoBg,
      maintenanceBg:
          Color.lerp(maintenanceBg, other.maintenanceBg, t) ?? maintenanceBg,
      surfaceVariant:
          Color.lerp(surfaceVariant, other.surfaceVariant, t) ?? surfaceVariant,
      surface1: Color.lerp(surface1, other.surface1, t) ?? surface1,
    );
  }
}
