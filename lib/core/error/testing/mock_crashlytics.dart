import '../models/app_error.dart';
import '../logging/log_level.dart';
import '../services/crashlytics_service.dart';

/// Mock implementation of CrashlyticsService for testing
class MockCrashlyticsService extends CrashlyticsService {
  final List<MockErrorRecord> _errorRecords = [];
  final List<MockLogRecord> _logRecords = [];
  final List<MockExceptionRecord> _exceptionRecords = [];
  final Map<String, dynamic> _customKeys = {};
  String? _userId;
  bool _isEnabled = true;

  MockCrashlyticsService() : super(crashlytics: null);

  /// Get recorded errors for testing
  List<MockErrorRecord> get errorRecords => List.unmodifiable(_errorRecords);

  /// Get recorded logs for testing
  List<MockLogRecord> get logRecords => List.unmodifiable(_logRecords);

  /// Get recorded exceptions for testing
  List<MockExceptionRecord> get exceptionRecords =>
      List.unmodifiable(_exceptionRecords);

  /// Get custom keys for testing
  Map<String, dynamic> get customKeys => Map.unmodifiable(_customKeys);

  /// Get user ID for testing
  String? get userId => _userId;

  /// Enable/disable mock for testing
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Clear all recorded data
  void clearRecords() {
    _errorRecords.clear();
    _logRecords.clear();
    _exceptionRecords.clear();
    _customKeys.clear();
    _userId = null;
  }

  @override
  Future<void> recordError(
    AppError error, {
    Map<String, dynamic>? additionalAttributes,
  }) async {
    if (!_isEnabled) return;

    _errorRecords.add(
      MockErrorRecord(
        error: error,
        additionalAttributes: additionalAttributes,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> recordLog(
    LogLevel level,
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) async {
    if (!_isEnabled) return;

    _logRecords.add(
      MockLogRecord(
        level: level,
        message: message,
        attributes: attributes,
        stackTrace: stackTrace,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> recordException(
    Object exception,
    StackTrace stackTrace, {
    bool fatal = false,
    Map<String, dynamic>? attributes,
  }) async {
    if (!_isEnabled) return;

    _exceptionRecords.add(
      MockExceptionRecord(
        exception: exception,
        stackTrace: stackTrace,
        fatal: fatal,
        attributes: attributes,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> setUserId(String userId) async {
    if (!_isEnabled) return;
    _userId = userId;
  }

  @override
  Future<void> setCustomKey(String key, dynamic value) async {
    if (!_isEnabled) return;
    _customKeys[key] = value;
  }

  @override
  Future<void> clearCustomKeys() async {
    if (!_isEnabled) return;
    _customKeys.clear();
  }

  /// Test helper: Check if error was recorded
  bool hasErrorWithCode(String errorCode) {
    return _errorRecords.any((record) => record.error.errorCode == errorCode);
  }

  /// Test helper: Check if log was recorded
  bool hasLogWithMessage(String message) {
    return _logRecords.any((record) => record.message == message);
  }

  /// Test helper: Check if exception was recorded
  bool hasExceptionOfType<T>() {
    return _exceptionRecords.any((record) => record.exception is T);
  }

  /// Test helper: Get errors by type
  List<MockErrorRecord> getErrorsByType<T extends AppError>() {
    return _errorRecords.where((record) => record.error is T).toList();
  }

  /// Test helper: Get logs by level
  List<MockLogRecord> getLogsByLevel(LogLevel level) {
    return _logRecords.where((record) => record.level == level).toList();
  }

  /// Test helper: Get custom key value
  T? getCustomKey<T>(String key) {
    return _customKeys[key] as T?;
  }
}

/// Record of an error sent to Crashlytics
class MockErrorRecord {
  final AppError error;
  final Map<String, dynamic>? additionalAttributes;
  final DateTime timestamp;

  MockErrorRecord({
    required this.error,
    this.additionalAttributes,
    required this.timestamp,
  });

  @override
  String toString() =>
      'MockErrorRecord(error: ${error.errorCode}, timestamp: $timestamp)';
}

/// Record of a log sent to Crashlytics
class MockLogRecord {
  final LogLevel level;
  final String message;
  final Map<String, dynamic>? attributes;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  MockLogRecord({
    required this.level,
    required this.message,
    this.attributes,
    this.stackTrace,
    required this.timestamp,
  });

  @override
  String toString() =>
      'MockLogRecord(level: $level, message: $message, timestamp: $timestamp)';
}

/// Record of an exception sent to Crashlytics
class MockExceptionRecord {
  final Object exception;
  final StackTrace stackTrace;
  final bool fatal;
  final Map<String, dynamic>? attributes;
  final DateTime timestamp;

  MockExceptionRecord({
    required this.exception,
    required this.stackTrace,
    this.fatal = false,
    this.attributes,
    required this.timestamp,
  });

  @override
  String toString() =>
      'MockExceptionRecord(exception: ${exception.runtimeType}, fatal: $fatal, timestamp: $timestamp)';
}
