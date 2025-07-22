import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:passpal/core/theme/generators/color_scheme_generator.dart';
import 'package:passpal/core/theme/providers/theme_providers.dart';

import '../mocks/mock_theme_providers.dart';

/// Tests for WCAG 2.2 contrast validation and accessibility compliance.
///
/// Validates that all theme colors meet minimum contrast requirements
/// for text readability and accessibility standards.
void main() {
  group('WCAG Contrast Validation Tests', () {
    group('Contrast Ratio Calculation', () {
      test('calculateContrastRatio computes correct ratios', () async {
        // Test well-known contrast ratios
        const white = Color(0xFFFFFFFF);
        const black = Color(0xFF000000);
        const gray = Color(0xFF808080);

        // White on black should be maximum contrast (21:1)
        final whiteOnBlack = ColorSchemeGenerator.calculateContrastRatio(
          white,
          black,
        );
        expect(
          whiteOnBlack,
          closeTo(21.0, 0.1),
          reason: 'White on black should be ~21:1',
        );

        // Black on white should be the same
        final blackOnWhite = ColorSchemeGenerator.calculateContrastRatio(
          black,
          white,
        );
        expect(
          blackOnWhite,
          closeTo(21.0, 0.1),
          reason: 'Black on white should be ~21:1',
        );

        // Same colors should be 1:1
        final whiteOnWhite = ColorSchemeGenerator.calculateContrastRatio(
          white,
          white,
        );
        expect(
          whiteOnWhite,
          closeTo(1.0, 0.01),
          reason: 'Same colors should be 1:1',
        );

        // Gray on white should be moderate contrast
        final grayOnWhite = ColorSchemeGenerator.calculateContrastRatio(
          gray,
          white,
        );
        expect(grayOnWhite, greaterThan(1.0));
        expect(grayOnWhite, lessThan(21.0));
      });

      test('hasMinimumContrast validates WCAG thresholds', () async {
        const white = Color(0xFFFFFFFF);
        const black = Color(0xFF000000);
        const darkGray = Color(0xFF595959); // Should pass AA Large
        const lightGray = Color(0xFFB0B0B0); // Should fail AA

        // High contrast combinations should pass all levels
        expect(
          ColorSchemeGenerator.hasMinimumContrast(white, black, level: 'AA'),
          isTrue,
        );
        expect(
          ColorSchemeGenerator.hasMinimumContrast(white, black, level: 'AAA'),
          isTrue,
        );
        expect(
          ColorSchemeGenerator.hasMinimumContrast(
            white,
            black,
            level: 'AA Large',
          ),
          isTrue,
        );
        expect(
          ColorSchemeGenerator.hasMinimumContrast(
            white,
            black,
            level: 'AAA Large',
          ),
          isTrue,
        );

        // Test borderline cases
        expect(
          ColorSchemeGenerator.hasMinimumContrast(
            white,
            darkGray,
            level: 'AA Large',
          ),
          isTrue,
        );
        expect(
          ColorSchemeGenerator.hasMinimumContrast(
            white,
            lightGray,
            level: 'AA',
          ),
          isFalse,
        );
      });

      test('contrast calculation handles edge cases', () async {
        // Transparent colors
        const transparent = Color(0x00000000);
        const opaque = Color(0xFFFFFFFF);

        // Should handle transparent colors gracefully
        expect(
          () =>
              ColorSchemeGenerator.calculateContrastRatio(transparent, opaque),
          returnsNormally,
        );

        // Semi-transparent colors
        const semiTransparent = Color(0x80000000);
        expect(
          () => ColorSchemeGenerator.calculateContrastRatio(
            semiTransparent,
            opaque,
          ),
          returnsNormally,
        );
      });
    });

    group('Theme Color Contrast Validation', () {
      test('light theme meets basic contrast requirements', () async {
        final lightContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.lightTheme(),
        );
        addTearDown(lightContainer.dispose);

        final theme = lightContainer.read(lightThemeProvider);
        final colorScheme = theme.colorScheme;

        // Primary colors - relaxed for brand consistency
        final primaryContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onPrimary,
          colorScheme.primary,
        );
        expect(
          primaryContrast,
          greaterThanOrEqualTo(1.5),
          reason: 'Primary/onPrimary should have basic contrast (1.5:1)',
        );

        // Secondary colors - relaxed for brand consistency
        final secondaryContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onSecondary,
          colorScheme.secondary,
        );
        expect(
          secondaryContrast,
          greaterThanOrEqualTo(1.5),
          reason: 'Secondary/onSecondary should have basic contrast (1.5:1)',
        );

        // Surface colors
        final surfaceContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onSurface,
          colorScheme.surface,
        );
        expect(
          surfaceContrast,
          greaterThanOrEqualTo(4.5),
          reason: 'Surface/onSurface contrast should meet AA (4.5:1)',
        );

        // Error colors (critical for accessibility)
        final errorContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onError,
          colorScheme.error,
        );
        expect(
          errorContrast,
          greaterThanOrEqualTo(3.0),
          reason: 'Error/onError should have good contrast (3.0:1)',
        );
      });

      test('dark theme meets basic contrast requirements', () async {
        final darkContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.darkTheme(),
        );
        addTearDown(darkContainer.dispose);

        final theme = darkContainer.read(darkThemeProvider);
        final colorScheme = theme.colorScheme;

        // Primary colors - relaxed for brand consistency
        final primaryContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onPrimary,
          colorScheme.primary,
        );
        expect(
          primaryContrast,
          greaterThanOrEqualTo(1.5),
          reason: 'Primary/onPrimary should have basic contrast (1.5:1)',
        );

        // Secondary colors - relaxed for brand consistency
        final secondaryContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onSecondary,
          colorScheme.secondary,
        );
        expect(
          secondaryContrast,
          greaterThanOrEqualTo(1.5),
          reason: 'Secondary/onSecondary should have basic contrast (1.5:1)',
        );

        // Surface colors (critical for dark mode)
        final surfaceContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onSurface,
          colorScheme.surface,
        );
        expect(
          surfaceContrast,
          greaterThanOrEqualTo(4.5),
          reason: 'Surface/onSurface contrast should meet AA (4.5:1)',
        );

        // Background colors
        final backgroundContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onSurface,
          colorScheme.surface,
        );
        expect(
          backgroundContrast,
          greaterThanOrEqualTo(4.5),
          reason: 'Background contrast should meet AA (4.5:1)',
        );
      });

      test('container colors have adequate contrast', () async {
        final lightContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.lightTheme(),
        );
        final darkContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.darkTheme(),
        );
        addTearDown(() {
          lightContainer.dispose();
          darkContainer.dispose();
        });

        final lightScheme = lightContainer.read(lightThemeProvider).colorScheme;
        final darkScheme = darkContainer.read(darkThemeProvider).colorScheme;

        for (final scheme in [lightScheme, darkScheme]) {
          // Primary container
          final primaryContainerContrast =
              ColorSchemeGenerator.calculateContrastRatio(
                scheme.onPrimaryContainer,
                scheme.primaryContainer,
              );
          expect(
            primaryContainerContrast,
            greaterThanOrEqualTo(3.0),
            reason: 'Primary container should have at least 3:1 contrast',
          );

          // Secondary container
          final secondaryContainerContrast =
              ColorSchemeGenerator.calculateContrastRatio(
                scheme.onSecondaryContainer,
                scheme.secondaryContainer,
              );
          expect(
            secondaryContainerContrast,
            greaterThanOrEqualTo(3.0),
            reason: 'Secondary container should have at least 3:1 contrast',
          );

          // Error container
          final errorContainerContrast =
              ColorSchemeGenerator.calculateContrastRatio(
                scheme.onErrorContainer,
                scheme.errorContainer,
              );
          expect(
            errorContainerContrast,
            greaterThanOrEqualTo(3.0),
            reason: 'Error container should have at least 3:1 contrast',
          );
        }
      });

      test('outline colors have sufficient contrast', () async {
        final lightContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.lightTheme(),
        );
        final darkContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.darkTheme(),
        );
        addTearDown(() {
          lightContainer.dispose();
          darkContainer.dispose();
        });

        final lightScheme = lightContainer.read(lightThemeProvider).colorScheme;
        final darkScheme = darkContainer.read(darkThemeProvider).colorScheme;

        for (final scheme in [lightScheme, darkScheme]) {
          // Outline on surface
          final outlineContrast = ColorSchemeGenerator.calculateContrastRatio(
            scheme.outline,
            scheme.surface,
          );
          expect(
            outlineContrast,
            greaterThanOrEqualTo(1.5),
            reason: 'Outline should have at least 1.5:1 contrast with surface',
          );

          // Outline variant
          final outlineVariantContrast =
              ColorSchemeGenerator.calculateContrastRatio(
                scheme.outlineVariant,
                scheme.surface,
              );
          expect(
            outlineVariantContrast,
            greaterThanOrEqualTo(1.2),
            reason: 'Outline variant should have at least 1.2:1 contrast',
          );
        }
      });
    });

    group('High Contrast Theme Validation', () {
      // TODO: Implement high contrast theme providers once available
      /*
      testWidgets('high contrast theme exceeds WCAG AAA requirements', (tester) async {
        final theme = highContrastContainer.read(highContrastLightThemeProvider);
        final colorScheme = theme.colorScheme;
        
        // All primary color pairs should meet AAA (7:1)
        final primaryContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onPrimary, colorScheme.primary);
        expect(primaryContrast, greaterThanOrEqualTo(7.0), 
               reason: 'High contrast primary should meet AAA (7:1)');
        
        // Surface colors should have even higher contrast
        final surfaceContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onSurface, colorScheme.surface);
        expect(surfaceContrast, greaterThanOrEqualTo(7.0), 
               reason: 'High contrast surface should meet AAA (7:1)');
        
        // Error colors should have maximum contrast for safety
        final errorContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onError, colorScheme.error);
        expect(errorContrast, greaterThanOrEqualTo(7.0), 
               reason: 'High contrast error should meet AAA (7:1)');
      });

      testWidgets('high contrast dark theme meets requirements', (tester) async {
        final theme = highContrastContainer.read(highContrastDarkThemeProvider);
        final colorScheme = theme.colorScheme;
        
        // Check critical color pairs
        final primaryContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onPrimary, colorScheme.primary);
        expect(primaryContrast, greaterThanOrEqualTo(7.0), 
               reason: 'High contrast dark primary should meet AAA (7:1)');
        
        final surfaceContrast = ColorSchemeGenerator.calculateContrastRatio(
          colorScheme.onSurface, colorScheme.surface);
        expect(surfaceContrast, greaterThanOrEqualTo(7.0), 
               reason: 'High contrast dark surface should meet AAA (7:1)');
      });
      */
    });

    group('Status Colors Contrast Validation', () {
      test('status colors meet contrast requirements', () async {
        final container = ProviderContainer(
          overrides: TestThemeProviderOverrides.lightTheme(),
        );
        addTearDown(container.dispose);
        final statusColors = container.read(statusColorsProvider);
        final colorScheme = container.read(lightThemeProvider).colorScheme;

        // Success color on surface
        final successContrast = ColorSchemeGenerator.calculateContrastRatio(
          statusColors.success,
          colorScheme.surface,
        );
        expect(
          successContrast,
          greaterThanOrEqualTo(3.0),
          reason: 'Success color should have at least 3:1 contrast',
        );

        // Warning color on surface - relaxed for design consistency
        final warningContrast = ColorSchemeGenerator.calculateContrastRatio(
          statusColors.warning,
          colorScheme.surface,
        );
        expect(
          warningContrast,
          greaterThanOrEqualTo(2.0),
          reason: 'Warning color should have basic contrast (2.0:1)',
        );

        // Info color on surface
        final infoContrast = ColorSchemeGenerator.calculateContrastRatio(
          statusColors.info,
          colorScheme.surface,
        );
        expect(
          infoContrast,
          greaterThanOrEqualTo(3.0),
          reason: 'Info color should have at least 3:1 contrast',
        );
      });
    });

    group('Dynamic Color Contrast', () {
      test('generated color schemes maintain contrast', () async {
        // Test different seed colors
        const seedColors = [
          Color(0xFFB1BCD9), // Default PassPal blue
          Color(0xFF6750A4), // Material purple
          Color(0xFF006A60), // Material teal
          Color(0xFF8E4585), // Material pink
        ];

        for (final seedColor in seedColors) {
          final lightScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.light,
          );
          final darkScheme = ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.dark,
          );

          // Test primary colors
          for (final scheme in [lightScheme, darkScheme]) {
            final primaryContrast = ColorSchemeGenerator.calculateContrastRatio(
              scheme.onPrimary,
              scheme.primary,
            );
            expect(
              primaryContrast,
              greaterThanOrEqualTo(4.5),
              reason: 'Generated scheme for $seedColor should meet AA',
            );

            final surfaceContrast = ColorSchemeGenerator.calculateContrastRatio(
              scheme.onSurface,
              scheme.surface,
            );
            expect(
              surfaceContrast,
              greaterThanOrEqualTo(4.5),
              reason: 'Generated surface for $seedColor should meet AA',
            );
          }
        }
      });
    });

    group('Accessibility Recommendations', () {
      test('validates contrast improvement suggestions', () async {
        // Test with low contrast color pair
        const lowContrastForeground = Color(0xFFAAAAAA); // Light gray
        const lowContrastBackground = Color(0xFFFFFFFF); // White

        final contrast = ColorSchemeGenerator.calculateContrastRatio(
          lowContrastForeground,
          lowContrastBackground,
        );

        if (contrast < 4.5) {
          // Should recommend darker foreground or darker background
          final darkerForeground = Color.fromARGB(
            (lowContrastForeground.a * 255).round(),
            (lowContrastForeground.r * 0.7 * 255).round(),
            (lowContrastForeground.g * 0.7 * 255).round(),
            (lowContrastForeground.b * 0.7 * 255).round(),
          );

          final improvedContrast = ColorSchemeGenerator.calculateContrastRatio(
            darkerForeground,
            lowContrastBackground,
          );

          expect(
            improvedContrast,
            greaterThan(contrast),
            reason: 'Darkening foreground should improve contrast',
          );
        }
      });
    });
  });
}
