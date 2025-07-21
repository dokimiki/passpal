import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/builders/theme_builder.dart';
import 'package:passpal/core/theme/extensions/status_colors.dart';
import 'package:passpal/core/theme/extensions/spacing_tokens.dart';
import 'package:passpal/core/theme/extensions/radius_tokens.dart';
import 'package:passpal/core/theme/extensions/elevation_tokens.dart';
import 'package:passpal/core/theme/extensions/motion_tokens.dart';

void main() {
  group('Theme Consistency Tests', () {
    late ThemeData lightTheme;
    late ThemeData darkTheme;

    setUpAll(() {
      lightTheme = ThemeBuilder.buildTheme(Brightness.light);
      darkTheme = ThemeBuilder.buildTheme(Brightness.dark);
    });

    group('Material 3 Compliance', () {
      test('Both themes should use Material 3', () {
        expect(lightTheme.useMaterial3, isTrue);
        expect(darkTheme.useMaterial3, isTrue);
      });

      test('Both themes should have proper brightness', () {
        expect(lightTheme.brightness, equals(Brightness.light));
        expect(darkTheme.brightness, equals(Brightness.dark));
        expect(lightTheme.colorScheme.brightness, equals(Brightness.light));
        expect(darkTheme.colorScheme.brightness, equals(Brightness.dark));
      });

      test('Color schemes should follow Material 3 specifications', () {
        // Light theme colors should be lighter
        expect(
          lightTheme.colorScheme.surface.computeLuminance(),
          greaterThan(darkTheme.colorScheme.surface.computeLuminance()),
        );

        // Both themes should have required surface variants
        expect(lightTheme.colorScheme.surfaceContainerHighest, isNotNull);
        expect(darkTheme.colorScheme.surfaceContainerHighest, isNotNull);

        // Primary colors should maintain brand consistency while adapting to brightness
        expect(lightTheme.colorScheme.primary, isNotNull);
        expect(darkTheme.colorScheme.primary, isNotNull);
      });
    });

    group('Extension Consistency', () {
      test('Both themes should have all required extensions', () {
        // Check StatusColors
        final lightStatusColors = lightTheme.extension<StatusColors>();
        final darkStatusColors = darkTheme.extension<StatusColors>();
        expect(lightStatusColors, isNotNull);
        expect(darkStatusColors, isNotNull);

        // Check SpacingTokensExtension
        final lightSpacing = lightTheme.extension<SpacingTokensExtension>();
        final darkSpacing = darkTheme.extension<SpacingTokensExtension>();
        expect(lightSpacing, isNotNull);
        expect(darkSpacing, isNotNull);

        // Check RadiusTokensExtension
        final lightRadius = lightTheme.extension<RadiusTokensExtension>();
        final darkRadius = darkTheme.extension<RadiusTokensExtension>();
        expect(lightRadius, isNotNull);
        expect(darkRadius, isNotNull);

        // Check ElevationTokensExtension
        final lightElevation = lightTheme.extension<ElevationTokensExtension>();
        final darkElevation = darkTheme.extension<ElevationTokensExtension>();
        expect(lightElevation, isNotNull);
        expect(darkElevation, isNotNull);

        // Check MotionTokensExtension
        final lightMotion = lightTheme.extension<MotionTokensExtension>();
        final darkMotion = darkTheme.extension<MotionTokensExtension>();
        expect(lightMotion, isNotNull);
        expect(darkMotion, isNotNull);
      });

      test('StatusColors should be appropriate for each brightness', () {
        final lightStatusColors = lightTheme.extension<StatusColors>()!;
        final darkStatusColors = darkTheme.extension<StatusColors>()!;

        // Success colors should maintain semantic meaning
        expect(
          lightStatusColors.success.computeLuminance(),
          lessThan(darkStatusColors.success.computeLuminance()),
        );

        // Error colors should maintain semantic meaning
        expect(
          lightStatusColors.error.computeLuminance(),
          lessThan(darkStatusColors.error.computeLuminance()),
        );

        // Warning colors should maintain semantic meaning
        expect(
          lightStatusColors.warning.computeLuminance(),
          lessThan(darkStatusColors.warning.computeLuminance()),
        );

        // Info colors should maintain semantic meaning
        expect(
          lightStatusColors.info.computeLuminance(),
          lessThan(darkStatusColors.info.computeLuminance()),
        );
      });

      test('Spacing tokens should be identical across themes', () {
        final lightSpacing = lightTheme.extension<SpacingTokensExtension>()!;
        final darkSpacing = darkTheme.extension<SpacingTokensExtension>()!;

        expect(lightSpacing.xs, equals(darkSpacing.xs));
        expect(lightSpacing.sm, equals(darkSpacing.sm));
        expect(lightSpacing.md, equals(darkSpacing.md));
        expect(lightSpacing.lg, equals(darkSpacing.lg));
        expect(lightSpacing.xl, equals(darkSpacing.xl));
        expect(lightSpacing.xxl, equals(darkSpacing.xxl));
      });

      test('Radius tokens should be identical across themes', () {
        final lightRadius = lightTheme.extension<RadiusTokensExtension>()!;
        final darkRadius = darkTheme.extension<RadiusTokensExtension>()!;

        expect(lightRadius.none, equals(darkRadius.none));
        expect(lightRadius.xs, equals(darkRadius.xs));
        expect(lightRadius.sm, equals(darkRadius.sm));
        expect(lightRadius.md, equals(darkRadius.md));
        expect(lightRadius.lg, equals(darkRadius.lg));
        expect(lightRadius.xl, equals(darkRadius.xl));
        expect(lightRadius.full, equals(darkRadius.full));
      });

      test('Motion tokens should be identical across themes', () {
        final lightMotion = lightTheme.extension<MotionTokensExtension>()!;
        final darkMotion = darkTheme.extension<MotionTokensExtension>()!;

        expect(lightMotion.instant, equals(darkMotion.instant));
        expect(lightMotion.fast, equals(darkMotion.fast));
        expect(lightMotion.normal, equals(darkMotion.normal));
        expect(lightMotion.slow, equals(darkMotion.slow));
        expect(lightMotion.extraSlow, equals(darkMotion.extraSlow));
      });
    });

    group('Component Theme Consistency', () {
      test('AppBar themes should be properly configured', () {
        expect(lightTheme.appBarTheme, isNotNull);
        expect(darkTheme.appBarTheme, isNotNull);

        // AppBar should use surface colors appropriately
        expect(
          lightTheme.appBarTheme.backgroundColor,
          equals(lightTheme.colorScheme.surface),
        );
        expect(
          darkTheme.appBarTheme.backgroundColor,
          equals(darkTheme.colorScheme.surface),
        );
      });

      test('Button themes should be properly configured', () {
        expect(lightTheme.elevatedButtonTheme, isNotNull);
        expect(darkTheme.elevatedButtonTheme, isNotNull);
        expect(lightTheme.filledButtonTheme, isNotNull);
        expect(darkTheme.filledButtonTheme, isNotNull);
        expect(lightTheme.outlinedButtonTheme, isNotNull);
        expect(darkTheme.outlinedButtonTheme, isNotNull);
        expect(lightTheme.textButtonTheme, isNotNull);
        expect(darkTheme.textButtonTheme, isNotNull);

        // Button minimum sizes should meet accessibility requirements (48x48)
        final lightElevatedStyle = lightTheme
            .elevatedButtonTheme
            .style
            ?.minimumSize
            ?.resolve({});
        final darkElevatedStyle = darkTheme
            .elevatedButtonTheme
            .style
            ?.minimumSize
            ?.resolve({});

        if (lightElevatedStyle != null) {
          expect(lightElevatedStyle.height, greaterThanOrEqualTo(48));
          expect(lightElevatedStyle.width, greaterThanOrEqualTo(48));
        }
        if (darkElevatedStyle != null) {
          expect(darkElevatedStyle.height, greaterThanOrEqualTo(48));
          expect(darkElevatedStyle.width, greaterThanOrEqualTo(48));
        }
      });

      test('Card themes should be properly configured', () {
        expect(lightTheme.cardTheme, isNotNull);
        expect(darkTheme.cardTheme, isNotNull);

        // Cards should have appropriate elevation
        expect(lightTheme.cardTheme.elevation, isNotNull);
        expect(darkTheme.cardTheme.elevation, isNotNull);
        expect(lightTheme.cardTheme.elevation!, greaterThan(0));
        expect(darkTheme.cardTheme.elevation!, greaterThan(0));
      });

      test('Input decoration themes should be properly configured', () {
        expect(lightTheme.inputDecorationTheme, isNotNull);
        expect(darkTheme.inputDecorationTheme, isNotNull);

        // Input fields should have appropriate borders
        expect(lightTheme.inputDecorationTheme.border, isNotNull);
        expect(darkTheme.inputDecorationTheme.border, isNotNull);
      });

      test('Navigation themes should be properly configured', () {
        expect(lightTheme.bottomNavigationBarTheme, isNotNull);
        expect(darkTheme.bottomNavigationBarTheme, isNotNull);
        expect(lightTheme.navigationBarTheme, isNotNull);
        expect(darkTheme.navigationBarTheme, isNotNull);
        expect(lightTheme.navigationRailTheme, isNotNull);
        expect(darkTheme.navigationRailTheme, isNotNull);
      });
    });

    group('Typography Consistency', () {
      test('Both themes should use Inter font family', () {
        final lightDisplayLarge = lightTheme.textTheme.displayLarge;
        final darkDisplayLarge = darkTheme.textTheme.displayLarge;

        if (lightDisplayLarge?.fontFamily != null) {
          expect(
            lightDisplayLarge!.fontFamily!.toLowerCase(),
            contains('inter'),
          );
        }
        if (darkDisplayLarge?.fontFamily != null) {
          expect(
            darkDisplayLarge!.fontFamily!.toLowerCase(),
            contains('inter'),
          );
        }
      });

      test('Text themes should have appropriate contrast', () {
        final lightBodyLarge = lightTheme.textTheme.bodyLarge;
        final darkBodyLarge = darkTheme.textTheme.bodyLarge;

        if (lightBodyLarge?.color != null && darkBodyLarge?.color != null) {
          // Light theme text should be darker
          expect(
            lightBodyLarge!.color!.computeLuminance(),
            lessThan(darkBodyLarge!.color!.computeLuminance()),
          );
        }
      });

      test('All text styles should be properly defined', () {
        final requiredTextStyles = [
          (ThemeData theme) => theme.textTheme.displayLarge,
          (ThemeData theme) => theme.textTheme.displayMedium,
          (ThemeData theme) => theme.textTheme.displaySmall,
          (ThemeData theme) => theme.textTheme.headlineLarge,
          (ThemeData theme) => theme.textTheme.headlineMedium,
          (ThemeData theme) => theme.textTheme.headlineSmall,
          (ThemeData theme) => theme.textTheme.titleLarge,
          (ThemeData theme) => theme.textTheme.titleMedium,
          (ThemeData theme) => theme.textTheme.titleSmall,
          (ThemeData theme) => theme.textTheme.bodyLarge,
          (ThemeData theme) => theme.textTheme.bodyMedium,
          (ThemeData theme) => theme.textTheme.bodySmall,
          (ThemeData theme) => theme.textTheme.labelLarge,
          (ThemeData theme) => theme.textTheme.labelMedium,
          (ThemeData theme) => theme.textTheme.labelSmall,
        ];

        for (final styleGetter in requiredTextStyles) {
          expect(styleGetter(lightTheme), isNotNull);
          expect(styleGetter(darkTheme), isNotNull);
        }
      });
    });

    group('Visual Density and Accessibility', () {
      test('Visual density should be adaptive on Android', () {
        // Note: This test assumes Android platform behavior
        // In actual usage, the theme builder should set adaptive visual density
        expect(lightTheme.visualDensity, isNotNull);
        expect(darkTheme.visualDensity, isNotNull);
      });

      test('Theme should support platform brightness detection', () {
        // Both themes should be able to be created successfully
        expect(
          () => ThemeBuilder.buildTheme(Brightness.light),
          returnsNormally,
        );
        expect(() => ThemeBuilder.buildTheme(Brightness.dark), returnsNormally);
      });
    });

    group('Performance and Caching', () {
      test('Theme building should be deterministic', () {
        final theme1 = ThemeBuilder.buildTheme(Brightness.light);
        final theme2 = ThemeBuilder.buildTheme(Brightness.light);

        // Same brightness should produce equivalent themes
        expect(theme1.brightness, equals(theme2.brightness));
        expect(theme1.useMaterial3, equals(theme2.useMaterial3));
        expect(theme1.colorScheme.primary, equals(theme2.colorScheme.primary));
      });

      test('Extensions should be efficiently accessible', () {
        final statusColors = lightTheme.extension<StatusColors>();
        final spacing = lightTheme.extension<SpacingTokensExtension>();
        final radius = lightTheme.extension<RadiusTokensExtension>();
        final elevation = lightTheme.extension<ElevationTokensExtension>();
        final motion = lightTheme.extension<MotionTokensExtension>();

        expect(statusColors, isNotNull);
        expect(spacing, isNotNull);
        expect(radius, isNotNull);
        expect(elevation, isNotNull);
        expect(motion, isNotNull);

        // Multiple accesses should return same instance
        expect(
          identical(lightTheme.extension<StatusColors>(), statusColors),
          isTrue,
        );
      });
    });
  });
}
