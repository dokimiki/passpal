/// Simplified Theme-Config Integration Tests
///
/// Basic tests to ensure theme works independently of config
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Test mocks
import 'theme_test_mocks.dart';

/// Simplified integration test suite for theme-config integration
void main() {
  group('Simplified Theme-Config Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(overrides: integrationTestOverrides);
    });

    tearDown(() async {
      container.dispose();
      await Future.delayed(const Duration(milliseconds: 10));
    });

    group('Theme Independence', () {
      testWidgets('should work without config dependencies', (
        WidgetTester tester,
      ) async {
        final themeData = container.read(mockCurrentThemeDataProvider);
        expect(themeData, isNotNull);
        expect(themeData.useMaterial3, isTrue);

        // Verify theme works without config
        expect(themeData.colorScheme, isNotNull);
        expect(themeData.textTheme, isNotNull);
      });

      testWidgets('should provide all theme extensions', (
        WidgetTester tester,
      ) async {
        final statusColors = container.read(mockStatusColorsProvider);
        final spacingTokens = container.read(mockSpacingProvider);

        expect(statusColors, isNotNull);
        expect(spacingTokens, isNotNull);
      });
    });

    group('Theme Consistency', () {
      testWidgets('should maintain theme consistency', (
        WidgetTester tester,
      ) async {
        final lightTheme = container.read(mockLightThemeProvider);
        final darkTheme = container.read(mockDarkThemeProvider);

        // Both themes should have consistent structure
        expect(lightTheme.useMaterial3, equals(darkTheme.useMaterial3));
        expect(lightTheme.extensions.keys, equals(darkTheme.extensions.keys));

        // Verify Material 3 support
        expect(lightTheme.useMaterial3, isTrue);
        expect(darkTheme.useMaterial3, isTrue);
      });
    });

    group('System Integration', () {
      testWidgets('should integrate with system settings', (
        WidgetTester tester,
      ) async {
        final systemBrightness = container.read(mockSystemBrightnessProvider);
        final effectiveMode = container.read(mockEffectiveThemeModeProvider);

        expect(
          [Brightness.light, Brightness.dark].contains(systemBrightness),
          isTrue,
        );
        expect(
          [ThemeMode.light, ThemeMode.dark].contains(effectiveMode),
          isTrue,
        );
      });
    });
  });
}
