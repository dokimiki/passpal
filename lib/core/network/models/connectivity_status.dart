import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity_status.freezed.dart';
part 'connectivity_status.g.dart';

/// Network connectivity types
enum ConnectivityType {
  /// No network connection
  none,

  /// WiFi connection
  wifi,

  /// Mobile/cellular connection
  mobile,

  /// Ethernet connection (desktop platforms)
  ethernet,

  /// Bluetooth connection
  bluetooth,

  /// VPN connection
  vpn,

  /// Other or unknown connection type
  other,
}

/// Network connection quality levels
enum ConnectionQuality {
  /// No connection
  none,

  /// Excellent connection (>= 10 Mbps)
  excellent,

  /// Good connection (>= 1 Mbps)
  good,

  /// Fair connection (>= 100 Kbps)
  fair,

  /// Poor connection (< 100 Kbps)
  poor,

  /// Unknown quality
  unknown,
}

/// Network connectivity status model
@freezed
abstract class ConnectivityStatus with _$ConnectivityStatus {
  const factory ConnectivityStatus({
    /// Whether device is connected to internet
    required bool isConnected,

    /// Type of network connection
    required ConnectivityType type,

    /// Connection quality assessment
    @Default(ConnectionQuality.unknown) ConnectionQuality quality,

    /// Signal strength (0-100 for mobile, dBm for WiFi)
    int? signalStrength,

    /// Connection speed in Kbps (if available)
    double? speedKbps,

    /// Whether connection is metered (limited data)
    @Default(false) bool isMetered,

    /// Whether roaming (for mobile connections)
    @Default(false) bool isRoaming,

    /// Network name (SSID for WiFi, carrier for mobile)
    String? networkName,

    /// IP address (if available)
    String? ipAddress,

    /// Connection timestamp
    required DateTime timestamp,

    /// Additional metadata
    @Default({}) Map<String, dynamic> metadata,
  }) = _ConnectivityStatus;

  factory ConnectivityStatus.fromJson(Map<String, dynamic> json) =>
      _$ConnectivityStatusFromJson(json);
}

/// Extension methods for ConnectivityStatus
extension ConnectivityStatusExtension on ConnectivityStatus {
  /// Whether device is online
  bool get isOnline => isConnected;

  /// Whether device is offline
  bool get isOffline => !isConnected;

  /// Connection type (alias for type field)
  ConnectivityType get connectionType => type;

  /// Whether connection is suitable for background operations
  bool get isGoodForBackground =>
      isConnected &&
      (quality == ConnectionQuality.excellent ||
          quality == ConnectionQuality.good) &&
      !isMetered;

  /// Whether connection is suitable for heavy operations
  bool get isGoodForHeavyOperations =>
      isConnected &&
      quality == ConnectionQuality.excellent &&
      !isMetered &&
      !isRoaming;

  /// Whether connection allows basic operations
  bool get allowsBasicOperations =>
      isConnected && quality != ConnectionQuality.poor;

  /// Whether this is a mobile connection
  bool get isMobile => type == ConnectivityType.mobile;

  /// Whether this is a WiFi connection
  bool get isWifi => type == ConnectivityType.wifi;

  /// Whether connection cost should be considered
  bool get shouldConsiderCost => isMetered || isRoaming;

  /// Get connection description for debugging
  String get description {
    if (!isConnected) return 'No connection';

    final typeStr = type.name.toUpperCase();
    final qualityStr = quality.name;
    final speedStr = speedKbps != null
        ? ' (${speedKbps!.toStringAsFixed(0)} Kbps)'
        : '';
    final meteredStr = isMetered ? ' [Metered]' : '';
    final roamingStr = isRoaming ? ' [Roaming]' : '';

    return '$typeStr $qualityStr$speedStr$meteredStr$roamingStr';
  }
}

/// Factory methods for common connectivity scenarios
class ConnectivityStatusFactory {
  /// Create offline status
  static ConnectivityStatus offline() {
    return ConnectivityStatus(
      isConnected: false,
      type: ConnectivityType.none,
      timestamp: DateTime.now(),
    );
  }

  /// Create online status with connection type
  static ConnectivityStatus online({
    required ConnectivityType connectionType,
    ConnectionQuality quality = ConnectionQuality.good,
    String? networkName,
    int? signalStrength,
    double? speedKbps,
    bool isMetered = false,
    bool isRoaming = false,
  }) {
    return ConnectivityStatus(
      isConnected: true,
      type: connectionType,
      quality: quality,
      networkName: networkName,
      signalStrength: signalStrength,
      speedKbps: speedKbps,
      isMetered: isMetered,
      isRoaming: isRoaming,
      timestamp: DateTime.now(),
    );
  }

  /// Create WiFi connection
  static ConnectivityStatus wifi({
    ConnectionQuality quality = ConnectionQuality.good,
    String? networkName,
    int? signalStrength,
    double? speedKbps,
  }) {
    return ConnectivityStatus(
      isConnected: true,
      type: ConnectivityType.wifi,
      quality: quality,
      networkName: networkName,
      signalStrength: signalStrength,
      speedKbps: speedKbps,
      timestamp: DateTime.now(),
    );
  }

  /// Create mobile connection
  static ConnectivityStatus mobile({
    ConnectionQuality quality = ConnectionQuality.fair,
    String? networkName,
    int? signalStrength,
    double? speedKbps,
    bool isMetered = true,
    bool isRoaming = false,
  }) {
    return ConnectivityStatus(
      isConnected: true,
      type: ConnectivityType.mobile,
      quality: quality,
      networkName: networkName,
      signalStrength: signalStrength,
      speedKbps: speedKbps,
      isMetered: isMetered,
      isRoaming: isRoaming,
      timestamp: DateTime.now(),
    );
  }
}
