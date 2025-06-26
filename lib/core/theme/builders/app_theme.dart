import 'package:flutter/material.dart';
import 'package:passpal/core/theme/extensions/passpal_theme_ext.dart';
import 'package:passpal/core/theme/tokens/radii.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';

/// Application theme builder for Material Design 3
class AppTheme {
  const AppTheme._();

  /// Generate light theme with given seed color
  static ThemeData light(Color seed) => _base(seed, Brightness.light);

  /// Generate dark theme with given seed color
  static ThemeData dark(Color seed) => _base(seed, Brightness.dark);

  /// Base theme generation method
  static ThemeData _base(Color seed, Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusTokens.button),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SpaceTokens.lg,
            vertical: SpaceTokens.sm,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.errorContainer,
        contentTextStyle: TextStyle(color: colorScheme.onErrorContainer),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.card),
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.card),
        ),
        elevation: 2,
      ),
      extensions: [PasspalThemeExt.fromColorScheme(colorScheme)],
    );
  }
}
