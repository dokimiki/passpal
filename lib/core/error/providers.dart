import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
export 'models/app_error.dart';
export 'models/failure.dart';
export 'models/app_exception.dart';
export 'models/specific_errors.dart';

// Logging
export 'logging/app_logger.dart';
export 'logging/log_level.dart';
export 'logging/log_formatter.dart';

// Services
export 'services/crashlytics_service.dart';
export 'services/error_reporter.dart';

// Notifiers
export 'notifiers/error_notifier.dart';
export 'notifiers/error_state.dart';

// Recovery
export 'recovery/recovery_strategy.dart';
export 'recovery/auth_recovery.dart';
export 'recovery/network_recovery.dart';
export 'recovery/storage_recovery.dart';
export 'recovery/recovery_manager.dart';

// Handlers
export 'handlers/global_error_handler.dart';
export 'handlers/zone_error_handler.dart';

// Import the classes needed for providers
import 'models/app_error.dart';
import 'notifiers/error_notifier.dart';
import 'notifiers/error_state.dart';
import 'recovery/recovery_manager.dart';
import 'services/crashlytics_service.dart';
import 'services/error_reporter.dart';
import 'logging/app_logger.dart';
import 'handlers/global_error_handler.dart';

part 'providers.g.dart';

// =============================================================================
// SERVICES
// =============================================================================

/// Provider for the Crashlytics service
@riverpod
CrashlyticsService crashlyticsService(Ref ref) {
  return CrashlyticsService();
}

/// Provider for the error reporter
@riverpod
ErrorReporter errorReporter(Ref ref) {
  final crashlyticsService = ref.watch(crashlyticsServiceProvider);
  return ErrorReporter(crashlyticsService: crashlyticsService);
}

// =============================================================================
// LOGGING
// =============================================================================

/// Provider for the main app logger
@riverpod
AppLogger appLogger(Ref ref) {
  final errorReporter = ref.watch(errorReporterProvider);
  return AppLogger(tag: 'App', errorReporter: errorReporter);
}

/// Provider for error-specific logger
@riverpod
AppLogger errorLogger(Ref ref) {
  final errorReporter = ref.watch(errorReporterProvider);
  return AppLogger(tag: 'Error', errorReporter: errorReporter);
}

// =============================================================================
// GLOBAL ERROR HANDLING
// =============================================================================

/// Provider for the global error handler
@riverpod
GlobalErrorHandler globalErrorHandler(Ref ref) {
  final container = ProviderContainer();
  return GlobalErrorHandler(container: container);
}

// =============================================================================
// CONVENIENCE PROVIDERS
// =============================================================================

/// Provider for accessing the error notifier state
@riverpod
ErrorState errorState(Ref ref) {
  return ref.watch(errorNotifierProvider);
}

/// Provider for checking if there are any active errors
@riverpod
bool hasActiveErrors(Ref ref) {
  final state = ref.watch(errorStateProvider);
  return state.errors.isNotEmpty;
}

/// Provider for getting the last error
@riverpod
AppError? lastError(Ref ref) {
  final state = ref.watch(errorStateProvider);
  return state.lastError;
}

/// Provider for checking if error handling is in progress
@riverpod
bool isHandlingError(Ref ref) {
  final state = ref.watch(errorStateProvider);
  return state.isHandlingError;
}

/// Provider for getting non-dismissed errors
@riverpod
List<AppError> activeErrors(Ref ref) {
  final state = ref.watch(errorStateProvider);
  return state.errors
      .where((error) => !state.dismissedErrorIds.contains(error.errorCode))
      .toList();
}

/// Provider for getting errors of a specific type
@riverpod
List<AppError> errorsOfType(Ref ref, Type errorType) {
  final state = ref.watch(errorStateProvider);
  return state.errors.where((error) => error.runtimeType == errorType).toList();
}

// =============================================================================
// UTILITY PROVIDERS
// =============================================================================

/// Provider for creating a scoped logger with a specific tag
@riverpod
AppLogger scopedLogger(Ref ref, String tag) {
  final errorReporter = ref.watch(errorReporterProvider);
  return AppLogger(tag: tag, errorReporter: errorReporter);
}

// =============================================================================
// INITIALIZATION
// =============================================================================

/// Provider for initializing the error core module
/// This should be called during app startup to set up global error handling
@riverpod
Future<void> initializeErrorCore(Ref ref) async {
  // Initialize global error handler
  final globalErrorHandler = ref.watch(globalErrorHandlerProvider);
  globalErrorHandler.initialize();

  // Log initialization
  final logger = ref.watch(errorLoggerProvider);
  logger.info('Error core module initialized');
}

// =============================================================================
// FAMILY PROVIDERS
// =============================================================================

/// Provider family for creating loggers with specific tags
@riverpod
AppLogger loggerForTag(Ref ref, String tag) {
  final errorReporter = ref.watch(errorReporterProvider);
  return AppLogger(tag: tag, errorReporter: errorReporter);
}

/// Provider family for filtering errors by error code
@riverpod
List<AppError> errorsByCode(Ref ref, String errorCode) {
  final state = ref.watch(errorStateProvider);
  return state.errors.where((error) => error.errorCode == errorCode).toList();
}

/// Provider family for checking if a specific error type is recoverable
@riverpod
bool isErrorRecoverable(Ref ref, AppError error) {
  final recoveryManager = ref.watch(recoveryManagerProvider);
  return recoveryManager.canRecover(error);
}

/// Provider family for getting recovery attempt count for an error
@riverpod
int recoveryAttemptCount(Ref ref, AppError error) {
  final recoveryManager = ref.watch(recoveryManagerProvider);
  return recoveryManager.getAttemptCount(error);
}

// =============================================================================
// TESTING PROVIDERS
// =============================================================================

/// Provider for testing - allows overriding the error reporter
@riverpod
ErrorReporter testErrorReporter(Ref ref) {
  // This provider is meant to be overridden in tests
  return ref.watch(errorReporterProvider);
}

/// Provider for testing - allows overriding the logger
@riverpod
AppLogger testLogger(Ref ref) {
  // This provider is meant to be overridden in tests
  return ref.watch(errorLoggerProvider);
}

/// Provider for testing - allows overriding the Crashlytics service
@riverpod
CrashlyticsService testCrashlyticsService(Ref ref) {
  // This provider is meant to be overridden in tests
  return ref.watch(crashlyticsServiceProvider);
}

// =============================================================================
// KEEPALIVE PROVIDERS
// =============================================================================

/// Provider for the error notifier that should be kept alive
@riverpod
ErrorNotifier errorNotifierKeepAlive(Ref ref) {
  ref.keepAlive();
  return ref.watch(errorNotifierProvider.notifier);
}

/// Provider for the recovery manager that should be kept alive
@riverpod
RecoveryManager recoveryManagerKeepAlive(Ref ref) {
  ref.keepAlive();
  return ref.watch(recoveryManagerProvider);
}

/// Provider for the global error handler that should be kept alive
@riverpod
GlobalErrorHandler globalErrorHandlerKeepAlive(Ref ref) {
  ref.keepAlive();
  return ref.watch(globalErrorHandlerProvider);
}
