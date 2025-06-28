// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_diagram_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusDiagramDto _$BusDiagramDtoFromJson(Map<String, dynamic> json) =>
    _BusDiagramDto(
      diagramId: json['diagramId'] as String,
      name: json['name'] as String,
      campusName: json['campusName'] as String,
      routes: (json['routes'] as List<dynamic>)
          .map((e) => RouteDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$BusDiagramDtoToJson(_BusDiagramDto instance) =>
    <String, dynamic>{
      'diagramId': instance.diagramId,
      'name': instance.name,
      'campusName': instance.campusName,
      'routes': instance.routes,
      'metadata': instance.metadata,
    };

_RouteDto _$RouteDtoFromJson(Map<String, dynamic> json) => _RouteDto(
  lineId: json['lineId'] as String,
  routeName: json['routeName'] as String,
  direction: json['direction'] as String,
  transportMode: json['transportMode'] as String,
  stations: (json['stations'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$RouteDtoToJson(_RouteDto instance) => <String, dynamic>{
  'lineId': instance.lineId,
  'routeName': instance.routeName,
  'direction': instance.direction,
  'transportMode': instance.transportMode,
  'stations': instance.stations,
  'metadata': instance.metadata,
};
