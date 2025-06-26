import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/storage/prefs/user_prefs.dart';
import 'package:passpal/core/storage/errors/storage_exception.dart';

/// SharedPreferencesを使用したUserPrefsの実装
class SharedPrefsUserPrefs implements UserPrefs {
  SharedPrefsUserPrefs(this._prefs);

  final SharedPreferences _prefs;

  static const String _themeKey = 'pref.theme';
  static const String _campusKey = 'pref.campus';
  static const String _notificationsKey = 'pref.notifications_enabled';

  @override
  ThemeMode get theme {
    try {
      final themeString = _prefs.getString(_themeKey);
      switch (themeString) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        case 'system':
        default:
          return ThemeMode.system;
      }
    } catch (e) {
      return ThemeMode.system;
    }
  }

  @override
  Future<void> setTheme(ThemeMode mode) async {
    try {
      final themeString = switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };
      await _prefs.setString(_themeKey, themeString);
    } catch (e) {
      throw KvIoException(
        operation: 'setTheme',
        message: 'Failed to save theme preference',
        cause: e,
      );
    }
  }

  @override
  String? get campus {
    try {
      return _prefs.getString(_campusKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setCampus(String value) async {
    try {
      await _prefs.setString(_campusKey, value);
    } catch (e) {
      throw KvIoException(
        operation: 'setCampus',
        message: 'Failed to save campus preference',
        cause: e,
      );
    }
  }

  @override
  bool get notificationsEnabled {
    try {
      return _prefs.getBool(_notificationsKey) ?? true;
    } catch (e) {
      return true;
    }
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    try {
      await _prefs.setBool(_notificationsKey, enabled);
    } catch (e) {
      throw KvIoException(
        operation: 'setNotificationsEnabled',
        message: 'Failed to save notifications preference',
        cause: e,
      );
    }
  }
}
