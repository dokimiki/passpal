import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_diagram_dto.freezed.dart';
part 'bus_diagram_dto.g.dart';

@freezed
abstract class BusDiagramDto with _$BusDiagramDto {
  const factory BusDiagramDto({
    required String diagramId,
    required String name,
    required String campusName,
    required List<RouteDto> routes,
    @Default({}) Map<String, dynamic> metadata,
  }) = _BusDiagramDto;

  factory BusDiagramDto.fromJson(Map<String, dynamic> json) =>
      _$BusDiagramDtoFromJson(json);
}

@freezed
abstract class RouteDto with _$RouteDto {
  const factory RouteDto({
    required String lineId,
    required String routeName,
    required String direction,
    required String transportMode,
    required List<String> stations,
    @Default({}) Map<String, dynamic> metadata,
  }) = _RouteDto;

  factory RouteDto.fromJson(Map<String, dynamic> json) =>
      _$RouteDtoFromJson(json);
}
