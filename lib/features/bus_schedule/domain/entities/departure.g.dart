// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DepartureEntity _$DepartureEntityFromJson(Map<String, dynamic> json) =>
    _DepartureEntity(
      departureTime: TimeOfDay.fromJson(
        json['departureTime'] as Map<String, dynamic>,
      ),
      arrivalTime: TimeOfDay.fromJson(
        json['arrivalTime'] as Map<String, dynamic>,
      ),
      lineId: LineId.fromJson(json['lineId'] as Map<String, dynamic>),
      direction: $enumDecode(_$RouteDirectionEnumMap, json['direction']),
      diagramId: DiagramId.fromJson(json['diagramId'] as Map<String, dynamic>),
      destination: json['destination'] as String?,
      isVia: json['isVia'] as bool?,
      elapsedMinutes: (json['elapsedMinutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DepartureEntityToJson(_DepartureEntity instance) =>
    <String, dynamic>{
      'departureTime': instance.departureTime,
      'arrivalTime': instance.arrivalTime,
      'lineId': instance.lineId,
      'direction': _$RouteDirectionEnumMap[instance.direction]!,
      'diagramId': instance.diagramId,
      'destination': instance.destination,
      'isVia': instance.isVia,
      'elapsedMinutes': instance.elapsedMinutes,
    };

const _$RouteDirectionEnumMap = {
  RouteDirection.forward: 'forward',
  RouteDirection.reverse: 'reverse',
};

_DepartureDTO _$DepartureDTOFromJson(Map<String, dynamic> json) =>
    _DepartureDTO(
      lineDisplayName: json['lineDisplayName'] as String,
      departureTime: TimeOfDay.fromJson(
        json['departureTime'] as Map<String, dynamic>,
      ),
      arrivalTime: TimeOfDay.fromJson(
        json['arrivalTime'] as Map<String, dynamic>,
      ),
      destinationName: json['destinationName'] as String,
      direction: $enumDecode(_$RouteDirectionEnumMap, json['direction']),
      isNearestDeparture: json['isNearestDeparture'] as bool,
      platformInfo: json['platformInfo'] as String?,
      isVia: json['isVia'] as bool?,
      minutesUntilDeparture: (json['minutesUntilDeparture'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DepartureDTOToJson(_DepartureDTO instance) =>
    <String, dynamic>{
      'lineDisplayName': instance.lineDisplayName,
      'departureTime': instance.departureTime,
      'arrivalTime': instance.arrivalTime,
      'destinationName': instance.destinationName,
      'direction': _$RouteDirectionEnumMap[instance.direction]!,
      'isNearestDeparture': instance.isNearestDeparture,
      'platformInfo': instance.platformInfo,
      'isVia': instance.isVia,
      'minutesUntilDeparture': instance.minutesUntilDeparture,
    };
