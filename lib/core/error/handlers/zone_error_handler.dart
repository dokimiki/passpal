import 'dart:async';
import 'package:riverpod/riverpod.dart';
import '../models/app_error.dart';
import '../notifiers/error_notifier.dart';
import '../logging/app_logger.dart';

/// Zone-based error handler that provides a controlled environment for error handling
/// and can be used to wrap specific operations or entire app sections.
class ZoneErrorHandler {
  final ProviderContainer _container;
  final AppLogger _logger;
  final String _zoneName;

  late final ErrorNotifier _errorNotifier;

  ZoneErrorHandler({
    required ProviderContainer container,
    required String zoneName,
  }) : _container = container,
       _zoneName = zoneName,
       _logger = AppLogger(tag: 'ZoneErrorHandler[$zoneName]') {
    _errorNotifier = _container.read(errorNotifierProvider.notifier);
  }

  /// Run a function within a guarded zone with error handling
  T runGuarded<T>(
    T Function() callback, {
    Map<String, dynamic>? zoneContext,
    bool handleSyncExceptions = true,
  }) {
    _logger.debug('Running guarded zone: $_zoneName');

    try {
      return runZonedGuarded(
            callback,
            (error, stackTrace) =>
                _handleZoneError(error, stackTrace, zoneContext: zoneContext),
            zoneSpecification: _createZoneSpecification(
              handleSyncExceptions: handleSyncExceptions,
            ),
          ) ??
          (throw StateError('runZonedGuarded returned null'));
    } catch (e, stackTrace) {
      _logger.debug('Sync error in guarded zone: $e');

      if (handleSyncExceptions) {
        _handleZoneError(e, stackTrace, zoneContext: zoneContext);
        rethrow;
      }

      rethrow;
    }
  }

  /// Run an async function within a guarded zone
  Future<T> runGuardedAsync<T>(
    Future<T> Function() callback, {
    Map<String, dynamic>? zoneContext,
    bool handleSyncExceptions = true,
  }) async {
    _logger.debug('Running async guarded zone: $_zoneName');

    try {
      return await runZonedGuarded(
            callback,
            (error, stackTrace) =>
                _handleZoneError(error, stackTrace, zoneContext: zoneContext),
            zoneSpecification: _createZoneSpecification(
              handleSyncExceptions: handleSyncExceptions,
            ),
          ) ??
          (throw StateError('runZonedGuarded returned null'));
    } catch (e, stackTrace) {
      _logger.debug('Sync error in async guarded zone: $e');

      if (handleSyncExceptions) {
        _handleZoneError(e, stackTrace, zoneContext: zoneContext);
        rethrow;
      }

      rethrow;
    }
  }

  /// Create zone specification for custom error handling
  ZoneSpecification _createZoneSpecification({
    required bool handleSyncExceptions,
  }) {
    return ZoneSpecification(
      handleUncaughtError:
          (
            Zone self,
            ZoneDelegate parent,
            Zone zone,
            Object error,
            StackTrace stackTrace,
          ) {
            _logger.debug('Uncaught error in zone $_zoneName: $error');
            _handleZoneError(error, stackTrace);
          },

      // Handle print statements in the zone (useful for debugging)
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        _logger.debug('Zone $_zoneName print: $line');
        parent.print(zone, line);
      },
    );
  }

  /// Handle errors that occur within the zone
  void _handleZoneError(
    Object error,
    StackTrace stackTrace, {
    Map<String, dynamic>? zoneContext,
  }) {
    _logger.debug('Handling zone error: $error');

    final appError = _createErrorFromZoneError(error, stackTrace);
    final context = <String, dynamic>{
      'zone': _zoneName,
      'source': 'zone_error_handler',
      ...?zoneContext,
    };

    try {
      _errorNotifier.handleError(appError, context: context);
    } catch (e, stack) {
      // If error handling fails, log it but don't create an infinite loop
      _logger.error(
        'Failed to handle zone error through ErrorNotifier: $e',
        stackTrace: stack,
      );
    }
  }

  /// Create an AppError from a zone error
  AppError _createErrorFromZoneError(Object error, StackTrace stackTrace) {
    return AppError.now(
      message: error.toString(),
      errorCode: _getErrorCodeFromException(error),
      stackTrace: stackTrace,
      isRecoverable: _isRecoverableException(error),
      context: {
        'zone': _zoneName,
        'exception_type': error.runtimeType.toString(),
      },
    );
  }

  /// Determine error code based on exception type
  String _getErrorCodeFromException(Object error) {
    if (error is StateError) return 'ZONE_STATE_ERROR';
    if (error is ArgumentError) return 'ZONE_ARGUMENT_ERROR';
    if (error is TypeError) return 'ZONE_TYPE_ERROR';
    if (error is RangeError) return 'ZONE_RANGE_ERROR';
    if (error is FormatException) return 'ZONE_FORMAT_ERROR';
    if (error is TimeoutException) return 'ZONE_TIMEOUT_ERROR';
    if (error is UnimplementedError) return 'ZONE_UNIMPLEMENTED_ERROR';

    return 'ZONE_UNKNOWN_ERROR';
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

    // Format errors from parsing are usually recoverable
    if (error is FormatException) return true;

    // Type errors and argument errors are usually not recoverable
    if (error is TypeError || error is ArgumentError) return false;

    // Unimplemented errors are not recoverable
    if (error is UnimplementedError) return false;

    // Default to non-recoverable for unknown errors
    return false;
  }

  /// Create a scoped zone handler for specific operations
  static ZoneErrorHandler createScoped(
    ProviderContainer container,
    String operationName,
  ) {
    return ZoneErrorHandler(
      container: container,
      zoneName: 'scoped_$operationName',
    );
  }

  /// Create a feature-specific zone handler
  static ZoneErrorHandler createFeature(
    ProviderContainer container,
    String featureName,
  ) {
    return ZoneErrorHandler(
      container: container,
      zoneName: 'feature_$featureName',
    );
  }

  /// Create a service-specific zone handler
  static ZoneErrorHandler createService(
    ProviderContainer container,
    String serviceName,
  ) {
    return ZoneErrorHandler(
      container: container,
      zoneName: 'service_$serviceName',
    );
  }
}
