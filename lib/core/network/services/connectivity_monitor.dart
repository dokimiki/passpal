import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/connectivity_status.dart';
import '../models/network_event.dart';

part 'connectivity_monitor.g.dart';

/// Provider for the connectivity monitor service
@riverpod
ConnectivityMonitor connectivityMonitor(Ref ref) {
  return ConnectivityMonitor();
}

/// Provider for the current connectivity status
@riverpod
Stream<ConnectivityStatus> connectivityStatus(Ref ref) {
  final monitor = ref.watch(connectivityMonitorProvider);
  return monitor.statusStream;
}

/// Provider for network events stream
@riverpod
Stream<NetworkEvent> networkEvents(Ref ref) {
  final monitor = ref.watch(connectivityMonitorProvider);
  return monitor.eventStream;
}

/// Service for monitoring network connectivity changes
///
/// This service wraps connectivity_plus and provides:
/// - Real-time connectivity status monitoring
/// - Network quality assessment
/// - Event-based status change notifications
/// - Connection speed testing capabilities
class ConnectivityMonitor {
  ConnectivityMonitor({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity() {
    _initialize();
  }

  final Connectivity _connectivity;

  // Stream controllers
  final _statusController = StreamController<ConnectivityStatus>.broadcast();
  final _eventController = StreamController<NetworkEvent>.broadcast();

  // State tracking
  ConnectivityStatus? _currentStatus;
  DateTime? _lastStatusChange;
  Timer? _speedTestTimer;
  Timer? _qualityCheckTimer;

  /// Stream of connectivity status updates
  Stream<ConnectivityStatus> get statusStream => _statusController.stream;

  /// Stream of network events
  Stream<NetworkEvent> get eventStream => _eventController.stream;

  /// Current connectivity status (null if not initialized)
  ConnectivityStatus? get currentStatus => _currentStatus;

  /// Whether the device is currently online
  bool get isOnline => _currentStatus?.isOnline ?? false;

  /// Whether the device is currently offline
  bool get isOffline => _currentStatus?.isOffline ?? false;

  void _initialize() {
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);

    // Get initial connectivity state
    _updateCurrentConnectivity();

    // Start periodic quality checks for active connections
    _startQualityMonitoring();
  }

  Future<void> _updateCurrentConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      await _handleConnectivityChange(results);
    } catch (e) {
      // Handle error by creating offline status
      final status = ConnectivityStatusFactory.offline();
      _updateStatus(status, const NetworkEventType.initial());
    }
  }

  Future<void> _handleConnectivityChange(
    List<ConnectivityResult> results,
  ) async {
    final newStatus = await _createConnectivityStatus(results);
    final eventType = _determineEventType(_currentStatus, newStatus);

    _updateStatus(newStatus, eventType);
  }

  Future<ConnectivityStatus> _createConnectivityStatus(
    List<ConnectivityResult> results,
  ) async {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return ConnectivityStatusFactory.offline();
    }

    // Determine primary connection type
    final primaryResult = _getPrimaryConnection(results);
    final connectionType = _mapConnectivityResult(primaryResult);

    // Test actual internet connectivity
    final hasInternet = await _testInternetConnectivity();

    if (!hasInternet) {
      return ConnectivityStatusFactory.offline();
    }

    // Assess connection quality
    final quality = await _assessConnectionQuality(connectionType);

    return ConnectivityStatusFactory.online(
      connectionType: connectionType,
      quality: quality,
    );
  }

  ConnectivityResult _getPrimaryConnection(List<ConnectivityResult> results) {
    // Priority: WiFi > Ethernet > Mobile > VPN > Other
    const priority = [
      ConnectivityResult.wifi,
      ConnectivityResult.ethernet,
      ConnectivityResult.mobile,
      ConnectivityResult.vpn,
      ConnectivityResult.other,
    ];

    for (final preferredType in priority) {
      if (results.contains(preferredType)) {
        return preferredType;
      }
    }

    return results.first;
  }

  ConnectivityType _mapConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return ConnectivityType.wifi;
      case ConnectivityResult.mobile:
        return ConnectivityType.mobile;
      case ConnectivityResult.ethernet:
        return ConnectivityType.ethernet;
      case ConnectivityResult.vpn:
        return ConnectivityType.vpn;
      case ConnectivityResult.bluetooth:
        return ConnectivityType.other;
      case ConnectivityResult.other:
        return ConnectivityType.other;
      case ConnectivityResult.none:
        return ConnectivityType.none;
    }
  }

  Future<bool> _testInternetConnectivity() async {
    try {
      // Try to connect to reliable hosts
      const hosts = ['google.com', 'cloudflare.com', 'apple.com'];

      for (final host in hosts) {
        try {
          final result = await InternetAddress.lookup(
            host,
          ).timeout(const Duration(seconds: 5));
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            return true;
          }
        } catch (_) {
          continue;
        }
      }

      return false;
    } catch (_) {
      return false;
    }
  }

  Future<ConnectionQuality> _assessConnectionQuality(
    ConnectivityType connectionType,
  ) async {
    // Quick quality assessment based on connection type
    // In a real implementation, this could include speed tests
    switch (connectionType) {
      case ConnectivityType.wifi:
        return await _testWifiQuality();
      case ConnectivityType.ethernet:
        return ConnectionQuality.excellent;
      case ConnectivityType.mobile:
        return await _testMobileQuality();
      case ConnectivityType.vpn:
        return ConnectionQuality.good; // VPN typically has some overhead
      case ConnectivityType.bluetooth:
        return ConnectionQuality.poor; // Bluetooth typically slow
      case ConnectivityType.other:
        return ConnectionQuality.poor;
      case ConnectivityType.none:
        return ConnectionQuality.none;
    }
  }

  Future<ConnectionQuality> _testWifiQuality() async {
    // Simplified quality test - could be enhanced with actual speed testing
    try {
      final stopwatch = Stopwatch()..start();
      await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      stopwatch.stop();

      final latency = stopwatch.elapsedMilliseconds;

      if (latency < 100) return ConnectionQuality.excellent;
      if (latency < 300) return ConnectionQuality.good;
      if (latency < 1000) return ConnectionQuality.fair;
      return ConnectionQuality.poor;
    } catch (_) {
      return ConnectionQuality.poor;
    }
  }

  Future<ConnectionQuality> _testMobileQuality() async {
    // Mobile connections typically have higher latency
    try {
      final stopwatch = Stopwatch()..start();
      await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 5));
      stopwatch.stop();

      final latency = stopwatch.elapsedMilliseconds;

      if (latency < 200) return ConnectionQuality.excellent;
      if (latency < 500) return ConnectionQuality.good;
      if (latency < 1500) return ConnectionQuality.fair;
      return ConnectionQuality.poor;
    } catch (_) {
      return ConnectionQuality.poor;
    }
  }

  NetworkEventType _determineEventType(
    ConnectivityStatus? previous,
    ConnectivityStatus current,
  ) {
    if (previous == null) {
      return const NetworkEventType.initial();
    }

    // Connection state changes
    if (previous.isOffline && current.isOnline) {
      return const NetworkEventType.connected();
    }

    if (previous.isOnline && current.isOffline) {
      return const NetworkEventType.disconnected();
    }

    // Both online - check for type or quality changes
    if (previous.isOnline && current.isOnline) {
      if (previous.connectionType != current.connectionType) {
        return const NetworkEventType.typeChanged();
      }

      if (previous.quality != current.quality) {
        return const NetworkEventType.qualityChanged();
      }
    }

    // No significant change
    return const NetworkEventType.qualityChanged();
  }

  void _updateStatus(ConnectivityStatus status, NetworkEventType eventType) {
    final previous = _currentStatus;
    _currentStatus = status;
    _lastStatusChange = DateTime.now();

    // Emit status update
    _statusController.add(status);

    // Create and emit network event
    final event = NetworkEvent(
      previous: previous,
      current: status,
      timestamp: _lastStatusChange!,
      type: eventType,
      metadata: previous != null
          ? {'previousTimestamp': previous.timestamp.toIso8601String()}
          : null,
    );

    _eventController.add(event);
  }

  void _startQualityMonitoring() {
    // Check quality every 30 seconds for active connections
    _qualityCheckTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _checkQualityPeriodically(),
    );
  }

  Future<void> _checkQualityPeriodically() async {
    if (_currentStatus?.isOnline != true) return;

    try {
      final newQuality = await _assessConnectionQuality(
        _currentStatus!.connectionType,
      );

      if (newQuality != _currentStatus!.quality) {
        final updatedStatus = _currentStatus!.copyWith(
          quality: newQuality,
          timestamp: DateTime.now(),
        );

        _updateStatus(updatedStatus, const NetworkEventType.qualityChanged());
      }
    } catch (_) {
      // Quality check failed - connection might be unstable
      if (_currentStatus?.quality != ConnectionQuality.poor) {
        final updatedStatus = _currentStatus!.copyWith(
          quality: ConnectionQuality.poor,
          timestamp: DateTime.now(),
        );

        _updateStatus(updatedStatus, const NetworkEventType.qualityChanged());
      }
    }
  }

  /// Manually trigger a connectivity check
  Future<void> refreshConnectivity() async {
    await _updateCurrentConnectivity();
  }

  /// Test current connection speed (simplified implementation)
  Future<double?> testConnectionSpeed() async {
    if (_currentStatus?.isOffline != false) return null;

    try {
      final stopwatch = Stopwatch()..start();

      // Download a small test resource
      final client = HttpClient();
      final request = await client.getUrl(
        Uri.parse('http://www.google.com/generate_204'),
      );
      final response = await request.close();
      await response.drain();

      stopwatch.stop();
      client.close();

      // Rough speed calculation (very simplified)
      final latency = stopwatch.elapsedMilliseconds;
      return latency > 0 ? 1000.0 / latency : null;
    } catch (_) {
      return null;
    }
  }

  /// Dispose resources
  void dispose() {
    _statusController.close();
    _eventController.close();
    _speedTestTimer?.cancel();
    _qualityCheckTimer?.cancel();
  }
}
