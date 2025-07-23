/// Simplified Performance Integration Tests
///
/// Basic performance tests for theme providers
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Test mocks
import 'theme_test_mocks.dart';

/// Performance benchmarking utilities
class PerformanceBenchmark {
  static const Duration reasonableThreshold = Duration(milliseconds: 100);

  static Duration measureSync(void Function() operation) {
    final stopwatch = Stopwatch()..start();
    operation();
    stopwatch.stop();
    return stopwatch.elapsed;
  }
}

/// Simplified performance integration test suite
void main() {
  group('Simplified Performance Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(overrides: integrationTestOverrides);
    });

    tearDown(() async {
      container.dispose();
      await Future.delayed(const Duration(milliseconds: 10));
    });

    group('Provider Access Performance', () {
      testWidgets('should have fast theme data provider access', (
        WidgetTester tester,
      ) async {
        final duration = PerformanceBenchmark.measureSync(() {
          final themeData = container.read(mockCurrentThemeDataProvider);
          expect(themeData, isNotNull);
        });

        expect(
          duration,
          lessThan(PerformanceBenchmark.reasonableThreshold),
          reason:
              'Theme data access should be fast: ${duration.inMilliseconds}ms',
        );
      });

      testWidgets('should have efficient theme extension access', (
        WidgetTester tester,
      ) async {
        final duration = PerformanceBenchmark.measureSync(() {
          final statusColors = container.read(mockStatusColorsProvider);
          final spacingTokens = container.read(mockSpacingProvider);
          final radiusTokens = container.read(mockRadiusProvider);

          expect(statusColors, isNotNull);
          expect(spacingTokens, isNotNull);
          expect(radiusTokens, isNotNull);
        });

        expect(
          duration,
          lessThan(PerformanceBenchmark.reasonableThreshold),
          reason:
              'Theme extension access should be efficient: ${duration.inMilliseconds}ms',
        );
      });
    });

    group('Bulk Operations Performance', () {
      testWidgets('should have efficient bulk provider access', (
        WidgetTester tester,
      ) async {
        final duration = PerformanceBenchmark.measureSync(() {
          final themeData = container.read(mockCurrentThemeDataProvider);
          final lightTheme = container.read(mockLightThemeProvider);
          final darkTheme = container.read(mockDarkThemeProvider);
          final systemBrightness = container.read(mockSystemBrightnessProvider);
          final effectiveMode = container.read(mockEffectiveThemeModeProvider);

          expect(themeData, isNotNull);
          expect(lightTheme, isNotNull);
          expect(darkTheme, isNotNull);
          expect(
            [Brightness.light, Brightness.dark].contains(systemBrightness),
            isTrue,
          );
          expect(
            [ThemeMode.light, ThemeMode.dark].contains(effectiveMode),
            isTrue,
          );
        });

        expect(
          duration,
          lessThan(PerformanceBenchmark.reasonableThreshold),
          reason:
              'Bulk provider access should be efficient: ${duration.inMilliseconds}ms',
        );
      });
    });

    group('Container Lifecycle Performance', () {
      testWidgets('should handle container lifecycle efficiently', (
        WidgetTester tester,
      ) async {
        final duration = PerformanceBenchmark.measureSync(() {
          for (int i = 0; i < 3; i++) {
            final testContainer = ProviderContainer(
              overrides: integrationTestOverrides,
            );

            try {
              final themeData = testContainer.read(
                mockCurrentThemeDataProvider,
              );
              expect(themeData, isNotNull);
            } finally {
              testContainer.dispose();
            }
          }
        });

        expect(
          duration,
          lessThan(PerformanceBenchmark.reasonableThreshold),
          reason:
              'Container lifecycle should be efficient: ${duration.inMilliseconds}ms',
        );
      });
    });
  });
}
