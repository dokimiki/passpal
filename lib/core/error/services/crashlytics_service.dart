import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import '../models/app_error.dart';
import '../logging/log_level.dart';

class CrashlyticsService {
  static const String _keyErrorCode = 'error_code';
  static const String _keyErrorType = 'error_type';
  static const String _keyIsRecoverable = 'is_recoverable';
  static const String _keyTimestamp = 'timestamp';
  static const String _keyRetryDelay = 'retry_delay';
  static const String _keyLogLevel = 'log_level';

  final FirebaseCrashlytics _crashlytics;

  CrashlyticsService({FirebaseCrashlytics? crashlytics})
    : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  Future<void> recordError(
    AppError error, {
    Map<String, dynamic>? additionalAttributes,
  }) async {
    if (kDebugMode) {
      // Skip Crashlytics in debug mode
      return;
    }

    try {
      // Set custom attributes
      await _setCustomAttributes(error, additionalAttributes);

      // Record the error
      await _crashlytics.recordError(
        error.message,
        error.stackTrace,
        fatal: false,
        printDetails: false,
      );
    } catch (e) {
      // If Crashlytics fails, don't break the app
      debugPrint('Failed to record error to Crashlytics: $e');
    }
  }

  Future<void> recordLog(
    LogLevel level,
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) async {
    if (kDebugMode) {
      // Skip Crashlytics in debug mode
      return;
    }

    // Only record warning and above
    if (level < LogLevel.warning) {
      return;
    }

    try {
      // Set log level attribute
      await _crashlytics.setCustomKey(_keyLogLevel, level.name);

      // Set custom attributes if provided
      if (attributes != null) {
        for (final entry in attributes.entries) {
          await _crashlytics.setCustomKey(entry.key, entry.value);
        }
      }

      // Log the message
      _crashlytics.log(message);

      // For fatal logs, also record as a non-fatal error
      if (level == LogLevel.fatal) {
        await _crashlytics.recordError(
          message,
          stackTrace,
          fatal: false,
          printDetails: false,
        );
      }
    } catch (e) {
      // If Crashlytics fails, don't break the app
      debugPrint('Failed to record log to Crashlytics: $e');
    }
  }

  Future<void> recordException(
    Object exception,
    StackTrace stackTrace, {
    bool fatal = false,
    Map<String, dynamic>? attributes,
  }) async {
    if (kDebugMode) {
      // Skip Crashlytics in debug mode
      return;
    }

    try {
      // Set custom attributes if provided
      if (attributes != null) {
        for (final entry in attributes.entries) {
          await _crashlytics.setCustomKey(entry.key, entry.value);
        }
      }

      // Record the exception
      await _crashlytics.recordError(
        exception,
        stackTrace,
        fatal: fatal,
        printDetails: false,
      );
    } catch (e) {
      // If Crashlytics fails, don't break the app
      debugPrint('Failed to record exception to Crashlytics: $e');
    }
  }

  Future<void> setUserId(String userId) async {
    if (kDebugMode) {
      return;
    }

    try {
      await _crashlytics.setUserIdentifier(userId);
    } catch (e) {
      debugPrint('Failed to set user ID in Crashlytics: $e');
    }
  }

  Future<void> setCustomKey(String key, dynamic value) async {
    if (kDebugMode) {
      return;
    }

    try {
      await _crashlytics.setCustomKey(key, value);
    } catch (e) {
      debugPrint('Failed to set custom key in Crashlytics: $e');
    }
  }

  Future<void> clearCustomKeys() async {
    if (kDebugMode) {
      return;
    }

    try {
      // Firebase Crashlytics doesn't have a direct clear method
      // We'll reset common keys to empty values
      await _crashlytics.setCustomKey(_keyErrorCode, '');
      await _crashlytics.setCustomKey(_keyErrorType, '');
      await _crashlytics.setCustomKey(_keyIsRecoverable, false);
      await _crashlytics.setCustomKey(_keyTimestamp, '');
      await _crashlytics.setCustomKey(_keyRetryDelay, '');
      await _crashlytics.setCustomKey(_keyLogLevel, '');
    } catch (e) {
      debugPrint('Failed to clear custom keys in Crashlytics: $e');
    }
  }

  Future<void> _setCustomAttributes(
    AppError error,
    Map<String, dynamic>? additionalAttributes,
  ) async {
    // Set error-specific attributes
    await _crashlytics.setCustomKey(_keyErrorCode, error.errorCode);
    await _crashlytics.setCustomKey(
      _keyErrorType,
      error.runtimeType.toString(),
    );
    await _crashlytics.setCustomKey(_keyIsRecoverable, error.isRecoverable);
    await _crashlytics.setCustomKey(
      _keyTimestamp,
      error.timestamp.toIso8601String(),
    );

    if (error.retryDelay != null) {
      await _crashlytics.setCustomKey(
        _keyRetryDelay,
        error.retryDelay.toString(),
      );
    }

    // Set error context if available
    if (error.context != null) {
      for (final entry in error.context!.entries) {
        await _crashlytics.setCustomKey('ctx_${entry.key}', entry.value);
      }
    }

    // Set additional attributes if provided
    if (additionalAttributes != null) {
      for (final entry in additionalAttributes.entries) {
        await _crashlytics.setCustomKey(entry.key, entry.value);
      }
    }
  }

  static bool get isEnabled => !kDebugMode;
}
