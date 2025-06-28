// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LineEntity _$LineEntityFromJson(Map<String, dynamic> json) => _LineEntity(
  id: LineId.fromJson(json['id'] as Map<String, dynamic>),
  name: json['name'] as String,
  type: $enumDecode(_$TransportModeEnumMap, json['type']),
  from: json['from'] as String,
  to: json['to'] as String,
  via: json['via'] as String?,
  directionName: (json['directionName'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  destination: (json['destination'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
  ),
  diagram: (json['diagram'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, DiagramEntity.fromJson(e as Map<String, dynamic>)),
  ),
  elapsedTime: json['elapsedTime'] == null
      ? null
      : ElapsedTimeEntity.fromJson(json['elapsedTime'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LineEntityToJson(_LineEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$TransportModeEnumMap[instance.type]!,
      'from': instance.from,
      'to': instance.to,
      'via': instance.via,
      'directionName': instance.directionName,
      'destination': instance.destination,
      'diagram': instance.diagram,
      'elapsedTime': instance.elapsedTime,
    };

const _$TransportModeEnumMap = {
  TransportMode.bus: 'chukyo',
  TransportMode.train: 'train',
};

_ElapsedTimeEntity _$ElapsedTimeEntityFromJson(Map<String, dynamic> json) =>
    _ElapsedTimeEntity(
      forward: (json['forward'] as num).toInt(),
      reverse: (json['reverse'] as num).toInt(),
      via: (json['via'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ElapsedTimeEntityToJson(_ElapsedTimeEntity instance) =>
    <String, dynamic>{
      'forward': instance.forward,
      'reverse': instance.reverse,
      'via': instance.via,
    };

_DiagramEntity _$DiagramEntityFromJson(Map<String, dynamic> json) =>
    _DiagramEntity(
      id: json['id'] as String,
      schedule: (json['schedule'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          $enumDecode(_$RouteDirectionEnumMap, k),
          (e as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              int.parse(k),
              (e as List<dynamic>)
                  .map((e) => DepartureTime.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          ),
        ),
      ),
    );

Map<String, dynamic> _$DiagramEntityToJson(_DiagramEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schedule': instance.schedule.map(
        (k, e) => MapEntry(
          _$RouteDirectionEnumMap[k]!,
          e.map((k, e) => MapEntry(k.toString(), e)),
        ),
      ),
    };

const _$RouteDirectionEnumMap = {
  RouteDirection.forward: 'forward',
  RouteDirection.reverse: 'reverse',
};

_DepartureTime _$DepartureTimeFromJson(Map<String, dynamic> json) =>
    _DepartureTime(
      minute: (json['minute'] as num).toInt(),
      isVia: json['isVia'] as bool?,
      destination: json['destination'] as String?,
    );

Map<String, dynamic> _$DepartureTimeToJson(_DepartureTime instance) =>
    <String, dynamic>{
      'minute': instance.minute,
      'isVia': instance.isVia,
      'destination': instance.destination,
    };
