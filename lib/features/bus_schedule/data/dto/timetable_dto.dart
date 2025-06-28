import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable_dto.freezed.dart';
part 'timetable_dto.g.dart';

@freezed
abstract class TimetableDto with _$TimetableDto {
  const factory TimetableDto({
    required String lineId,
    required String diagramId,
    required String direction,
    required String transportMode,
    required List<DepartureTimeDto> departures,
    @Default({}) Map<String, dynamic> metadata,
  }) = _TimetableDto;

  factory TimetableDto.fromJson(Map<String, dynamic> json) =>
      _$TimetableDtoFromJson(json);
}

@freezed
abstract class DepartureTimeDto with _$DepartureTimeDto {
  const factory DepartureTimeDto({
    required String time,
    required String stationId,
    @Default(false) bool isHoliday,
    @Default(false) bool isWeekend,
    @Default({}) Map<String, dynamic> metadata,
  }) = _DepartureTimeDto;

  factory DepartureTimeDto.fromJson(Map<String, dynamic> json) =>
      _$DepartureTimeDtoFromJson(json);
}
