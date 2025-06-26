import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/extensions/passpal_theme_ext.dart';

void main() {
  group('PasspalThemeExt', () {
    test('should create from light ColorScheme', () {
      final colorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0057D9),
        brightness: Brightness.light,
      );

      final extension = PasspalThemeExt.fromColorScheme(colorScheme);

      expect(extension.errorBg, isNotNull);
      expect(extension.warningBg, isNotNull);
      expect(extension.successBg, isNotNull);
      expect(extension.infoBg, isNotNull);
      expect(extension.maintenanceBg, isNotNull);
    });

    test('should create from dark ColorScheme', () {
      final colorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0057D9),
        brightness: Brightness.dark,
      );

      final extension = PasspalThemeExt.fromColorScheme(colorScheme);

      expect(extension.errorBg, isNotNull);
      expect(extension.warningBg, isNotNull);
      expect(extension.successBg, isNotNull);
      expect(extension.infoBg, isNotNull);
      expect(extension.maintenanceBg, isNotNull);
    });

    test('should support copyWith', () {
      final colorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0057D9),
        brightness: Brightness.light,
      );

      final original = PasspalThemeExt.fromColorScheme(colorScheme);
      const customErrorBg = Color(0xFFFF0000);

      final copied = original.copyWith(errorBg: customErrorBg);

      expect(copied.errorBg, equals(customErrorBg));
      expect(copied.warningBg, equals(original.warningBg));
    });

    test('should support theme interpolation', () {
      final lightScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0057D9),
        brightness: Brightness.light,
      );
      final darkScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0057D9),
        brightness: Brightness.dark,
      );

      final lightExt = PasspalThemeExt.fromColorScheme(lightScheme);
      final darkExt = PasspalThemeExt.fromColorScheme(darkScheme);

      final interpolated = lightExt.lerp(darkExt, 0.5);

      expect(interpolated, isNotNull);
      expect(interpolated, isA<PasspalThemeExt>());
    });
  });
}
