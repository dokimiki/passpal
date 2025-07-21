import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:passpal/core/theme/providers/theme_providers.dart';
import 'package:passpal/core/theme/providers/theme_mode_provider.dart';
import 'package:passpal/core/theme/extensions/status_colors.dart';
import 'package:passpal/core/theme/extensions/spacing_tokens.dart';
import 'package:passpal/core/theme/extensions/radius_tokens.dart';
import 'package:passpal/core/theme/extensions/elevation_tokens.dart';
import 'package:passpal/core/theme/extensions/motion_tokens.dart';

void main() {
  group('Theme Providers', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      addTearDown(container.dispose);
    });

    group('lightThemeProvider', () {
      test('generates valid light theme data', () {
        final theme = container.read(lightThemeProvider);

        expect(theme.brightness, Brightness.light);
        expect(theme.useMaterial3, true);
        expect(theme.colorScheme.brightness, Brightness.light);
      });

      test('includes all required theme extensions', () {
        final theme = container.read(lightThemeProvider);

        expect(theme.extension<StatusColors>(), isNotNull);
        expect(theme.extension<SpacingTokensExtension>(), isNotNull);
        expect(theme.extension<RadiusTokensExtension>(), isNotNull);
        expect(theme.extension<ElevationTokensExtension>(), isNotNull);
        expect(theme.extension<MotionTokensExtension>(), isNotNull);
      });
    });

    group('darkThemeProvider', () {
      test('generates valid dark theme data', () {
        final theme = container.read(darkThemeProvider);

        expect(theme.brightness, Brightness.dark);
        expect(theme.useMaterial3, true);
        expect(theme.colorScheme.brightness, Brightness.dark);
      });

      test('includes all required theme extensions', () {
        final theme = container.read(darkThemeProvider);

        expect(theme.extension<StatusColors>(), isNotNull);
        expect(theme.extension<SpacingTokensExtension>(), isNotNull);
        expect(theme.extension<RadiusTokensExtension>(), isNotNull);
        expect(theme.extension<ElevationTokensExtension>(), isNotNull);
        expect(theme.extension<MotionTokensExtension>(), isNotNull);
      });
    });

    group('currentThemeDataProvider', () {
      test('returns light theme when theme mode is light', () {
        final container = ProviderContainer(
          overrides: [
            effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.light),
          ],
        );
        addTearDown(container.dispose);

        final currentTheme = container.read(currentThemeDataProvider);
        final lightTheme = container.read(lightThemeProvider);

        expect(currentTheme.brightness, lightTheme.brightness);
        expect(
          currentTheme.colorScheme.primary,
          lightTheme.colorScheme.primary,
        );
      });

      test('returns dark theme when theme mode is dark', () {
        final container = ProviderContainer(
          overrides: [
            effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.dark),
          ],
        );
        addTearDown(container.dispose);

        final currentTheme = container.read(currentThemeDataProvider);
        final darkTheme = container.read(darkThemeProvider);

        expect(currentTheme.brightness, darkTheme.brightness);
        expect(currentTheme.colorScheme.primary, darkTheme.colorScheme.primary);
      });
    });

    group('theme extension providers', () {
      test('statusColorsProvider provides StatusColors extension', () {
        final statusColors = container.read(statusColorsProvider);

        expect(statusColors, isA<StatusColors>());
        expect(statusColors.success, isNotNull);
        expect(statusColors.warning, isNotNull);
        expect(statusColors.error, isNotNull);
        expect(statusColors.info, isNotNull);
      });

      test('spacingProvider provides SpacingTokensExtension', () {
        final spacing = container.read(spacingProvider);

        expect(spacing, isA<SpacingTokensExtension>());
        expect(spacing.xs, 4.0);
        expect(spacing.sm, 8.0);
        expect(spacing.md, 16.0);
      });

      test('radiusProvider provides RadiusTokensExtension', () {
        final radius = container.read(radiusProvider);

        expect(radius, isA<RadiusTokensExtension>());
      });

      test('elevationProvider provides ElevationTokensExtension', () {
        final elevation = container.read(elevationProvider);

        expect(elevation, isA<ElevationTokensExtension>());
      });

      test('motionProvider provides MotionTokensExtension', () {
        final motion = container.read(motionProvider);

        expect(motion, isA<MotionTokensExtension>());
      });
    });

    group('utility providers', () {
      test('isThemeInitializedProvider returns true for valid theme', () {
        final isInitialized = container.read(isThemeInitializedProvider);

        expect(isInitialized, true);
      });

      test('themeBrightnessProvider returns current brightness', () {
        final brightness = container.read(themeBrightnessProvider);

        expect(brightness, isA<Brightness>());
      });

      test('themeColorSchemeProvider returns current color scheme', () {
        final colorScheme = container.read(themeColorSchemeProvider);

        expect(colorScheme, isA<ColorScheme>());
      });

      test('themeTextThemeProvider returns current text theme', () {
        final textTheme = container.read(themeTextThemeProvider);

        expect(textTheme, isA<TextTheme>());
      });
    });

    group('theme switching', () {
      test('currentTheme changes when theme mode changes', () {
        // Test light theme
        final lightContainer = ProviderContainer(
          overrides: [
            effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.light),
          ],
        );
        addTearDown(lightContainer.dispose);

        final lightTheme = lightContainer.read(currentThemeDataProvider);
        expect(lightTheme.brightness, Brightness.light);

        // Test dark theme in separate container
        final darkContainer = ProviderContainer(
          overrides: [
            effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.dark),
          ],
        );
        addTearDown(darkContainer.dispose);

        final darkTheme = darkContainer.read(currentThemeDataProvider);
        expect(darkTheme.brightness, Brightness.dark);
      });
    });
  });
}
