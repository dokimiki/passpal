import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects.dart';

part 'line.freezed.dart';
part 'line.g.dart';

/// Transportation line entity
@freezed
abstract class LineEntity with _$LineEntity {
  const factory LineEntity({
    required LineId id,
    required String name,
    required TransportMode type,
    required String from,
    required String to,
    String? via,
    Map<String, String>? directionName,
    Map<String, Map<String, String>>? destination,
    required Map<String, DiagramEntity> diagram,
    ElapsedTimeEntity? elapsedTime,
  }) = _LineEntity;

  factory LineEntity.fromJson(Map<String, dynamic> json) =>
      _$LineEntityFromJson(json);
}

/// Elapsed time information for different route types
@freezed
abstract class ElapsedTimeEntity with _$ElapsedTimeEntity {
  const factory ElapsedTimeEntity({
    required int forward,
    required int reverse,
    int? via,
  }) = _ElapsedTimeEntity;

  factory ElapsedTimeEntity.fromJson(Map<String, dynamic> json) =>
      _$ElapsedTimeEntityFromJson(json);
}

/// Diagram entity representing timetable patterns
@freezed
abstract class DiagramEntity with _$DiagramEntity {
  const factory DiagramEntity({
    required String id,
    required Map<RouteDirection, Map<int, List<DepartureTime>>> schedule,
  }) = _DiagramEntity;

  factory DiagramEntity.fromJson(Map<String, dynamic> json) =>
      _$DiagramEntityFromJson(json);
}

/// Individual departure time with optional metadata
@freezed
abstract class DepartureTime with _$DepartureTime {
  const factory DepartureTime({
    required int minute,
    bool? isVia,
    String? destination,
  }) = _DepartureTime;

  factory DepartureTime.fromJson(Map<String, dynamic> json) =>
      _$DepartureTimeFromJson(json);

  factory DepartureTime.fromDynamic(dynamic value) {
    if (value is int) {
      return DepartureTime(minute: value);
    } else if (value is List && value.length >= 2) {
      return DepartureTime(
        minute: value[0] as int,
        isVia: value[1] as bool? ?? false,
        destination: value.length > 2 ? value[2] as String? : null,
      );
    }
    throw ArgumentError('Invalid departure time format: $value');
  }
}
