import '../dto/bus_diagram_dto.dart';
import '../../domain/entities/campus.dart';
import '../../domain/entities/line.dart';
import '../../domain/value_objects.dart';

class BusDiagramAdapter {
  static CampusEntity fromDto(BusDiagramDto dto) {
    final lineIds = dto.routes
        .map((routeDto) => LineId(routeDto.lineId))
        .toList();

    return CampusEntity(
      id: parseCampus(dto.campusName),
      name: dto.campusName,
      description: 'Campus from diagram ${dto.diagramId}',
      availableLines: lineIds,
    );
  }

  static LineEntity lineFromRouteDto(RouteDto routeDto, DiagramId diagramId) {
    // Create empty diagram for now - will be populated by timetable data
    final emptyDiagram = DiagramEntity(id: diagramId.value, schedule: const {});

    return LineEntity(
      id: LineId(routeDto.lineId),
      name: routeDto.routeName,
      type: _parseTransportMode(routeDto.transportMode),
      from: routeDto.stations.isNotEmpty ? routeDto.stations.first : '',
      to: routeDto.stations.length > 1 ? routeDto.stations.last : '',
      diagram: {diagramId.value: emptyDiagram},
    );
  }

  static Campus parseCampus(String campusName) {
    if (campusName.contains('豊田') ||
        campusName.toLowerCase().contains('toyota')) {
      return Campus.toyota;
    } else if (campusName.contains('八事') ||
        campusName.toLowerCase().contains('yagoto')) {
      return Campus.yagoto;
    }
    return Campus.toyota; // default fallback
  }

  static TransportMode _parseTransportMode(String mode) {
    switch (mode.toLowerCase()) {
      case 'bus':
        return TransportMode.bus;
      case 'train':
        return TransportMode.train;
      default:
        return TransportMode.bus; // default fallback
    }
  }
}
