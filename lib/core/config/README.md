# Config Core Module

The Config core module provides a unified configuration management system for PassPal, integrating environment files (.env) and Firebase Remote Config with type safety, caching, and real-time updates.

## Features

- **Multi-source Configuration**: Integrates `.env` files, Firebase Remote Config, and default values
- **Priority-based Merging**: `.env` > Remote Config > defaults
- **Type Safety**: Strongly typed configuration models with Freezed
- **Memory Caching**: 15-minute in-memory cache with automatic expiration
- **Real-time Updates**: Monitors Remote Config changes and propagates updates
- **Comprehensive Validation**: URL, version, and domain validation
- **Error Handling**: Proper error recovery with AppException integration
- **Reactive State**: Riverpod-based reactive configuration management

## Architecture

```
lib/core/config/
├── models/           # Configuration data models
├── sources/          # Configuration source implementations
├── services/         # Business logic services
├── providers/        # Riverpod providers
├── extensions/       # Helper extensions
└── exceptions/       # Error handling
```

## Quick Start

### 1. Basic Usage

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/config/providers/config_provider.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    
    return Text('App Version: ${config.version}');
  }
}
```

### 2. Feature Flag Usage

```dart
class FeatureWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNewUIEnabled = ref.watch(featureFlagProvider('new_ui'));
    
    if (isNewUIEnabled) {
      return NewUIWidget();
    }
    return LegacyUIWidget();
  }
}
```

### 3. API Configuration

```dart
class ApiService extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiConfig = ref.watch(apiConfigProvider);
    
    final httpClient = HttpClient(
      baseUrl: apiConfig.baseUrl,
      timeout: Duration(milliseconds: apiConfig.timeoutMs),
    );
    
    return Container();
  }
}
```

### 4. Environment-specific Configuration

Create environment-specific `.env` files:

```bash
# .env.development
API_BASE_URL=https://dev-api.passpal.app
ENABLE_DEBUG_MODE=true
ENABLE_ANALYTICS=false
LOG_LEVEL=debug

# .env.production  
API_BASE_URL=https://api.passpal.app
ENABLE_DEBUG_MODE=false
ENABLE_ANALYTICS=true
LOG_LEVEL=info
```

## Configuration Models

### AppConfig
Main configuration container with all sub-configurations.

```dart
@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    @Default('1.0.0') String version,
    @Default(true) bool enableAnalytics,
    @Default(true) bool enableCrashReporting,
    @Default(false) bool enableDebugMode,
    required ApiConfig apiConfig,
    required AuthConfig authConfig,
    required DebugConfig debugConfig,
    required FeatureFlags featureFlags,
    required AdminConfig adminConfig,
  }) = _AppConfig;
}
```

### ApiConfig
API endpoint and network configuration.

```dart
@freezed
abstract class ApiConfig with _$ApiConfig {
  const factory ApiConfig({
    required String baseUrl,
    @Default(30000) int timeoutMs,
    @Default(3) int maxRetries,
    @Default(1000) int retryDelayMs,
    required String manaboApiUrl,
    required String alboApiUrl,
    required String cubicsApiUrl,
    @Default(false) bool enableLogging,
  }) = _ApiConfig;
}
```

### FeatureFlags
Feature toggle configuration.

```dart
@freezed
abstract class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    @Default(true) bool enableNotifications,
    @Default(true) bool enableOfflineMode,
    @Default(false) bool enableBetaFeatures,
    @Default(true) bool enableAutoSync,
    @Default(false) bool enableAdvancedSettings,
    @Default(true) bool enableCampusMap,
    @Default(false) bool enableDarkMode,
    @Default(true) bool enableTimetableWidget,
  }) = _FeatureFlags;
}
```

### DebugConfig
Development and debugging configuration.

```dart
@freezed
abstract class DebugConfig with _$DebugConfig {
  const factory DebugConfig({
    @Default('info') String logLevel,
    @Default(false) bool enableVerboseLogging,
    @Default(false) bool enableNetworkLogging,
    @Default(true) bool enableCrashlytics,
    @Default(false) bool enablePerformanceMonitoring,
    @Default(false) bool showDebugInfo,
  }) = _DebugConfig;
}
```

### AuthConfig
Authentication and SSO configuration.

```dart
@freezed
abstract class AuthConfig with _$AuthConfig {
  const factory AuthConfig({
    required String shibbolethUrl,
    required String googleClientId,
    @Default(3600) int sessionTimeoutSeconds,
    @Default(false) bool enableBiometricAuth,
    @Default(true) bool enableRememberMe,
    @Default(7) int maxLoginAttempts,
  }) = _AuthConfig;
}
```

### AdminConfig
Administrative controls and maintenance configuration.

```dart
@freezed
abstract class AdminConfig with _$AdminConfig {
  const factory AdminConfig({
    @Default(false) bool maintenanceMode,
    @Default('') String maintenanceMessage,
    @Default('1.0.0') String minSupportedVersion,
    @Default('') String latestVersion,
    @Default(false) bool forceUpdate,
    @Default('') String updateMessage,
    @Default('') String supportEmail,
  }) = _AdminConfig;
}
```

## Providers

### Main Providers

```dart
// Main configuration provider
final appConfigProvider = appConfigProvider;

// Specific configuration sections
final apiConfigProvider = apiConfigProvider;
final authConfigProvider = authConfigProvider;
final debugConfigProvider = debugConfigProvider;
final featureFlagsProvider = featureFlagsProvider;
final adminConfigProvider = adminConfigProvider;
```

### Utility Providers

```dart
// Feature flag checking
final featureFlagProvider = featureFlagProvider;

// Configuration validation
final isConfigValidProvider = isConfigValidProvider;

// Cache management
final refreshConfigProvider = refreshConfigProvider;
```

## Extensions

### ApiConfig Extensions

```dart
import 'package:passpal/core/config/extensions/api_config_extensions.dart';

final apiConfig = ref.watch(apiConfigProvider);

// Service type detection
final serviceType = apiConfig.getServiceType();
print('Service: $serviceType'); // ServiceType.development

// URL resolution
final manaboUrl = apiConfig.getServiceUrl(ServiceType.manabo);
final timeout = apiConfig.getTimeoutForService(ServiceType.cubics);

// Security checks
final isSecure = apiConfig.isSecureConnection();
final isTesting = apiConfig.isTestingMode();
```

### DebugConfig Extensions

```dart
import 'package:passpal/core/config/extensions/debug_config_extensions.dart';

final debugConfig = ref.watch(debugConfigProvider);

// Log level management
final logLevel = debugConfig.getLogLevel();
final canLogDebug = debugConfig.canLog(LogLevel.debug);

// Environment detection
final isDev = debugConfig.isDevelopment();
final isProd = debugConfig.isProduction();

// Service enablement
final shouldEnableCrashlytics = debugConfig.shouldEnableCrashlytics();
final shouldShowPerformance = debugConfig.shouldShowPerformanceInfo();
```

### AdminConfig Extensions

```dart
import 'package:passpal/core/config/extensions/admin_config_extensions.dart';

final adminConfig = ref.watch(adminConfigProvider);

// Update requirement checking
final requirement = adminConfig.getUpdateRequirement('1.2.0');
print('Update: $requirement'); // UpdateRequirement.optional

// Version comparison
final isSupported = adminConfig.isVersionSupported('1.1.0');
final needsUpdate = adminConfig.shouldForceUpdate('1.0.0');

// User messages
final message = adminConfig.getUserMessage();
final supportInfo = adminConfig.getSupportInfo();
```

## Error Handling

The config module integrates with the core error system:

```dart
class ConfigAwareWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(loadedConfigProvider);
    
    return configAsync.when(
      data: (config) => AppContent(config: config),
      loading: () => LoadingIndicator(),
      error: (error, stack) {
        // Errors are automatically reported to errorNotifierProvider
        return ErrorWidget.withDetails(
          message: 'Configuration load failed',
          error: error,
        );
      },
    );
  }
}
```

## Validation

Configuration validation is performed automatically:

```dart
// Manual validation
final configValidation = ref.read(configValidationProvider);
final result = configValidation.validateAppConfig(config);

result.fold(
  (failure) => print('Validation failed: ${failure.message}'),
  (success) => print('Configuration is valid'),
);
```

## Testing

### Mock Configuration

```dart
import 'package:passpal/test/core/config/mocks/mock_config_providers.dart';

testWidgets('should use test configuration', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWith((_) => AppConfig.forTesting()),
      ],
      child: MyApp(),
    ),
  );
  
  // Test with mock configuration
});
```

### Test Configuration Factory

```dart
// Create test-specific configurations
final testConfig = AppConfig.forTesting();
final devConfig = AppConfig.forDevelopment();
final prodConfig = AppConfig.forProduction();
```

## Environment Setup

### 1. Environment Files

Create `.env` files in your project root:

```bash
# .env (default/fallback)
API_BASE_URL=https://api.passpal.app
ENABLE_DEBUG_MODE=false

# .env.development
API_BASE_URL=https://dev-api.passpal.app
ENABLE_DEBUG_MODE=true
LOG_LEVEL=debug

# .env.staging
API_BASE_URL=https://staging-api.passpal.app
ENABLE_DEBUG_MODE=false
LOG_LEVEL=info

# .env.production
API_BASE_URL=https://api.passpal.app
ENABLE_DEBUG_MODE=false
LOG_LEVEL=error
```

### 2. Firebase Remote Config

Configure in Firebase Console with these parameters:

```json
{
  "feature_flags": {
    "enable_notifications": true,
    "enable_beta_features": false,
    "enable_dark_mode": true
  },
  "admin_config": {
    "maintenance_mode": false,
    "min_supported_version": "1.0.0",
    "force_update": false
  }
}
```

## Best Practices

1. **Use Specific Providers**: Access specific config sections rather than the entire AppConfig when possible
2. **Handle Loading States**: Always handle async config loading in UI
3. **Cache Appropriately**: Use `keepAlive` for critical configuration providers
4. **Validate Early**: Validate configuration during app initialization
5. **Environment Separation**: Use different `.env` files for different environments
6. **Feature Flags**: Use feature flags for gradual rollouts and A/B testing
7. **Error Recovery**: Implement fallback configurations for error scenarios

## Performance Considerations

- Configuration is cached in memory for 15 minutes
- Remote Config updates trigger cache invalidation
- Use `keepAlive` for frequently accessed providers
- Batch configuration reads when possible
- Environment files are loaded once at startup

## Security Notes

- Never store sensitive data in `.env` files that go to version control
- Use Firebase Remote Config for sensitive production configuration
- Validate all configuration values before use
- Implement proper error handling to prevent information leakage

## Migration Guide

### From Direct .env Usage

```dart
// Before
final apiUrl = dotenv.env['API_BASE_URL'] ?? 'default';

// After
final apiUrl = ref.watch(apiConfigProvider).baseUrl;
```

### From Manual Firebase Remote Config

```dart
// Before
final remoteConfig = FirebaseRemoteConfig.instance;
await remoteConfig.fetchAndActivate();
final value = remoteConfig.getString('feature_flag');

// After
final isEnabled = ref.watch(featureFlagProvider('feature_flag'));
```

## Troubleshooting

### Common Issues

1. **Configuration Not Loading**: Check Firebase Remote Config setup and network connectivity
2. **Environment Variables Not Found**: Ensure `.env` files are in project root and properly formatted
3. **Cache Not Invalidating**: Manually refresh using `refreshConfigProvider`
4. **Type Errors**: Ensure all required configuration fields are provided

### Debug Information

```dart
// Enable debug logging
final debugConfig = DebugConfig(
  logLevel: 'debug',
  enableVerboseLogging: true,
  enableNetworkLogging: true,
);
```

## Dependencies

- `flutter_riverpod`: State management
- `riverpod_annotation`: Code generation
- `freezed`: Immutable data classes
- `json_annotation`: JSON serialization
- `firebase_remote_config`: Remote configuration
- `flutter_dotenv`: Environment file parsing

## Related Modules

- **Error Core**: Exception handling and reporting
- **Network Core**: API client configuration
- **Auth Core**: Authentication endpoints
- **Background Core**: Configuration sync tasks