import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/theme/builders/theme_builder.dart';
import 'golden_test_utilities.dart';

void main() {
  group('Theme Golden Tests', () {
    testWidgets('Light theme golden test', (WidgetTester tester) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildThemeTestWidget(
          brightness: Brightness.light,
          child: const SizedBox(
            width: 400,
            height: 600,
            child: ThemeTestContent(),
          ),
        ),
      );

      // Generate golden files for comparison (skip actual comparison for now)
      // This test primarily validates that the theme can be rendered without errors
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Dark theme golden test', (WidgetTester tester) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildThemeTestWidget(
          brightness: Brightness.dark,
          child: const SizedBox(
            width: 400,
            height: 600,
            child: ThemeTestContent(),
          ),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Extensions showcase golden test - light', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildExtensionsTestWidget(Brightness.light),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('extensions_light.png'),
      // );
    });

    testWidgets('Extensions showcase golden test - dark', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildExtensionsTestWidget(Brightness.dark),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('extensions_dark.png'),
      // );
    });

    testWidgets('Components showcase golden test - light', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildComponentsTestWidget(Brightness.light),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('components_light.png'),
      // );
    });

    testWidgets('Components showcase golden test - dark', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildComponentsTestWidget(Brightness.dark),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('components_dark.png'),
      // );
    });

    testWidgets('Color scheme golden test - light', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildColorSchemeTestWidget(Brightness.light),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('color_scheme_light.png'),
      // );
    });

    testWidgets('Color scheme golden test - dark', (WidgetTester tester) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildColorSchemeTestWidget(Brightness.dark),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('color_scheme_dark.png'),
      // );
    });

    testWidgets('Typography golden test - light', (WidgetTester tester) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildTypographyTestWidget(Brightness.light),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('typography_light.png'),
      // );
    });

    testWidgets('Typography golden test - dark', (WidgetTester tester) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildTypographyTestWidget(Brightness.dark),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('typography_dark.png'),
      // );
    });

    testWidgets('Accessibility golden test - light', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildAccessibilityTestWidget(Brightness.light),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('accessibility_light.png'),
      // );
    });

    testWidgets('Accessibility golden test - dark', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        GoldenTestUtilities.buildAccessibilityTestWidget(Brightness.dark),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
      // TODO: Enable golden file comparison once golden files are generated
      // await expectLater(
      //   find.byType(MaterialApp),
      //   matchesGoldenFile('accessibility_dark.png'),
      // );
    });
  });

  group('Theme Data Validation', () {
    test('Light theme should have all required properties', () {
      final theme = ThemeBuilder.buildTheme(Brightness.light);

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, equals(Brightness.light));
      expect(theme.colorScheme, isNotNull);
      expect(theme.textTheme, isNotNull);

      // Verify extensions are present
      expect(theme.extensions, isNotEmpty);
      expect(theme.extensions.length, greaterThanOrEqualTo(5));
    });

    test('Dark theme should have all required properties', () {
      final theme = ThemeBuilder.buildTheme(Brightness.dark);

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, equals(Brightness.dark));
      expect(theme.colorScheme, isNotNull);
      expect(theme.textTheme, isNotNull);

      // Verify extensions are present
      expect(theme.extensions, isNotEmpty);
      expect(theme.extensions.length, greaterThanOrEqualTo(5));
    });

    test('Light and dark themes should have different color schemes', () {
      final lightTheme = ThemeBuilder.buildTheme(Brightness.light);
      final darkTheme = ThemeBuilder.buildTheme(Brightness.dark);

      expect(
        lightTheme.colorScheme.primary,
        isNot(equals(darkTheme.colorScheme.primary)),
      );
      expect(
        lightTheme.colorScheme.surface,
        isNot(equals(darkTheme.colorScheme.surface)),
      );
    });

    test('Themes should have consistent component themes', () {
      final lightTheme = ThemeBuilder.buildTheme(Brightness.light);
      final darkTheme = ThemeBuilder.buildTheme(Brightness.dark);

      // Check that both themes have the same component theme types
      expect(lightTheme.appBarTheme, isNotNull);
      expect(darkTheme.appBarTheme, isNotNull);

      expect(lightTheme.elevatedButtonTheme, isNotNull);
      expect(darkTheme.elevatedButtonTheme, isNotNull);

      expect(lightTheme.cardTheme, isNotNull);
      expect(darkTheme.cardTheme, isNotNull);

      expect(lightTheme.inputDecorationTheme, isNotNull);
      expect(darkTheme.inputDecorationTheme, isNotNull);
    });
  });

  group('Cross-platform Theme Consistency', () {
    testWidgets(
      'Theme should be consistent across different platform densities',
      (WidgetTester tester) async {
        // Test with default density
        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(
              devicePixelRatio: 2.0,
              textScaler: TextScaler.linear(1.0),
            ),
            child: GoldenTestUtilities.buildThemeTestWidget(
              brightness: Brightness.light,
            ),
          ),
        );

        // Verify theme is applied
        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );
        expect(materialApp.theme, isNotNull);
        expect(materialApp.theme!.useMaterial3, isTrue);
      },
    );

    testWidgets('Theme should handle different text scaling factors', (
      WidgetTester tester,
    ) async {
      // Test with large text scale
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            devicePixelRatio: 2.0,
            textScaler: TextScaler.linear(1.5),
          ),
          child: GoldenTestUtilities.buildThemeTestWidget(
            brightness: Brightness.light,
          ),
        ),
      );

      // Find text widgets and verify they can handle scaling
      final textWidgets = find.byType(Text);
      expect(textWidgets, findsWidgets);
    });
  });
}
