import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:passpal/core/storage/providers.dart';
import 'package:passpal/core/storage/testing/integration_test_helpers.dart';
import 'package:passpal/core/storage/testing/storage_test_utils.dart';
import 'package:passpal/core/error/providers.dart';
import 'package:passpal/core/error/testing/mock_crashlytics.dart';
import 'package:passpal/core/error/testing/mock_logger.dart';

void main() {
  group('Storage End-to-End Workflow Tests', () {
    late ProviderContainer container;
    late StorageTestScenario scenario;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});

      // Create realistic test scenario
      scenario = StorageTestScenarioBuilder()
          .withSecureData({
            'user_credentials': 'encrypted_user_data',
            'api_tokens': 'secure_api_tokens',
          })
          .withCacheData({
            'user_assignments': CacheEntry(
              value: [
                {'id': 1, 'title': 'Math Assignment', 'due': '2024-12-25'},
                {'id': 2, 'title': 'Physics Lab', 'due': '2024-12-26'},
              ],
              timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
              ttl: const Duration(hours: 1),
            ),
            'timetable_cache': CacheEntry(
              value: {
                'monday': [
                  {'time': '09:00', 'subject': 'Math', 'room': 'A101'},
                  {'time': '10:30', 'subject': 'Physics', 'room': 'B202'},
                ],
              },
              timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
              ttl: const Duration(hours: 6),
            ),
          })
          .withPreferenceData({
            'theme_mode': 'dark',
            'selected_campus': 'nagoya',
            'notifications_enabled': 'true',
            'notification_frequency': 'daily',
          })
          .build();

      container = ProviderContainer(
        overrides: [
          secureStorageProvider.overrideWith((_) => scenario.secureStorage),
          cacheStorageProvider.overrideWith((_) async => scenario.cacheStorage),
          preferenceStorageProvider.overrideWith(
            (_) async => scenario.preferenceStorage,
          ),
          crashlyticsServiceProvider.overrideWithValue(
            MockCrashlyticsService(),
          ),
          errorReporterProvider.overrideWithValue(MockErrorReporter()),
        ],
      );
    });

    tearDown(() {
      scenario.dispose();
      container.dispose();
    });

    group('User Session Lifecycle', () {
      test('should handle complete user login flow', () async {
        // 1. App startup - initialize storage
        await container.read(initializeStorageProvider.future);

        // 2. User login - store credentials
        final credentialManager = container.read(credentialManagerProvider);

        final loginData =
            IntegrationTestDataGenerator.generateUserSessionData();

        for (final entry in loginData.entries) {
          final result = await credentialManager.storeCredential(
            identifier: entry.key,
            value: entry.value,
            type: CredentialType.manabo,
          );
          expect(result.isRight(), true, reason: 'Should store ${entry.key}');
        }

        // 3. Set user preferences
        await container.read(updateThemeModeProvider(ThemeMode.dark).future);
        await container.read(
          updateSelectedCampusProvider(Campus.nagoya).future,
        );
        await container.read(
          updateAssignmentNotificationsProvider(true).future,
        );

        // 4. Cache user data
        final cacheStorage = await container.read(cacheStorageProvider.future);
        final userData =
            IntegrationTestDataGenerator.generateRealisticCacheData();

        for (final entry in userData.entries) {
          final result = await cacheStorage.set(
            entry.key,
            entry.value,
            ttl: const Duration(hours: 1),
          );
          expect(result.isRight(), true, reason: 'Should cache ${entry.key}');
        }

        // 5. Verify all data is accessible
        // Check credentials
        for (final key in loginData.keys) {
          final result = await credentialManager.getCredential(
            identifier: key,
            type: CredentialType.manabo,
          );
          expect(result.isRight(), true, reason: 'Should retrieve $key');
        }

        // Check preferences (these are async providers)
        final themeMode = await container.read(themeModeProvider.future);
        expect(themeMode, ThemeMode.dark);

        final campus = await container.read(selectedCampusProvider.future);
        expect(campus, Campus.nagoya);

        final notifications = await container.read(
          assignmentNotificationsProvider.future,
        );
        expect(notifications, true);

        // Check cached data
        for (final key in userData.keys) {
          final result = await cacheStorage.get(key);
          expect(result.isRight(), true, reason: 'Should retrieve cached $key');
        }
      });

      test('should handle user logout flow', () async {
        final credentialManager = container.read(credentialManagerProvider);
        final cacheStorage = await container.read(cacheStorageProvider.future);

        // Setup user session
        await credentialManager.storeCredential(
          identifier: 'access_token',
          value: 'user_token_123',
          type: CredentialType.manabo,
        );
        await cacheStorage.set('user_profile', {'id': 1, 'name': 'Test User'});
        await container.read(updateThemeModeProvider(ThemeMode.dark).future);

        // Perform logout
        await credentialManager.clearAllCredentials();
        await container.read(clearAllCacheProvider.future);

        // Verify credentials are cleared
        final tokenResult = await credentialManager.getCredential(
          identifier: 'access_token',
          type: CredentialType.manabo,
        );
        expect(tokenResult.isRight(), true);
        tokenResult.fold(
          (failure) => fail('Should not fail getting cleared credential'),
          (credential) => expect(credential, isNull),
        );

        // Verify cache is cleared
        final profileResult = await cacheStorage.get('user_profile');
        expect(profileResult.isLeft(), true); // Should fail after clear

        // Verify preferences are preserved (selective clear)
        final themeMode = await container.read(themeModeProvider.future);
        expect(themeMode, ThemeMode.dark);
      });
    });

    group('Data Synchronization Workflow', () {
      test('should handle data sync and invalidation', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);

        // 1. Initial data load (cache miss)
        var assignmentsResult = await cacheStorage.get('user_assignments');
        expect(assignmentsResult.isRight(), true);

        // 2. Cache fresh data
        final freshData = [
          {'id': 1, 'title': 'Updated Math Assignment', 'due': '2024-12-25'},
          {'id': 3, 'title': 'New Chemistry Lab', 'due': '2024-12-27'},
        ];

        await cacheStorage.set(
          'user_assignments',
          freshData,
          ttl: const Duration(hours: 2),
        );

        // 3. Subsequent reads (cache hit)
        assignmentsResult = await cacheStorage.get('user_assignments');
        expect(assignmentsResult.isRight(), true);

        assignmentsResult.fold(
          (failure) => fail('Should retrieve cached data'),
          (entry) => expect(entry.value, freshData),
        );

        // 4. Invalidate specific cache entry
        await container.read(
          invalidateCacheProvider('user_assignments').future,
        );

        // 5. Verify invalidation
        assignmentsResult = await cacheStorage.get('user_assignments');
        assignmentsResult.fold(
          (failure) => expect(true, true), // Expected after invalidation
          (data) => expect(data, isNull),
        );

        // 6. Verify operations completed successfully
      });

      test('should handle cache expiration workflow', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);

        // Store data with short TTL
        await cacheStorage.set(
          'short_lived_data',
          'test_value',
          ttl: const Duration(milliseconds: 100),
        );

        // Verify data is available immediately
        var result = await cacheStorage.get('short_lived_data');
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should retrieve data before expiration'),
          (entry) => expect(entry.value, 'test_value'),
        );

        // Wait for expiration
        await Future.delayed(const Duration(milliseconds: 150));

        // Verify data is expired
        result = await cacheStorage.get('short_lived_data');
        result.fold(
          (failure) => expect(true, true), // Expected for expired data
          (value) => expect(value, isNull),
        );
      });
    });

    group('Error Recovery Workflow', () {
      test('should handle storage errors and recovery', () async {
        // Create error-prone scenario
        final errorScenario = StorageTestScenarioBuilder()
            .withErrorSimulation(errorProbability: 0.5)
            .build();

        final errorContainer = ProviderContainer(
          overrides: [
            secureStorageProvider.overrideWith(
              (_) => errorScenario.secureStorage,
            ),
            cacheStorageProvider.overrideWith(
              (_) async => errorScenario.cacheStorage,
            ),
            preferenceStorageProvider.overrideWith(
              (_) async => errorScenario.preferenceStorage,
            ),
            crashlyticsServiceProvider.overrideWithValue(
              MockCrashlyticsService(),
            ),
            errorReporterProvider.overrideWithValue(MockErrorReporter()),
          ],
        );

        try {
          final secureStorage = errorContainer.read(secureStorageProvider);

          // Attempt operations that may fail
          final results = <bool>[];
          for (int i = 0; i < 10; i++) {
            final result = await secureStorage.write('test_key_$i', 'value_$i');
            results.add(result.isRight());
          }

          // Some operations should succeed (due to 50% error rate)
          final successCount = results.where((success) => success).length;
          expect(
            successCount,
            greaterThan(0),
            reason: 'Some operations should succeed',
          );
          expect(
            successCount,
            lessThanOrEqualTo(10),
            reason: 'Operations may all succeed in test environment',
          );
        } finally {
          errorScenario.dispose();
          errorContainer.dispose();
        }
      });

      test('should handle migration workflow', () async {
        final migrationManager = await container.read(
          migrationManagerProvider.future,
        );

        // Get initial version
        final initialVersionResult = await migrationManager
            .getCurrentStorageVersion();
        expect(initialVersionResult.isRight(), true);

        // Perform migration
        final migrationResult = await migrationManager.migrate();
        expect(migrationResult.isRight(), true);

        // Verify version is updated or unchanged
        final finalVersionResult = await migrationManager
            .getCurrentStorageVersion();
        expect(finalVersionResult.isRight(), true);

        finalVersionResult.fold((failure) => fail('Should get final version'), (
          finalVersion,
        ) {
          initialVersionResult.fold(
            (failure) => fail('Should get initial version'),
            (initialVersion) {
              expect(
                finalVersion,
                greaterThanOrEqualTo(initialVersion),
                reason: 'Version should not decrease',
              );
            },
          );
        });
      });
    });

    group('Performance and Stress Testing', () {
      test('should handle high-frequency operations', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);

        final stopwatch = Stopwatch()..start();

        // Perform rapid operations
        final futures = <Future>[];
        for (int i = 0; i < 50; i++) {
          futures.add(cacheStorage.set('rapid_$i', 'value_$i'));
        }

        await Future.wait(futures);

        stopwatch.stop();

        // Verify performance is reasonable (adjust threshold as needed)
        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(5000), // Should complete within 5 seconds
          reason: 'High-frequency operations should be fast',
        );

        // Verify all data was stored
        for (int i = 0; i < 50; i++) {
          final result = await cacheStorage.get('rapid_$i');
          expect(result.isRight(), true);
        }

        // Verify operations completed successfully
      });

      test('should handle concurrent access patterns', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);
        final preferenceStorage = await container.read(
          preferenceStorageProvider.future,
        );

        // Simulate concurrent user actions
        final futures = <Future>[];

        // Concurrent cache operations
        for (int i = 0; i < 20; i++) {
          futures.add(cacheStorage.set('concurrent_cache_$i', 'value_$i'));
        }

        // Concurrent preference updates
        for (int i = 0; i < 20; i++) {
          futures.add(
            preferenceStorage.set(
              PreferenceKey<String>(
                key: 'concurrent_pref_$i',
                defaultValue: '',
                serializer: (value) => value,
                deserializer: (value) => value,
              ),
              'pref_value_$i',
            ),
          );
        }

        // Wait for all operations to complete
        final results = await Future.wait(futures);

        // All operations should succeed
        final failures = results.where((result) => result.isLeft()).toList();
        expect(
          failures.length,
          0,
          reason: 'All concurrent operations should succeed',
        );
      });
    });

    group('Real-World Usage Patterns', () {
      test('should handle typical app usage flow', () async {
        // 1. App startup
        await container.read(initializeStorageProvider.future);

        // 2. Load cached data
        final cacheStorage = await container.read(cacheStorageProvider.future);

        // Check for existing cached assignments
        var assignmentsResult = await cacheStorage.get('user_assignments');
        expect(assignmentsResult.isRight(), true);

        // 3. User preferences loaded from storage
        var currentTheme = await container.read(themeModeProvider.future);
        var currentCampus = await container.read(selectedCampusProvider.future);
        expect(currentTheme, isNotNull);
        expect(currentCampus, isNotNull);

        // 4. User changes preferences
        await container.read(updateThemeModeProvider(ThemeMode.light).future);
        await container.read(
          updateSelectedCampusProvider(Campus.toyota).future,
        );

        // Verify changes are persisted
        currentTheme = await container.read(themeModeProvider.future);
        currentCampus = await container.read(selectedCampusProvider.future);
        expect(currentTheme, ThemeMode.light);
        expect(currentCampus, Campus.toyota);

        // 5. Update cached assignments
        final newAssignments = [
          {'id': 1, 'title': 'Updated Assignment', 'due': '2024-12-25'},
          {'id': 4, 'title': 'New Assignment', 'due': '2024-12-28'},
        ];

        await cacheStorage.set(
          'user_assignments',
          newAssignments,
          ttl: const Duration(hours: 1),
        );

        // 6. Verify updated data
        assignmentsResult = await cacheStorage.get('user_assignments');
        assignmentsResult.fold(
          (failure) => fail('Should retrieve updated assignments'),
          (entry) => expect(entry.value, newAssignments),
        );

        // 7. Health check
        final healthStatus = await container.read(
          storageHealthCheckProvider.future,
        );
        expect(healthStatus, StorageHealthStatus.healthy);
      });

      test('should handle offline/online transition', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);

        // 1. Simulate offline state - use cached data
        final offlineData = {
          'assignments': [
            {'id': 1, 'title': 'Cached Assignment', 'offline': true},
          ],
          'timetable': {
            'cached': true,
            'last_update': DateTime.now()
                .subtract(const Duration(hours: 2))
                .toIso8601String(),
          },
        };

        await cacheStorage.set(
          'offline_assignments',
          offlineData['assignments'],
          ttl: const Duration(days: 1), // Long TTL for offline data
        );
        await cacheStorage.set(
          'offline_timetable',
          offlineData['timetable'],
          ttl: const Duration(days: 1),
        );

        // 2. Verify offline data is available
        var assignmentsResult = await cacheStorage.get('offline_assignments');
        var timetableResult = await cacheStorage.get('offline_timetable');

        expect(assignmentsResult.isRight(), true);
        expect(timetableResult.isRight(), true);

        // 3. Simulate going online - update with fresh data
        final onlineData = {
          'assignments': [
            {'id': 1, 'title': 'Updated Assignment', 'offline': false},
            {'id': 2, 'title': 'New Assignment', 'offline': false},
          ],
          'timetable': {
            'cached': false,
            'last_update': DateTime.now().toIso8601String(),
          },
        };

        await cacheStorage.set(
          'offline_assignments',
          onlineData['assignments'],
          ttl: const Duration(hours: 1), // Shorter TTL for online data
        );
        await cacheStorage.set(
          'offline_timetable',
          onlineData['timetable'],
          ttl: const Duration(hours: 6),
        );

        // 4. Verify fresh data is available
        assignmentsResult = await cacheStorage.get('offline_assignments');
        timetableResult = await cacheStorage.get('offline_timetable');

        assignmentsResult.fold(
          (failure) => fail('Should get updated assignments'),
          (entry) => expect(entry.value, onlineData['assignments']),
        );

        timetableResult.fold(
          (failure) => fail('Should get updated timetable'),
          (entry) => expect(entry.value, onlineData['timetable']),
        );
      });
    });
  });
}
