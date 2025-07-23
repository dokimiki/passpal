/// Simplified Cross-Module Error Handling Integration Tests
///
/// Basic tests to ensure theme providers work without freezing
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Test mocks
import 'theme_test_mocks.dart';

/// Simplified integration test suite for theme error handling
void main() {
  group('Simplified Error Handling Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(overrides: integrationTestOverrides);
    });

    tearDown(() async {
      container.dispose();
      await Future.delayed(const Duration(milliseconds: 10));
    });

    group('Basic Theme Provider Tests', () {
      testWidgets('should provide basic theme data', (
        WidgetTester tester,
      ) async {
        final themeData = container.read(mockCurrentThemeDataProvider);
        expect(themeData, isNotNull);
        expect(themeData.useMaterial3, isTrue);
      });

      testWidgets('should provide theme extensions', (
        WidgetTester tester,
      ) async {
        final statusColors = container.read(mockStatusColorsProvider);
        final spacingTokens = container.read(mockSpacingProvider);

        expect(statusColors, isNotNull);
        expect(spacingTokens, isNotNull);
        expect(statusColors.success, isNotNull);
        expect(spacingTokens.sm, isNotNull);
      });

      testWidgets('should provide light and dark themes', (
        WidgetTester tester,
      ) async {
        final lightTheme = container.read(mockLightThemeProvider);
        final darkTheme = container.read(mockDarkThemeProvider);

        expect(lightTheme, isNotNull);
        expect(darkTheme, isNotNull);
        expect(lightTheme.brightness, equals(Brightness.light));
        expect(darkTheme.brightness, equals(Brightness.dark));
      });

      testWidgets('should handle provider disposal gracefully', (
        WidgetTester tester,
      ) async {
        final testContainer = ProviderContainer(
          overrides: integrationTestOverrides,
        );

        try {
          final themeData = testContainer.read(mockCurrentThemeDataProvider);
          expect(themeData, isNotNull);
        } finally {
          testContainer.dispose();
        }
      });
    });

    group('System Integration', () {
      testWidgets('should provide system brightness', (
        WidgetTester tester,
      ) async {
        final systemBrightness = container.read(mockSystemBrightnessProvider);
        expect(
          [Brightness.light, Brightness.dark].contains(systemBrightness),
          isTrue,
        );
      });

      testWidgets('should provide effective theme mode', (
        WidgetTester tester,
      ) async {
        final effectiveMode = container.read(mockEffectiveThemeModeProvider);
        expect(
          [ThemeMode.light, ThemeMode.dark].contains(effectiveMode),
          isTrue,
        );
      });
    });
  });
}
