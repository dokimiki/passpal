import 'package:flutter/foundation.dart';
import '../models/app_error.dart';
import '../logging/log_level.dart';
import 'crashlytics_service.dart';

class ErrorReporter {
  final CrashlyticsService _crashlyticsService;
  final Set<String> _recentErrors = {};
  static const Duration _deduplicationWindow = Duration(minutes: 5);

  ErrorReporter({CrashlyticsService? crashlyticsService})
    : _crashlyticsService = crashlyticsService ?? CrashlyticsService();

  Future<void> reportError(
    AppError error, {
    Map<String, dynamic>? additionalAttributes,
  }) async {
    if (!_shouldReport(error)) {
      return;
    }

    try {
      await _crashlyticsService.recordError(
        error,
        additionalAttributes: additionalAttributes,
      );

      _addToRecentErrors(error);
    } catch (e) {
      debugPrint('Failed to report error: $e');
    }
  }

  Future<void> reportLog(
    LogLevel level,
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) async {
    if (!_shouldReportLog(level)) {
      return;
    }

    try {
      await _crashlyticsService.recordLog(
        level,
        message,
        attributes: attributes,
        stackTrace: stackTrace,
      );
    } catch (e) {
      debugPrint('Failed to report log: $e');
    }
  }

  Future<void> reportException(
    Object exception,
    StackTrace stackTrace, {
    bool fatal = false,
    Map<String, dynamic>? attributes,
  }) async {
    if (!_shouldReportException(exception)) {
      return;
    }

    try {
      await _crashlyticsService.recordException(
        exception,
        stackTrace,
        fatal: fatal,
        attributes: attributes,
      );

      _addToRecentExceptions(exception);
    } catch (e) {
      debugPrint('Failed to report exception: $e');
    }
  }

  Future<void> setUserId(String userId) async {
    try {
      await _crashlyticsService.setUserId(userId);
    } catch (e) {
      debugPrint('Failed to set user ID: $e');
    }
  }

  Future<void> setCustomKey(String key, dynamic value) async {
    try {
      await _crashlyticsService.setCustomKey(key, value);
    } catch (e) {
      debugPrint('Failed to set custom key: $e');
    }
  }

  Future<void> clearCustomKeys() async {
    try {
      await _crashlyticsService.clearCustomKeys();
    } catch (e) {
      debugPrint('Failed to clear custom keys: $e');
    }
  }

  bool _shouldReport(AppError error) {
    // Don't report in debug mode
    if (kDebugMode) {
      return false;
    }

    // Check for spam prevention
    final errorKey = _getErrorKey(error);
    if (_recentErrors.contains(errorKey)) {
      return false;
    }

    // Apply error-specific filtering
    return _shouldReportErrorType(error);
  }

  bool _shouldReportLog(LogLevel level) {
    // Don't report in debug mode
    if (kDebugMode) {
      return false;
    }

    // Only report warning and above
    return level >= LogLevel.warning;
  }

  bool _shouldReportException(Object exception) {
    // Don't report in debug mode
    if (kDebugMode) {
      return false;
    }

    // Check for spam prevention
    final exceptionKey = _getExceptionKey(exception);
    if (_recentErrors.contains(exceptionKey)) {
      return false;
    }

    return true;
  }

  bool _shouldReportErrorType(AppError error) {
    // Don't spam recoverable errors with short retry delays
    if (error.isRecoverable) {
      final retryDelay = error.retryDelay;
      if (retryDelay != null && retryDelay.inSeconds < 10) {
        return false;
      }
    }

    // Filter out specific error types that shouldn't be reported
    switch (error.errorCode) {
      case 'MAINTENANCE_SCHEDULED':
      case 'MAINTENANCE_EMERGENCY':
        // Don't report maintenance errors as they're expected
        return false;
      case 'NETWORK_CONNECTION':
        // Only report network errors if they're persistent
        return !error.isRecoverable;
      default:
        return true;
    }
  }

  String _getErrorKey(AppError error) {
    return '${error.errorCode}_${error.message.hashCode}';
  }

  String _getExceptionKey(Object exception) {
    return '${exception.runtimeType}_${exception.toString().hashCode}';
  }

  void _addToRecentErrors(AppError error) {
    final errorKey = _getErrorKey(error);
    _recentErrors.add(errorKey);

    // Clean up old entries after deduplication window
    Future.delayed(_deduplicationWindow, () {
      _recentErrors.remove(errorKey);
    });
  }

  void _addToRecentExceptions(Object exception) {
    final exceptionKey = _getExceptionKey(exception);
    _recentErrors.add(exceptionKey);

    // Clean up old entries after deduplication window
    Future.delayed(_deduplicationWindow, () {
      _recentErrors.remove(exceptionKey);
    });
  }

  static bool get isEnabled => CrashlyticsService.isEnabled;
}
