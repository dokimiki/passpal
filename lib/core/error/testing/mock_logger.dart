import '../models/app_error.dart';
import '../logging/app_logger.dart';
import '../logging/log_level.dart';
import '../services/error_reporter.dart';

/// Mock implementation of AppLogger for testing
class MockAppLogger extends AppLogger {
  final List<MockLogEntry> _logs = [];
  bool _enabled = true;

  MockAppLogger({super.tag = 'MockLogger', super.minimumLevel = LogLevel.debug})
    : super(errorReporter: MockErrorReporter());

  /// Get all logged entries
  List<MockLogEntry> get logs => List.unmodifiable(_logs);

  /// Enable/disable logging for testing
  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  /// Clear all logged entries
  void clearLogs() {
    _logs.clear();
  }

  @override
  void debug(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    if (!_enabled) return;
    _recordLog(LogLevel.debug, message, attributes, stackTrace);
  }

  @override
  void info(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    if (!_enabled) return;
    _recordLog(LogLevel.info, message, attributes, stackTrace);
  }

  @override
  void warning(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    if (!_enabled) return;
    _recordLog(LogLevel.warning, message, attributes, stackTrace);
  }

  @override
  void error(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    if (!_enabled) return;
    _recordLog(LogLevel.error, message, attributes, stackTrace);
  }

  @override
  void fatal(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    if (!_enabled) return;
    _recordLog(LogLevel.fatal, message, attributes, stackTrace);
  }

  @override
  void logError(AppError error, {Map<String, dynamic>? additionalAttributes}) {
    if (!_enabled) return;

    final level = error.isRecoverable ? LogLevel.warning : LogLevel.error;
    final attributes = <String, dynamic>{
      'errorCode': error.errorCode,
      'isRecoverable': error.isRecoverable,
      'timestamp': error.timestamp.toIso8601String(),
      if (error.retryDelay != null) 'retryDelay': error.retryDelay.toString(),
      if (error.context != null) ...error.context!,
      if (additionalAttributes != null) ...additionalAttributes,
    };

    _recordLog(level, error.message, attributes, error.stackTrace);
  }

  void _recordLog(
    LogLevel level,
    String message,
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  ) {
    _logs.add(
      MockLogEntry(
        level: level,
        message: message,
        attributes: attributes,
        stackTrace: stackTrace,
        timestamp: DateTime.now(),
      ),
    );
  }

  /// Test helper: Check if log with message exists
  bool hasLogWithMessage(String message) {
    return _logs.any((log) => log.message == message);
  }

  /// Test helper: Check if log with level exists
  bool hasLogWithLevel(LogLevel level) {
    return _logs.any((log) => log.level == level);
  }

  /// Test helper: Get logs by level
  List<MockLogEntry> getLogsByLevel(LogLevel level) {
    return _logs.where((log) => log.level == level).toList();
  }

  /// Test helper: Get logs containing message
  List<MockLogEntry> getLogsContaining(String substring) {
    return _logs.where((log) => log.message.contains(substring)).toList();
  }

  /// Test helper: Get logs with specific attribute
  List<MockLogEntry> getLogsWithAttribute(String key, dynamic value) {
    return _logs.where((log) => log.attributes?[key] == value).toList();
  }

  /// Test helper: Get last log entry
  MockLogEntry? get lastLog => _logs.isNotEmpty ? _logs.last : null;

  /// Test helper: Get log count
  int get logCount => _logs.length;

  /// Test helper: Get log count by level
  int getLogCountByLevel(LogLevel level) {
    return _logs.where((log) => log.level == level).length;
  }
}

/// Mock implementation of ErrorReporter for testing
class MockErrorReporter extends ErrorReporter {
  final List<MockErrorReportEntry> _errorReports = [];
  final List<MockLogReportEntry> _logReports = [];
  final List<MockExceptionReportEntry> _exceptionReports = [];
  bool _enabled = true;

  /// Get all error reports
  List<MockErrorReportEntry> get errorReports =>
      List.unmodifiable(_errorReports);

  /// Get all log reports
  List<MockLogReportEntry> get logReports => List.unmodifiable(_logReports);

  /// Get all exception reports
  List<MockExceptionReportEntry> get exceptionReports =>
      List.unmodifiable(_exceptionReports);

  /// Enable/disable reporting for testing
  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  /// Clear all reports
  void clearReports() {
    _errorReports.clear();
    _logReports.clear();
    _exceptionReports.clear();
  }

  @override
  Future<void> reportError(
    AppError error, {
    Map<String, dynamic>? additionalAttributes,
  }) async {
    if (!_enabled) return;

    _errorReports.add(
      MockErrorReportEntry(
        error: error,
        additionalAttributes: additionalAttributes,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> reportLog(
    LogLevel level,
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) async {
    if (!_enabled) return;

    _logReports.add(
      MockLogReportEntry(
        level: level,
        message: message,
        attributes: attributes,
        stackTrace: stackTrace,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> reportException(
    Object exception,
    StackTrace stackTrace, {
    bool fatal = false,
    Map<String, dynamic>? attributes,
  }) async {
    if (!_enabled) return;

    _exceptionReports.add(
      MockExceptionReportEntry(
        exception: exception,
        stackTrace: stackTrace,
        fatal: fatal,
        attributes: attributes,
        timestamp: DateTime.now(),
      ),
    );
  }

  /// Test helper: Check if error was reported
  bool hasErrorReport(String errorCode) {
    return _errorReports.any((report) => report.error.errorCode == errorCode);
  }

  /// Test helper: Check if log was reported
  bool hasLogReport(String message) {
    return _logReports.any((report) => report.message == message);
  }

  /// Test helper: Check if exception was reported
  bool hasExceptionReport<T>() {
    return _exceptionReports.any((report) => report.exception is T);
  }
}

/// Record of a log entry
class MockLogEntry {
  final LogLevel level;
  final String message;
  final Map<String, dynamic>? attributes;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  MockLogEntry({
    required this.level,
    required this.message,
    this.attributes,
    this.stackTrace,
    required this.timestamp,
  });

  @override
  String toString() =>
      'MockLogEntry(level: $level, message: $message, timestamp: $timestamp)';
}

/// Record of an error report
class MockErrorReportEntry {
  final AppError error;
  final Map<String, dynamic>? additionalAttributes;
  final DateTime timestamp;

  MockErrorReportEntry({
    required this.error,
    this.additionalAttributes,
    required this.timestamp,
  });

  @override
  String toString() =>
      'MockErrorReportEntry(error: ${error.errorCode}, timestamp: $timestamp)';
}

/// Record of a log report
class MockLogReportEntry {
  final LogLevel level;
  final String message;
  final Map<String, dynamic>? attributes;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  MockLogReportEntry({
    required this.level,
    required this.message,
    this.attributes,
    this.stackTrace,
    required this.timestamp,
  });

  @override
  String toString() =>
      'MockLogReportEntry(level: $level, message: $message, timestamp: $timestamp)';
}

/// Record of an exception report
class MockExceptionReportEntry {
  final Object exception;
  final StackTrace stackTrace;
  final bool fatal;
  final Map<String, dynamic>? attributes;
  final DateTime timestamp;

  MockExceptionReportEntry({
    required this.exception,
    required this.stackTrace,
    this.fatal = false,
    this.attributes,
    required this.timestamp,
  });

  @override
  String toString() =>
      'MockExceptionReportEntry(exception: ${exception.runtimeType}, fatal: $fatal, timestamp: $timestamp)';
}
