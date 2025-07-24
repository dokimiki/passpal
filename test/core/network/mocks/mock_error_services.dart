import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/error/services/crashlytics_service.dart';
import 'package:passpal/core/error/services/error_reporter.dart';
import 'package:passpal/core/error/models/app_error.dart';
import 'package:passpal/core/error/logging/log_level.dart';

/// Mock CrashlyticsService for testing
class MockCrashlyticsService implements CrashlyticsService {
  final List<String> recordedErrors = [];
  final List<String> recordedLogs = [];
  final List<String> recordedExceptions = [];
  final Map<String, dynamic> customKeys = {};
  String? userId;

  @override
  Future<void> recordError(
    AppError error, {
    Map<String, dynamic>? additionalAttributes,
  }) async {
    recordedErrors.add('${error.errorCode}: ${error.message}');
  }

  @override
  Future<void> recordLog(
    LogLevel level,
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) async {
    recordedLogs.add('${level.name}: $message');
  }

  @override
  Future<void> recordException(
    Object exception,
    StackTrace stackTrace, {
    bool fatal = false,
    Map<String, dynamic>? attributes,
  }) async {
    recordedExceptions.add('${exception.runtimeType}: $exception');
  }

  @override
  Future<void> setUserId(String userId) async {
    this.userId = userId;
  }

  @override
  Future<void> setCustomKey(String key, dynamic value) async {
    customKeys[key] = value;
  }

  @override
  Future<void> clearCustomKeys() async {
    customKeys.clear();
  }

  void reset() {
    recordedErrors.clear();
    recordedLogs.clear();
    recordedExceptions.clear();
    customKeys.clear();
    userId = null;
  }

  static bool get isEnabled => true;
}

/// Mock ErrorReporter for testing
class MockErrorReporter implements ErrorReporter {
  final MockCrashlyticsService crashlyticsService;

  MockErrorReporter({MockCrashlyticsService? crashlyticsService})
    : crashlyticsService = crashlyticsService ?? MockCrashlyticsService();

  @override
  Future<void> reportError(
    AppError error, {
    Map<String, dynamic>? additionalAttributes,
  }) async {
    await crashlyticsService.recordError(
      error,
      additionalAttributes: additionalAttributes,
    );
  }

  @override
  Future<void> reportLog(
    LogLevel level,
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) async {
    await crashlyticsService.recordLog(
      level,
      message,
      attributes: attributes,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<void> reportException(
    Object exception,
    StackTrace stackTrace, {
    bool fatal = false,
    Map<String, dynamic>? attributes,
  }) async {
    await crashlyticsService.recordException(
      exception,
      stackTrace,
      fatal: fatal,
      attributes: attributes,
    );
  }

  @override
  Future<void> setUserId(String userId) async {
    await crashlyticsService.setUserId(userId);
  }

  @override
  Future<void> setCustomKey(String key, dynamic value) async {
    await crashlyticsService.setCustomKey(key, value);
  }

  @override
  Future<void> clearCustomKeys() async {
    await crashlyticsService.clearCustomKeys();
  }

  static bool get isEnabled => true;
}
