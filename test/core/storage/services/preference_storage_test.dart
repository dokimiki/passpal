import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:passpal/core/storage/interfaces/preference_storage_interface.dart';
import 'package:passpal/core/storage/models/preference_types.dart';
import 'package:passpal/core/storage/services/preference_storage.dart';
import 'package:passpal/core/storage/testing/mock_preference_storage.dart';

void main() {
  group('PreferenceStorage', () {
    late PreferenceStorage storage;
    late SharedPreferences sharedPreferences;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      storage = PreferenceStorage(sharedPreferences: sharedPreferences);
    });

    tearDown(() {
      storage.dispose();
    });

    group('get', () {
      test('returns default value when key does not exist', () async {
        final result = await storage.get(PreferenceKeys.themeMode);

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not fail'),
          (value) => expect(value, equals(ThemeMode.system)),
        );
      });

      test('returns stored value when key exists', () async {
        // Set a value first
        await storage.set(PreferenceKeys.themeMode, ThemeMode.dark);

        final result = await storage.get(PreferenceKeys.themeMode);

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not fail'),
          (value) => expect(value, equals(ThemeMode.dark)),
        );
      });

      test('returns default value when invalid enum value is stored', () async {
        // Manually set an invalid value
        await sharedPreferences.setString('pref_theme_mode', 'invalid_theme');

        final result = await storage.get(PreferenceKeys.themeMode);

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not fail'),
          (value) =>
              expect(value, equals(ThemeMode.system)), // Falls back to default
        );
      });

      test('returns failure when DateTime parsing fails', () async {
        // Manually set an invalid DateTime value
        await sharedPreferences.setString(
          'pref_last_sync_timestamp',
          'invalid_date',
        );

        final result = await storage.get(PreferenceKeys.lastSyncTimestamp);

        expect(result.isLeft(), true);
      });
    });

    group('set', () {
      test('stores value successfully', () async {
        final result = await storage.set(
          PreferenceKeys.selectedCampus,
          Campus.toyota,
        );

        expect(result.isRight(), true);

        // Verify the value was stored
        final getValue = await storage.get(PreferenceKeys.selectedCampus);
        getValue.fold(
          (_) => fail('Should not fail'),
          (value) => expect(value, equals(Campus.toyota)),
        );
      });

      test('emits change event when value is set', () async {
        final events = <PreferenceEvent>[];
        final subscription = storage.changes.listen(events.add);

        await storage.set(PreferenceKeys.assignmentNotifications, false);

        await Future.delayed(const Duration(milliseconds: 10));

        expect(events, hasLength(1));
        expect(events.first, isA<PreferenceChanged>());
        final event = events.first as PreferenceChanged;
        expect(event.keyName, equals('assignment_notifications'));
        expect(event.value, equals(false));

        await subscription.cancel();
      });

      test('emits to watchers when value is set', () async {
        final values = <bool?>[];
        final subscription = storage
            .watch(PreferenceKeys.assignmentNotifications)
            .listen(values.add);

        await Future.delayed(
          const Duration(milliseconds: 10),
        ); // Wait for initial value
        await storage.set(PreferenceKeys.assignmentNotifications, false);
        await Future.delayed(const Duration(milliseconds: 10));

        expect(values, hasLength(2));
        expect(values[0], equals(true)); // Default value
        expect(values[1], equals(false)); // Set value

        await subscription.cancel();
      });
    });

    group('delete', () {
      test('removes existing preference', () async {
        // Set a value first
        await storage.set(PreferenceKeys.enableAnalytics, false);

        final deleteResult = await storage.delete(
          PreferenceKeys.enableAnalytics,
        );
        expect(deleteResult.isRight(), true);

        // Verify the value is gone and returns default
        final getValue = await storage.get(PreferenceKeys.enableAnalytics);
        getValue.fold(
          (_) => fail('Should not fail'),
          (value) => expect(value, equals(true)), // Default value
        );
      });

      test('succeeds even when key does not exist', () async {
        final result = await storage.delete(PreferenceKeys.enableAnalytics);
        expect(result.isRight(), true);
      });

      test('emits removal event when preference is deleted', () async {
        await storage.set(PreferenceKeys.enableCrashReporting, false);

        final events = <PreferenceEvent>[];
        final subscription = storage.changes.listen(events.add);

        await storage.delete(PreferenceKeys.enableCrashReporting);

        await Future.delayed(const Duration(milliseconds: 10));

        expect(events, hasLength(1));
        expect(events.first, isA<PreferenceRemoved>());
        final event = events.first as PreferenceRemoved;
        expect(event.keyName, equals('enable_crash_reporting'));

        await subscription.cancel();
      });
    });

    group('containsKey', () {
      test('returns true when key exists', () async {
        await storage.set(PreferenceKeys.isFirstLaunch, false);

        final result = await storage.containsKey(PreferenceKeys.isFirstLaunch);

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not fail'),
          (exists) => expect(exists, true),
        );
      });

      test('returns false when key does not exist', () async {
        final result = await storage.containsKey(PreferenceKeys.isFirstLaunch);

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not fail'),
          (exists) => expect(exists, false),
        );
      });
    });

    group('clear', () {
      test('removes all preferences', () async {
        // Set multiple values
        await storage.set(PreferenceKeys.themeMode, ThemeMode.dark);
        await storage.set(PreferenceKeys.selectedCampus, Campus.toyota);
        await storage.set(PreferenceKeys.assignmentNotifications, false);

        final clearResult = await storage.clear();
        expect(clearResult.isRight(), true);

        // Verify all values return defaults
        final theme = await storage.get(PreferenceKeys.themeMode);
        final campus = await storage.get(PreferenceKeys.selectedCampus);
        final notifications = await storage.get(
          PreferenceKeys.assignmentNotifications,
        );

        theme.fold(
          (_) => fail('Should not fail'),
          (v) => expect(v, ThemeMode.system),
        );
        campus.fold(
          (_) => fail('Should not fail'),
          (v) => expect(v, Campus.nagoya),
        );
        notifications.fold(
          (_) => fail('Should not fail'),
          (v) => expect(v, true),
        );
      });

      test('emits removal events for all cleared preferences', () async {
        await storage.set(PreferenceKeys.themeMode, ThemeMode.dark);
        await storage.set(PreferenceKeys.selectedCampus, Campus.toyota);

        final events = <PreferenceEvent>[];
        final subscription = storage.changes.listen(events.add);

        await storage.clear();

        await Future.delayed(const Duration(milliseconds: 10));

        expect(events, hasLength(2));
        expect(events.every((e) => e is PreferenceRemoved), true);

        await subscription.cancel();
      });
    });

    group('getAllKeys', () {
      test('returns empty list when no preferences exist', () async {
        final result = await storage.getAllKeys();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should not fail'),
          (keys) => expect(keys, isEmpty),
        );
      });

      test('returns all preference keys', () async {
        await storage.set(PreferenceKeys.themeMode, ThemeMode.dark);
        await storage.set(PreferenceKeys.selectedCampus, Campus.toyota);

        final result = await storage.getAllKeys();

        expect(result.isRight(), true);
        result.fold((_) => fail('Should not fail'), (keys) {
          expect(keys, hasLength(2));
          expect(keys, contains('theme_mode'));
          expect(keys, contains('selected_campus'));
        });
      });
    });

    group('watch', () {
      test('emits current value immediately', () async {
        await storage.set(PreferenceKeys.languageCode, 'en');

        final values = <String?>[];
        final subscription = storage
            .watch(PreferenceKeys.languageCode)
            .listen(values.add);

        await Future.delayed(const Duration(milliseconds: 10));

        expect(values, hasLength(1));
        expect(values.first, equals('en'));

        await subscription.cancel();
      });

      test('emits updates when preference changes', () async {
        final values = <NotificationFrequency?>[];
        final subscription = storage
            .watch(PreferenceKeys.notificationFrequency)
            .listen(values.add);

        await Future.delayed(
          const Duration(milliseconds: 10),
        ); // Wait for initial value
        await storage.set(
          PreferenceKeys.notificationFrequency,
          NotificationFrequency.daily,
        );
        await Future.delayed(const Duration(milliseconds: 10));
        await storage.set(
          PreferenceKeys.notificationFrequency,
          NotificationFrequency.weekly,
        );
        await Future.delayed(const Duration(milliseconds: 10));

        expect(values, hasLength(3));
        expect(values[0], equals(NotificationFrequency.immediate)); // Default
        expect(values[1], equals(NotificationFrequency.daily));
        expect(values[2], equals(NotificationFrequency.weekly));

        await subscription.cancel();
      });
    });
  });

  group('MockPreferenceStorage', () {
    late MockPreferenceStorage mockStorage;

    setUp(() {
      mockStorage = MockPreferenceStorage();
    });

    tearDown(() {
      mockStorage.dispose();
    });

    test('behaves like real implementation', () async {
      // Test basic operations
      final setResult = await mockStorage.set(
        PreferenceKeys.themeMode,
        ThemeMode.dark,
      );
      expect(setResult.isRight(), true);

      final getResult = await mockStorage.get(PreferenceKeys.themeMode);
      expect(getResult.isRight(), true);
      getResult.fold(
        (_) => fail('Should not fail'),
        (value) => expect(value, equals(ThemeMode.dark)),
      );
    });

    test('can simulate errors', () async {
      final errorStorage = MockPreferenceStorage(
        simulateErrors: true,
        errorProbability: 1.0, // Always fail
      );

      final result = await errorStorage.get(PreferenceKeys.themeMode);
      expect(result.isLeft(), true);

      errorStorage.dispose();
    });

    test('provides initial data', () async {
      final storageWithData = MockPreferenceStorage(
        initialData: {'theme_mode': 'dark'},
      );

      final result = await storageWithData.get(PreferenceKeys.themeMode);
      result.fold(
        (_) => fail('Should not fail'),
        (value) => expect(value, equals(ThemeMode.dark)),
      );

      storageWithData.dispose();
    });
  });
}
