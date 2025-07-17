import '../models/app_error.dart';
import '../notifiers/error_state.dart';
import 'mock_logger.dart';

/// Mock implementation of ErrorNotifier for testing
class MockErrorNotifier {
  ErrorState _state = const ErrorState();
  final MockAppLogger _logger = MockAppLogger(tag: 'MockErrorNotifier');
  final MockErrorReporter _errorReporter = MockErrorReporter();
  final List<MockErrorHandling> _handledErrors = [];
  bool _enabled = true;

  /// Get current error state
  ErrorState get state => _state;

  /// Get logger for testing
  MockAppLogger get logger => _logger;

  /// Get error reporter for testing
  MockErrorReporter get errorReporter => _errorReporter;

  /// Get handled errors for testing
  List<MockErrorHandling> get handledErrors =>
      List.unmodifiable(_handledErrors);

  /// Enable/disable error handling for testing
  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  /// Clear all state and records
  void clearAll() {
    _state = const ErrorState();
    _logger.clearLogs();
    _errorReporter.clearReports();
    _handledErrors.clear();
  }

  /// Mock implementation of handleError
  Future<void> handleError(
    AppError error, {
    bool showToUser = true,
    Map<String, dynamic>? context,
  }) async {
    if (!_enabled) return;

    // Record the error handling for testing
    _handledErrors.add(
      MockErrorHandling(
        error: error,
        showToUser: showToUser,
        context: context,
        timestamp: DateTime.now(),
      ),
    );

    // Skip deduplication check in mock (can be customized if needed)
    _logger.logError(error, additionalAttributes: context);
    await _errorReporter.reportError(error, additionalAttributes: context);

    // Update state
    _state = _state.copyWith(
      errors: _addErrorToHistory(error),
      lastError: error,
      isHandlingError: true,
    );

    // Simulate error processing
    await _processError(error, showToUser: showToUser, context: context);

    // Mark as done
    _state = _state.copyWith(isHandlingError: false);
  }

  /// Mock implementation of dismissError
  void dismissError(String errorCode) {
    if (!_enabled) return;

    _logger.info('Error dismissed: $errorCode');
    _state = _state.copyWith(
      dismissedErrorIds: [..._state.dismissedErrorIds, errorCode],
    );
  }

  /// Mock implementation of clearDismissedErrors
  void clearDismissedErrors() {
    if (!_enabled) return;

    _logger.info('Clearing dismissed errors');
    _state = _state.copyWith(dismissedErrorIds: []);
  }

  /// Mock implementation of clearAllErrors
  void clearAllErrors() {
    if (!_enabled) return;

    _logger.info('Clearing all errors');
    _state = const ErrorState();
  }

  /// Mock implementation of clearErrorsOfType
  void clearErrorsOfType(Type errorType) {
    if (!_enabled) return;

    _logger.info('Clearing errors of type: $errorType');
    final filteredErrors = _state.errors
        .where((error) => error.runtimeType != errorType)
        .toList();
    _state = _state.copyWith(errors: filteredErrors);
  }

  List<AppError> _addErrorToHistory(AppError error) {
    const maxErrorHistory = 50;
    final updatedErrors = [..._state.errors, error];

    if (updatedErrors.length > maxErrorHistory) {
      return updatedErrors.sublist(updatedErrors.length - maxErrorHistory);
    }

    return updatedErrors;
  }

  Future<void> _processError(
    AppError error, {
    required bool showToUser,
    Map<String, dynamic>? context,
  }) async {
    // Mock processing based on error type
    switch (error.runtimeType.toString()) {
      case 'AuthenticationException':
        _logger.info('Processing authentication error: ${error.errorCode}');
        break;
      case 'NetworkFailure':
        _logger.info('Processing network error: ${error.errorCode}');
        break;
      case 'StorageException':
        _logger.info('Processing storage error: ${error.errorCode}');
        break;
      case 'MaintenanceException':
        _logger.info('Processing maintenance error: ${error.errorCode}');
        break;
      case 'UpdateRequiredException':
        _logger.info('Processing update required error: ${error.errorCode}');
        break;
      case 'ParseFailure':
        _logger.info('Processing parse error: ${error.errorCode}');
        break;
      default:
        _logger.warning('Unhandled error type: ${error.runtimeType}');
    }
  }

  /// Test helper: Check if error was handled
  bool hasHandledError(String errorCode) {
    return _handledErrors.any(
      (handling) => handling.error.errorCode == errorCode,
    );
  }

  /// Test helper: Check if error is in state
  bool hasErrorInState(String errorCode) {
    return _state.errors.any((error) => error.errorCode == errorCode);
  }

  /// Test helper: Check if error is dismissed
  bool isErrorDismissed(String errorCode) {
    return _state.dismissedErrorIds.contains(errorCode);
  }

  /// Test helper: Get errors by type
  List<AppError> getErrorsByType<T extends AppError>() {
    return _state.errors.whereType<T>().toList();
  }

  /// Test helper: Get handled errors by type
  List<MockErrorHandling> getHandledErrorsByType<T extends AppError>() {
    return _handledErrors.where((handling) => handling.error is T).toList();
  }

  /// Test helper: Get last handled error
  MockErrorHandling? get lastHandledError =>
      _handledErrors.isNotEmpty ? _handledErrors.last : null;

  /// Test helper: Get error count
  int get errorCount => _state.errors.length;

  /// Test helper: Get dismissed error count
  int get dismissedErrorCount => _state.dismissedErrorIds.length;

  /// Test helper: Get handled error count
  int get handledErrorCount => _handledErrors.length;

  /// Test helper: Check if currently handling error
  bool get isHandlingError => _state.isHandlingError;

  /// Test helper: Get last error
  AppError? get lastError => _state.lastError;

  /// Test helper: Set state directly (for testing edge cases)
  void setState(ErrorState state) {
    _state = state;
  }

  /// Test helper: Simulate error deduplication scenario
  void simulateDeduplication(AppError error) {
    _logger.debug('Duplicate error filtered: ${error.errorCode}');
  }

  /// Test helper: Simulate recovery success
  void simulateRecoverySuccess(AppError error) {
    _logger.info('Error recovered successfully: ${error.errorCode}');
    clearErrorsOfType(error.runtimeType);
  }

  /// Test helper: Simulate recovery failure
  void simulateRecoveryFailure(AppError error) {
    _logger.warning('Error recovery failed: ${error.errorCode}');
  }

  /// Test helper: Simulate recovery retry
  void simulateRecoveryRetry(AppError error) {
    _logger.info('Error recovery scheduled retry: ${error.errorCode}');
  }
}

/// Record of an error handling operation
class MockErrorHandling {
  final AppError error;
  final bool showToUser;
  final Map<String, dynamic>? context;
  final DateTime timestamp;

  MockErrorHandling({
    required this.error,
    required this.showToUser,
    this.context,
    required this.timestamp,
  });

  @override
  String toString() =>
      'MockErrorHandling(error: ${error.errorCode}, showToUser: $showToUser, timestamp: $timestamp)';
}
