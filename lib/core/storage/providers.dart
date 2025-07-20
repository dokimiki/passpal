/// Storage Core Module Providers
///
/// This file exports all storage-related providers for easy access
/// from other parts of the application.
///
/// Usage:
/// ```dart
/// import 'package:passpal/core/storage/providers.dart';
///
/// // Use any storage provider
/// final secureStorage = ref.watch(secureStorageProvider);
/// final cacheStorage = await ref.read(cacheStorageProvider.future);
/// final preferences = await ref.read(preferenceStorageProvider.future);
/// ```
library;

// Main storage providers
export 'providers/storage_providers.dart';

// Service providers (generated)
export 'providers/storage_providers.dart'
    show
        secureStorageProvider,
        cacheStorageProvider,
        preferenceStorageProvider,
        cacheManagerProvider,
        credentialManagerProvider,
        migrationManagerProvider,
        sharedPreferencesProvider,
        storageAnalyticsProvider,
        firebaseAnalyticsProvider,
        storageMetricsReporterProvider,
        sendStorageAnalyticsReportProvider;

// Initialization provider
export 'providers/storage_providers.dart' show initializeStorageProvider;

// Cache access providers
export 'providers/storage_providers.dart'
    show
        cachedDataProvider,
        hasCachedDataProvider,
        invalidateCacheProvider,
        clearAllCacheProvider;

// Preference access providers
export 'providers/storage_providers.dart'
    show
        themeModeProvider,
        selectedCampusProvider,
        assignmentNotificationsProvider,
        notificationFrequencyProvider,
        updateThemeModeProvider,
        updateSelectedCampusProvider,
        updateAssignmentNotificationsProvider,
        updateNotificationFrequencyProvider;

// Health check provider
export 'providers/storage_providers.dart'
    show storageHealthCheckProvider, StorageHealthStatus;

// Test utilities
export 'providers/test_overrides.dart'
    show
        createStorageTestOverrides,
        storageTestOverrides,
        lightweightStorageTestOverrides,
        createTestContainer,
        runStorageTest,
        createPreferenceTestOverrides,
        createSecureStorageTestOverrides,
        integrationTestOverrides;

// Core interfaces and models (for type annotations)
export 'interfaces/secure_storage_interface.dart';
export 'interfaces/cache_storage_interface.dart';
export 'interfaces/preference_storage_interface.dart';

export 'models/cache_entry.dart';
export 'models/preference_types.dart';
export 'models/storage_exceptions.dart';
export 'models/storage_version.dart';

// Services (for direct access when needed)
export 'services/secure_storage.dart' show SecureStorage;
export 'services/cache_storage.dart' show CacheStorage;
export 'services/preference_storage.dart' show PreferenceStorage;
export 'services/cache_manager.dart' show CacheManager;
export 'services/credential_manager.dart'
    show CredentialManager, CredentialType, StoredCredential;
export 'services/migration_manager.dart' show MigrationManager;
export 'services/storage_analytics.dart'
    show
        StorageAnalytics,
        StorageOperationType,
        StorageSubsystem,
        StoragePerformanceMetrics,
        CacheMetrics;

// Testing utilities
export 'testing/mock_secure_storage.dart'
    show MockSecureStorage, InMemorySecureStorage;
export 'testing/mock_preference_storage.dart' show MockPreferenceStorage;
