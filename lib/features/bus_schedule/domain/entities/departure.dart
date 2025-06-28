import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects.dart';

part 'departure.freezed.dart';
part 'departure.g.dart';

/// Departure information with calculated arrival times
@freezed
abstract class DepartureEntity with _$DepartureEntity {
  const factory DepartureEntity({
    required TimeOfDay departureTime,
    required TimeOfDay arrivalTime,
    required LineId lineId,
    required RouteDirection direction,
    required DiagramId diagramId,
    String? destination,
    bool? isVia,
    int? elapsedMinutes,
  }) = _DepartureEntity;

  factory DepartureEntity.fromJson(Map<String, dynamic> json) =>
      _$DepartureEntityFromJson(json);
}

/// DTO for departure data used in presentation layer
@freezed
abstract class DepartureDTO with _$DepartureDTO {
  const factory DepartureDTO({
    required String lineDisplayName,
    required TimeOfDay departureTime,
    required TimeOfDay arrivalTime,
    required String destinationName,
    required RouteDirection direction,
    required bool isNearestDeparture,
    String? platformInfo,
    bool? isVia,
    int? minutesUntilDeparture,
  }) = _DepartureDTO;

  factory DepartureDTO.fromJson(Map<String, dynamic> json) =>
      _$DepartureDTOFromJson(json);

  factory DepartureDTO.fromEntity(
    DepartureEntity entity,
    String lineDisplayName,
    String destinationName, {
    bool isNearestDeparture = false,
    String? platformInfo,
  }) {
    final now = TimeOfDay.now();
    final minutesUntil = entity.departureTime.totalMinutes - now.totalMinutes;

    return DepartureDTO(
      lineDisplayName: lineDisplayName,
      departureTime: entity.departureTime,
      arrivalTime: entity.arrivalTime,
      destinationName: destinationName,
      direction: entity.direction,
      isNearestDeparture: isNearestDeparture,
      platformInfo: platformInfo,
      isVia: entity.isVia,
      minutesUntilDeparture: minutesUntil > 0 ? minutesUntil : null,
    );
  }
}
