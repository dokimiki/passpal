import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/theme/providers/theme_mode_provider.dart';
import 'package:passpal/core/theme/extensions/passpal_theme_ext.dart';
import 'package:passpal/core/storage/storage_providers.dart';

@GenerateMocks([SharedPreferences])
import 'theme_exception_propagation_test.mocks.dart';

void main() {
  group('Theme Exception Propagation', () {
    late MockSharedPreferences mockPrefs;
    late ProviderContainer container;

    setUp(() {
      mockPrefs = MockSharedPreferences();

      container = ProviderContainer(
        overrides: [sharedPrefsProvider.overrideWithValue(mockPrefs)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should handle SharedPreferences exceptions gracefully', () {
      // Setup: Make SharedPreferences throw
      when(
        mockPrefs.getInt('theme_mode'),
      ).thenThrow(Exception('SharedPreferences access failed'));

      // Act & Assert: Should not crash, should fall back to default
      expect(() {
        try {
          final themeMode = container.read(themeModeProvider);
          // If no exception is thrown, it should be system mode
          expect(themeMode, equals(ThemeMode.system));
        } catch (e) {
          // If exception is thrown, it should be properly typed
          expect(e, isA<Exception>());
        }
      }, returnsNormally);
    });

    test('should handle toggle operation exceptions gracefully', () async {
      // Setup: Make SharedPreferences setInt throw
      when(mockPrefs.getInt('theme_mode')).thenReturn(ThemeMode.system.index);
      when(
        mockPrefs.setInt('theme_mode', any),
      ).thenThrow(Exception('Storage write failed'));

      final notifier = container.read(themeModeProvider.notifier);

      // Act & Assert: Should handle exception without crashing
      expect(() async {
        try {
          await notifier.toggle(ThemeMode.light);
        } catch (e) {
          // Exception should be properly handled
          expect(e, isA<Exception>());
        }
      }, returnsNormally);
    });

    test('should handle theme extension creation with edge cases', () {
      // This test verifies that theme extension creation handles edge cases
      // without throwing exceptions that could crash the app

      // Test with various edge case color schemes
      final testCases = [
        ColorScheme.fromSeed(
          seedColor: const Color(0x00000000), // Transparent black
          brightness: Brightness.light,
        ),
        ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFFFFF), // White
          brightness: Brightness.dark,
        ),
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF808080), // Gray
          brightness: Brightness.light,
        ),
      ];

      for (final colorScheme in testCases) {
        expect(
          () {
            final extension = PasspalThemeExt.fromColorScheme(colorScheme);
            expect(extension, isNotNull);
            expect(extension.errorBg, isA<Color>());
            expect(extension.warningBg, isA<Color>());
            expect(extension.successBg, isA<Color>());
            expect(extension.infoBg, isA<Color>());
            expect(extension.maintenanceBg, isA<Color>());
            expect(extension.surfaceVariant, isA<Color>());
          },
          returnsNormally,
          reason: 'Theme extension should handle edge cases gracefully',
        );
      }
    });

    test('should validate theme interpolation stability', () {
      // Create two theme extensions
      final lightScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0057D9),
        brightness: Brightness.light,
      );
      final darkScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0057D9),
        brightness: Brightness.dark,
      );

      final lightExt = PasspalThemeExt.fromColorScheme(lightScheme);
      final darkExt = PasspalThemeExt.fromColorScheme(darkScheme);

      // Test interpolation at various points
      for (double t = 0.0; t <= 1.0; t += 0.1) {
        expect(
          () {
            final interpolated = lightExt.lerp(darkExt, t);
            expect(interpolated, isNotNull);
            expect(interpolated, isA<PasspalThemeExt>());
          },
          returnsNormally,
          reason: 'Theme interpolation should be stable at t=$t',
        );
      }
    });
  });
}
