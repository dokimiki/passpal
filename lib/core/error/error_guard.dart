import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_exception.dart';
import 'crashlytics_reporter.dart';
import 'error_notifier.dart';

/// Global error handling utilities
class ErrorGuard {
  /// Initialize global error handling
  static void initialize(ProviderContainer container) {
    // Handle Flutter framework errors
    FlutterError.onError = (details) {
      handleFlutterError(container, details);
    };

    // Handle isolate errors
    PlatformDispatcher.instance.onError = (error, stack) {
      return handlePlatformError(container, error, stack);
    };
  }

  /// Run code with zone-based error handling
  static Future<T> runGuarded<T>(
    ProviderContainer container,
    Future<T> Function() body, {
    bool isBackground = false,
    void Function(Object error)? onError,
  }) async {
    return runZonedGuarded<Future<T>>(body, (error, stack) {
          handleZoneError(container, error, stack, isBackground: isBackground);
          onError?.call(error);
        }) ??
        Future.error('Zone error handling failed');
  }

  /// Handle Flutter framework errors
  static void handleFlutterError(
    ProviderContainer container,
    FlutterErrorDetails details,
  ) {
    final exception = _convertToAppException(details.exception, details.stack);
    _reportAndShow(container, exception, recordToCrashlytics: true);
  }

  /// Handle platform/isolate errors
  static bool handlePlatformError(
    ProviderContainer container,
    Object error,
    StackTrace stack,
  ) {
    final exception = _convertToAppException(error, stack);
    _reportAndShow(container, exception, recordToCrashlytics: true);
    return true; // Indicate that we handled the error
  }

  /// Handle zone errors
  static void handleZoneError(
    ProviderContainer container,
    Object error,
    StackTrace stack, {
    bool isBackground = false,
  }) {
    final exception = _convertToAppException(error, stack);
    _reportAndShow(
      container,
      exception,
      recordToCrashlytics: true,
      showInUI: !isBackground,
    );
  }

  /// Convert any error to AppException
  static AppException _convertToAppException(Object error, StackTrace? stack) {
    if (error is AppException) {
      return error;
    }

    return UnknownException(
      message: error.toString(),
      stack: stack,
      originalException: error is Exception
          ? error
          : Exception(error.toString()),
    );
  }

  /// Report error and optionally show in UI
  static Future<void> _reportAndShow(
    ProviderContainer container,
    AppException exception, {
    bool recordToCrashlytics = true,
    bool showInUI = true,
  }) async {
    try {
      // Always record to Crashlytics
      if (recordToCrashlytics) {
        await container
            .read(crashlyticsReporterProvider)
            .recordError(exception);
      }

      // Show in UI if requested
      if (showInUI) {
        container
            .read(errorNotifierProvider.notifier)
            .show(exception, recordToCrashlytics: false);
      }
    } catch (e) {
      // If error handling itself fails, just log it
      debugPrint('Error handling failed: $e');
    }
  }
}
