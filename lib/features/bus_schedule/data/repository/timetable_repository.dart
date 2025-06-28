import '../../domain/entities/departure.dart';
import '../../domain/value_objects.dart';
import '../sources/timetable_remote_ds.dart';
import '../adapters/timetable_adapter.dart';
import '../dto/timetable_dto.dart';

abstract class TimetableRepository {
  Future<List<DepartureEntity>> getDepartures(
    LineId lineId,
    DiagramId diagramId,
  );
  Future<List<DepartureEntity>> getNextDepartures(
    LineId lineId,
    TimeOfDay currentTime,
  );
}

class TimetableRepositoryImpl implements TimetableRepository {
  final TimetableRemoteDataSource _remoteDataSource;
  final Map<String, List<DepartureEntity>> _cachedDepartures = {};

  TimetableRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<DepartureEntity>> getDepartures(
    LineId lineId,
    DiagramId diagramId,
  ) async {
    final cacheKey = '${lineId.value}_${diagramId.value}';

    try {
      final response = await _remoteDataSource.fetchTimetable();

      // Parse the response and create TimetableDto
      final departures = <DepartureTimeDto>[];

      // Assuming response contains departure times in some format
      // This will need to be adjusted based on actual API response structure
      final departureList = response['departures'] as List<dynamic>? ?? [];
      for (final departure in departureList) {
        if (departure is Map<String, dynamic>) {
          departures.add(
            DepartureTimeDto(
              time: departure['time'] as String,
              stationId: departure['stationId'] as String? ?? '',
              isHoliday: departure['isHoliday'] as bool? ?? false,
              isWeekend: departure['isWeekend'] as bool? ?? false,
              metadata: departure['metadata'] as Map<String, dynamic>? ?? {},
            ),
          );
        }
      }

      final timetableDto = TimetableDto(
        lineId: lineId.value,
        diagramId: diagramId.value,
        direction: 'forward',
        transportMode: 'bus',
        departures: departures,
      );

      final departureEntities = TimetableAdapter.fromTimetableDto(timetableDto);
      _cachedDepartures[cacheKey] = departureEntities;
      return departureEntities;
    } catch (e) {
      // Return cached departures if available, otherwise rethrow
      if (_cachedDepartures.containsKey(cacheKey)) {
        return _cachedDepartures[cacheKey]!;
      }
      rethrow;
    }
  }

  @override
  Future<List<DepartureEntity>> getNextDepartures(
    LineId lineId,
    TimeOfDay currentTime,
  ) async {
    // For simplicity, use a default diagram - this could be enhanced to select
    // the appropriate diagram based on the current date/time
    final departures = await getDepartures(lineId, DiagramId.weekday);

    // Filter departures to only include those after the current time
    return departures
        .where((departure) {
          return departure.departureTime.totalMinutes >
              currentTime.totalMinutes;
        })
        .take(3)
        .toList(); // Return next 3 departures
  }
}
