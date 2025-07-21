import 'package:flutter/material.dart';

/// StatusColors theme extension implementation.
///
/// Provides concrete implementation of status colors (success, warning, error, info)
/// with proper theme interpolation and Material 3 integration.
///
/// This extension integrates with StatusColors from the color tokens model
/// and provides both primary and light/dark variants for better accessibility.
class StatusColors extends ThemeExtension<StatusColors> {
  /// Creates a StatusColors theme extension.
  StatusColors({
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.successLight,
    required this.warningLight,
    required this.errorLight,
    required this.infoLight,
    required this.successDark,
    required this.warningDark,
    required this.errorDark,
    required this.infoDark,
  });

  /// Light mode status colors using design tokens.
  static final light = StatusColors(
    // Primary status colors
    success: Color(0xFF2E7D32), // StatusColors.light.success
    warning: Color(0xFFF57C00), // StatusColors.light.warning
    error: Color(0xFFD32F2F), // StatusColors.light.error
    info: Color(0xFF1976D2), // StatusColors.light.info
    // Light variants (for dark backgrounds)
    successLight: Color(0xFF66BB6A), // Lighter green
    warningLight: Color(0xFFFFB74D), // Lighter orange
    errorLight: Color(0xFFEF5350), // Lighter red
    infoLight: Color(0xFF42A5F5), // Lighter blue
    // Dark variants (for light backgrounds)
    successDark: Color(0xFF1B5E20), // Darker green
    warningDark: Color(0xFFE65100), // Darker orange
    errorDark: Color(0xFFB71C1C), // Darker red
    infoDark: Color(0xFF0D47A1), // Darker blue
  );

  /// Dark mode status colors using design tokens.
  static final dark = StatusColors(
    // Primary status colors (using dark mode tokens)
    success: Color(0xFF66BB6A), // StatusColors.dark.success
    warning: Color(0xFFFFB74D), // StatusColors.dark.warning
    error: Color(0xFFEF5350), // StatusColors.dark.error
    info: Color(0xFF42A5F5), // StatusColors.dark.info
    // Light variants (for dark backgrounds) - brighter in dark mode
    successLight: Color(0xFF81C784), // Even lighter green
    warningLight: Color(0xFFFFC947), // Even lighter orange
    errorLight: Color(0xFFF44336), // Even lighter red
    infoLight: Color(0xFF2196F3), // Even lighter blue
    // Dark variants (for light backgrounds) - use light mode colors
    successDark: Color(0xFF2E7D32), // Light mode success
    warningDark: Color(0xFFF57C00), // Light mode warning
    errorDark: Color(0xFFD32F2F), // Light mode error
    infoDark: Color(0xFF1976D2), // Light mode info
  );

  /// High contrast mode status colors for accessibility.
  static final highContrast = StatusColors(
    // High contrast primary colors (WCAG AAA compliance)
    success: Color(0xFF0D5016), // Very dark green
    warning: Color(0xFF8A4000), // Very dark orange
    error: Color(0xFF8B0000), // Very dark red
    info: Color(0xFF003D82), // Very dark blue
    // Light variants with high contrast
    successLight: Color(0xFF4CAF50), // Material green
    warningLight: Color(0xFFFF9800), // Material orange
    errorLight: Color(0xFFF44336), // Material red
    infoLight: Color(0xFF2196F3), // Material blue
    // Dark variants with high contrast
    successDark: Color(0xFF0D5016), // Very dark green
    warningDark: Color(0xFF8A4000), // Very dark orange
    errorDark: Color(0xFF8B0000), // Very dark red
    infoDark: Color(0xFF003D82), // Very dark blue
  );

  /// Success state color (typically green).
  /// Used for positive feedback, completed states, and success messages.
  final Color success;

  /// Warning state color (typically yellow/orange).
  /// Used for cautionary messages and attention-grabbing elements.
  final Color warning;

  /// Error state color (typically red).
  /// Used for error messages, destructive actions, and failure states.
  final Color error;

  /// Information state color (typically blue).
  /// Used for informational messages and neutral notifications.
  final Color info;

  /// Light variant colors for success states.
  /// Provides better contrast on dark backgrounds.
  final Color successLight;

  /// Light variant colors for warning states.
  /// Provides better contrast on dark backgrounds.
  final Color warningLight;

  /// Light variant colors for error states.
  /// Provides better contrast on dark backgrounds.
  final Color errorLight;

  /// Light variant colors for info states.
  /// Provides better contrast on dark backgrounds.
  final Color infoLight;

  /// Dark variant colors for success states.
  /// Provides better contrast on light backgrounds.
  final Color successDark;

  /// Dark variant colors for warning states.
  /// Provides better contrast on light backgrounds.
  final Color warningDark;

  /// Dark variant colors for error states.
  /// Provides better contrast on light backgrounds.
  final Color errorDark;

  /// Dark variant colors for info states.
  /// Provides better contrast on light backgrounds.
  final Color infoDark;

  @override
  StatusColors copyWith({
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
  }) {
    return StatusColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      successLight: successLight ?? this.successLight,
      warningLight: warningLight ?? this.warningLight,
      errorLight: errorLight ?? this.errorLight,
      infoLight: infoLight ?? this.infoLight,
      successDark: successDark ?? this.successDark,
      warningDark: warningDark ?? this.warningDark,
      errorDark: errorDark ?? this.errorDark,
      infoDark: infoDark ?? this.infoDark,
    );
  }

  @override
  StatusColors lerp(ThemeExtension<StatusColors>? other, double t) {
    if (other is! StatusColors) {
      return this;
    }

    return StatusColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      errorLight: Color.lerp(errorLight, other.errorLight, t)!,
      infoLight: Color.lerp(infoLight, other.infoLight, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      warningDark: Color.lerp(warningDark, other.warningDark, t)!,
      errorDark: Color.lerp(errorDark, other.errorDark, t)!,
      infoDark: Color.lerp(infoDark, other.infoDark, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StatusColors &&
        other.success == success &&
        other.warning == warning &&
        other.error == error &&
        other.info == info &&
        other.successLight == successLight &&
        other.warningLight == warningLight &&
        other.errorLight == errorLight &&
        other.infoLight == infoLight &&
        other.successDark == successDark &&
        other.warningDark == warningDark &&
        other.errorDark == errorDark &&
        other.infoDark == infoDark;
  }

  @override
  int get hashCode {
    return Object.hash(
      success,
      warning,
      error,
      info,
      successLight,
      warningLight,
      errorLight,
      infoLight,
      successDark,
      warningDark,
      errorDark,
      infoDark,
    );
  }

  @override
  String toString() {
    return 'StatusColors('
        'success: $success, '
        'warning: $warning, '
        'error: $error, '
        'info: $info, '
        'successLight: $successLight, '
        'warningLight: $warningLight, '
        'errorLight: $errorLight, '
        'infoLight: $infoLight, '
        'successDark: $successDark, '
        'warningDark: $warningDark, '
        'errorDark: $errorDark, '
        'infoDark: $infoDark'
        ')';
  }
}

/// Extension methods for easy access to status colors in BuildContext.
extension StatusColorsContext on BuildContext {
  /// Gets the current [StatusColors] from the theme.
  StatusColors get statusColors {
    final statusColors = Theme.of(this).extension<StatusColors>();
    assert(
      statusColors != null,
      'StatusColors extension is not registered in the current theme',
    );
    return statusColors!;
  }
}

/// Extension methods for easy access to status colors in ThemeData.
extension StatusColorsTheme on ThemeData {
  /// Gets the [StatusColors] extension from this theme.
  StatusColors? get statusColors => extension<StatusColors>();
}
