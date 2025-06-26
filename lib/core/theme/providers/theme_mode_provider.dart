import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/storage/storage_providers.dart';

/// Theme mode state management provider
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Notifier for managing theme mode state and persistence
class ThemeModeNotifier extends Notifier<ThemeMode> {
  late final SharedPreferences _prefs;
  static const String _kKey = 'theme_mode';

  @override
  ThemeMode build() {
    _prefs = ref.watch(sharedPrefsProvider);
    final index = _prefs.getInt(_kKey) ?? ThemeMode.system.index;

    // Validate index is within valid range
    if (index < 0 || index >= ThemeMode.values.length) {
      return ThemeMode.system;
    }

    return ThemeMode.values[index];
  }

  /// Toggle theme mode and persist the change
  Future<void> toggle(ThemeMode mode) async {
    state = mode;
    await _prefs.setInt(_kKey, mode.index);
  }

  /// Get next theme mode in cycle (system -> light -> dark -> system)
  ThemeMode getNextMode() {
    switch (state) {
      case ThemeMode.system:
        return ThemeMode.light;
      case ThemeMode.light:
        return ThemeMode.dark;
      case ThemeMode.dark:
        return ThemeMode.system;
    }
  }

  /// Cycle to next theme mode
  Future<void> cycle() async {
    await toggle(getNextMode());
  }
}
