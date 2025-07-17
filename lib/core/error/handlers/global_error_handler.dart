import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import '../models/app_error.dart';
import '../notifiers/error_notifier.dart';
import '../logging/app_logger.dart';
import '../services/error_reporter.dart';

/// Global error handler that captures uncaught errors from various sources
/// and routes them to the ErrorNotifier for unified handling.
class GlobalErrorHandler {
  final ProviderContainer _container;
  final AppLogger _logger;
  final ErrorReporter _errorReporter;

  late final ErrorNotifier _errorNotifier;

  GlobalErrorHandler({required ProviderContainer container})
    : _container = container,
      _errorReporter = ErrorReporter(),
      _logger = AppLogger(tag: 'GlobalErrorHandler') {
    _errorNotifier = _container.read(errorNotifierProvider.notifier);
  }

  /// Initialize global error handling by setting up all error capture mechanisms
  void initialize() {
    _logger.info('Initializing global error handler');

    _setupFlutterErrorHandler();
    _setupIsolateErrorHandler();

    _logger.info('Global error handler initialized');
  }

  /// Setup Flutter framework error handler
  void _setupFlutterErrorHandler() {
    // Handle Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      _logger.debug('Flutter error caught: ${details.exception}');

      final error = _createErrorFromFlutterError(details);
      _handleError(
        error,
        context: {
          'source': 'flutter_framework',
          'library': details.library,
          'context': details.context?.toString(),
          'informationCollector': details.informationCollector?.toString(),
        },
      );
    };

    // Handle platform dispatcher errors (for errors that escape runZonedGuarded)
    PlatformDispatcher.instance.onError = (error, stack) {
      _logger.debug('Platform dispatcher error caught: $error');

      final appError = _createErrorFromException(error, stack);
      _handleError(appError, context: {'source': 'platform_dispatcher'});

      return true; // Indicate that we handled the error
    };
  }

  /// Setup isolate error handler for background task errors
  void _setupIsolateErrorHandler() {
    // Handle isolate errors
    Isolate.current.addErrorListener(
      RawReceivePort((List<dynamic> errorData) {
        _logger.debug('Isolate error caught: ${errorData[0]}');

        final error = _createErrorFromIsolateError(errorData);
        _handleError(error, context: {'source': 'isolate'});
      }).sendPort,
    );
  }

  /// Create an AppError from FlutterErrorDetails
  AppError _createErrorFromFlutterError(FlutterErrorDetails details) {
    return AppError.now(
      message: details.exception.toString(),
      errorCode: 'FLUTTER_ERROR',
      stackTrace: details.stack,
      isRecoverable: !details.silent, // Silent errors are usually recoverable
      context: {
        'library': details.library,
        'context': details.context?.toString(),
        'silent': details.silent,
      },
    );
  }

  /// Create an AppError from a general exception
  AppError _createErrorFromException(Object error, StackTrace? stackTrace) {
    return AppError.now(
      message: error.toString(),
      errorCode: _getErrorCodeFromException(error),
      stackTrace: stackTrace,
      isRecoverable: _isRecoverableException(error),
      context: {'exception_type': error.runtimeType.toString()},
    );
  }

  /// Create an AppError from isolate error data
  AppError _createErrorFromIsolateError(List<dynamic> errorData) {
    final error = errorData[0];
    final stackTrace = errorData[1] as String?;

    return AppError.now(
      message: error.toString(),
      errorCode: 'ISOLATE_ERROR',
      stackTrace: stackTrace != null ? StackTrace.fromString(stackTrace) : null,
      isRecoverable: false, // Isolate errors are usually not recoverable
      context: {'isolate_error': true},
    );
  }

  /// Determine error code based on exception type
  String _getErrorCodeFromException(Object error) {
    if (error is StateError) return 'STATE_ERROR';
    if (error is ArgumentError) return 'ARGUMENT_ERROR';
    if (error is TypeError) return 'TYPE_ERROR';
    if (error is RangeError) return 'RANGE_ERROR';
    if (error is FormatException) return 'FORMAT_ERROR';
    if (error is TimeoutException) return 'TIMEOUT_ERROR';

    return 'UNKNOWN_ERROR';
  }

  /// Determine if an exception is recoverable
  bool _isRecoverableException(Object error) {
    // Network and timeout errors are usually recoverable
    if (error is TimeoutException) return true;
    if (error.toString().contains('network') ||
        error.toString().contains('connection')) {
      return true;
    }

    // State errors might be recoverable depending on context
    if (error is StateError) return true;

    // Most other errors are not recoverable
    return false;
  }

  /// Handle error through the error notifier
  void _handleError(AppError error, {Map<String, dynamic>? context}) {
    try {
      // Report to Crashlytics directly for global errors
      _errorReporter.reportError(error, additionalAttributes: context);

      _errorNotifier.handleError(error, context: context);
    } catch (e, stackTrace) {
      // If error handling fails, log it but don't create an infinite loop
      _logger.error(
        'Failed to handle error through ErrorNotifier: $e',
        stackTrace: stackTrace,
      );

      // Try to report the error handling failure to Crashlytics
      try {
        _errorReporter.reportException(
          e,
          stackTrace,
          attributes: {
            'original_error': error.toString(),
            'handler_failure': true,
          },
        );
      } catch (_) {
        // If even that fails, just continue
      }
    }
  }

  /// Run a function with zone-based error handling
  static T runWithErrorHandling<T>(
    T Function() callback, {
    required ProviderContainer container,
  }) {
    final handler = GlobalErrorHandler(container: container);
    handler.initialize();

    return runZonedGuarded(callback, (error, stackTrace) {
          handler._logger.debug('Zone error caught: $error');

          final appError = handler._createErrorFromException(error, stackTrace);
          handler._handleError(appError, context: {'source': 'zone'});
        }) ??
        (throw StateError('runZonedGuarded returned null'));
  }

  /// Dispose of the error handler
  void dispose() {
    _logger.info('Disposing global error handler');
    // Remove error listeners if needed
    // Note: Flutter doesn't provide a way to remove PlatformDispatcher.onError
    // or FlutterError.onError listeners, so we just log the disposal
  }
}
