import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/app_error.dart';
import '../logging/app_logger.dart';
import '../services/error_reporter.dart';
import 'error_state.dart';

part 'error_notifier.g.dart';

@riverpod
class ErrorNotifier extends _$ErrorNotifier {
  late final AppLogger _logger;
  late final ErrorReporter _errorReporter;
  static const int _maxErrorHistory = 50;
  static const Duration _deduplicationWindow = Duration(seconds: 5);

  @override
  ErrorState build() {
    _errorReporter = ErrorReporter();
    _logger = AppLogger(tag: 'ErrorNotifier', errorReporter: _errorReporter);
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
      default:
        _logger.warning('Unhandled error type: ${error.runtimeType}');
    }
  }

  Future<void> _handleAuthenticationError(AppError error) async {
    _logger.info('Processing authentication error: ${error.errorCode}');
    // TODO: Implement authentication error recovery in Issue #6
  }

  Future<void> _handleNetworkError(AppError error) async {
    _logger.info('Processing network error: ${error.errorCode}');
    // TODO: Implement network error recovery in Issue #6
  }

  Future<void> _handleStorageError(AppError error) async {
    _logger.info('Processing storage error: ${error.errorCode}');
    // TODO: Implement storage error recovery in Issue #6
  }

  Future<void> _handleMaintenanceError(AppError error) async {
    _logger.info('Processing maintenance error: ${error.errorCode}');
    // TODO: Implement maintenance error recovery in Issue #6
  }

  Future<void> _handleUpdateRequiredError(AppError error) async {
    _logger.info('Processing update required error: ${error.errorCode}');
    // TODO: Implement update required error recovery in Issue #6
  }

  Future<void> _handleParseError(AppError error) async {
    _logger.info('Processing parse error: ${error.errorCode}');
    // TODO: Implement parse error recovery in Issue #6
  }

  // Convenience methods for common error scenarios
  Future<void> reportNetworkError({
    required String message,
    String? errorCode,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) async {
    // TODO: Create specific NetworkFailure when implementing Issue #6
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
    // TODO: Create specific AuthenticationException when implementing Issue #6
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
    // TODO: Create specific StorageException when implementing Issue #6
    final error = AppError.now(
      message: message,
      errorCode: errorCode ?? 'STORAGE_ERROR',
      stackTrace: stackTrace,
      isRecoverable: canRetry,
      retryDelay: canRetry ? const Duration(seconds: 1) : null,
    );

    await handleError(error);
  }
}
