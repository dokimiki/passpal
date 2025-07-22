import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:passpal/core/theme/providers/accessibility_providers.dart';
import 'package:passpal/core/theme/providers/theme_providers.dart';

import '../mocks/mock_theme_providers.dart';

/// Tests for colorblind simulation functionality.
///
/// Validates that colorblind simulations work correctly for all supported
/// color blind types and that the transformations produce expected results.
void main() {
  group('ColorBlind Simulation Tests', () {
    group('ColorBlindUtilities', () {
      testWidgets('simulateProtanopia transforms colors correctly', (
        tester,
      ) async {
        // Test basic red color transformation for protanopia
        const redColor = Color(0xFFFF0000); // Pure red
        final transformedColor = ColorBlindUtilities.simulateProtanopia(
          redColor,
        );

        // For protanopia, red should be shifted toward green/yellow
        expect(transformedColor.r * 255, lessThan(redColor.r * 255));
        expect(transformedColor.a * 255, equals(redColor.a * 255));

        // Test with complex color
        const complexColor = Color(0xFF3F51B5); // Material indigo
        final transformedComplex = ColorBlindUtilities.simulateProtanopia(
          complexColor,
        );

        expect(transformedComplex.a * 255, equals(complexColor.a * 255));
        expect(transformedComplex, isNot(equals(complexColor)));
      });

      testWidgets('simulateDeuteranopia transforms colors correctly', (
        tester,
      ) async {
        // Test basic green color transformation for deuteranopia
        const greenColor = Color(0xFF00FF00); // Pure green
        final transformedColor = ColorBlindUtilities.simulateDeuteranopia(
          greenColor,
        );

        // For deuteranopia, green should be shifted
        expect(transformedColor.g * 255, lessThan(greenColor.g * 255));
        expect(transformedColor.a * 255, equals(greenColor.a * 255));

        // Test with blue color (should be less affected)
        const blueColor = Color(0xFF0000FF); // Pure blue
        final transformedBlue = ColorBlindUtilities.simulateDeuteranopia(
          blueColor,
        );

        expect(transformedBlue.a * 255, equals(blueColor.a * 255));
        expect(transformedBlue.b * 255, greaterThan(0));
      });

      testWidgets('simulateTritanopia transforms colors correctly', (
        tester,
      ) async {
        // Test basic blue color transformation for tritanopia
        const blueColor = Color(0xFF0000FF); // Pure blue
        final transformedColor = ColorBlindUtilities.simulateTritanopia(
          blueColor,
        );

        // For tritanopia, blue should be shifted toward green/yellow
        expect(transformedColor.b * 255, lessThan(blueColor.b * 255));
        expect(transformedColor.a * 255, equals(blueColor.a * 255));

        // Test with red color (should be less affected)
        const redColor = Color(0xFFFF0000); // Pure red
        final transformedRed = ColorBlindUtilities.simulateTritanopia(redColor);

        expect(transformedRed.a * 255, equals(redColor.a * 255));
        expect(transformedRed.r * 255, greaterThan(0));
      });

      testWidgets('color transformations preserve alpha channel', (
        tester,
      ) async {
        const testColors = [
          Color(0x80FF0000), // Semi-transparent red
          Color(0x40FFFF00), // Semi-transparent yellow
          Color(0xCCFF00FF), // Semi-transparent magenta
        ];

        for (final color in testColors) {
          final protanopia = ColorBlindUtilities.simulateProtanopia(color);
          final deuteranopia = ColorBlindUtilities.simulateDeuteranopia(color);
          final tritanopia = ColorBlindUtilities.simulateTritanopia(color);

          expect(
            protanopia.a * 255,
            equals(color.a * 255),
            reason: 'Protanopia should preserve alpha for $color',
          );
          expect(
            deuteranopia.a * 255,
            equals(color.a * 255),
            reason: 'Deuteranopia should preserve alpha for $color',
          );
          expect(
            tritanopia.a * 255,
            equals(color.a * 255),
            reason: 'Tritanopia should preserve alpha for $color',
          );
        }
      });
    });

    group('ColorScheme Transformation', () {
      test('applyColorBlindSimulation works for all types', () async {
        final container = ProviderContainer(
          overrides: TestThemeProviderOverrides.lightTheme(),
        );
        addTearDown(container.dispose);

        final originalScheme = container.read(lightThemeProvider).colorScheme;

        for (final colorBlindType in ColorBlindType.values) {
          final transformedScheme =
              ColorBlindUtilities.applyColorBlindSimulation(
                originalScheme,
                colorBlindType,
              );

          if (colorBlindType == ColorBlindType.none) {
            // None type should return original scheme
            expect(
              transformedScheme,
              equals(originalScheme),
              reason: 'None type should not transform colors',
            );
          } else {
            // Other types should transform at least some colors
            expect(
              transformedScheme,
              isNot(equals(originalScheme)),
              reason: '$colorBlindType should transform colors',
            );

            // Verify some key colors are transformed
            expect(
              transformedScheme.primary,
              isNot(equals(originalScheme.primary)),
              reason: 'Primary color should be transformed for $colorBlindType',
            );
          }
        }
      });

      test('colorblind transformation preserves scheme structure', () async {
        final container = ProviderContainer(
          overrides: TestThemeProviderOverrides.lightTheme(),
        );
        addTearDown(container.dispose);

        final originalScheme = container.read(lightThemeProvider).colorScheme;

        final transformedScheme = ColorBlindUtilities.applyColorBlindSimulation(
          originalScheme,
          ColorBlindType.protanopia,
        );

        // Check that all color properties exist and are not null
        expect(transformedScheme.primary, isNotNull);
        expect(transformedScheme.onPrimary, isNotNull);
        expect(transformedScheme.secondary, isNotNull);
        expect(transformedScheme.onSecondary, isNotNull);
        expect(transformedScheme.surface, isNotNull);
        expect(transformedScheme.onSurface, isNotNull);
        expect(transformedScheme.error, isNotNull);
        expect(transformedScheme.onError, isNotNull);

        // Check brightness is preserved
        expect(transformedScheme.brightness, equals(originalScheme.brightness));
      });
    });

    group('Colorblind Provider Integration', () {
      // TODO: Implement these providers in accessibility_providers.dart
      /*
      testWidgets('colorblind friendly theme provider works', (tester) async {
        final colorblindTheme = container.read(colorblindFriendlyThemeProvider);
        
        expect(colorblindTheme, isNotNull);
        expect(colorblindTheme.colorScheme, isNotNull);
        
        // Verify that the theme has enhanced contrast colors
        final scheme = colorblindTheme.colorScheme;
        expect(scheme.primary, isNotNull);
        expect(scheme.secondary, isNotNull);
      });

      testWidgets('accessibility aware theme switches to colorblind', (tester) async {
        final theme = container.read(accessibilityAwareThemeDataProvider);
        
        expect(theme, isNotNull);
        expect(theme.colorScheme, isNotNull);
        
        // Theme should be adapted for colorblind users
        final scheme = theme.colorScheme;
        expect(scheme.primary, isNotNull);
        expect(scheme.secondary, isNotNull);
      });
      */
    });

    group('Color Distinguishability', () {
      testWidgets(
        'colorblind friendly palette provides distinguishable colors',
        (tester) async {
          final palette = ColorBlindUtilities.createColorBlindFriendlyPalette();

          expect(palette, isNotEmpty);
          expect(palette.containsKey('primary'), isTrue);
          expect(palette.containsKey('secondary'), isTrue);

          // Colors should be different
          expect(palette['primary'], isNot(equals(palette['secondary'])));

          // Test the colors under different colorblind simulations
          final primaryColor = palette['primary']!;
          final secondaryColor = palette['secondary']!;

          for (final colorBlindType in [
            ColorBlindType.protanopia,
            ColorBlindType.deuteranopia,
            ColorBlindType.tritanopia,
          ]) {
            late Color transformedPrimary;
            late Color transformedSecondary;

            switch (colorBlindType) {
              case ColorBlindType.protanopia:
                transformedPrimary = ColorBlindUtilities.simulateProtanopia(
                  primaryColor,
                );
                transformedSecondary = ColorBlindUtilities.simulateProtanopia(
                  secondaryColor,
                );
                break;
              case ColorBlindType.deuteranopia:
                transformedPrimary = ColorBlindUtilities.simulateDeuteranopia(
                  primaryColor,
                );
                transformedSecondary = ColorBlindUtilities.simulateDeuteranopia(
                  secondaryColor,
                );
                break;
              case ColorBlindType.tritanopia:
                transformedPrimary = ColorBlindUtilities.simulateTritanopia(
                  primaryColor,
                );
                transformedSecondary = ColorBlindUtilities.simulateTritanopia(
                  secondaryColor,
                );
                break;
              default:
                continue;
            }

            // Colors should still be distinguishable after transformation
            expect(
              transformedPrimary,
              isNot(equals(transformedSecondary)),
              reason:
                  'Colors should remain distinguishable for $colorBlindType',
            );
          }
        },
      );
    });

    group('Edge Cases', () {
      testWidgets('handles extreme colors correctly', (tester) async {
        const extremeColors = [
          Color(0x00000000), // Fully transparent black
          Color(0xFFFFFFFF), // Opaque white
          Color(0xFF000000), // Opaque black
          Color(0x80808080), // Semi-transparent gray
        ];

        for (final color in extremeColors) {
          // Should not throw exceptions
          expect(
            () => ColorBlindUtilities.simulateProtanopia(color),
            returnsNormally,
          );
          expect(
            () => ColorBlindUtilities.simulateDeuteranopia(color),
            returnsNormally,
          );
          expect(
            () => ColorBlindUtilities.simulateTritanopia(color),
            returnsNormally,
          );

          // Results should be valid colors
          final protanopia = ColorBlindUtilities.simulateProtanopia(color);
          final deuteranopia = ColorBlindUtilities.simulateDeuteranopia(color);
          final tritanopia = ColorBlindUtilities.simulateTritanopia(color);

          expect(protanopia.toARGB32(), isA<int>());
          expect(deuteranopia.toARGB32(), isA<int>());
          expect(tritanopia.toARGB32(), isA<int>());
        }
      });

      testWidgets('color values stay in valid range', (tester) async {
        const testColor = Color(0xFFFF8000); // Orange

        final transformations = [
          ColorBlindUtilities.simulateProtanopia(testColor),
          ColorBlindUtilities.simulateDeuteranopia(testColor),
          ColorBlindUtilities.simulateTritanopia(testColor),
        ];

        for (final transformed in transformations) {
          expect(transformed.r * 255, inInclusiveRange(0, 255));
          expect(transformed.g * 255, inInclusiveRange(0, 255));
          expect(transformed.b * 255, inInclusiveRange(0, 255));
          expect(transformed.a * 255, inInclusiveRange(0, 255));
        }
      });
    });
  });
}
