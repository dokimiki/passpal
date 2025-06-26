import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passpal/core/storage/prefs/shared_prefs_user_prefs.dart';
import 'package:passpal/core/storage/errors/storage_exception.dart';

import 'shared_prefs_user_prefs_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  group('SharedPrefsUserPrefs', () {
    late MockSharedPreferences mockPrefs;
    late SharedPrefsUserPrefs userPrefs;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      userPrefs = SharedPrefsUserPrefs(mockPrefs);
    });

    group('theme', () {
      test('should return system theme when no preference stored', () {
        when(mockPrefs.getString('pref.theme')).thenReturn(null);

        expect(userPrefs.theme, equals(ThemeMode.system));
      });

      test('should return light theme when stored', () {
        when(mockPrefs.getString('pref.theme')).thenReturn('light');

        expect(userPrefs.theme, equals(ThemeMode.light));
      });

      test('should return dark theme when stored', () {
        when(mockPrefs.getString('pref.theme')).thenReturn('dark');

        expect(userPrefs.theme, equals(ThemeMode.dark));
      });

      test('should return system theme for invalid value', () {
        when(mockPrefs.getString('pref.theme')).thenReturn('invalid');

        expect(userPrefs.theme, equals(ThemeMode.system));
      });

      test('should return system theme when exception occurs', () {
        when(mockPrefs.getString('pref.theme')).thenThrow(Exception('Error'));

        expect(userPrefs.theme, equals(ThemeMode.system));
      });
    });

    group('setTheme', () {
      test('should save light theme', () async {
        when(mockPrefs.setString('pref.theme', 'light'))
            .thenAnswer((_) async => true);

        await userPrefs.setTheme(ThemeMode.light);

        verify(mockPrefs.setString('pref.theme', 'light')).called(1);
      });

      test('should save dark theme', () async {
        when(mockPrefs.setString('pref.theme', 'dark'))
            .thenAnswer((_) async => true);

        await userPrefs.setTheme(ThemeMode.dark);

        verify(mockPrefs.setString('pref.theme', 'dark')).called(1);
      });

      test('should save system theme', () async {
        when(mockPrefs.setString('pref.theme', 'system'))
            .thenAnswer((_) async => true);

        await userPrefs.setTheme(ThemeMode.system);

        verify(mockPrefs.setString('pref.theme', 'system')).called(1);
      });

      test('should throw KvIoException when save fails', () async {
        when(mockPrefs.setString('pref.theme', any))
            .thenThrow(Exception('Prefs error'));

        await expectLater(
          () => userPrefs.setTheme(ThemeMode.light),
          throwsA(isA<KvIoException>()
              .having((e) => e.operation, 'operation', 'setTheme')
              .having((e) => e.message, 'message', contains('Failed to save theme preference'))),
        );
      });
    });

    group('campus', () {
      test('should return null when no campus stored', () {
        when(mockPrefs.getString('pref.campus')).thenReturn(null);

        expect(userPrefs.campus, isNull);
      });

      test('should return stored campus', () {
        when(mockPrefs.getString('pref.campus')).thenReturn('toyota');

        expect(userPrefs.campus, equals('toyota'));
      });

      test('should return null when exception occurs', () {
        when(mockPrefs.getString('pref.campus')).thenThrow(Exception('Error'));

        expect(userPrefs.campus, isNull);
      });
    });

    group('setCampus', () {
      test('should save campus', () async {
        when(mockPrefs.setString('pref.campus', 'nagoya'))
            .thenAnswer((_) async => true);

        await userPrefs.setCampus('nagoya');

        verify(mockPrefs.setString('pref.campus', 'nagoya')).called(1);
      });

      test('should throw KvIoException when save fails', () async {
        when(mockPrefs.setString('pref.campus', any))
            .thenThrow(Exception('Prefs error'));

        await expectLater(
          () => userPrefs.setCampus('nagoya'),
          throwsA(isA<KvIoException>()
              .having((e) => e.operation, 'operation', 'setCampus')
              .having((e) => e.message, 'message', contains('Failed to save campus preference'))),
        );
      });
    });

    group('notificationsEnabled', () {
      test('should return true when no preference stored', () {
        when(mockPrefs.getBool('pref.notifications_enabled')).thenReturn(null);

        expect(userPrefs.notificationsEnabled, isTrue);
      });

      test('should return stored value', () {
        when(mockPrefs.getBool('pref.notifications_enabled')).thenReturn(false);

        expect(userPrefs.notificationsEnabled, isFalse);
      });

      test('should return true when exception occurs', () {
        when(mockPrefs.getBool('pref.notifications_enabled')).thenThrow(Exception('Error'));

        expect(userPrefs.notificationsEnabled, isTrue);
      });
    });

    group('setNotificationsEnabled', () {
      test('should save notifications enabled state', () async {
        when(mockPrefs.setBool('pref.notifications_enabled', false))
            .thenAnswer((_) async => true);

        await userPrefs.setNotificationsEnabled(false);

        verify(mockPrefs.setBool('pref.notifications_enabled', false)).called(1);
      });

      test('should throw KvIoException when save fails', () async {
        when(mockPrefs.setBool('pref.notifications_enabled', any))
            .thenThrow(Exception('Prefs error'));

        await expectLater(
          () => userPrefs.setNotificationsEnabled(true),
          throwsA(isA<KvIoException>()
              .having((e) => e.operation, 'operation', 'setNotificationsEnabled')
              .having((e) => e.message, 'message', contains('Failed to save notifications preference'))),
        );
      });
    });
  });
}
