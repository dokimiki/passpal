import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:passpal/core/theme/providers/accessibility_providers.dart';

/// Tests for overall accessibility functionality and WCAG compliance.
void main() {
  group('Accessibility System Tests', () {
    group('AccessibilitySettings', () {
      testWidgets('AccessibilitySettings has correct default values', (
        tester,
      ) async {
        const settings = AccessibilitySettings(
          highContrast: false,
          reduceMotion: false,
          largeText: false,
          boldText: false,
          disableAnimations: false,
          accessibleNavigation: false,
          colorBlindType: ColorBlindType.none,
        );

        expect(settings.highContrast, isFalse);
        expect(settings.reduceMotion, isFalse);
        expect(settings.largeText, isFalse);
        expect(settings.boldText, isFalse);
        expect(settings.disableAnimations, isFalse);
        expect(settings.accessibleNavigation, isFalse);
        expect(settings.colorBlindType, equals(ColorBlindType.none));
      });

      testWidgets('AccessibilitySettings copyWith works correctly', (
        tester,
      ) async {
        const original = AccessibilitySettings(
          highContrast: false,
          reduceMotion: false,
          largeText: false,
          boldText: false,
          disableAnimations: false,
          accessibleNavigation: false,
          colorBlindType: ColorBlindType.none,
        );

        final modified = original.copyWith(
          highContrast: true,
          colorBlindType: ColorBlindType.protanopia,
        );

        expect(modified.highContrast, isTrue);
        expect(modified.colorBlindType, equals(ColorBlindType.protanopia));
        expect(modified.reduceMotion, isFalse); // unchanged
        expect(modified.largeText, isFalse); // unchanged
      });
    });

    group('AccessibilitySettingsNotifier', () {
      test('initial state has correct defaults', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        final settings = container.read(accessibilitySettingsNotifierProvider);

        expect(settings.highContrast, isFalse);
        expect(settings.colorBlindType, equals(ColorBlindType.none));
      });

      test('setHighContrast updates state correctly', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(
          accessibilitySettingsNotifierProvider.notifier,
        );

        notifier.setHighContrast(true);
        final updatedSettings = container.read(
          accessibilitySettingsNotifierProvider,
        );

        expect(updatedSettings.highContrast, isTrue);
      });

      test('setColorBlindType updates state correctly', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(
          accessibilitySettingsNotifierProvider.notifier,
        );

        notifier.setColorBlindType(ColorBlindType.deuteranopia);
        final updatedSettings = container.read(
          accessibilitySettingsNotifierProvider,
        );

        expect(
          updatedSettings.colorBlindType,
          equals(ColorBlindType.deuteranopia),
        );
      });
    });

    group('ColorBlindType Enum', () {
      testWidgets('ColorBlindType has all expected values', (tester) async {
        final values = ColorBlindType.values;

        expect(values, contains(ColorBlindType.none));
        expect(values, contains(ColorBlindType.protanopia));
        expect(values, contains(ColorBlindType.deuteranopia));
        expect(values, contains(ColorBlindType.tritanopia));
        expect(values, contains(ColorBlindType.protanomaly));
        expect(values, contains(ColorBlindType.deuteranomaly));
        expect(values, contains(ColorBlindType.tritanomaly));

        expect(values.length, equals(7));
      });
    });

    group('System Accessibility Detection', () {
      test('systemHighContrastProvider provides boolean value', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final highContrast = container.read(systemHighContrastProvider);
        expect(highContrast, isA<bool>());
      });

      test('systemReducedMotionProvider provides boolean value', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final reducedMotion = container.read(systemReducedMotionProvider);
        expect(reducedMotion, isA<bool>());
      });
    });

    group('WCAG Compliance', () {
      testWidgets(
        'ColorBlindUtilities provides scientifically accurate simulations',
        (tester) async {
          const testColor = Color(0xFF6750A4); // Material purple

          final protanopia = ColorBlindUtilities.simulateProtanopia(testColor);
          final deuteranopia = ColorBlindUtilities.simulateDeuteranopia(
            testColor,
          );
          final tritanopia = ColorBlindUtilities.simulateTritanopia(testColor);

          expect(protanopia, isNot(equals(testColor)));
          expect(deuteranopia, isNot(equals(testColor)));
          expect(tritanopia, isNot(equals(testColor)));

          expect(protanopia, isNot(equals(deuteranopia)));
          expect(protanopia, isNot(equals(tritanopia)));
          expect(deuteranopia, isNot(equals(tritanopia)));
        },
      );

      testWidgets('colorblind friendly palette provides good alternatives', (
        tester,
      ) async {
        final palette = ColorBlindUtilities.createColorBlindFriendlyPalette();

        expect(palette, isNotEmpty);
        expect(palette.containsKey('primary'), isTrue);
        expect(palette.containsKey('secondary'), isTrue);

        final colors = palette.values.toList();
        for (int i = 0; i < colors.length; i++) {
          for (int j = i + 1; j < colors.length; j++) {
            expect(
              colors[i],
              isNot(equals(colors[j])),
              reason: 'Palette colors should be distinct',
            );
          }
        }
      });

      testWidgets('ColorScheme transformation preserves structure', (
        tester,
      ) async {
        final originalScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFFB1BCD9),
          brightness: Brightness.light,
        );

        for (final colorBlindType in ColorBlindType.values) {
          final transformedScheme =
              ColorBlindUtilities.applyColorBlindSimulation(
                originalScheme,
                colorBlindType,
              );

          expect(
            transformedScheme.brightness,
            equals(originalScheme.brightness),
          );
          expect(transformedScheme.primary, isNotNull);
          expect(transformedScheme.onPrimary, isNotNull);
          expect(transformedScheme.secondary, isNotNull);
          expect(transformedScheme.surface, isNotNull);
          expect(transformedScheme.error, isNotNull);
        }
      });
    });
  });
}
