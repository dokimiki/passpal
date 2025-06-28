import '../../domain/entities/campus.dart';
import '../../domain/entities/line.dart';
import '../../domain/value_objects.dart';
import '../sources/bus_diagram_remote_ds.dart';
import '../adapters/bus_diagram_adapter.dart';
import '../dto/bus_diagram_dto.dart';

abstract class BusDiagramRepository {
  Future<List<CampusEntity>> getCampuses();
  Future<List<LineEntity>> getLinesForCampus(Campus campus);
}

class BusDiagramRepositoryImpl implements BusDiagramRepository {
  final BusDiagramRemoteDataSource _remoteDataSource;
  List<CampusEntity>? _cachedCampuses;

  BusDiagramRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CampusEntity>> getCampuses() async {
    try {
      final response = await _remoteDataSource.fetchBusDiagram();
      final campuses = <CampusEntity>[];

      // Parse response and create BusDiagramDto objects
      // For now, create mock campuses based on expected structure
      if (response.containsKey('toyota')) {
        final toyotaDto = BusDiagramDto(
          diagramId: 'toyota',
          name: 'Toyota Campus Bus Diagram',
          campusName: '豊田キャンパス',
          routes: [], // Will be populated from timetable data
        );
        campuses.add(BusDiagramAdapter.fromDto(toyotaDto));
      }

      if (response.containsKey('yagoto')) {
        final yagotoDto = BusDiagramDto(
          diagramId: 'yagoto',
          name: 'Yagoto Campus Bus Diagram',
          campusName: '八事キャンパス',
          routes: [], // Will be populated from timetable data
        );
        campuses.add(BusDiagramAdapter.fromDto(yagotoDto));
      }

      _cachedCampuses = campuses;
      return campuses;
    } catch (e) {
      // Return cached campuses if available, otherwise rethrow
      if (_cachedCampuses != null) {
        return _cachedCampuses!;
      }
      rethrow;
    }
  }

  @override
  Future<List<LineEntity>> getLinesForCampus(Campus campus) async {
    await getCampuses(); // Ensure campuses are loaded

    final lines = <LineEntity>[];

    // Create lines based on the campus and available data
    final diagramId = DiagramId(campus.name);

    // This will be expanded once we know the exact API response structure
    // For now, create placeholder lines
    if (campus == Campus.toyota) {
      final toyotaLine = LineEntity(
        id: LineId.toyota,
        name: '豊田線',
        type: TransportMode.bus,
        from: '豊田キャンパス',
        to: '豊田駅',
        diagram: {
          diagramId.value: DiagramEntity(
            id: diagramId.value,
            schedule: const {},
          ),
        },
      );
      lines.add(toyotaLine);
    } else if (campus == Campus.yagoto) {
      final yagotoLine = LineEntity(
        id: LineId.yagoToT,
        name: '八事線',
        type: TransportMode.bus,
        from: '八事キャンパス',
        to: '八事駅',
        diagram: {
          diagramId.value: DiagramEntity(
            id: diagramId.value,
            schedule: const {},
          ),
        },
      );
      lines.add(yagotoLine);
    }

    return lines;
  }
}
