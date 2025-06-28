import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_objects.freezed.dart';
part 'value_objects.g.dart';

/// Line identifier for different transportation lines
@freezed
abstract class LineId with _$LineId {
  const factory LineId(String value) = _LineId;

  factory LineId.fromJson(Map<String, dynamic> json) => _$LineIdFromJson(json);

  // Predefined line IDs
  static const toyota = LineId('toyota');
  static const campus = LineId('campus');
  static const kaizu = LineId('kaizu');
  static const josui = LineId('josui');
  static const yagoToT = LineId('yagoto-t');
  static const yagoToM = LineId('yagoto-m');
}

/// Diagram pattern identifier (A, B, C, A_dash, Special, etc.)
@freezed
abstract class DiagramId with _$DiagramId {
  const factory DiagramId(String value) = _DiagramId;

  factory DiagramId.fromJson(Map<String, dynamic> json) =>
      _$DiagramIdFromJson(json);

  // Predefined diagram patterns
  static const a = DiagramId('A');
  static const b = DiagramId('B');
  static const c = DiagramId('C');
  static const aDash = DiagramId('A_dash');
  static const special = DiagramId('Special');
  static const none = DiagramId('None');
  static const weekday = DiagramId('weekday');
  static const holiday = DiagramId('holiday');
}

/// Time of day representation for timetables
@freezed
abstract class TimeOfDay with _$TimeOfDay {
  const TimeOfDay._();

  const factory TimeOfDay({required int hour, required int minute}) =
      _TimeOfDay;

  factory TimeOfDay.fromJson(Map<String, dynamic> json) =>
      _$TimeOfDayFromJson(json);

  factory TimeOfDay.now() {
    final now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  DateTime toDateTime([DateTime? baseDate]) {
    final base = baseDate ?? DateTime.now();
    return DateTime(base.year, base.month, base.day, hour, minute);
  }

  /// Convert to minutes since midnight for comparison
  int get totalMinutes => hour * 60 + minute;

  /// Check if this time is after another time
  bool isAfter(TimeOfDay other) => totalMinutes > other.totalMinutes;

  /// Check if this time is before another time
  bool isBefore(TimeOfDay other) => totalMinutes < other.totalMinutes;

  /// Add minutes to this time
  TimeOfDay addMinutes(int minutes) {
    final total = totalMinutes + minutes;
    return TimeOfDay(hour: (total ~/ 60) % 24, minute: total % 60);
  }

  /// Format as HH:MM string
  String get formatted =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

/// Transportation mode enumeration
enum TransportMode {
  @JsonValue('chukyo')
  bus,
  @JsonValue('train')
  train;

  const TransportMode();
}

/// Direction enumeration for routes
enum RouteDirection {
  @JsonValue('forward')
  forward,
  @JsonValue('reverse')
  reverse;

  const RouteDirection();
}

/// Campus enumeration
enum Campus {
  toyota,
  yagoto;

  const Campus();

  String get displayName {
    switch (this) {
      case Campus.toyota:
        return '豊田キャンパス';
      case Campus.yagoto:
        return '八事キャンパス';
    }
  }
}

/// Station identifier for train destinations
@freezed
abstract class StationId with _$StationId {
  const factory StationId(String value) = _StationId;

  factory StationId.fromJson(Map<String, dynamic> json) =>
      _$StationIdFromJson(json);
}
