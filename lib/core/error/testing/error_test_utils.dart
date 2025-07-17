import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import 'mock_crashlytics.dart';
import 'mock_logger.dart';
import 'mock_error_notifier.dart';

/// Utility class for testing error handling functionality
class ErrorTestUtils {
  /// Create a test AppError with minimal required fields
  static AppError createTestError({
    String message = 'Test error',
    String errorCode = 'TEST_ERROR',
    bool isRecoverable = false,
    Duration? retryDelay,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppError.now(
      message: message,
      errorCode: errorCode,
      isRecoverable: isRecoverable,
      retryDelay: retryDelay,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a test AuthenticationException
  static AppException createAuthError({
    String message = 'Authentication failed',
    String errorCode = 'AUTH_INVALID_CREDENTIALS',
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppException.authenticationNow(
      message: message,
      errorCode: errorCode,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a test NetworkFailure
  static Failure createNetworkError({
    String message = 'Network error',
    String errorCode = 'NETWORK_CONNECTION',
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return Failure.networkNow(
      message: message,
      errorCode: errorCode,
      stackTrace: stackTrace,
      retryDelay: const Duration(seconds: 2),
      context: context,
    );
  }

  /// Create a test StorageException
  static AppException createStorageError({
    String message = 'Storage error',
    String errorCode = 'STORAGE_READ_FAILURE',
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppException.storageNow(
      message: message,
      errorCode: errorCode,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a test ParseFailure
  static Failure createParseError({
    String message = 'Parse error',
    String errorCode = 'PARSE_MALFORMED_DATA',
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return Failure.parseNow(
      message: message,
      errorCode: errorCode,
      stackTrace: stackTrace,
      retryDelay: const Duration(seconds: 1),
      context: context,
    );
  }

  /// Create a test MaintenanceException
  static AppException createMaintenanceError({
    String message = 'System maintenance',
    String errorCode = 'MAINTENANCE_SCHEDULED',
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppException.maintenanceNow(
      message: message,
      errorCode: errorCode,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a test UpdateRequiredException
  static AppException createUpdateRequiredError({
    String message = 'Update required',
    String errorCode = 'UPDATE_REQUIRED',
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return AppException.updateRequiredNow(
      message: message,
      errorCode: errorCode,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Create a test ErrorState
  static ErrorState createTestErrorState({
    List<AppError>? errors,
    AppError? lastError,
    List<String>? dismissedErrorIds,
    bool isHandlingError = false,
  }) {
    return ErrorState(
      errors: errors ?? [],
      lastError: lastError,
      dismissedErrorIds: dismissedErrorIds ?? [],
      isHandlingError: isHandlingError,
    );
  }

  /// Create a ProviderContainer with mock error providers
  static ProviderContainer createMockContainer({
    MockCrashlyticsService? mockCrashlytics,
    MockAppLogger? mockLogger,
  }) {
    final container = ProviderContainer(
      overrides: [
        // Override crashlytics service
        if (mockCrashlytics != null)
          crashlyticsServiceProvider.overrideWithValue(mockCrashlytics),

        // Override logger
        if (mockLogger != null)
          appLoggerProvider.overrideWith((ref) => mockLogger),
      ],
    );

    return container;
  }

  /// Create a stack trace for testing
  static StackTrace createTestStackTrace() {
    try {
      throw Exception('Test exception for stack trace');
    } catch (e, stackTrace) {
      return stackTrace;
    }
  }

  /// Create test context data
  static Map<String, dynamic> createTestContext({
    String? userId,
    String? feature,
    String? operation,
    Map<String, dynamic>? additionalData,
  }) {
    final context = <String, dynamic>{};

    if (userId != null) context['userId'] = userId;
    if (feature != null) context['feature'] = feature;
    if (operation != null) context['operation'] = operation;
    if (additionalData != null) context.addAll(additionalData);

    return context;
  }

  /// Simulate error scenarios for testing
  static Future<void> simulateErrorScenario({
    required MockErrorNotifier mockNotifier,
    required List<AppError> errors,
    Duration delay = const Duration(milliseconds: 100),
  }) async {
    for (final error in errors) {
      await mockNotifier.handleError(error);
      await Future.delayed(delay);
    }
  }

  /// Create a series of errors for testing error history
  static List<AppError> createErrorSeries({
    int count = 5,
    String baseMessage = 'Test error',
    String baseErrorCode = 'TEST_ERROR',
  }) {
    return List.generate(count, (index) {
      return createTestError(
        message: '$baseMessage $index',
        errorCode: '${baseErrorCode}_$index',
        isRecoverable: index % 2 == 0, // Alternate recoverable/non-recoverable
      );
    });
  }

  /// Create errors of different types for testing
  static List<AppError> createMixedErrorTypes() {
    return [
      createAuthError().asAppError,
      createNetworkError().asAppError,
      createStorageError().asAppError,
      createParseError().asAppError,
      createMaintenanceError().asAppError,
      createUpdateRequiredError().asAppError,
    ];
  }

  /// Verify error was logged correctly
  static bool verifyErrorLogged(
    MockAppLogger logger,
    AppError error, {
    LogLevel? expectedLevel,
  }) {
    final logs = logger.logs;

    return logs.any(
      (log) =>
          log.message == error.message &&
          (expectedLevel == null || log.level == expectedLevel) &&
          log.attributes?['errorCode'] == error.errorCode,
    );
  }

  /// Verify error was reported to Crashlytics
  static bool verifyErrorReported(
    MockCrashlyticsService crashlytics,
    AppError error,
  ) {
    return crashlytics.hasErrorWithCode(error.errorCode);
  }

  /// Verify error state contains expected error
  static bool verifyErrorInState(ErrorState state, AppError error) {
    return state.errors.any((e) => e.errorCode == error.errorCode);
  }

  /// Verify error is dismissed
  static bool verifyErrorDismissed(ErrorState state, String errorCode) {
    return state.dismissedErrorIds.contains(errorCode);
  }

  /// Get error count by type from state
  static int getErrorCountByType<T extends AppError>(ErrorState state) {
    return state.errors.whereType<T>().length;
  }

  /// Get logs by level from mock logger
  static List<MockLogEntry> getLogsByLevel(
    MockAppLogger logger,
    LogLevel level,
  ) {
    return logger.getLogsByLevel(level);
  }

  /// Get error records by type from mock crashlytics
  static List<MockErrorRecord> getErrorRecordsByType<T extends AppError>(
    MockCrashlyticsService crashlytics,
  ) {
    return crashlytics.getErrorsByType<T>();
  }

  /// Assert error handling metrics
  static void assertErrorHandlingMetrics({
    required MockErrorNotifier notifier,
    required MockAppLogger logger,
    required MockCrashlyticsService crashlytics,
    required int expectedHandledErrors,
    required int expectedLogEntries,
    required int expectedCrashlyticsReports,
  }) {
    assert(
      notifier.handledErrorCount == expectedHandledErrors,
      'Expected $expectedHandledErrors handled errors, got ${notifier.handledErrorCount}',
    );

    assert(
      logger.logCount == expectedLogEntries,
      'Expected $expectedLogEntries log entries, got ${logger.logCount}',
    );

    assert(
      crashlytics.errorRecords.length == expectedCrashlyticsReports,
      'Expected $expectedCrashlyticsReports Crashlytics reports, got ${crashlytics.errorRecords.length}',
    );
  }

  /// Create a test scenario with error recovery
  static Future<void> simulateErrorRecoveryScenario({
    required MockErrorNotifier notifier,
    required AppError error,
    required bool shouldRecover,
  }) async {
    // Handle the error
    await notifier.handleError(error);

    // Simulate recovery outcome
    if (shouldRecover) {
      notifier.simulateRecoverySuccess(error);
    } else {
      notifier.simulateRecoveryFailure(error);
    }
  }

  /// Create a test scenario with error deduplication
  static Future<void> simulateDeduplicationScenario({
    required MockErrorNotifier notifier,
    required AppError error,
    required int duplicateAttempts,
  }) async {
    // Handle the error first time
    await notifier.handleError(error);

    // Simulate duplicate attempts
    for (int i = 0; i < duplicateAttempts; i++) {
      notifier.simulateDeduplication(error);
    }
  }

  /// Cleanup test resources
  static void cleanup({
    ProviderContainer? container,
    MockErrorNotifier? notifier,
    MockAppLogger? logger,
    MockCrashlyticsService? crashlytics,
  }) {
    container?.dispose();
    notifier?.clearAll();
    logger?.clearLogs();
    crashlytics?.clearRecords();
  }
}
