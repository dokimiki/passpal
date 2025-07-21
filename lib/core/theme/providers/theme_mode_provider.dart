import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../storage/providers.dart' hide ThemeMode;
import '../../storage/models/preference_types.dart' as storage;

part 'theme_mode_provider.g.dart';

/// Provider for theme mode with system brightness detection
///
/// This provider integrates with the storage core to persist theme mode
/// preferences and provides system brightness detection for automatic
/// theme switching when ThemeMode.system is selected.
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  Future<ThemeMode> build() async {
    // Listen to system brightness changes
    _listenToSystemBrightness();

    // Get the stored theme mode from storage and convert to Flutter ThemeMode
    final storageThemeMode = await ref.read(themeModeProvider.future);
    return _convertFromStorageThemeMode(storageThemeMode);
  }

  /// Update the theme mode and persist to storage
  Future<void> setThemeMode(ThemeMode mode) async {
    state = const AsyncValue.loading();

    try {
      // Convert to storage theme mode and update in storage
      final storageMode = _convertToStorageThemeMode(mode);
      await ref.read(updateThemeModeProvider(storageMode).future);

      // Update local state
      state = AsyncValue.data(mode);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Listen to system brightness changes for automatic theme switching
  void _listenToSystemBrightness() {
    // Get platform brightness dispatcher if available
    try {
      final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
      platformDispatcher.onPlatformBrightnessChanged = () {
        // Only refresh if current mode is system
        ref.read(themeModeProvider.future).then((currentMode) {
          if (currentMode == storage.ThemeMode.system) {
            // Invalidate to trigger rebuild with new system brightness
            ref.invalidateSelf();
          }
        });
      };
    } catch (_) {
      // Fallback for platforms that don't support brightness detection
      // This will just use the stored preference without system detection
    }
  }

  /// Convert from storage ThemeMode to Flutter ThemeMode
  ThemeMode _convertFromStorageThemeMode(storage.ThemeMode storageMode) {
    switch (storageMode) {
      case storage.ThemeMode.system:
        return ThemeMode.system;
      case storage.ThemeMode.light:
        return ThemeMode.light;
      case storage.ThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  /// Convert from Flutter ThemeMode to storage ThemeMode
  storage.ThemeMode _convertToStorageThemeMode(ThemeMode flutterMode) {
    switch (flutterMode) {
      case ThemeMode.system:
        return storage.ThemeMode.system;
      case ThemeMode.light:
        return storage.ThemeMode.light;
      case ThemeMode.dark:
        return storage.ThemeMode.dark;
    }
  }
}

/// Provider for effective theme mode (resolves system to light/dark)
///
/// This provider takes the theme mode preference and resolves ThemeMode.system
/// to either ThemeMode.light or ThemeMode.dark based on system brightness.
@riverpod
ThemeMode effectiveThemeMode(Ref ref) {
  final themeModeAsync = ref.watch(themeModeNotifierProvider);

  return themeModeAsync.when(
    data: (themeMode) {
      if (themeMode == ThemeMode.system) {
        // Get system brightness
        final brightness = _getSystemBrightness();
        return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      }
      return themeMode;
    },
    loading: () => _getSystemBrightness() == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light,
    error: (_, _) => _getSystemBrightness() == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light,
  );
}

/// Provider for current system brightness
///
/// This provider provides access to the current system brightness setting.
@riverpod
Brightness systemBrightness(Ref ref) {
  return _getSystemBrightness();
}

/// Provider for theme mode display name
///
/// This provider converts ThemeMode enum values to user-friendly display names.
@riverpod
String themeModeDisplayName(Ref ref, ThemeMode mode) {
  switch (mode) {
    case ThemeMode.system:
      return 'システム';
    case ThemeMode.light:
      return 'ライト';
    case ThemeMode.dark:
      return 'ダーク';
  }
}

/// Provider for checking if dark mode is active
///
/// This provider returns true if the effective theme mode is dark.
@riverpod
bool isDarkMode(Ref ref) {
  final effectiveMode = ref.watch(effectiveThemeModeProvider);
  return effectiveMode == ThemeMode.dark;
}

/// Provider for available theme modes with display names
///
/// This provider returns a map of all available theme modes with their
/// user-friendly display names for use in settings UI.
@riverpod
Map<ThemeMode, String> availableThemeModes(Ref ref) {
  return {
    for (final mode in ThemeMode.values)
      mode: ref.read(themeModeDisplayNameProvider(mode)),
  };
}

/// Helper function to get system brightness safely
Brightness _getSystemBrightness() {
  try {
    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
    return platformDispatcher.platformBrightness;
  } catch (_) {
    // Fallback to light mode if brightness detection fails
    return Brightness.light;
  }
}
