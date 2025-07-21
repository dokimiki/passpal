# Storage Core

Unified storage platform for PassPal app, providing secure credential storage, cache management, and preference handling with reactive monitoring.

## Overview

Storage Core is designed following Clean Architecture patterns and fully integrated with the Riverpod provider system. It provides three main storage types:

- **SecureStorage**: AES-256 encryption for auth tokens, API keys, and user credentials
- **CacheStorage**: Performance optimization with TTL caching, LRU eviction, and SWR strategy
- **PreferenceStorage**: Type-safe app settings storage with reactive monitoring

## Key Features

- 🔐 **Secure Encryption**: AES-256 encryption using iOS Keychain/Android Keystore
- 🚀 **High Performance Cache**: TTL, LRU eviction, SWR strategy
- 🎯 **Type Safety**: Freezed data classes and strongly-typed preferences
- 🔄 **Reactive**: Real-time updates via Stream monitoring
- 📊 **Analytics Integration**: Firebase Analytics and performance metrics
- 🧪 **Testable**: Complete mock implementations and test utilities
- 🔄 **Migration**: Schema version management and data migration

## Setup

### 1. Provider Initialization

```dart
import 'package:passpal/core/storage/providers.dart';

// App startup
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final container = ProviderContainer();
  
  // Initialize storage
  await container.read(initializeStorageProvider.future);
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}
```

### 2. Basic Usage

#### SecureStorage

```dart
import 'package:passpal/core/storage/providers.dart';

class AuthService extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _handleAuth(ref),
      builder: (context, snapshot) => /* UI */,
    );
  }
  
  Future<void> _handleAuth(WidgetRef ref) async {
    final secureStorage = ref.read(secureStorageProvider);
    
    // Store auth token
    await secureStorage.write('auth_token', 'your_token_here');
    
    // Read auth token
    final result = await secureStorage.read('auth_token');
    result.fold(
      (failure) => handleError(failure),
      (token) => useToken(token),
    );
  }
}
```

#### CacheStorage

```dart
import 'package:passpal/core/storage/providers.dart';

class AssignmentService extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get data from cache with TTL
    final assignmentsAsync = ref.watch(
      cachedDataProvider<List<Assignment>>(
        CacheKeys.assignments,
        fetcher: () => _fetchAssignments(),
        ttl: Duration(hours: 1),
      ),
    );
    
    return assignmentsAsync.when(
      data: (assignments) => AssignmentsList(assignments),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

#### PreferenceStorage

```dart
import 'package:passpal/core/storage/providers.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final campus = ref.watch(selectedCampusProvider);
    
    return Column(
      children: [
        // Theme setting
        DropdownButton<ThemeMode>(
          value: themeMode,
          onChanged: (value) {
            if (value != null) {
              ref.read(updateThemeModeProvider(value));
            }
          },
          items: ThemeMode.values.map((mode) => 
            DropdownMenuItem(
              value: mode,
              child: Text(mode.displayName),
            ),
          ).toList(),
        ),
        
        // Campus setting
        DropdownButton<Campus>(
          value: campus,
          onChanged: (value) {
            if (value != null) {
              ref.read(updateSelectedCampusProvider(value));
            }
          },
          items: Campus.values.map((campus) => 
            DropdownMenuItem(
              value: campus,
              child: Text(campus.displayName),
            ),
          ).toList(),
        ),
      ],
    );
  }
}
```

## Advanced Usage

### CredentialManager

```dart
import 'package:passpal/core/storage/providers.dart';

class LoginService {
  Future<void> saveCredentials(WidgetRef ref, String username, String password) async {
    final credentialManager = ref.read(credentialManagerProvider);
    
    final credentials = StoredCredential(
      type: CredentialType.manaboLogin,
      username: username,
      password: password,
      metadata: {'campus': 'nagoya'},
    );
    
    final result = await credentialManager.store('manabo_creds', credentials);
    result.fold(
      (failure) => throw Exception('Failed to save credentials'),
      (success) => print('Credentials saved successfully'),
    );
  }
  
  Future<StoredCredential?> loadCredentials(WidgetRef ref) async {
    final credentialManager = ref.read(credentialManagerProvider);
    
    final result = await credentialManager.retrieve('manabo_creds');
    return result.fold(
      (failure) => null,
      (credentials) => credentials,
    );
  }
}
```

### CacheManager with SWR Strategy

```dart
import 'package:passpal/core/storage/providers.dart';

class TimetableService {
  Future<List<TimetableEntry>> getTimetable(WidgetRef ref) async {
    final cacheManager = ref.read(cacheManagerProvider);
    
    // SWR strategy: return stale data while revalidating in background
    final result = await cacheManager.getOrFetch<List<TimetableEntry>>(
      CacheKeys.timetable,
      fetcher: () => _fetchTimetableFromAPI(),
      ttl: Duration(hours: 2),
      staleWhileRevalidate: true,
    );
    
    return result.fold(
      (failure) => throw Exception('Failed to fetch timetable'),
      (timetable) => timetable,
    );
  }
}
```

### Storage Analytics

```dart
import 'package:passpal/core/storage/providers.dart';

class AnalyticsService {
  Future<void> sendStorageMetrics(WidgetRef ref) async {
    final analytics = ref.read(storageAnalyticsProvider);
    
    // Get cache metrics
    final cacheMetrics = analytics.getCacheMetrics();
    print('Cache hit rate: ${cacheMetrics.hitRate}');
    
    // Send performance report
    await analytics.sendPerformanceReport();
  }
}
```

## Integration with Other Core Modules

### Error Core Integration

```dart
import 'package:passpal/core/storage/providers.dart';
import 'package:passpal/core/error/providers.dart';

class ErrorHandlingExample {
  Future<void> handleStorageError(WidgetRef ref) async {
    final secureStorage = ref.read(secureStorageProvider);
    final errorReporter = ref.read(errorReporterProvider);
    
    final result = await secureStorage.read('sensitive_key');
    result.fold(
      (failure) async {
        // Report error using Error Core
        await errorReporter.reportError(
          exception: Exception('Secure storage read failed'),
          stackTrace: StackTrace.current,
          context: {'operation': 'secure_storage_read'},
        );
      },
      (value) => print('Value retrieved: $value'),
    );
  }
}
```

### Config Core Integration

```dart
import 'package:passpal/core/storage/providers.dart';
import 'package:passpal/core/config/providers.dart';

class ConfigIntegrationExample {
  Future<void> setupWithConfig(WidgetRef ref) async {
    final config = ref.read(appConfigProvider);
    final cacheStorage = ref.read(cacheStorageProvider);
    
    // Adjust cache capacity based on Config Core settings
    await cacheStorage.configureLimits(
      maxSizeBytes: config.maxCacheSize,
      maxEntries: config.maxCacheEntries,
    );
  }
}
```

## Testing

### Unit Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/storage/providers.dart';

void main() {
  group('Storage Tests', () {
    late ProviderContainer container;
    
    setUp(() {
      container = ProviderContainer(
        overrides: createStorageTestOverrides(),
      );
    });
    
    tearDown(() {
      container.dispose();
    });
    
    test('should store and retrieve secure data', () async {
      final secureStorage = container.read(secureStorageProvider);
      
      await secureStorage.write('test_key', 'test_value');
      final result = await secureStorage.read('test_key');
      
      expect(result.isRight(), true);
      expect(result.getOrElse(() => null), 'test_value');
    });
  });
}
```

### Integration Tests

```dart
import 'package:passpal/core/storage/testing/integration_test_helpers.dart';

void main() {
  testWidgets('Storage integration test', (tester) async {
    await runStorageIntegrationTest(
      scenario: LoginLogoutWorkflow(),
      tester: tester,
    );
  });
}
```

## Performance Optimization

### Cache Optimization

```dart
// Monitor cache size
final cacheMetrics = ref.watch(storageAnalyticsProvider).getCacheMetrics();
if (cacheMetrics.hitRate < 0.7) {
  // Take action when hit rate is low
  await ref.read(cacheStorageProvider).optimizeCache();
}
```

### Batch Operations

```dart
// Update multiple preferences at once
await ref.read(preferenceStorageProvider).batchUpdate({
  PreferenceKeys.themeMode: ThemeMode.dark,
  PreferenceKeys.selectedCampus: Campus.toyota,
  PreferenceKeys.assignmentNotifications: true,
});
```

## Troubleshooting

### Common Issues

#### 1. SecureStorage Initialization Failure

```dart
// Solution: Check initialization
final healthCheck = await ref.read(storageHealthCheckProvider.future);
if (healthCheck.secureStorageStatus != StorageHealthStatus.healthy) {
  // Fallback processing
  await ref.read(initializeStorageProvider.future);
}
```

#### 2. Cache Capacity Exceeded

```dart
// Solution: Cache cleanup
await ref.read(clearAllCacheProvider.future);
// Or specific keys only
await ref.read(invalidateCacheProvider(CacheKeys.assignments).future);
```

#### 3. Migration Failure

```dart
// Solution: Check migration status
final migrationManager = ref.read(migrationManagerProvider);
final needsMigration = await migrationManager.needsMigration();
if (needsMigration) {
  await migrationManager.runMigrations();
}
```

### Debug Mode

```dart
// Enable debug information
const bool kDebugStorage = true;

if (kDebugStorage) {
  final analytics = ref.read(storageAnalyticsProvider);
  final metrics = analytics.getCacheMetrics();
  print('Storage Debug Info: $metrics');
}
```

## Security Considerations

1. **Encryption**: All sensitive data is encrypted with AES-256
2. **Platform Security**: Utilizes iOS Keychain/Android Keystore
3. **Key Management**: Automatic key generation and rotation
4. **Logging**: Prevents logging of sensitive data

## API Reference

### Main Interfaces

- [`SecureStorageInterface`](interfaces/secure_storage_interface.dart) - Basic interface for secure storage
- [`CacheStorageInterface`](interfaces/cache_storage_interface.dart) - Basic interface for cache storage  
- [`PreferenceStorageInterface`](interfaces/preference_storage_interface.dart) - Basic interface for preference storage

### Main Services

- [`SecureStorage`](services/secure_storage.dart) - Encrypted storage implementation
- [`CacheStorage`](services/cache_storage.dart) - Cache storage implementation
- [`PreferenceStorage`](services/preference_storage.dart) - Preference storage implementation
- [`CredentialManager`](services/credential_manager.dart) - Credential management
- [`CacheManager`](services/cache_manager.dart) - Cache management and SWR strategy

### Data Models

- [`CacheEntry`](models/cache_entry.dart) - Cache entry model
- [`PreferenceKey`](models/preference_types.dart) - Type-safe preference keys
- [`StorageException`](models/storage_exceptions.dart) - Storage-specific exceptions
