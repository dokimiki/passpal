import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/builders/app_theme.dart';
import 'package:passpal/core/theme/extensions/passpal_theme_ext.dart';
import 'package:passpal/core/theme/tokens/colors.dart';

void main() {
  group('AppTheme', () {
    test('should generate light theme with Material 3', () {
      final theme = AppTheme.light(ColorTokens.brand.primary);

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, equals(Brightness.light));
      expect(theme.colorScheme.primary, isNotNull);
    });

    test('should generate dark theme with Material 3', () {
      final theme = AppTheme.dark(ColorTokens.brand.primary);

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, equals(Brightness.dark));
      expect(theme.colorScheme.primary, isNotNull);
    });

    test('should include PasspalThemeExt extension', () {
      final theme = AppTheme.light(ColorTokens.brand.primary);

      final extension = theme.extension<PasspalThemeExt>();
      expect(extension, isNotNull);
    });

    test('should configure ElevatedButtonTheme', () {
      final theme = AppTheme.light(ColorTokens.brand.primary);

      expect(theme.elevatedButtonTheme, isNotNull);
      expect(theme.elevatedButtonTheme.style, isNotNull);
    });

    test('should configure SnackBarTheme for errors', () {
      final theme = AppTheme.light(ColorTokens.brand.primary);

      expect(theme.snackBarTheme, isNotNull);
      expect(theme.snackBarTheme.backgroundColor, isNotNull);
      expect(theme.snackBarTheme.contentTextStyle, isNotNull);
    });

    test('light and dark themes should have different brightness', () {
      final lightTheme = AppTheme.light(ColorTokens.brand.primary);
      final darkTheme = AppTheme.dark(ColorTokens.brand.primary);

      expect(lightTheme.brightness, equals(Brightness.light));
      expect(darkTheme.brightness, equals(Brightness.dark));
      expect(lightTheme.brightness, isNot(equals(darkTheme.brightness)));
    });

    test('should handle custom seed color', () {
      const customSeed = Color(0xFF00FF00);
      final theme = AppTheme.light(customSeed);

      expect(theme.colorScheme.primary, isNotNull);
    });
  });
}
