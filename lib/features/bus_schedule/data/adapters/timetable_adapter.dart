import '../dto/timetable_dto.dart';
import '../../domain/entities/departure.dart';
import '../../domain/entities/line.dart';
import '../../domain/value_objects.dart';

class TimetableAdapter {
  static List<DepartureEntity> fromTimetableDto(TimetableDto dto) {
    final lineId = LineId(dto.lineId);
    final direction = _parseDirection(dto.direction);
    final diagramId = DiagramId(dto.diagramId);

    return dto.departures.map((departureDto) {
      final timeOfDay = _parseTimeOfDay(departureDto.time);

      return DepartureEntity(
        departureTime: timeOfDay,
        arrivalTime:
            timeOfDay, // For now, same as departure - will be calculated later
        lineId: lineId,
        direction: direction,
        diagramId: diagramId,
        destination: departureDto.metadata['destination'] as String?,
      );
    }).toList();
  }

  static DepartureTime fromDepartureTimeDto(DepartureTimeDto dto) {
    final timeOfDay = _parseTimeOfDay(dto.time);
    return DepartureTime(
      minute: timeOfDay.minute,
      destination: dto.metadata['destination'] as String?,
    );
  }

  static DiagramEntity toDiagramEntity(TimetableDto dto) {
    final direction = _parseDirection(dto.direction);
    final departures = dto.departures.map((departureDto) {
      return fromDepartureTimeDto(departureDto);
    }).toList();

    // Group departures by hour
    final Map<int, List<DepartureTime>> hourlySchedule = {};
    for (final departure in departures) {
      final departureDto = dto.departures.firstWhere(
        (d) => departure.minute == _parseTimeOfDay(d.time).minute,
      );
      final timeOfDay = _parseTimeOfDay(departureDto.time);
      final hour = timeOfDay.hour;

      hourlySchedule.putIfAbsent(hour, () => []).add(departure);
    }

    return DiagramEntity(
      id: dto.diagramId,
      schedule: {direction: hourlySchedule},
    );
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid time format: $timeString');
    }

    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  static RouteDirection _parseDirection(String direction) {
    switch (direction.toLowerCase()) {
      case 'forward':
        return RouteDirection.forward;
      case 'reverse':
        return RouteDirection.reverse;
      default:
        return RouteDirection.forward;
    }
  }
}
