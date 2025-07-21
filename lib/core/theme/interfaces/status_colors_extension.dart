import 'package:flutter/material.dart';

/// Base interface for StatusColors theme extension.
///
/// Provides type-safe access to status colors (success, warning, error, info)
/// that are not part of Material 3's standard ColorScheme.
///
/// This interface ensures consistent status color implementation across
/// light, dark, and high-contrast theme variants.
abstract class StatusColorsExtension
    extends ThemeExtension<StatusColorsExtension> {
  /// Success state color (typically green).
  /// Used for positive feedback, completed states, and success messages.
  Color get success;

  /// Warning state color (typically yellow/orange).
  /// Used for cautionary messages and attention-grabbing elements.
  Color get warning;

  /// Error state color (typically red).
  /// Used for error messages, destructive actions, and failure states.
  Color get error;

  /// Information state color (typically blue).
  /// Used for informational messages and neutral notifications.
  Color get info;

  /// Light variant colors for success states.
  /// Provides better contrast on dark backgrounds.
  Color get successLight;

  /// Light variant colors for warning states.
  /// Provides better contrast on dark backgrounds.
  Color get warningLight;

  /// Light variant colors for error states.
  /// Provides better contrast on dark backgrounds.
  Color get errorLight;

  /// Light variant colors for info states.
  /// Provides better contrast on dark backgrounds.
  Color get infoLight;

  /// Dark variant colors for success states.
  /// Provides better contrast on light backgrounds.
  Color get successDark;

  /// Dark variant colors for warning states.
  /// Provides better contrast on light backgrounds.
  Color get warningDark;

  /// Dark variant colors for error states.
  /// Provides better contrast on light backgrounds.
  Color get errorDark;

  /// Dark variant colors for info states.
  /// Provides better contrast on light backgrounds.
  Color get infoDark;

  /// Creates a copy of this extension with given fields replaced.
  @override
  StatusColorsExtension copyWith({
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? successLight,
    Color? warningLight,
    Color? errorLight,
    Color? infoLight,
    Color? successDark,
    Color? warningDark,
    Color? errorDark,
    Color? infoDark,
  });

  /// Linearly interpolates between this and another [StatusColorsExtension].
  ///
  /// Required for theme transitions and animations.
  @override
  StatusColorsExtension lerp(
    ThemeExtension<StatusColorsExtension>? other,
    double t,
  );
}
