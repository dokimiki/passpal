# Error Core Module

This module provides comprehensive error handling capabilities for the PassPal application, including error modeling, logging, recovery mechanisms, and testing utilities.

## Overview

The error core module follows Clean Architecture principles and provides:

- **Structured Error Models**: Hierarchical error types with recovery capabilities
- **Unified Logging**: Environment-specific logging with Crashlytics integration
- **Automatic Recovery**: Smart recovery strategies for different error types
- **Global Error Handling**: Catches uncaught exceptions and Flutter framework errors
- **Testing Support**: Comprehensive mocking and test utilities

## Architecture

```
lib/core/error/
├── models/             # Error type definitions
├── logging/            # Logging system
├── services/           # External service integrations
├── notifiers/          # Riverpod state management
├── recovery/           # Auto-recovery mechanisms
├── handlers/           # Global error collection
├── testing/            # Test utilities and mocks
└── providers.dart      # Dependency injection
```

## Quick Start

### 1. Setup in main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/error/providers.dart';

void main() {
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          // Initialize global error handling
          ref.read(globalErrorHandlerProvider);
          
          return MyApp();
        },
      ),
    ),
  );
}
```

### 2. Handle Errors in Features

```dart
class DataRepository {
  DataRepository(this._ref);
  
  final Ref _ref;
  
  Future<Data> fetchData() async {
    try {
      // Your API call
      return await api.getData();
    } catch (e, stackTrace) {
      // Handle error with automatic recovery
      final error = NetworkFailure.connectionNow(
        message: 'Failed to fetch data',
        stackTrace: stackTrace,
      );
      
      // This will automatically attempt recovery
      _ref.read(errorNotifierProvider.notifier).handleError(error);
      
      rethrow;
    }
  }
}
```

### 3. Listen to Error State in UI

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorState = ref.watch(errorNotifierProvider);
    
    return errorState.when(
      data: (_) => YourNormalWidget(),
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => ErrorWidget(error: error),
    );
  }
}
```

## Error Types

### Base Error Model

```dart
@freezed
abstract class AppError with _$AppError {
  const factory AppError({
    required String message,
    required String errorCode,
    StackTrace? stackTrace,
    required DateTime timestamp,
    required bool isRecoverable,
    Duration? retryDelay,
    Map<String, dynamic>? context,
  }) = _AppError;
}
```

### Error Hierarchy

- **AppError**: Base error class with common properties
  - **Failure**: Recoverable errors (network, parsing, storage)
  - **AppException**: System errors (authentication, maintenance, updates)

### Specific Error Types

#### Authentication Errors
```dart
// Invalid credentials
AppException.authenticationNow(
  message: 'Invalid username or password',
  errorCode: 'AUTH_INVALID_CREDENTIALS',
);

// Session expired
AppException.authenticationNow(
  message: 'Session has expired',
  errorCode: 'AUTH_SESSION_EXPIRED',
);
```

#### Network Errors
```dart
// Connection failure
NetworkFailure.connectionNow(
  message: 'Unable to connect to server',
  retryDelay: Duration(seconds: 5),
);

// Server error
NetworkFailure.serverNow(
  message: 'Server returned error 500',
  retryDelay: Duration(seconds: 10),
);
```

#### Storage Errors
```dart
// Storage write failure
StorageException.writeFailureNow(
  message: 'Failed to save data to storage',
);

// Storage capacity exceeded
StorageException.capacityExceededNow(
  message: 'Storage capacity exceeded',
);
```

## Logging System

### Log Levels

- **Debug**: Development debugging information
- **Info**: General application information
- **Warning**: Potentially problematic situations
- **Error**: Error events that allow application to continue
- **Fatal**: Critical errors that may cause application termination

### Environment-Specific Behavior

- **Debug Mode**: Color-coded console output with full details
- **Release Mode**: Warning+ levels sent to Crashlytics
- **Dev Menu**: Info+ levels written to file (when enabled)

### Usage Examples

```dart
// Get logger instance
final logger = ref.read(appLoggerProvider);

// Log different levels
logger.debug('Debug information');
logger.info('Application started');
logger.warning('Potential issue detected');
logger.error('Operation failed', error: error, stackTrace: stackTrace);
logger.fatal('Critical system error', error: error, stackTrace: stackTrace);

// Log with custom attributes
logger.error(
  'API call failed',
  error: error,
  stackTrace: stackTrace,
  attributes: {
    'endpoint': '/api/data',
    'statusCode': 500,
    'userId': 'user123',
  },
);
```

## Recovery Mechanisms

### Automatic Recovery

The system automatically attempts recovery for recoverable errors:

```dart
// This error will trigger automatic recovery
final error = NetworkFailure.connectionNow(
  message: 'Connection failed',
  retryDelay: Duration(seconds: 5),
);

// Recovery is attempted automatically
ref.read(errorNotifierProvider.notifier).handleError(error);
```

### Recovery Strategies

#### Authentication Recovery
- Clear invalid credentials
- Redirect to login screen
- Attempt credential refresh

#### Network Recovery
- Exponential backoff retry
- Connection availability check
- Configurable retry limits

#### Storage Recovery
- Clear corrupted cache
- Retry operation
- Fallback to alternative storage

### Manual Recovery

```dart
// Trigger manual recovery
final recoveryManager = ref.read(recoveryManagerProvider);
final success = await recoveryManager.recoverFromError(error);

if (success) {
  // Recovery successful, retry operation
  return await retryOperation();
} else {
  // Recovery failed, handle gracefully
  showUserFriendlyError();
}
```

## Testing Support

### Mock Implementations

```dart
// Setup test environment
final container = ProviderContainer(
  overrides: [
    crashlyticsServiceProvider.overrideWithValue(MockCrashlyticsService()),
    appLoggerProvider.overrideWithValue(MockAppLogger()),
    errorNotifierProvider.overrideWith(MockErrorNotifier.new),
  ],
);
```

### Test Utilities

```dart
// Create test errors
final testError = ErrorTestUtils.createTestError(
  message: 'Test error',
  errorCode: 'TEST_ERROR',
  isRecoverable: true,
);

// Create specific error types
final authError = ErrorTestUtils.createAuthError();
final networkError = ErrorTestUtils.createNetworkError();
final storageError = ErrorTestUtils.createStorageError();

// Test error handling
await ErrorTestUtils.testErrorHandling(
  container: container,
  error: testError,
  expectedRecoveryAttempts: 3,
);
```

### Test Scenarios

```dart
group('Error handling tests', () {
  testWidgets('Network error recovery', (tester) async {
    // Setup
    final container = createTestContainer();
    final mockLogger = container.read(appLoggerProvider) as MockAppLogger;
    
    // Test
    final error = ErrorTestUtils.createNetworkError();
    await container.read(errorNotifierProvider.notifier).handleError(error);
    
    // Verify
    expect(mockLogger.errorLogs, hasLength(1));
    expect(mockLogger.errorLogs.first.message, contains('Network error'));
  });
});
```

## Integration with Other Core Modules

### Authentication Module

```dart
// Handle authentication errors
if (error is AuthenticationException) {
  // Clear credentials
  await ref.read(authServiceProvider).clearCredentials();
  
  // Redirect to login
  ref.read(routerProvider).go('/login');
}
```

### Storage Module

```dart
// Handle storage errors
if (error is StorageException) {
  // Clear cache
  await ref.read(cacheServiceProvider).clearCache();
  
  // Retry operation
  return await retryOperation();
}
```

### Network Module

```dart
// Handle network errors with retry
if (error is NetworkFailure) {
  // Check connectivity
  final isConnected = await ref.read(connectivityProvider.future);
  
  if (isConnected) {
    // Retry with exponential backoff
    return await retryWithBackoff(operation);
  } else {
    // Show offline message
    showOfflineMessage();
  }
}
```

## Best Practices

### Error Creation

```dart
// ✅ Good: Use factory constructors for consistency
final error = NetworkFailure.connectionNow(
  message: 'Connection failed',
  retryDelay: Duration(seconds: 5),
  context: {'endpoint': '/api/data'},
);

// ❌ Bad: Direct constructor usage
final error = AppError(
  message: 'Connection failed',
  errorCode: 'NETWORK_CONNECTION',
  timestamp: DateTime.now(),
  isRecoverable: true,
);
```

### Error Handling

```dart
// ✅ Good: Let the system handle recovery
try {
  return await operation();
} catch (e, stackTrace) {
  final error = createAppropriateError(e, stackTrace);
  ref.read(errorNotifierProvider.notifier).handleError(error);
  rethrow;
}

// ❌ Bad: Manual error handling without system integration
try {
  return await operation();
} catch (e) {
  print('Error occurred: $e');
  return null;
}
```

### Logging

```dart
// ✅ Good: Structured logging with context
logger.error(
  'Operation failed',
  error: error,
  stackTrace: stackTrace,
  attributes: {
    'operation': 'fetchUserData',
    'userId': user.id,
    'attempt': attemptNumber,
  },
);

// ❌ Bad: Unstructured logging
print('Error: ${error.toString()}');
```

## Configuration

### Environment Variables

```dart
// Debug mode behavior
const bool isDebugMode = kDebugMode;

// Crashlytics reporting
const bool enableCrashlytics = !kDebugMode;

// Log file writing
const bool enableLogFile = kDebugMode;
```

### Customization

```dart
// Custom error codes
class CustomErrorCodes {
  static const String customOperation = 'CUSTOM_OPERATION_FAILED';
  static const String customValidation = 'CUSTOM_VALIDATION_ERROR';
}

// Custom recovery strategy
class CustomRecoveryStrategy extends RecoveryStrategy {
  @override
  Future<bool> canRecover(AppError error) async {
    return error.errorCode == CustomErrorCodes.customOperation;
  }
  
  @override
  Future<bool> recover(AppError error) async {
    // Custom recovery logic
    return true;
  }
}
```

## Troubleshooting

### Common Issues

1. **Errors not being logged**: Check that global error handler is initialized
2. **Recovery not working**: Verify error is marked as recoverable
3. **Crashlytics not receiving errors**: Ensure release mode and proper Firebase setup
4. **Memory leaks**: Use appropriate provider scoping and disposal

### Debug Mode Tools

```dart
// Check error state
final errorState = ref.read(errorNotifierProvider);

// View recent errors
final recentErrors = ref.read(recentErrorsProvider);

// Check logger records
final logRecords = ref.read(logRecordsProvider);
```

## Performance Considerations

- Error deduplication prevents spam
- Automatic cleanup of old error records
- Efficient provider scoping
- Lazy initialization of services
- Optimized logging in release mode

## Migration Guide

### From Previous Error Handling

```dart
// Old way
try {
  await operation();
} catch (e) {
  showErrorDialog(e.toString());
}

// New way
try {
  await operation();
} catch (e, stackTrace) {
  final error = NetworkFailure.connectionNow(
    message: 'Operation failed',
    stackTrace: stackTrace,
  );
  ref.read(errorNotifierProvider.notifier).handleError(error);
  rethrow;
}
```

## Contributing

When adding new error types:

1. Add to appropriate sealed class (Failure or AppException)
2. Update recovery strategies if needed
3. Add test utilities
4. Update documentation
5. Consider impact on existing error handling

## License

This module is part of the PassPal application and follows the same licensing terms.