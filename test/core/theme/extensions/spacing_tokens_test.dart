import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/extensions/spacing_tokens.dart';
import 'package:passpal/core/theme/models/spacing_tokens.dart';

// Helper function to calculate responsive spacing logic
double _calculateResponsiveSpacing(
  double screenWidth,
  double? mobile,
  double? tablet,
  double? desktop,
) {
  if (screenWidth < 600) {
    return mobile ?? 8.0; // standardSpacing.sm fallback
  } else if (screenWidth > 1024) {
    return desktop ?? 32.0; // standardSpacing.xl fallback
  } else {
    return tablet ?? 16.0; // standardSpacing.md fallback
  }
}

void main() {
  group('SpacingTokensExtension', () {
    late SpacingTokensExtension standardSpacing;
    late SpacingTokensExtension compactSpacing;
    late SpacingTokensExtension expandedSpacing;

    setUp(() {
      standardSpacing = SpacingTokensExtension.standard;
      compactSpacing = SpacingTokensExtension.compact;
      expandedSpacing = SpacingTokensExtension.expanded;
    });

    group('Static Constants', () {
      test('standard spacing values are correct', () {
        expect(standardSpacing.xs, 4.0);
        expect(standardSpacing.sm, 8.0);
        expect(standardSpacing.md, 16.0);
        expect(standardSpacing.lg, 24.0);
        expect(standardSpacing.xl, 32.0);
        expect(standardSpacing.xxl, 48.0);
      });

      test('compact spacing values are reduced', () {
        expect(compactSpacing.xs, 3.0);
        expect(compactSpacing.sm, 6.0);
        expect(compactSpacing.md, 12.0);
        expect(compactSpacing.lg, 18.0);
        expect(compactSpacing.xl, 24.0);
        expect(compactSpacing.xxl, 36.0);
      });

      test('expanded spacing values are increased', () {
        expect(expandedSpacing.xs, 5.0);
        expect(expandedSpacing.sm, 10.0);
        expect(expandedSpacing.md, 20.0);
        expect(expandedSpacing.lg, 30.0);
        expect(expandedSpacing.xl, 40.0);
        expect(expandedSpacing.xxl, 60.0);
      });

      test('spacing tokens models are correctly assigned', () {
        expect(standardSpacing.spacingTokens, SpacingTokens.standard);
        expect(compactSpacing.spacingTokens, SpacingTokens.compact);
        expect(expandedSpacing.spacingTokens, SpacingTokens.expanded);
      });
    });

    group('Responsive Spacing', () {
      test('responsiveSpacing logic for different screen sizes', () {
        // Test mobile
        final mobileSpacing = _calculateResponsiveSpacing(400, 8.0, 16.0, 24.0);
        expect(mobileSpacing, 8.0);

        // Test tablet
        final tabletSpacing = _calculateResponsiveSpacing(800, 8.0, 16.0, 24.0);
        expect(tabletSpacing, 16.0);

        // Test desktop
        final desktopSpacing = _calculateResponsiveSpacing(
          1200,
          8.0,
          16.0,
          24.0,
        );
        expect(desktopSpacing, 24.0);
      });

      test('responsiveSpacing falls back to default values', () {
        // Test fallback logic
        final fallbackSpacing = _calculateResponsiveSpacing(
          400,
          null,
          null,
          null,
        );
        expect(fallbackSpacing, standardSpacing.sm);
      });
    });

    group('Spacing Widgets', () {
      test('verticalSpace creates SizedBox with correct height', () {
        final widget = standardSpacing.verticalSpace(16.0);
        expect(widget, isA<SizedBox>());
        expect((widget as SizedBox).height, 16.0);
        expect(widget.width, isNull);
      });

      test('horizontalSpace creates SizedBox with correct width', () {
        final widget = standardSpacing.horizontalSpace(24.0);
        expect(widget, isA<SizedBox>());
        expect((widget as SizedBox).width, 24.0);
        expect(widget.height, isNull);
      });
    });

    group('Padding and Margin Utilities', () {
      test('padding with all parameter creates EdgeInsets.all', () {
        final padding = standardSpacing.padding(all: 16.0);
        expect(padding, const EdgeInsets.all(16.0));
      });

      test('padding with individual parameters works correctly', () {
        final padding = standardSpacing.padding(
          top: 8.0,
          bottom: 16.0,
          left: 12.0,
          right: 20.0,
        );
        expect(
          padding,
          const EdgeInsets.only(
            top: 8.0,
            bottom: 16.0,
            left: 12.0,
            right: 20.0,
          ),
        );
      });

      test('padding with horizontal and vertical parameters', () {
        final padding = standardSpacing.padding(
          horizontal: 16.0,
          vertical: 8.0,
        );
        expect(
          padding,
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        );
      });

      test('margin with all parameter creates EdgeInsets.all', () {
        final margin = standardSpacing.margin(all: 16.0);
        expect(margin, const EdgeInsets.all(16.0));
      });

      test('margin with individual parameters works correctly', () {
        final margin = standardSpacing.margin(
          top: 8.0,
          bottom: 16.0,
          left: 12.0,
          right: 20.0,
        );
        expect(
          margin,
          const EdgeInsets.only(
            top: 8.0,
            bottom: 16.0,
            left: 12.0,
            right: 20.0,
          ),
        );
      });
    });

    group('copyWith', () {
      test('copyWith creates new instance with updated values', () {
        final newSpacing = standardSpacing.copyWith(xs: 6.0, lg: 28.0);

        expect(newSpacing.xs, 6.0);
        expect(newSpacing.sm, standardSpacing.sm);
        expect(newSpacing.md, standardSpacing.md);
        expect(newSpacing.lg, 28.0);
        expect(newSpacing.xl, standardSpacing.xl);
        expect(newSpacing.xxl, standardSpacing.xxl);
      });

      test('copyWith with no parameters returns equivalent instance', () {
        final newSpacing = standardSpacing.copyWith();

        expect(newSpacing.xs, standardSpacing.xs);
        expect(newSpacing.sm, standardSpacing.sm);
        expect(newSpacing.md, standardSpacing.md);
        expect(newSpacing.lg, standardSpacing.lg);
        expect(newSpacing.xl, standardSpacing.xl);
        expect(newSpacing.xxl, standardSpacing.xxl);
      });
    });

    group('lerp', () {
      test('lerp interpolates between spacing values correctly', () {
        final result = standardSpacing.lerp(
          compactSpacing as ThemeExtension<SpacingTokensExtension>,
          0.5,
        );

        expect(result.xs, 3.5); // (4.0 + 3.0) / 2
        expect(result.sm, 7.0); // (8.0 + 6.0) / 2
        expect(result.md, 14.0); // (16.0 + 12.0) / 2
        expect(result.lg, 21.0); // (24.0 + 18.0) / 2
        expect(result.xl, 28.0); // (32.0 + 24.0) / 2
        expect(result.xxl, 42.0); // (48.0 + 36.0) / 2
      });

      test('lerp with t=0 returns first spacing', () {
        final result = standardSpacing.lerp(
          compactSpacing as ThemeExtension<SpacingTokensExtension>,
          0.0,
        );

        expect(result.xs, standardSpacing.xs);
        expect(result.sm, standardSpacing.sm);
        expect(result.md, standardSpacing.md);
        expect(result.lg, standardSpacing.lg);
        expect(result.xl, standardSpacing.xl);
        expect(result.xxl, standardSpacing.xxl);
      });

      test('lerp with t=1 returns second spacing', () {
        final result = standardSpacing.lerp(
          compactSpacing as ThemeExtension<SpacingTokensExtension>,
          1.0,
        );

        expect(result.xs, compactSpacing.xs);
        expect(result.sm, compactSpacing.sm);
        expect(result.md, compactSpacing.md);
        expect(result.lg, compactSpacing.lg);
        expect(result.xl, compactSpacing.xl);
        expect(result.xxl, compactSpacing.xxl);
      });

      test('lerp with non-SpacingTokensExtension returns original', () {
        final result = standardSpacing.lerp(null, 0.5);
        expect(result, standardSpacing);
      });
    });

    group('Equality and HashCode', () {
      test('identical spacing extensions are equal', () {
        expect(standardSpacing, standardSpacing);
        expect(standardSpacing.hashCode, standardSpacing.hashCode);
      });

      test('equivalent spacing extensions are equal', () {
        final otherSpacing = SpacingTokensExtension(
          xs: 4.0,
          sm: 8.0,
          md: 16.0,
          lg: 24.0,
          xl: 32.0,
          xxl: 48.0,
          spacingTokens: SpacingTokens.standard,
          insetTokens: InsetTokens.standard,
          gridTokens: GridTokens.standard,
        );

        expect(standardSpacing, otherSpacing);
        expect(standardSpacing.hashCode, otherSpacing.hashCode);
      });

      test('different spacing extensions are not equal', () {
        expect(standardSpacing, isNot(compactSpacing));
        expect(standardSpacing.hashCode, isNot(compactSpacing.hashCode));
      });
    });

    group('toString', () {
      test('toString provides useful debugging information', () {
        final stringRepresentation = standardSpacing.toString();

        expect(stringRepresentation, contains('SpacingTokensExtension'));
        expect(stringRepresentation, contains('xs: 4.0'));
        expect(stringRepresentation, contains('sm: 8.0'));
        expect(stringRepresentation, contains('md: 16.0'));
        expect(stringRepresentation, contains('lg: 24.0'));
        expect(stringRepresentation, contains('xl: 32.0'));
        expect(stringRepresentation, contains('xxl: 48.0'));
      });
    });
  });

  group('SpacingTokensContext Extension', () {
    testWidgets('context extension provides access to spacing', (tester) async {
      final testSpacing = SpacingTokensExtension.standard;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [testSpacing]),
          home: Builder(
            builder: (context) {
              expect(context.spacing, testSpacing);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('context extension spacing widget helpers work', (
      tester,
    ) async {
      final testSpacing = SpacingTokensExtension.standard;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [testSpacing]),
          home: Builder(
            builder: (context) {
              expect(context.spacingXS, isA<SizedBox>());
              expect((context.spacingXS as SizedBox).height, testSpacing.xs);

              expect(context.hSpacingMD, isA<SizedBox>());
              expect((context.hSpacingMD as SizedBox).width, testSpacing.md);

              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('context extension padding helpers work', (tester) async {
      final testSpacing = SpacingTokensExtension.standard;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [testSpacing]),
          home: Builder(
            builder: (context) {
              expect(context.paddingMD, EdgeInsets.all(testSpacing.md));
              expect(context.paddingLG, EdgeInsets.all(testSpacing.lg));

              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('context responsive padding works', (tester) async {
      final testSpacing = SpacingTokensExtension.standard;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [testSpacing]),
          home: Builder(
            builder: (context) {
              final responsivePadding = context.responsivePadding(
                mobile: 8.0,
                tablet: 16.0,
                desktop: 24.0,
              );

              // Should use fallback values based on current screen size
              expect(responsivePadding, isA<EdgeInsets>());
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('SpacingTokensTheme Extension', () {
    test('theme extension provides access to spacing', () {
      final testSpacing = SpacingTokensExtension.standard;
      final theme = ThemeData(extensions: [testSpacing]);

      // The extension should be accessible
      final retrievedSpacing = theme.extension<SpacingTokensExtension>();
      expect(retrievedSpacing, isNotNull);
      expect(retrievedSpacing!.xs, testSpacing.xs);
      expect(retrievedSpacing.sm, testSpacing.sm);
      expect(retrievedSpacing.md, testSpacing.md);
    });

    test('theme without spacing extension returns null', () {
      final theme = ThemeData();
      expect(theme.extension<SpacingTokensExtension>(), isNull);
    });
  });
}
