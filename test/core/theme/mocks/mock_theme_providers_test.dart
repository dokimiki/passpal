import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_theme_providers.dart';

void main() {
  group('MockThemeProviders', () {
    group('Theme Factory Methods', () {
      test('getTestLightTheme creates valid light theme', () {
        final theme = getTestLightTheme();

        expect(theme.brightness, equals(Brightness.light));
        expect(theme.useMaterial3, isTrue);
        expect(theme.extensions.isNotEmpty, isTrue);
      });

      test('getTestDarkTheme creates valid dark theme', () {
        final theme = getTestDarkTheme();

        expect(theme.brightness, equals(Brightness.dark));
        expect(theme.useMaterial3, isTrue);
        expect(theme.extensions.isNotEmpty, isTrue);
      });

      test('getTestCustomTheme creates theme with custom properties', () {
        final customColorScheme = ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        );

        final theme = getTestCustomTheme(
          brightness: Brightness.light,
          colorScheme: customColorScheme,
        );

        expect(theme.brightness, equals(Brightness.light));
        expect(theme.colorScheme.primary, equals(customColorScheme.primary));
      });
    });

    group('TestThemeScenarios', () {
      test('light() creates correct light theme config', () {
        final config = TestThemeScenarios.light();

        expect(config.brightness, equals(Brightness.light));
        expect(config.themeMode, equals(ThemeMode.light));
        expect(config.theme.brightness, equals(Brightness.light));
        expect(config.isDarkMode, isFalse);
      });

      test('dark() creates correct dark theme config', () {
        final config = TestThemeScenarios.dark();

        expect(config.brightness, equals(Brightness.dark));
        expect(config.themeMode, equals(ThemeMode.dark));
        expect(config.theme.brightness, equals(Brightness.dark));
        expect(config.isDarkMode, isTrue);
      });

      test('systemLight() creates correct system light config', () {
        final config = TestThemeScenarios.systemLight();

        expect(config.brightness, equals(Brightness.light));
        expect(config.themeMode, equals(ThemeMode.system));
        expect(config.theme.brightness, equals(Brightness.light));
        expect(config.isDarkMode, isFalse);
      });

      test('systemDark() creates correct system dark config', () {
        final config = TestThemeScenarios.systemDark();

        expect(config.brightness, equals(Brightness.dark));
        expect(config.themeMode, equals(ThemeMode.system));
        expect(config.theme.brightness, equals(Brightness.dark));
        expect(config.isDarkMode, isTrue);
      });

      test('highContrast() creates high contrast theme', () {
        final config = TestThemeScenarios.highContrast();

        expect(config.brightness, equals(Brightness.light));
        expect(config.themeMode, equals(ThemeMode.light));
        expect(config.theme, isA<ThemeData>());
      });

      test('custom() creates theme with custom properties', () {
        final customColorScheme = ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        );

        final config = TestThemeScenarios.custom(
          brightness: Brightness.dark,
          themeMode: ThemeMode.dark,
          colorScheme: customColorScheme,
        );

        expect(config.brightness, equals(Brightness.dark));
        expect(config.themeMode, equals(ThemeMode.dark));
        expect(config.isDarkMode, isTrue);
        expect(
          config.theme.colorScheme.primary,
          equals(customColorScheme.primary),
        );
      });
    });

    group('TestThemeConfig', () {
      test('overrides property provides correct provider overrides', () {
        final config = TestThemeConfig(
          brightness: Brightness.light,
          themeMode: ThemeMode.light,
          theme: getTestLightTheme(),
          isDarkMode: false,
        );

        final overrides = config.overrides;
        expect(
          overrides.length,
          greaterThan(5),
        ); // Should have multiple overrides
      });
    });

    group('MockThemeNotifier', () {
      test('initializes with correct default mode', () {
        final notifier = MockThemeNotifier();
        expect(notifier.state.value, equals(ThemeMode.light));
      });

      test('initializes with custom initial mode', () {
        final notifier = MockThemeNotifier(initialMode: ThemeMode.dark);
        expect(notifier.state.value, equals(ThemeMode.dark));
      });

      test('setThemeMode updates state correctly', () {
        final notifier = MockThemeNotifier();
        notifier.setThemeMode(ThemeMode.dark);
        expect(notifier.state.value, equals(ThemeMode.dark));
      });

      test('setLoading sets loading state', () {
        final notifier = MockThemeNotifier();
        notifier.setLoading();
        expect(notifier.state.isLoading, isTrue);
      });

      test('setError sets error state', () {
        final notifier = MockThemeNotifier();
        final error = Exception('Test error');
        notifier.setError(error);
        expect(notifier.state.error, isNotNull);
        expect(notifier.state.error, equals(error));
      });
    });

    group('MockAccessibilitySettingsNotifier', () {
      test('initializes with default high contrast setting', () {
        final notifier = MockAccessibilitySettingsNotifier();
        expect(notifier.state, isFalse);
      });

      test('initializes with custom high contrast setting', () {
        final notifier = MockAccessibilitySettingsNotifier(highContrast: true);
        expect(notifier.state, isTrue);
      });

      test('toggleHighContrast toggles state', () {
        final notifier = MockAccessibilitySettingsNotifier(highContrast: false);
        notifier.toggleHighContrast();
        expect(notifier.state, isTrue);

        notifier.toggleHighContrast();
        expect(notifier.state, isFalse);
      });

      test('setHighContrast sets specific value', () {
        final notifier = MockAccessibilitySettingsNotifier(highContrast: false);
        notifier.setHighContrast(true);
        expect(notifier.state, isTrue);

        notifier.setHighContrast(false);
        expect(notifier.state, isFalse);
      });
    });

    group('MockThemeTestUtils', () {
      test('getAllExtensions returns all theme extensions', () {
        final theme = getTestLightTheme();
        final extensions = MockThemeTestUtils.getAllExtensions(theme);

        expect(extensions.length, equals(5));
        expect(
          extensions.values.every((ext) => ext.runtimeType != Null),
          isTrue,
        );
      });

      test('validateTheme validates theme completeness', () {
        final validTheme = getTestLightTheme();

        // Should not throw for valid theme
        expect(
          () => MockThemeTestUtils.validateTheme(validTheme),
          returnsNormally,
        );

        // Should throw for theme with missing extensions
        final invalidTheme = ThemeData.light();
        expect(
          () => MockThemeTestUtils.validateTheme(invalidTheme),
          throwsA(anything),
        );
      });
    });

    group('Mock Notifier Classes', () {
      testWidgets('MockLightThemeModeNotifier returns light mode', (
        tester,
      ) async {
        final notifier = MockLightThemeModeNotifier();
        final themeMode = await notifier.build();
        expect(themeMode, equals(ThemeMode.light));
      });

      testWidgets('MockDarkThemeModeNotifier returns dark mode', (
        tester,
      ) async {
        final notifier = MockDarkThemeModeNotifier();
        final themeMode = await notifier.build();
        expect(themeMode, equals(ThemeMode.dark));
      });

      testWidgets('MockSystemThemeModeNotifier returns system mode', (
        tester,
      ) async {
        final notifier = MockSystemThemeModeNotifier();
        final themeMode = await notifier.build();
        expect(themeMode, equals(ThemeMode.system));
      });

      testWidgets('MockErrorThemeModeNotifier throws error', (tester) async {
        final notifier = MockErrorThemeModeNotifier();
        expect(notifier.build(), throwsException);
      });
    });
  });
}
