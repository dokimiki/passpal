import 'package:freezed_annotation/freezed_annotation.dart';
import 'connectivity_status.dart';

part 'network_event.freezed.dart';
part 'network_event.g.dart';

/// Network connectivity change event
///
/// Represents state changes in network connectivity, including:
/// - Connection state transitions (online/offline)
/// - Connection type changes (WiFi -> Mobile, etc.)
/// - Connection quality changes (speed variations)
@freezed
abstract class NetworkEvent with _$NetworkEvent {
  const factory NetworkEvent({
    /// Previous connectivity status (null for initial state)
    ConnectivityStatus? previous,

    /// Current connectivity status
    required ConnectivityStatus current,

    /// Timestamp when the event occurred
    required DateTime timestamp,

    /// Event type classification
    required NetworkEventType type,

    /// Optional additional context or metadata
    Map<String, dynamic>? metadata,
  }) = _NetworkEvent;

  factory NetworkEvent.fromJson(Map<String, dynamic> json) =>
      _$NetworkEventFromJson(json);
}

/// Types of network events
@freezed
sealed class NetworkEventType with _$NetworkEventType {
  /// Connection established (offline -> online)
  const factory NetworkEventType.connected() = _Connected;

  /// Connection lost (online -> offline)
  const factory NetworkEventType.disconnected() = _Disconnected;

  /// Connection type changed (WiFi -> Mobile, etc.)
  const factory NetworkEventType.typeChanged() = _TypeChanged;

  /// Connection quality changed (speed variation)
  const factory NetworkEventType.qualityChanged() = _QualityChanged;

  /// Initial state detection
  const factory NetworkEventType.initial() = _Initial;

  factory NetworkEventType.fromJson(Map<String, dynamic> json) =>
      _$NetworkEventTypeFromJson(json);
}

/// Extension methods for NetworkEvent
extension NetworkEventExtensions on NetworkEvent {
  /// Whether this event represents a connection gain
  bool get isConnectionGained =>
      type == const NetworkEventType.connected() ||
      (previous?.isOffline == true && current.isOnline);

  /// Whether this event represents a connection loss
  bool get isConnectionLost =>
      type == const NetworkEventType.disconnected() ||
      (previous?.isOnline == true && current.isOffline);

  /// Whether this event represents a quality improvement
  bool get isQualityImproved {
    if (previous == null) return false;
    return _getQualityScore(current.quality) > _getQualityScore(previous!.quality);
  }

  /// Whether this event represents a quality degradation
  bool get isQualityDegraded {
    if (previous == null) return false;
    return _getQualityScore(current.quality) < _getQualityScore(previous!.quality);
  }

  /// Convert quality enum to numeric score for comparison
  int _getQualityScore(ConnectionQuality quality) {
    switch (quality) {
      case ConnectionQuality.none:
        return 0;
      case ConnectionQuality.poor:
        return 1;
      case ConnectionQuality.fair:
        return 2;
      case ConnectionQuality.good:
        return 3;
      case ConnectionQuality.excellent:
        return 4;
      case ConnectionQuality.unknown:
        return 0; // Treat unknown as lowest quality
    }
  }

  /// Duration since the previous state (if available)
  Duration? get stateDuration {
    if (previous == null || metadata?['previousTimestamp'] == null) {
      return null;
    }

    final previousTime = DateTime.parse(
      metadata!['previousTimestamp'] as String,
    );
    return timestamp.difference(previousTime);
  }

  /// Whether this is a significant change that should trigger actions
  bool get isSignificant {
    return type.when(
      connected: () => true,
      disconnected: () => true,
      typeChanged: () => true,
      qualityChanged: () => isQualityImproved || isQualityDegraded,
      initial: () => false,
    );
  }
}

/// Factory methods for common network events
class NetworkEventFactory {
  /// Create initial state event
  static NetworkEvent initial(ConnectivityStatus status) {
    return NetworkEvent(
      current: status,
      timestamp: DateTime.now(),
      type: const NetworkEventType.initial(),
    );
  }

  /// Create connection gained event
  static NetworkEvent connected({
    ConnectivityStatus? previous,
    required ConnectivityStatus current,
    DateTime? timestamp,
  }) {
    return NetworkEvent(
      previous: previous,
      current: current,
      timestamp: timestamp ?? DateTime.now(),
      type: const NetworkEventType.connected(),
    );
  }

  /// Create connection lost event
  static NetworkEvent disconnected({
    ConnectivityStatus? previous,
    required ConnectivityStatus current,
    DateTime? timestamp,
  }) {
    return NetworkEvent(
      previous: previous,
      current: current,
      timestamp: timestamp ?? DateTime.now(),
      type: const NetworkEventType.disconnected(),
    );
  }

  /// Create type change event
  static NetworkEvent typeChanged({
    ConnectivityStatus? previous,
    required ConnectivityStatus current,
    DateTime? timestamp,
  }) {
    return NetworkEvent(
      previous: previous,
      current: current,
      timestamp: timestamp ?? DateTime.now(),
      type: const NetworkEventType.typeChanged(),
    );
  }

  /// Create quality change event
  static NetworkEvent qualityChanged({
    ConnectivityStatus? previous,
    required ConnectivityStatus current,
    DateTime? timestamp,
  }) {
    return NetworkEvent(
      previous: previous,
      current: current,
      timestamp: timestamp ?? DateTime.now(),
      type: const NetworkEventType.qualityChanged(),
    );
  }
}
