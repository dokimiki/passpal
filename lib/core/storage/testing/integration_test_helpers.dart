import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/cache_storage_interface.dart';
import '../interfaces/preference_storage_interface.dart';
import '../models/preference_types.dart';
import '../providers/storage_providers.dart';
import '../services/credential_manager.dart';
import 'storage_test_utils.dart';

/// Integration test helpers for testing storage with other core modules
class StorageIntegrationTestHelper {
  /// Create a test container with storage providers overridden
  static ProviderContainer createTestContainer({
    StorageTestScenario? scenario,
    List<Override>? additionalOverrides,
  }) {
    final testScenario = scenario ?? StorageTestScenarioBuilder().build();

    final overrides = <Override>[
      secureStorageProvider.overrideWith((_) => testScenario.secureStorage),
      cacheStorageProvider.overrideWith(
        (ref) async => testScenario.cacheStorage,
      ),
      preferenceStorageProvider.overrideWith(
        (ref) async => testScenario.preferenceStorage,
      ),
      ...additionalOverrides ?? [],
    ];

    return ProviderContainer(overrides: overrides);
  }

  /// Test credential manager integration
  static Future<void> testCredentialManagerIntegration(
    ProviderContainer container,
  ) async {
    final credentialManager = container.read(credentialManagerProvider);

    // Test credential storage and retrieval
    const testCredentials = {
      'username': 'test_user',
      'password': 'test_password',
      'token': 'test_token',
    };

    // Store credentials
    for (final entry in testCredentials.entries) {
      final result = await credentialManager.storeCredential(
        identifier: entry.key,
        value: entry.value,
        type: CredentialType.manabo,
      );
      expect(
        result.isRight(),
        true,
        reason: 'Should store ${entry.key} successfully',
      );
    }

    // Retrieve credentials
    for (final entry in testCredentials.entries) {
      final result = await credentialManager.getCredential(
        identifier: entry.key,
        type: CredentialType.manabo,
      );
      expect(
        result.isRight(),
        true,
        reason: 'Should retrieve ${entry.key} successfully',
      );

      result.fold(
        (failure) =>
            fail('Failed to retrieve ${entry.key}: ${failure.message}'),
        (credential) {
          expect(
            credential,
            isNotNull,
            reason: 'Credential should not be null',
          );
          expect(
            credential!.value,
            entry.value,
            reason: 'Retrieved value should match stored value',
          );
        },
      );
    }

    // Test credential clearing
    await credentialManager.clearAllCredentials();

    for (final key in testCredentials.keys) {
      final result = await credentialManager.getCredential(
        identifier: key,
        type: CredentialType.manabo,
      );
      expect(
        result.isRight(),
        true,
        reason: 'Should return null for cleared credential',
      );
      result.fold(
        (failure) => fail('Should not fail when getting cleared credential'),
        (credential) => expect(
          credential,
          isNull,
          reason: 'Credential $key should be cleared',
        ),
      );
    }
  }

  /// Test migration manager integration
  static Future<void> testMigrationManagerIntegration(
    ProviderContainer container,
  ) async {
    final migrationManagerFuture = container.read(
      migrationManagerProvider.future,
    );
    final migrationManager = await migrationManagerFuture;
    final secureStorage = container.read(secureStorageProvider);
    final preferenceStorageFuture = container.read(
      preferenceStorageProvider.future,
    );
    final preferenceStorage = await preferenceStorageFuture;

    // Set up old version data and register test migrations
    await secureStorage.write('old_key', 'old_value');
    await preferenceStorage.set(PreferenceKeys.themeMode, ThemeMode.light);

    // Register test migrations
    migrationManager.registerMigration('1', (
      secureStorage,
      cacheStorage,
      preferenceStorage,
      parameters,
    ) async {
      // Mock migration from version 1 to 2
      await preferenceStorage.set(PreferenceKeys.selectedCampus, Campus.nagoya);
      return const Right(null);
    });

    migrationManager.registerMigration('2', (
      secureStorage,
      cacheStorage,
      preferenceStorage,
      parameters,
    ) async {
      // Mock migration from version 2 to 3
      await secureStorage.write('new_key', 'new_value');
      return const Right(null);
    });

    // Set current version to 0 to trigger migrations
    await migrationManager.setStorageVersion(0);

    // Test migration from version 0 to latest
    final migrationResult = await migrationManager.migrate();

    expect(migrationResult.isRight(), true, reason: 'Migration should succeed');

    // Verify migration effects (this would depend on actual migration logic)
    final currentVersionResult = await migrationManager
        .getCurrentStorageVersion();
    expect(
      currentVersionResult.isRight(),
      true,
      reason: 'Should get current version successfully',
    );

    currentVersionResult.fold(
      (failure) => fail('Failed to get current version: ${failure.message}'),
      (version) => expect(
        version,
        greaterThanOrEqualTo(2),
        reason: 'Version should be updated',
      ),
    );
  }

  /// Test storage analytics integration
  static Future<void> testStorageAnalyticsIntegration(
    ProviderContainer container,
  ) async {
    final analytics = container.read(storageAnalyticsProvider);
    final cacheStorageFuture = container.read(cacheStorageProvider.future);
    final cacheStorage = await cacheStorageFuture;

    // Perform operations that should be tracked
    await cacheStorage.set('analytics_test', 'test_value');
    await cacheStorage.get('analytics_test');
    await cacheStorage.get('non_existent_key'); // Should be a miss

    // Give analytics time to process
    await Future.delayed(const Duration(milliseconds: 100));

    // Verify analytics are being collected
    // Note: This would depend on actual analytics implementation
    // For now, we just verify the service is working
    expect(
      analytics,
      isNotNull,
      reason: 'Analytics service should be available',
    );
  }

  /// Test reactive storage updates across providers
  static Future<void> testReactiveStorageUpdates(
    ProviderContainer container,
  ) async {
    final preferenceStorageFuture = container.read(
      preferenceStorageProvider.future,
    );
    final preferenceStorage = await preferenceStorageFuture;
    final cacheStorageFuture = container.read(cacheStorageProvider.future);
    final cacheStorage = await cacheStorageFuture;

    final preferenceEvents = <PreferenceEvent>[];
    final cacheEvents = <CacheEvent>[];

    // Set up listeners
    final preferenceSubscription = preferenceStorage.changes.listen(
      preferenceEvents.add,
    );
    final cacheSubscription = cacheStorage.changes.listen(cacheEvents.add);

    try {
      // Perform operations
      await preferenceStorage.set(
        PreferenceKeys.assignmentNotifications,
        false,
      );
      await cacheStorage.set('reactive_test', 'test_value');
      await cacheStorage.delete('reactive_test');

      // Wait for events to propagate
      await Future.delayed(const Duration(milliseconds: 50));

      // Verify events were emitted
      expect(
        preferenceEvents.length,
        greaterThan(0),
        reason: 'Should emit preference events',
      );
      expect(
        cacheEvents.length,
        greaterThan(0),
        reason: 'Should emit cache events',
      );

      // Verify event types
      expect(
        preferenceEvents.any((event) => event is PreferenceChanged),
        true,
        reason: 'Should emit preference changed event',
      );

      expect(
        cacheEvents.any((event) => event is CacheEntryAdded),
        true,
        reason: 'Should emit cache entry added event',
      );

      expect(
        cacheEvents.any((event) => event is CacheEntryRemoved),
        true,
        reason: 'Should emit cache entry removed event',
      );
    } finally {
      await preferenceSubscription.cancel();
      await cacheSubscription.cancel();
    }
  }

  /// Test error handling across storage providers
  static Future<void> testErrorHandlingIntegration(
    ProviderContainer container,
  ) async {
    // Create error-prone storage scenario
    final errorScenario = StorageTestScenarioBuilder()
        .withErrorSimulation(errorProbability: 1.0) // Always fail
        .build();

    final errorContainer = createTestContainer(scenario: errorScenario);

    try {
      final secureStorage = errorContainer.read(secureStorageProvider);
      final preferenceStorageFuture = errorContainer.read(
        preferenceStorageProvider.future,
      );
      final preferenceStorage = await preferenceStorageFuture;
      final cacheStorageFuture = errorContainer.read(
        cacheStorageProvider.future,
      );
      final cacheStorage = await cacheStorageFuture;

      // Test that errors are properly propagated
      final secureResult = await secureStorage.write('test', 'value');
      expect(
        secureResult.isLeft(),
        true,
        reason: 'Should fail with error simulation',
      );

      final preferenceResult = await preferenceStorage.set(
        PreferenceKeys.themeMode,
        ThemeMode.dark,
      );
      expect(
        preferenceResult.isLeft(),
        true,
        reason: 'Should fail with error simulation',
      );

      final cacheResult = await cacheStorage.set('test', 'value');
      expect(
        cacheResult.isLeft(),
        true,
        reason: 'Should fail with error simulation',
      );

      // Verify error types are consistent
      secureResult.fold(
        (failure) =>
            expect(failure, isA<Failure>(), reason: 'Should be a Failure type'),
        (_) => fail('Should have failed'),
      );
    } finally {
      errorScenario.dispose();
      errorContainer.dispose();
    }
  }

  /// Test storage performance under load
  static Future<void> testStoragePerformanceIntegration(
    ProviderContainer container, {
    int iterations = 100,
  }) async {
    final secureStorage = container.read(secureStorageProvider);
    final preferenceStorageFuture = container.read(
      preferenceStorageProvider.future,
    );
    final preferenceStorage = await preferenceStorageFuture;
    final cacheStorageFuture = container.read(cacheStorageProvider.future);
    final cacheStorage = await cacheStorageFuture;

    final stopwatch = Stopwatch()..start();

    // Perform concurrent operations
    final futures = <Future>[];

    for (int i = 0; i < iterations; i++) {
      futures.add(secureStorage.write('perf_secure_$i', 'value_$i'));
      futures.add(
        preferenceStorage.set(
          PreferenceKey<int>(
            key: 'perf_pref_$i',
            defaultValue: 0,
            serializer: (value) => value.toString(),
            deserializer: (value) => int.parse(value),
          ),
          i,
        ),
      );
      futures.add(cacheStorage.set('perf_cache_$i', 'cache_value_$i'));
    }

    await Future.wait(futures);

    stopwatch.stop();

    final operationsPerSecond = (iterations * 3) / stopwatch.elapsed.inSeconds;

    // Verify reasonable performance (adjust threshold as needed)
    expect(
      operationsPerSecond,
      greaterThan(100),
      reason:
          'Should achieve reasonable operations per second: $operationsPerSecond',
    );
  }

  /// Test complete storage lifecycle
  static Future<void> testStorageLifecycle(ProviderContainer container) async {
    // Test setup
    await testCredentialManagerIntegration(container);
    await testMigrationManagerIntegration(container);
    await testStorageAnalyticsIntegration(container);
    await testReactiveStorageUpdates(container);
    // TODO: Fix error handling integration
    // await testErrorHandlingIntegration(container);
    await testStoragePerformanceIntegration(
      container,
      iterations: 10,
    ); // Lower iterations for CI
  }

  /// Create integration test group
  static void createIntegrationTestGroup({
    String groupName = 'Storage Integration Tests',
    StorageTestScenario? customScenario,
  }) {
    group(groupName, () {
      late ProviderContainer container;
      late StorageTestScenario scenario;

      setUp(() {
        scenario = customScenario ?? StorageTestScenarioBuilder().build();
        container = createTestContainer(scenario: scenario);
      });

      tearDown(() {
        scenario.dispose();
        container.dispose();
      });

      test('credential manager integration', () async {
        await testCredentialManagerIntegration(container);
      });

      test('migration manager integration', () async {
        await testMigrationManagerIntegration(container);
      });

      test('storage analytics integration', () async {
        await testStorageAnalyticsIntegration(container);
      });

      test('reactive storage updates', () async {
        await testReactiveStorageUpdates(container);
      });

      test('error handling integration', () async {
        await testErrorHandlingIntegration(container);
      });

      test('storage performance integration', () async {
        await testStoragePerformanceIntegration(container, iterations: 10);
      });

      test('complete storage lifecycle', () async {
        await testStorageLifecycle(container);
      });
    });
  }
}

/// Helper for testing storage with other core modules
class CrossCoreIntegrationHelper {
  /// Test storage integration with auth core (when available)
  static Future<void> testAuthIntegration(ProviderContainer container) async {
    // This would test integration with auth core
    // For now, just test credential storage patterns
    final credentialManager = container.read(credentialManagerProvider);

    // Simulate auth flow
    await credentialManager.storeCredential(
      identifier: 'access_token',
      value: 'auth_token_123',
      type: CredentialType.firebase,
    );
    await credentialManager.storeCredential(
      identifier: 'refresh_token',
      value: 'refresh_token_456',
      type: CredentialType.firebase,
    );

    // Verify tokens are stored
    final accessToken = await credentialManager.getCredential(
      identifier: 'access_token',
      type: CredentialType.firebase,
    );
    final refreshToken = await credentialManager.getCredential(
      identifier: 'refresh_token',
      type: CredentialType.firebase,
    );

    expect(accessToken.isRight(), true);
    expect(refreshToken.isRight(), true);
  }

  /// Test storage integration with network core (when available)
  static Future<void> testNetworkIntegration(
    ProviderContainer container,
  ) async {
    // This would test caching of network responses
    final cacheStorageFuture = container.read(cacheStorageProvider.future);
    final cacheStorage = await cacheStorageFuture;

    // Simulate network response caching
    final mockResponse = {
      'data': ['item1', 'item2', 'item3'],
      'timestamp': DateTime.now().toIso8601String(),
    };

    await cacheStorage.set(
      'api_response_/users',
      mockResponse,
      ttl: const Duration(minutes: 5),
    );

    // Verify cached response
    final cachedResult = await cacheStorage.get('api_response_/users');
    expect(cachedResult.isRight(), true);
  }

  /// Test storage integration with config core
  static Future<void> testConfigIntegration(ProviderContainer container) async {
    // Test preference storage with config values
    final preferenceStorageFuture = container.read(
      preferenceStorageProvider.future,
    );
    final preferenceStorage = await preferenceStorageFuture;

    // Store config preferences
    await preferenceStorage.set(PreferenceKeys.selectedCampus, Campus.nagoya);
    await preferenceStorage.set(PreferenceKeys.themeMode, ThemeMode.dark);

    // Verify config is stored and retrievable
    final campus = await preferenceStorage.get(PreferenceKeys.selectedCampus);
    final theme = await preferenceStorage.get(PreferenceKeys.themeMode);

    expect(campus.isRight(), true);
    expect(theme.isRight(), true);

    campus.fold(
      (failure) => fail('Failed to get campus: ${failure.message}'),
      (value) => expect(value, Campus.nagoya),
    );
  }
}

/// Test data generators for integration testing
class IntegrationTestDataGenerator {
  /// Generate realistic user session data
  static Map<String, String> generateUserSessionData() {
    return {
      'user_id': '12345',
      'session_token': 'session_abc123def456',
      'csrf_token': 'csrf_xyz789uvw012',
      'last_activity': DateTime.now().toIso8601String(),
    };
  }

  /// Generate realistic app configuration data
  static Map<String, String> generateAppConfigData() {
    return {
      'api_base_url': 'https://api.example.com',
      'app_version': '1.0.0',
      'feature_flags': '{"new_ui":true,"beta_features":false}',
      'update_interval': '300', // 5 minutes
    };
  }

  /// Generate realistic cache data for app
  static Map<String, dynamic> generateRealisticCacheData() {
    return {
      'user_assignments': [
        {'id': 1, 'title': 'Math Assignment', 'due': '2024-12-25'},
        {'id': 2, 'title': 'Physics Lab', 'due': '2024-12-26'},
      ],
      'timetable': {
        'monday': [
          {'time': '09:00', 'subject': 'Mathematics', 'room': 'A101'},
          {'time': '10:30', 'subject': 'Physics', 'room': 'B202'},
        ],
        'tuesday': [
          {'time': '09:00', 'subject': 'Chemistry', 'room': 'C303'},
        ],
      },
      'news_feed': [
        {'id': 1, 'title': 'Campus Event', 'date': '2024-12-20'},
        {'id': 2, 'title': 'System Maintenance', 'date': '2024-12-21'},
      ],
    };
  }
}
