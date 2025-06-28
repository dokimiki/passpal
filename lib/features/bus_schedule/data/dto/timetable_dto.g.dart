// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimetableDto _$TimetableDtoFromJson(Map<String, dynamic> json) =>
    _TimetableDto(
      lineId: json['lineId'] as String,
      diagramId: json['diagramId'] as String,
      direction: json['direction'] as String,
      transportMode: json['transportMode'] as String,
      departures: (json['departures'] as List<dynamic>)
          .map((e) => DepartureTimeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$TimetableDtoToJson(_TimetableDto instance) =>
    <String, dynamic>{
      'lineId': instance.lineId,
      'diagramId': instance.diagramId,
      'direction': instance.direction,
      'transportMode': instance.transportMode,
      'departures': instance.departures,
      'metadata': instance.metadata,
    };

_DepartureTimeDto _$DepartureTimeDtoFromJson(Map<String, dynamic> json) =>
    _DepartureTimeDto(
      time: json['time'] as String,
      stationId: json['stationId'] as String,
      isHoliday: json['isHoliday'] as bool? ?? false,
      isWeekend: json['isWeekend'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$DepartureTimeDtoToJson(_DepartureTimeDto instance) =>
    <String, dynamic>{
      'time': instance.time,
      'stationId': instance.stationId,
      'isHoliday': instance.isHoliday,
      'isWeekend': instance.isWeekend,
      'metadata': instance.metadata,
    };
