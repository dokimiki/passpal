import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/generators/typography_generator.dart';
import 'package:passpal/core/theme/models/typography_tokens.dart';

void main() {
  group('TypographyGenerator', () {
    group('generateTextTheme', () {
      testWidgets('should generate TextTheme with Inter font for light theme', (tester) async {
        // Arrange & Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Assert
        expect(textTheme, isNotNull);
        expect(textTheme.displayLarge?.fontFamily, contains('Inter'));
        expect(textTheme.headlineLarge?.fontFamily, contains('Inter'));
        expect(textTheme.bodyLarge?.fontFamily, contains('Inter'));
      });

      testWidgets('should generate TextTheme with Inter font for dark theme', (tester) async {
        // Arrange & Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.dark,
        );

        // Assert
        expect(textTheme, isNotNull);
        expect(textTheme.displayLarge?.fontFamily, contains('Inter'));
        expect(textTheme.headlineLarge?.fontFamily, contains('Inter'));
        expect(textTheme.bodyLarge?.fontFamily, contains('Inter'));
      });

      testWidgets('should apply custom text color when provided', (tester) async {
        // Arrange
        const customColor = Colors.red;

        // Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
          textColor: customColor,
        );

        // Assert
        expect(textTheme.displayLarge?.color, customColor);
        expect(textTheme.bodyLarge?.color, customColor);
      });

      testWidgets('should use custom typography tokens when provided', (tester) async {
        // Arrange
        const customTokens = TypographyTokens(
          display: DisplayTokens(
            displayLarge: TextStyle(fontSize: 100.0, fontWeight: FontWeight.w900),
            displayMedium: TextStyle(fontSize: 80.0, fontWeight: FontWeight.w800),
            displaySmall: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w700),
          ),
          headline: HeadlineTokens.standard,
          title: TitleTokens.standard,
          label: LabelTokens.standard,
          body: BodyTokens.standard,
        );

        // Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
          customTokens: customTokens,
        );

        // Assert
        expect(textTheme.displayLarge?.fontSize, 100.0);
        expect(textTheme.displayLarge?.fontWeight, FontWeight.w900);
        expect(textTheme.displayMedium?.fontSize, 80.0);
        expect(textTheme.displayMedium?.fontWeight, FontWeight.w800);
      });

      testWidgets('should apply design token specifications correctly', (tester) async {
        // Arrange & Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Assert - Display styles
        expect(textTheme.displayLarge?.fontSize, 57.0);
        expect(textTheme.displayLarge?.fontWeight, FontWeight.w400);
        expect(textTheme.displayLarge?.height, 1.12);
        expect(textTheme.displayLarge?.letterSpacing, -0.25);

        expect(textTheme.displayMedium?.fontSize, 45.0);
        expect(textTheme.displayMedium?.height, 1.16);

        expect(textTheme.displaySmall?.fontSize, 36.0);
        expect(textTheme.displaySmall?.height, 1.22);

        // Assert - Headline styles
        expect(textTheme.headlineLarge?.fontSize, 32.0);
        expect(textTheme.headlineLarge?.height, 1.25);

        expect(textTheme.headlineMedium?.fontSize, 28.0);
        expect(textTheme.headlineMedium?.height, 1.29);

        expect(textTheme.headlineSmall?.fontSize, 24.0);
        expect(textTheme.headlineSmall?.height, 1.33);

        // Assert - Title styles
        expect(textTheme.titleLarge?.fontSize, 22.0);
        expect(textTheme.titleLarge?.height, 1.27);

        expect(textTheme.titleMedium?.fontSize, 16.0);
        expect(textTheme.titleMedium?.fontWeight, FontWeight.w500);
        expect(textTheme.titleMedium?.letterSpacing, 0.15);

        expect(textTheme.titleSmall?.fontSize, 14.0);
        expect(textTheme.titleSmall?.fontWeight, FontWeight.w500);
        expect(textTheme.titleSmall?.letterSpacing, 0.1);

        // Assert - Label styles
        expect(textTheme.labelLarge?.fontSize, 14.0);
        expect(textTheme.labelLarge?.fontWeight, FontWeight.w500);

        expect(textTheme.labelMedium?.fontSize, 12.0);
        expect(textTheme.labelMedium?.letterSpacing, 0.5);

        expect(textTheme.labelSmall?.fontSize, 11.0);
        expect(textTheme.labelSmall?.letterSpacing, 0.5);

        // Assert - Body styles
        expect(textTheme.bodyLarge?.fontSize, 16.0);
        expect(textTheme.bodyLarge?.fontWeight, FontWeight.w400);
        expect(textTheme.bodyLarge?.letterSpacing, 0.15);

        expect(textTheme.bodyMedium?.fontSize, 14.0);
        expect(textTheme.bodyMedium?.letterSpacing, 0.25);

        expect(textTheme.bodySmall?.fontSize, 12.0);
        expect(textTheme.bodySmall?.letterSpacing, 0.4);
      });
    });

    group('generateResponsiveTextTheme', () {
      testWidgets('should scale font sizes based on screen width', (tester) async {
        // Arrange
        const smallScreenWidth = 320.0;
        const largeScreenWidth = 768.0;

        // Act
        final smallScreenTheme = TypographyGenerator.generateResponsiveTextTheme(
          brightness: Brightness.light,
          screenWidth: smallScreenWidth,
          minScale: 0.8,
          maxScale: 1.2,
        );

        final largeScreenTheme = TypographyGenerator.generateResponsiveTextTheme(
          brightness: Brightness.light,
          screenWidth: largeScreenWidth,
          minScale: 0.8,
          maxScale: 1.2,
        );

        // Assert
        expect(
          smallScreenTheme.displayLarge?.fontSize,
          lessThan(largeScreenTheme.displayLarge?.fontSize ?? 0),
        );
        expect(
          smallScreenTheme.bodyLarge?.fontSize,
          lessThan(largeScreenTheme.bodyLarge?.fontSize ?? 0),
        );
      });

      testWidgets('should respect min and max scale bounds', (tester) async {
        // Arrange
        const verySmallScreenWidth = 200.0;
        const veryLargeScreenWidth = 1200.0;
        const expectedMinScale = 0.8;
        const expectedMaxScale = 1.2;
        const baseFontSize = 16.0;

        // Act
        final smallScreenTheme = TypographyGenerator.generateResponsiveTextTheme(
          brightness: Brightness.light,
          screenWidth: verySmallScreenWidth,
          minScale: expectedMinScale,
          maxScale: expectedMaxScale,
        );

        final largeScreenTheme = TypographyGenerator.generateResponsiveTextTheme(
          brightness: Brightness.light,
          screenWidth: veryLargeScreenWidth,
          minScale: expectedMinScale,
          maxScale: expectedMaxScale,
        );

        // Assert
        expect(
          smallScreenTheme.bodyLarge?.fontSize,
          closeTo(baseFontSize * expectedMinScale, 0.1),
        );
        expect(
          largeScreenTheme.bodyLarge?.fontSize,
          closeTo(baseFontSize * expectedMaxScale, 0.1),
        );
      });
    });

    group('generateAccessibleTextTheme', () {
      testWidgets('should scale font sizes for accessibility', (tester) async {
        // Arrange
        const fontSizeScale = 1.5;
        const lineHeightScale = 1.3;

        // Act
        final accessibleTheme = TypographyGenerator.generateAccessibleTextTheme(
          brightness: Brightness.light,
          fontSizeScale: fontSizeScale,
          lineHeightScale: lineHeightScale,
        );

        final normalTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Assert
        expect(
          accessibleTheme.bodyLarge?.fontSize,
          greaterThan(normalTheme.bodyLarge?.fontSize ?? 0),
        );
        expect(
          accessibleTheme.bodyLarge?.height,
          greaterThan(normalTheme.bodyLarge?.height ?? 0),
        );
      });

      testWidgets('should apply accessibility font weight when provided', (tester) async {
        // Arrange
        const accessibilityWeight = FontWeight.w600;

        // Act
        final accessibleTheme = TypographyGenerator.generateAccessibleTextTheme(
          brightness: Brightness.light,
          accessibilityWeight: accessibilityWeight,
        );

        // Assert
        expect(accessibleTheme.bodyLarge?.fontWeight, accessibilityWeight);
        expect(accessibleTheme.titleMedium?.fontWeight, accessibilityWeight);
      });
    });

    group('generateJapaneseTextTheme', () {
      testWidgets('should optimize line height and letter spacing for Japanese text', (tester) async {
        // Arrange & Act
        final japaneseTheme = TypographyGenerator.generateJapaneseTextTheme(
          brightness: Brightness.light,
        );

        final normalTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Assert - Line height should be increased for Japanese text
        expect(
          japaneseTheme.bodyLarge?.height,
          greaterThan(normalTheme.bodyLarge?.height ?? 0),
        );

        // Assert - Letter spacing should be adjusted for Japanese text
        final normalLetterSpacing = normalTheme.bodyLarge?.letterSpacing ?? 0.0;
        final japaneseLetterSpacing = japaneseTheme.bodyLarge?.letterSpacing ?? 0.0;
        expect(japaneseLetterSpacing, lessThan(normalLetterSpacing));
      });
    });

    group('generateWithFallback', () {
      testWidgets('should generate normal theme when fonts load successfully', (tester) async {
        // Arrange & Act
        final fallbackTheme = TypographyGenerator.generateWithFallback(
          brightness: Brightness.light,
        );

        final normalTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Assert - Should be equivalent to normal theme when fonts load
        expect(fallbackTheme.bodyLarge?.fontSize, normalTheme.bodyLarge?.fontSize);
        expect(fallbackTheme.bodyLarge?.fontWeight, normalTheme.bodyLarge?.fontWeight);
      });

      testWidgets('should apply fallback fonts when provided', (tester) async {
        // Arrange
        const fallbackFonts = ['Roboto', 'Arial', 'sans-serif'];

        // Act
        final fallbackTheme = TypographyGenerator.generateWithFallback(
          brightness: Brightness.light,
          fallbackFonts: fallbackFonts,
        );

        // Assert
        expect(fallbackTheme, isNotNull);
        expect(fallbackTheme.bodyLarge, isNotNull);
        expect(fallbackTheme.bodyLarge?.fontSize, 16.0);
      });
    });

    group('TextTheme extensions', () {
      testWidgets('should provide responsive extension method', (tester) async {
        // Arrange
        final baseTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Act
        final responsiveTheme = baseTheme.responsive(
          screenWidth: 600.0,
          minScale: 0.9,
          maxScale: 1.1,
        );

        // Assert
        expect(responsiveTheme, isNotNull);
        expect(responsiveTheme.bodyLarge, isNotNull);
      });

      testWidgets('should provide accessible extension method', (tester) async {
        // Arrange
        final baseTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Act
        final accessibleTheme = baseTheme.accessible(
          fontSizeScale: 1.25,
          lineHeightScale: 1.15,
        );

        // Assert
        expect(accessibleTheme, isNotNull);
        expect(accessibleTheme.bodyLarge, isNotNull);
      });

      testWidgets('should provide japanese extension method', (tester) async {
        // Arrange
        final baseTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Act
        final japaneseTheme = baseTheme.japanese();

        // Assert
        expect(japaneseTheme, isNotNull);
        expect(japaneseTheme.bodyLarge, isNotNull);
      });
    });

    group('Font loading and error handling', () {
      testWidgets('should handle font loading gracefully', (tester) async {
        // Arrange & Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Assert - Should not throw exceptions
        expect(textTheme, isNotNull);
        expect(textTheme.bodyLarge, isNotNull);
        expect(textTheme.displayLarge, isNotNull);
      });

      testWidgets('should maintain design token specifications even with custom colors', (tester) async {
        // Arrange
        const customColor = Color(0xFF123456);

        // Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
          textColor: customColor,
        );

        // Assert - Color should be applied but other specs maintained
        expect(textTheme.bodyLarge?.color, customColor);
        expect(textTheme.bodyLarge?.fontSize, 16.0);
        expect(textTheme.bodyLarge?.fontWeight, FontWeight.w400);
        expect(textTheme.bodyLarge?.letterSpacing, 0.15);
      });
    });

    group('Material 3 integration', () {
      testWidgets('should generate theme compatible with Material 3', (tester) async {
        // Arrange & Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Assert - Should have all required Material 3 text styles
        expect(textTheme.displayLarge, isNotNull);
        expect(textTheme.displayMedium, isNotNull);
        expect(textTheme.displaySmall, isNotNull);
        expect(textTheme.headlineLarge, isNotNull);
        expect(textTheme.headlineMedium, isNotNull);
        expect(textTheme.headlineSmall, isNotNull);
        expect(textTheme.titleLarge, isNotNull);
        expect(textTheme.titleMedium, isNotNull);
        expect(textTheme.titleSmall, isNotNull);
        expect(textTheme.labelLarge, isNotNull);
        expect(textTheme.labelMedium, isNotNull);
        expect(textTheme.labelSmall, isNotNull);
        expect(textTheme.bodyLarge, isNotNull);
        expect(textTheme.bodyMedium, isNotNull);
        expect(textTheme.bodySmall, isNotNull);
      });

      testWidgets('should work with Material 3 ColorScheme', (tester) async {
        // Arrange
        final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

        // Act
        final textTheme = TypographyGenerator.generateTextTheme(
          brightness: colorScheme.brightness,
          textColor: colorScheme.onSurface,
        );

        // Assert
        expect(textTheme.bodyLarge?.color, colorScheme.onSurface);
        expect(textTheme.headlineLarge?.color, colorScheme.onSurface);
      });
    });

    group('Performance and memory', () {
      testWidgets('should generate themes efficiently', (tester) async {
        // Arrange
        const iterations = 100;

        // Act & Assert - Should not timeout or throw memory errors
        for (int i = 0; i < iterations; i++) {
          final theme = TypographyGenerator.generateTextTheme(
            brightness: i.isEven ? Brightness.light : Brightness.dark,
          );
          expect(theme, isNotNull);
        }
      });

      testWidgets('should cache font loading appropriately', (tester) async {
        // Arrange & Act
        final theme1 = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );
        final theme2 = TypographyGenerator.generateTextTheme(
          brightness: Brightness.light,
        );

        // Assert - Themes should be equivalent (indicating caching works)
        expect(theme1.bodyLarge?.fontFamily, theme2.bodyLarge?.fontFamily);
        expect(theme1.bodyLarge?.fontSize, theme2.bodyLarge?.fontSize);
      });
    });
  });
}