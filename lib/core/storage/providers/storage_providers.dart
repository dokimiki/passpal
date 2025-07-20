import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../error/providers.dart';
import '../interfaces/cache_storage_interface.dart';
import '../interfaces/preference_storage_interface.dart';
import '../interfaces/secure_storage_interface.dart';
import '../models/preference_types.dart';
import '../services/cache_manager.dart';
import '../services/cache_storage.dart';
import '../services/credential_manager.dart';
import '../services/migration_manager.dart';
import '../services/preference_storage.dart';
import '../services/secure_storage.dart';

part 'storage_providers.g.dart';

/// Provider for SecureStorage implementation
///
/// Provides secure storage for sensitive data using platform-specific
/// secure storage mechanisms (iOS Keychain, Android Keystore).
@Riverpod(keepAlive: true)
SecureStorageInterface secureStorage(Ref ref) {
  return const SecureStorage();
}

/// Provider for SharedPreferences instance
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

/// Provider for CacheStorage implementation
///
/// Provides cache storage with TTL, capacity management, and reactive updates.
@Riverpod(keepAlive: true)
Future<CacheStorageInterface> cacheStorage(Ref ref) async {
  final sharedPrefs = await ref.read(sharedPreferencesProvider.future);
  return CacheStorage(sharedPreferences: sharedPrefs);
}

/// Provider for PreferenceStorage implementation
///
/// Provides app preferences storage with typed access and reactive updates.
@Riverpod(keepAlive: true)
Future<PreferenceStorageInterface> preferenceStorage(Ref ref) async {
  final sharedPrefs = await ref.read(sharedPreferencesProvider.future);
  return PreferenceStorage(sharedPreferences: sharedPrefs);
}

/// Provider for CacheManager
///
/// Provides advanced cache management with capacity limits, LRU cleanup,
/// and SWR (Stale-While-Revalidate) strategies.
@Riverpod(keepAlive: true)
Future<CacheManager> cacheManager(Ref ref) async {
  final sharedPrefs = await ref.read(sharedPreferencesProvider.future);
  return CacheManager(sharedPreferences: sharedPrefs);
}

/// Provider for CredentialManager
///
/// Provides specialized credential handling with auto-invalidation
/// and integration with authentication systems.
@Riverpod(keepAlive: true)
CredentialManager credentialManager(Ref ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return CredentialManager(secureStorage);
}

/// Provider for MigrationManager
///
/// Provides storage schema migration and version tracking.
@Riverpod(keepAlive: true)
Future<MigrationManager> migrationManager(Ref ref) async {
  final secureStorage = ref.read(secureStorageProvider);
  final cacheStorage = await ref.read(cacheStorageProvider.future);
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);

  return MigrationManager(
    secureStorage: secureStorage,
    cacheStorage: cacheStorage,
    preferenceStorage: preferenceStorage,
  );
}

/// Initialize storage system
///
/// This provider handles the initialization of the storage system
/// and should be called during app startup.
@riverpod
Future<void> initializeStorage(Ref ref) async {
  final logger = ref.read(scopedLoggerProvider('StorageInit'));

  logger.info('Initializing storage system');

  try {
    // Initialize migration manager and check current version
    final migrationManager = await ref.read(migrationManagerProvider.future);
    await migrationManager.getCurrentStorageVersion();

    // Initialize cache manager
    await ref.read(cacheManagerProvider.future);
    // Cache manager is ready after construction

    logger.info('Storage system initialized successfully');
  } catch (error, stackTrace) {
    logger.error(
      'Failed to initialize storage system: ${error.toString()}',
      stackTrace: stackTrace,
    );

    // Report error but don't throw - app can continue
    final errorReporter = ref.read(errorReporterProvider);
    await errorReporter.reportError(
      AppError.now(
        message: 'Storage system initialization failed: ${error.toString()}',
        errorCode: 'STORAGE_INIT_ERROR',
        stackTrace: stackTrace,
        isRecoverable: true,
        retryDelay: const Duration(minutes: 1),
        context: {'error': error.toString()},
      ),
    );
  }
}

/// Typed cache access providers
/// These provide type-safe access to specific cache entries

/// Provider for getting cached data with type safety
@riverpod
Future<Object?> cachedData(Ref ref, String key) async {
  final cacheStorage = await ref.read(cacheStorageProvider.future);
  final result = await cacheStorage.get<Object>(key);

  return result.fold((failure) => null, (entry) => entry.value);
}

/// Provider for checking if cache has valid data
@riverpod
Future<bool> hasCachedData(Ref ref, String key) async {
  final cacheStorage = await ref.read(cacheStorageProvider.future);
  final result = await cacheStorage.containsKey(key);

  return result.fold((failure) => false, (hasData) => hasData);
}

/// Provider for cache invalidation
@riverpod
Future<void> invalidateCache(Ref ref, String key) async {
  final cacheStorage = await ref.read(cacheStorageProvider.future);
  await cacheStorage.delete(key);
}

/// Provider for clearing all cache
@riverpod
Future<void> clearAllCache(Ref ref) async {
  final cacheStorage = await ref.read(cacheStorageProvider.future);
  await cacheStorage.clear();
}

/// Preference access providers
/// These provide reactive access to app preferences

/// Provider for theme mode preference
@riverpod
Future<ThemeMode> themeMode(Ref ref) async {
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  final result = await preferenceStorage.get(PreferenceKeys.themeMode);
  return result.fold(
    (failure) => ThemeMode.system,
    (value) => value ?? ThemeMode.system,
  );
}

/// Provider for campus preference
@riverpod
Future<Campus> selectedCampus(Ref ref) async {
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  final result = await preferenceStorage.get(PreferenceKeys.selectedCampus);
  return result.fold(
    (failure) => Campus.nagoya,
    (value) => value ?? Campus.nagoya,
  );
}

/// Provider for assignment notifications preference
@riverpod
Future<bool> assignmentNotifications(Ref ref) async {
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  final result = await preferenceStorage.get(
    PreferenceKeys.assignmentNotifications,
  );
  return result.fold((failure) => true, (value) => value ?? true);
}

/// Provider for notification frequency preference
@riverpod
Future<NotificationFrequency> notificationFrequency(Ref ref) async {
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  final result = await preferenceStorage.get(
    PreferenceKeys.notificationFrequency,
  );
  return result.fold(
    (failure) => NotificationFrequency.immediate,
    (value) => value ?? NotificationFrequency.immediate,
  );
}

/// Provider for updating theme preference
@riverpod
Future<void> updateThemeMode(Ref ref, ThemeMode theme) async {
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  await preferenceStorage.set(PreferenceKeys.themeMode, theme);
  // Invalidate the theme provider to refresh the UI
  ref.invalidate(themeModeProvider);
}

/// Provider for updating campus preference
@riverpod
Future<void> updateSelectedCampus(Ref ref, Campus campus) async {
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  await preferenceStorage.set(PreferenceKeys.selectedCampus, campus);
  // Invalidate the campus provider to refresh the UI
  ref.invalidate(selectedCampusProvider);
}

/// Provider for updating assignment notifications
@riverpod
Future<void> updateAssignmentNotifications(Ref ref, bool enabled) async {
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  await preferenceStorage.set(PreferenceKeys.assignmentNotifications, enabled);
  ref.invalidate(assignmentNotificationsProvider);
}

/// Provider for updating notification frequency
@riverpod
Future<void> updateNotificationFrequency(
  Ref ref,
  NotificationFrequency frequency,
) async {
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  await preferenceStorage.set(PreferenceKeys.notificationFrequency, frequency);
  ref.invalidate(notificationFrequencyProvider);
}

/// Storage health check provider
@riverpod
Future<StorageHealthStatus> storageHealthCheck(Ref ref) async {
  final secureStorage = ref.read(secureStorageProvider);
  final cacheStorage = await ref.read(cacheStorageProvider.future);
  final preferenceStorage = await ref.read(preferenceStorageProvider.future);
  final logger = ref.read(scopedLoggerProvider('StorageHealth'));

  logger.info('Running storage health check');

  try {
    // Test secure storage
    const testKey = '_health_check_secure';
    const testValue = 'test_value';

    final writeResult = await secureStorage.write(testKey, testValue);
    if (writeResult.isLeft()) {
      throw Exception('Secure storage write failed');
    }

    final readResult = await secureStorage.read(testKey);
    if (readResult.isLeft() || readResult.getOrElse(() => null) != testValue) {
      throw Exception('Secure storage read failed');
    }

    await secureStorage.delete(testKey);

    // Test cache storage
    const cacheTestKey = '_health_check_cache';

    final cacheWriteResult = await cacheStorage.set(
      cacheTestKey,
      testValue,
      ttl: const Duration(minutes: 1),
    );
    if (cacheWriteResult.isLeft()) {
      throw Exception('Cache storage write failed');
    }

    final cacheReadResult = await cacheStorage.get<String>(cacheTestKey);
    if (cacheReadResult.isLeft()) {
      throw Exception('Cache storage read failed');
    }

    await cacheStorage.delete(cacheTestKey);

    // Test preference storage - create a test preference key
    final testPrefKey = PreferenceKey<bool>(
      key: '_health_check_pref',
      defaultValue: false,
      serializer: (value) => value.toString(),
      deserializer: (value) => value.toLowerCase() == 'true',
    );

    final prefWriteResult = await preferenceStorage.set(testPrefKey, true);
    if (prefWriteResult.isLeft()) {
      throw Exception('Preference storage write failed');
    }

    final prefReadResult = await preferenceStorage.get(testPrefKey);
    if (prefReadResult.isLeft() ||
        prefReadResult.getOrElse(() => false) != true) {
      throw Exception('Preference storage read failed');
    }

    await preferenceStorage.delete(testPrefKey);

    logger.info('Storage health check passed');
    return StorageHealthStatus.healthy;
  } catch (error, stackTrace) {
    logger.error(
      'Storage health check failed: ${error.toString()}',
      stackTrace: stackTrace,
    );

    return StorageHealthStatus.unhealthy;
  }
}

/// Storage health status enum
enum StorageHealthStatus { healthy, unhealthy }
