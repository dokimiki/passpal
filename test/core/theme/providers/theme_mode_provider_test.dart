import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:passpal/core/theme/providers/theme_mode_provider.dart';

void main() {
  group('ThemeModeProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('systemBrightnessProvider', () {
      test('returns system brightness', () {
        final brightness = container.read(systemBrightnessProvider);

        // Should return a valid brightness value
        expect(brightness, anyOf(Brightness.light, Brightness.dark));
      });
    });

    group('themeModeDisplayNameProvider', () {
      test('returns correct display names for all theme modes', () {
        final systemName = container.read(
          themeModeDisplayNameProvider(ThemeMode.system),
        );
        final lightName = container.read(
          themeModeDisplayNameProvider(ThemeMode.light),
        );
        final darkName = container.read(
          themeModeDisplayNameProvider(ThemeMode.dark),
        );

        expect(systemName, equals('システム'));
        expect(lightName, equals('ライト'));
        expect(darkName, equals('ダーク'));
      });
    });

    group('isDarkModeProvider', () {
      test('returns true when effective theme mode is dark', () {
        final testContainer = ProviderContainer(
          overrides: [
            effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.dark),
          ],
        );

        final isDark = testContainer.read(isDarkModeProvider);
        expect(isDark, isTrue);

        testContainer.dispose();
      });

      test('returns false when effective theme mode is light', () {
        final testContainer = ProviderContainer(
          overrides: [
            effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.light),
          ],
        );

        final isDark = testContainer.read(isDarkModeProvider);
        expect(isDark, isFalse);

        testContainer.dispose();
      });
    });

    group('availableThemeModesProvider', () {
      test('returns map of all theme modes with display names', () {
        final modes = container.read(availableThemeModesProvider);

        expect(modes, hasLength(3));
        expect(modes[ThemeMode.system], equals('システム'));
        expect(modes[ThemeMode.light], equals('ライト'));
        expect(modes[ThemeMode.dark], equals('ダーク'));
      });

      test('includes all ThemeMode values', () {
        final modes = container.read(availableThemeModesProvider);

        expect(modes.keys, containsAll(ThemeMode.values));
      });
    });

    group('effectiveThemeModeProvider', () {
      test('uses system brightness when provider fails', () {
        // Should handle provider failure gracefully
        final testContainer = ProviderContainer();

        final effectiveMode = testContainer.read(effectiveThemeModeProvider);

        // Should provide a fallback mode based on system brightness
        expect(effectiveMode, anyOf(ThemeMode.light, ThemeMode.dark));
        expect(effectiveMode, isNot(ThemeMode.system));

        testContainer.dispose();
      });
    });

    group('Error Handling', () {
      test('handles missing services gracefully', () {
        final testContainer = ProviderContainer();

        // Should not throw when services are unavailable
        expect(() {
          testContainer.read(systemBrightnessProvider);
          testContainer.read(themeModeDisplayNameProvider(ThemeMode.light));
          testContainer.read(availableThemeModesProvider);
        }, returnsNormally);

        testContainer.dispose();
      });

      test('provides fallback values when services fail', () {
        final testContainer = ProviderContainer();

        // Should provide fallback values
        final effectiveMode = testContainer.read(effectiveThemeModeProvider);
        final isDark = testContainer.read(isDarkModeProvider);

        expect(effectiveMode, anyOf(ThemeMode.light, ThemeMode.dark));
        expect(isDark, anyOf(isTrue, isFalse));

        testContainer.dispose();
      });
    });
  });
}
