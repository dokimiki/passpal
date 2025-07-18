import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/app_error.dart';
import '../logging/app_logger.dart';
import '../services/error_reporter.dart';
import '../recovery/recovery_manager.dart';
import 'error_state.dart';

part 'error_notifier.g.dart';

@riverpod
class ErrorNotifier extends _$ErrorNotifier {
  late final AppLogger _logger;
  late final ErrorReporter _errorReporter;
  late final RecoveryManager _recoveryManager;
  static const int _maxErrorHistory = 50;
  static const Duration _deduplicationWindow = Duration(seconds: 5);

  @override
  ErrorState build() {
    _errorReporter = ErrorReporter();
    _logger = AppLogger(tag: 'ErrorNotifier', errorReporter: _errorReporter);
    _recoveryManager = ref.read(recoveryManagerProvider);
    return const ErrorState();
  }

  Future<void> handleError(
    AppError error, {
    bool showToUser = true,
    Map<String, dynamic>? context,
  }) async {
    if (_isDuplicateError(error)) {
      _logger.debug('Duplicate error filtered: ${error.errorCode}');
      return;
    }

    _logger.logError(error, additionalAttributes: context);

    // Report error to Crashlytics
    await _errorReporter.reportError(error, additionalAttributes: context);

    state = state.copyWith(
      errors: _addErrorToHistory(error),
      lastError: error,
      isHandlingError: true,
    );

    try {
      await _processError(error, showToUser: showToUser, context: context);
    } finally {
      state = state.copyWith(isHandlingError: false);
    }
  }

  void dismissError(String errorCode) {
    _logger.info('Error dismissed: $errorCode');

    state = state.copyWith(
      dismissedErrorIds: [...state.dismissedErrorIds, errorCode],
    );
  }

  void clearDismissedErrors() {
    _logger.info('Clearing dismissed errors');

    state = state.copyWith(dismissedErrorIds: []);
  }

  void clearAllErrors() {
    _logger.info('Clearing all errors');

    state = const ErrorState();
  }

  void clearErrorsOfType(Type errorType) {
    _logger.info('Clearing errors of type: $errorType');

    final filteredErrors = state.errors
        .where((error) => error.runtimeType != errorType)
        .toList();

    state = state.copyWith(errors: filteredErrors);
  }

  bool _isDuplicateError(AppError error) {
    final now = DateTime.now();

    return state.errors.any(
      (existingError) =>
          existingError.errorCode == error.errorCode &&
          existingError.message == error.message &&
          now.difference(existingError.timestamp) < _deduplicationWindow,
    );
  }

  List<AppError> _addErrorToHistory(AppError error) {
    final updatedErrors = [...state.errors, error];

    if (updatedErrors.length > _maxErrorHistory) {
      return updatedErrors.sublist(updatedErrors.length - _maxErrorHistory);
    }

    return updatedErrors;
  }

  Future<void> _processError(
    AppError error, {
    required bool showToUser,
    Map<String, dynamic>? context,
  }) async {
    switch (error.runtimeType.toString()) {
      case 'AuthenticationException':
        await _handleAuthenticationError(error);
        break;
      case 'NetworkFailure':
        await _handleNetworkError(error);
        break;
      case 'StorageException':
        await _handleStorageError(error);
        break;
      case 'MaintenanceException':
        await _handleMaintenanceError(error);
        break;
      case 'UpdateRequiredException':
        await _handleUpdateRequiredError(error);
        break;
      case 'ParseFailure':
        await _handleParseError(error);
        break;
      case 'ConfigException':
        await _handleConfigError(error);
        break;
      case 'ConfigSourceFailure':
      case 'ConfigParseFailure':
        await _handleConfigFailure(error);
        break;
      default:
        _logger.warning('Unhandled error type: ${error.runtimeType}');
    }
  }

  Future<void> _handleAuthenticationError(AppError error) async {
    _logger.info('Processing authentication error: ${error.errorCode}');

    if (_recoveryManager.canRecover(error)) {
      try {
        final result = await _recoveryManager.attemptRecovery(error);

        // Handle recovery result using runtime type checking
        if (result.runtimeType.toString().contains('Success')) {
          _logger.info('Authentication error recovered successfully');
          // Clear the error from state as it's been resolved
          clearErrorsOfType(error.runtimeType);
        } else if (result.runtimeType.toString().contains('Failure')) {
          _logger.warning('Authentication recovery failed');
          // Recovery failed - error remains in state
        } else if (result.runtimeType.toString().contains('Retry')) {
          _logger.info('Authentication recovery scheduled retry');
          // Note: Actual retry scheduling is handled by RecoveryManager
        }
      } catch (e) {
        _logger.error('Authentication recovery attempt failed: $e');
      }
    } else {
      _logger.warning(
        'No recovery strategy available for authentication error',
      );
    }
  }

  Future<void> _handleNetworkError(AppError error) async {
    _logger.info('Processing network error: ${error.errorCode}');

    if (_recoveryManager.canRecover(error)) {
      try {
        final result = await _recoveryManager.attemptRecovery(error);

        // Handle recovery result
        if (result.runtimeType.toString().contains('Success')) {
          _logger.info('Network error recovered successfully');
          clearErrorsOfType(error.runtimeType);
        } else if (result.runtimeType.toString().contains('Failure')) {
          _logger.warning('Network recovery failed');
          // Error remains in state for user awareness
        } else if (result.runtimeType.toString().contains('Retry')) {
          _logger.info(
            'Network recovery scheduled retry with exponential backoff',
          );
          // RecoveryManager handles the retry logic automatically
        }
      } catch (e) {
        _logger.error('Network recovery attempt failed: $e');
      }
    } else {
      _logger.warning('No recovery strategy available for network error');
    }
  }

  Future<void> _handleStorageError(AppError error) async {
    _logger.info('Processing storage error: ${error.errorCode}');

    if (_recoveryManager.canRecover(error)) {
      try {
        final result = await _recoveryManager.attemptRecovery(error);

        // Handle recovery result
        if (result.runtimeType.toString().contains('Success')) {
          _logger.info('Storage error recovered successfully');
          clearErrorsOfType(error.runtimeType);
        } else if (result.runtimeType.toString().contains('Failure')) {
          _logger.warning('Storage recovery failed');
          // May need to show user a more persistent error state
        } else if (result.runtimeType.toString().contains('Retry')) {
          _logger.info(
            'Storage recovery scheduled retry (cache clear + retry)',
          );
          // RecoveryManager handles cache clearing and retry logic
        }
      } catch (e) {
        _logger.error('Storage recovery attempt failed: $e');
      }
    } else {
      _logger.warning('No recovery strategy available for storage error');
    }
  }

  Future<void> _handleMaintenanceError(AppError error) async {
    _logger.info('Processing maintenance error: ${error.errorCode}');

    // For maintenance errors, we typically don't use automatic recovery
    // but we should log the error and potentially show maintenance screen
    _logger.warning('System is under maintenance: ${error.message}');

    // Maintenance errors are usually handled at the UI level
    // by showing a maintenance screen, so we keep the error in state
    // for the UI to detect and respond appropriately

    // Future enhancement: Could implement recovery that:
    // 1. Shows maintenance screen to user
    // 2. Periodically checks if maintenance is over
    // 3. Automatically retries when system is back online
  }

  Future<void> _handleUpdateRequiredError(AppError error) async {
    _logger.info('Processing update required error: ${error.errorCode}');

    // Update required errors typically need user action (go to app store)
    // but we can implement some automatic handling
    _logger.warning('App update required: ${error.message}');

    // For UpdateRequiredException, the typical recovery would be:
    // 1. Show update dialog to user
    // 2. Redirect to app store if user accepts
    // 3. Potentially block app usage until updated (for force updates)

    // Since this requires UI interaction and app store redirection,
    // we'll keep the error in state for the UI layer to handle
    // The UI can detect this error type and show appropriate update dialog

    // Future enhancement: Could implement recovery that:
    // 1. Determines if it's a force update vs optional update
    // 2. Shows appropriate UI (blocking vs non-blocking)
    // 3. Handles app store redirection
  }

  Future<void> _handleParseError(AppError error) async {
    _logger.info('Processing parse error: ${error.errorCode}');

    if (_recoveryManager.canRecover(error)) {
      try {
        final result = await _recoveryManager.attemptRecovery(error);

        // Handle recovery result
        if (result.runtimeType.toString().contains('Success')) {
          _logger.info('Parse error recovered successfully');
          clearErrorsOfType(error.runtimeType);
        } else if (result.runtimeType.toString().contains('Failure')) {
          _logger.warning('Parse recovery failed');
          // Parse errors might indicate API changes or data format issues
          // These should be kept in state to alert developers/users
        } else if (result.runtimeType.toString().contains('Retry')) {
          _logger.info(
            'Parse recovery scheduled retry (possibly refetch data)',
          );
          // RecoveryManager might retry data fetching with different parameters
        }
      } catch (e) {
        _logger.error('Parse recovery attempt failed: $e');
      }
    } else {
      // Parse errors are often unrecoverable without manual intervention
      // Log detailed information for debugging
      _logger.error(
        'Parse error - potential API schema change: ${error.message}',
      );
      _logger.error('Parse error context: ${error.errorCode}');

      // Keep error in state so UI can show appropriate error message
      // and possibly suggest user actions (refresh, contact support)
    }
  }

  // Convenience methods for common error scenarios
  Future<void> reportNetworkError({
    required String message,
    String? errorCode,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) async {
    // TODO: Create specific NetworkFailure when specific error types are needed
    // For now, using generic AppError with network-specific error code
    final error = AppError.now(
      message: message,
      errorCode: errorCode ?? 'NETWORK_ERROR',
      stackTrace: stackTrace,
      isRecoverable: canRetry,
      retryDelay: canRetry ? const Duration(seconds: 2) : null,
    );

    await handleError(error);
  }

  Future<void> reportAuthenticationError({
    required String message,
    String? errorCode,
    StackTrace? stackTrace,
  }) async {
    // TODO: Create specific AuthenticationException when specific error types are needed
    // For now, using generic AppError with auth-specific error code
    final error = AppError.now(
      message: message,
      errorCode: errorCode ?? 'AUTH_ERROR',
      stackTrace: stackTrace,
      isRecoverable: false,
    );

    await handleError(error);
  }

  Future<void> reportStorageError({
    required String message,
    String? errorCode,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) async {
    // TODO: Create specific StorageException when specific error types are needed
    // For now, using generic AppError with storage-specific error code
    final error = AppError.now(
      message: message,
      errorCode: errorCode ?? 'STORAGE_ERROR',
      stackTrace: stackTrace,
      isRecoverable: canRetry,
      retryDelay: canRetry ? const Duration(seconds: 1) : null,
    );

    await handleError(error);
  }

  Future<void> reportConfigError({
    required String message,
    String? errorCode,
    StackTrace? stackTrace,
  }) async {
    final error = AppError.now(
      message: message,
      errorCode: errorCode ?? 'CONFIG_ERROR',
      stackTrace: stackTrace,
      isRecoverable: false,
    );

    await handleError(error);
  }

  Future<void> reportConfigSourceError({
    required String message,
    String? errorCode,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) async {
    final error = AppError.now(
      message: message,
      errorCode: errorCode ?? 'CONFIG_SOURCE_ERROR',
      stackTrace: stackTrace,
      isRecoverable: canRetry,
      retryDelay: canRetry ? const Duration(seconds: 3) : null,
    );

    await handleError(error);
  }

  Future<void> reportConfigParseError({
    required String message,
    String? errorCode,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) async {
    final error = AppError.now(
      message: message,
      errorCode: errorCode ?? 'CONFIG_PARSE_ERROR',
      stackTrace: stackTrace,
      isRecoverable: canRetry,
      retryDelay: canRetry ? const Duration(seconds: 2) : null,
    );

    await handleError(error);
  }

  Future<void> _handleConfigError(AppError error) async {
    _logger.info('Processing config error: ${error.errorCode}');

    // Config exceptions are usually critical and non-recoverable
    // These might indicate missing config files or critical validation failures
    _logger.warning('Critical config error: ${error.message}');

    // Keep error in state for UI to handle appropriately
    // UI might show fallback screens or prompt user to retry app initialization

    // Future enhancement: Could implement recovery that:
    // 1. Falls back to default configuration
    // 2. Retries config loading from different sources
    // 3. Shows user-friendly error with suggested actions
  }

  Future<void> _handleConfigFailure(AppError error) async {
    _logger.info('Processing config failure: ${error.errorCode}');

    if (_recoveryManager.canRecover(error)) {
      try {
        final result = await _recoveryManager.attemptRecovery(error);

        // Handle recovery result
        if (result.runtimeType.toString().contains('Success')) {
          _logger.info('Config failure recovered successfully');
          clearErrorsOfType(error.runtimeType);
        } else if (result.runtimeType.toString().contains('Failure')) {
          _logger.warning('Config recovery failed');
          // Config failures might need fallback to cached/default config
        } else if (result.runtimeType.toString().contains('Retry')) {
          _logger.info('Config recovery scheduled retry (refetch from remote)');
          // RecoveryManager handles retry logic with exponential backoff
        }
      } catch (e) {
        _logger.error('Config recovery attempt failed: $e');
      }
    } else {
      _logger.warning('No recovery strategy available for config failure');

      // Log detailed information for debugging config issues
      _logger.error('Config failure details: ${error.message}');
      _logger.error('Config failure context: ${error.errorCode}');

      // Keep error in state so UI can show appropriate fallback
      // or prompt user to check network/retry manually
    }
  }
}
