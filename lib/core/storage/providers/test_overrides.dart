import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/cache_storage_interface.dart';
import '../interfaces/preference_storage_interface.dart';
import '../interfaces/secure_storage_interface.dart';
import '../testing/mock_preference_storage.dart';
import '../testing/mock_secure_storage.dart';
import 'storage_providers.dart';

/// Test overrides for storage providers
///
/// This file provides test implementations and overrides for storage providers
/// to enable isolated testing without real storage backends.
///
/// Usage in tests:
/// ```dart
/// import 'package:passpal/core/storage/providers/test_overrides.dart';
///
/// testWidgets('my test', (tester) async {
///   final container = ProviderContainer(
///     overrides: storageTestOverrides,
///   );
///
///   // Your test code here
/// });
/// ```

/// Creates test overrides for all storage providers
List<Override> createStorageTestOverrides({
  SharedPreferences? mockSharedPreferences,
  SecureStorageInterface? mockSecureStorage,
  CacheStorageInterface? mockCacheStorage,
  PreferenceStorageInterface? mockPreferenceStorage,
}) {
  return [
    // Override SharedPreferences with test instance
    if (mockSharedPreferences != null)
      sharedPreferencesProvider.overrideWith(
        (_) async => mockSharedPreferences,
      ),

    // Override secure storage with mock implementation
    if (mockSecureStorage != null)
      secureStorageProvider.overrideWith((_) => mockSecureStorage),

    // Override cache storage with mock implementation
    if (mockCacheStorage != null)
      cacheStorageProvider.overrideWith((_) async => mockCacheStorage),

    // Override preference storage with mock implementation
    if (mockPreferenceStorage != null)
      preferenceStorageProvider.overrideWith(
        (_) async => mockPreferenceStorage,
      ),
  ];
}

/// Default test overrides using mock implementations
List<Override> get storageTestOverrides => [
  // Use mock secure storage
  secureStorageProvider.overrideWith((_) => MockSecureStorage()),

  // Note: CacheStorage and PreferenceStorage will use real implementations
  // backed by in-memory SharedPreferences for testing
];

/// Lightweight test overrides for unit tests that don't need real storage
List<Override> get lightweightStorageTestOverrides => [
  secureStorageProvider.overrideWith((_) => MockSecureStorage()),

  preferenceStorageProvider.overrideWith((_) async => MockPreferenceStorage()),
];

/// Test helper to create a ProviderContainer with storage overrides
ProviderContainer createTestContainer({
  List<Override> additionalOverrides = const [],
  bool useLightweightOverrides = false,
}) {
  final baseOverrides = useLightweightOverrides
      ? lightweightStorageTestOverrides
      : storageTestOverrides;

  return ProviderContainer(
    overrides: [...baseOverrides, ...additionalOverrides],
  );
}

/// Test helper to run storage operations in a test container
Future<T> runStorageTest<T>(
  Future<T> Function(ProviderContainer container) test, {
  List<Override> additionalOverrides = const [],
  bool useLightweightOverrides = false,
}) async {
  final container = createTestContainer(
    additionalOverrides: additionalOverrides,
    useLightweightOverrides: useLightweightOverrides,
  );

  try {
    return await test(container);
  } finally {
    container.dispose();
  }
}

/// Test utilities for specific storage scenarios

/// Creates overrides for testing preference scenarios
List<Override> createPreferenceTestOverrides({
  Map<String, String> initialPreferences = const {},
}) {
  final mockStorage = MockPreferenceStorage(initialData: initialPreferences);

  return [
    preferenceStorageProvider.overrideWith((_) async => mockStorage),
    secureStorageProvider.overrideWith((_) => MockSecureStorage()),
  ];
}

/// Creates overrides for testing secure storage scenarios
List<Override> createSecureStorageTestOverrides({
  Map<String, String> initialSecureData = const {},
}) {
  final mockStorage = InMemorySecureStorage.withData(initialSecureData);

  return [secureStorageProvider.overrideWith((_) => mockStorage)];
}

/// Test helper for integration tests that need all storage systems
List<Override> get integrationTestOverrides => [
  secureStorageProvider.overrideWith((_) => MockSecureStorage()),
  // Let other providers use real implementations
];
