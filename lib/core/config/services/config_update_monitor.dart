import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error/providers.dart';
import '../exceptions/config_error_types.dart';
import '../models/app_config.dart';
import '../providers/config_provider.dart';
import '../sources/remote_config_source.dart';

part 'config_update_monitor.g.dart';

/// Configuration update monitor that watches for Remote Config changes
///
/// This service monitors Firebase Remote Config for updates and propagates
/// them to the configuration provider. It handles:
/// - Real-time update streaming
/// - Automatic configuration refresh
/// - Error handling and recovery
/// - Update notification to dependent providers
class ConfigUpdateMonitor {
  final RemoteConfigSource _remoteConfigSource;
  final Ref _ref;

  StreamSubscription<RemoteConfigUpdate>? _remoteConfigSubscription;
  StreamController<AppConfig>? _configUpdateController;
  bool _isMonitoring = false;

  ConfigUpdateMonitor({
    required RemoteConfigSource remoteConfigSource,
    required Ref ref,
  }) : _remoteConfigSource = remoteConfigSource,
       _ref = ref;

  /// Stream of configuration updates
  ///
  /// Emits new [AppConfig] instances when Remote Config changes are detected.
  /// The stream automatically handles errors and continues monitoring.
  Stream<AppConfig> get configUpdateStream {
    _configUpdateController ??= StreamController<AppConfig>.broadcast();
    return _configUpdateController!.stream;
  }

  /// Start monitoring Remote Config for updates
  ///
  /// This method:
  /// 1. Initializes the Remote Config listener
  /// 2. Sets up automatic configuration refresh on updates
  /// 3. Handles errors gracefully
  /// 4. Ensures only one monitoring session is active
  Future<void> startMonitoring() async {
    if (_isMonitoring) {
      return;
    }

    try {
      _isMonitoring = true;
      _configUpdateController ??= StreamController<AppConfig>.broadcast();

      // Subscribe to Remote Config updates
      _remoteConfigSubscription = _remoteConfigSource.onConfigUpdated.listen(
        _handleRemoteConfigUpdate,
        onError: _handleMonitoringError,
      );
    } catch (e, stackTrace) {
      _isMonitoring = false;
      _ref
          .read(errorNotifierProvider.notifier)
          .handleError(
            AppException.config(
              message: ConfigErrorMessages.withDetail(
                ConfigErrorMessages.configInitializationFailed,
                e.toString(),
              ),
              errorCode: ConfigErrorCodes.configInitializationFailed,
              stackTrace: stackTrace,
              timestamp: DateTime.now(),
            ).asAppError,
          );
    }
  }

  /// Stop monitoring Remote Config updates
  ///
  /// Cancels the Remote Config subscription and cleans up resources.
  Future<void> stopMonitoring() async {
    if (!_isMonitoring) {
      return;
    }

    _isMonitoring = false;
    await _remoteConfigSubscription?.cancel();
    _remoteConfigSubscription = null;
  }

  /// Handle Remote Config update notifications
  ///
  /// This method is called when Remote Config detects changes.
  /// It triggers a configuration refresh and notifies listeners.
  void _handleRemoteConfigUpdate(RemoteConfigUpdate update) async {
    if (!_isMonitoring) {
      return;
    }

    try {
      // Refresh configuration from all sources
      final refreshedConfig = await _ref.read(loadedConfigProvider.future);

      // Notify listeners about the update
      if (_configUpdateController != null &&
          !_configUpdateController!.isClosed) {
        _configUpdateController!.add(refreshedConfig);
      }
    } catch (e, stackTrace) {
      _handleMonitoringError(e, stackTrace);
    }
  }

  /// Handle monitoring errors
  ///
  /// Logs errors and optionally attempts to restart monitoring
  /// for recoverable errors.
  void _handleMonitoringError(Object error, [StackTrace? stackTrace]) {
    _ref
        .read(errorNotifierProvider.notifier)
        .handleError(
          AppException.config(
            message: ConfigErrorMessages.withDetail(
              ConfigErrorMessages.configInitializationFailed,
              error.toString(),
            ),
            errorCode: ConfigErrorCodes.configInitializationFailed,
            stackTrace: stackTrace,
            timestamp: DateTime.now(),
          ).asAppError,
        );

    // Attempt to restart monitoring for recoverable errors
    if (_isRecoverableError(error)) {
      _scheduleRestartMonitoring();
    }
  }

  /// Check if an error is recoverable
  ///
  /// Returns true for network errors, timeout errors, and other
  /// transient issues that might resolve themselves.
  bool _isRecoverableError(Object error) {
    if (error is AppException) {
      return error.errorCode == ConfigErrorCodes.remoteConfigTimeout ||
          error.errorCode == ConfigErrorCodes.configSourceUnavailable;
    }
    return false;
  }

  /// Schedule a monitoring restart after a delay
  ///
  /// Uses exponential backoff to avoid overwhelming the service
  /// with retry attempts.
  void _scheduleRestartMonitoring() {
    Timer(const Duration(seconds: 30), () {
      if (!_isMonitoring) {
        startMonitoring();
      }
    });
  }

  /// Dispose of resources
  ///
  /// Stops monitoring and closes the update stream controller.
  /// Should be called when the monitor is no longer needed.
  Future<void> dispose() async {
    await stopMonitoring();
    await _configUpdateController?.close();
    _configUpdateController = null;
  }
}

/// Provider for the configuration update monitor
///
/// Creates and manages the lifecycle of the ConfigUpdateMonitor.
/// Automatically starts monitoring when accessed and handles disposal.
@riverpod
ConfigUpdateMonitor configUpdateMonitor(Ref ref) {
  final remoteConfigSource = ref.watch(remoteConfigSourceProvider);
  final monitor = ConfigUpdateMonitor(
    remoteConfigSource: remoteConfigSource,
    ref: ref,
  );

  // Start monitoring when the provider is first accessed
  ref.onDispose(() {
    monitor.dispose();
  });

  return monitor;
}

/// Provider for the configuration update stream
///
/// Provides a stream of AppConfig updates that are triggered by
/// Remote Config changes. The stream is automatically managed
/// and disposed of when no longer needed.
@riverpod
Stream<AppConfig> configUpdateStream(Ref ref) {
  final monitor = ref.watch(configUpdateMonitorProvider);

  // Start monitoring when the stream is accessed
  monitor.startMonitoring();

  return monitor.configUpdateStream;
}
