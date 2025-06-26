import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/theme/providers/theme_mode_provider.dart';
import 'package:passpal/core/storage/storage_providers.dart';

@GenerateMocks([SharedPreferences])
import 'theme_mode_provider_test.mocks.dart';

void main() {
  group('ThemeModeNotifier', () {
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

    test('should return system mode by default', () {
      when(mockPrefs.getInt('theme_mode')).thenReturn(null);

      final themeMode = container.read(themeModeProvider);

      expect(themeMode, equals(ThemeMode.system));
    });

    test('should restore saved theme mode', () {
      when(mockPrefs.getInt('theme_mode')).thenReturn(ThemeMode.dark.index);

      final themeMode = container.read(themeModeProvider);

      expect(themeMode, equals(ThemeMode.dark));
    });

    test('should toggle theme mode and persist', () async {
      when(mockPrefs.getInt('theme_mode')).thenReturn(ThemeMode.system.index);
      when(mockPrefs.setInt('theme_mode', any)).thenAnswer((_) async => true);

      final notifier = container.read(themeModeProvider.notifier);
      await notifier.toggle(ThemeMode.light);

      expect(container.read(themeModeProvider), equals(ThemeMode.light));
      verify(mockPrefs.setInt('theme_mode', ThemeMode.light.index)).called(1);
    });

    test('should handle invalid saved index gracefully', () {
      when(mockPrefs.getInt('theme_mode')).thenReturn(999);

      final themeMode = container.read(themeModeProvider);
      expect(themeMode, equals(ThemeMode.system));
    });

    test('should support all theme modes', () async {
      when(mockPrefs.getInt('theme_mode')).thenReturn(ThemeMode.system.index);
      when(mockPrefs.setInt('theme_mode', any)).thenAnswer((_) async => true);

      final notifier = container.read(themeModeProvider.notifier);

      // Test System mode
      await notifier.toggle(ThemeMode.system);
      expect(container.read(themeModeProvider), equals(ThemeMode.system));

      // Test Light mode
      await notifier.toggle(ThemeMode.light);
      expect(container.read(themeModeProvider), equals(ThemeMode.light));

      // Test Dark mode
      await notifier.toggle(ThemeMode.dark);
      expect(container.read(themeModeProvider), equals(ThemeMode.dark));
    });

    test('should cycle through theme modes', () async {
      when(mockPrefs.getInt('theme_mode')).thenReturn(ThemeMode.system.index);
      when(mockPrefs.setInt('theme_mode', any)).thenAnswer((_) async => true);

      final notifier = container.read(themeModeProvider.notifier);

      // Start with system
      expect(container.read(themeModeProvider), equals(ThemeMode.system));

      // Cycle to light
      await notifier.cycle();
      expect(container.read(themeModeProvider), equals(ThemeMode.light));

      // Cycle to dark
      await notifier.cycle();
      expect(container.read(themeModeProvider), equals(ThemeMode.dark));

      // Cycle back to system
      await notifier.cycle();
      expect(container.read(themeModeProvider), equals(ThemeMode.system));
    });
  });
}
