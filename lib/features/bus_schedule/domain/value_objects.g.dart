// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LineId _$LineIdFromJson(Map<String, dynamic> json) =>
    _LineId(json['value'] as String);

Map<String, dynamic> _$LineIdToJson(_LineId instance) => <String, dynamic>{
  'value': instance.value,
};

_DiagramId _$DiagramIdFromJson(Map<String, dynamic> json) =>
    _DiagramId(json['value'] as String);

Map<String, dynamic> _$DiagramIdToJson(_DiagramId instance) =>
    <String, dynamic>{'value': instance.value};

_TimeOfDay _$TimeOfDayFromJson(Map<String, dynamic> json) => _TimeOfDay(
  hour: (json['hour'] as num).toInt(),
  minute: (json['minute'] as num).toInt(),
);

Map<String, dynamic> _$TimeOfDayToJson(_TimeOfDay instance) =>
    <String, dynamic>{'hour': instance.hour, 'minute': instance.minute};

_StationId _$StationIdFromJson(Map<String, dynamic> json) =>
    _StationId(json['value'] as String);

Map<String, dynamic> _$StationIdToJson(_StationId instance) =>
    <String, dynamic>{'value': instance.value};
