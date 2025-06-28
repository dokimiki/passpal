import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/departure.dart';
import '../entities/line.dart';
import '../value_objects.dart';

part 'timetable_query.g.dart';

/// Service for querying timetable data and getting future departures
class TimetableQuery {
  const TimetableQuery();

  /// Get the next n departures from the given time for a specific line and direction
  List<DepartureEntity> getNextDepartures({
    required LineEntity line,
    required RouteDirection direction,
    required DiagramId diagramId,
    required TimeOfDay currentTime,
    int count = 3,
  }) {
    final departures = <DepartureEntity>[];

    // Get the diagram schedule for the given direction
    final diagram = line.diagram[diagramId.value];
    if (diagram == null) {
      return departures;
    }

    final schedule = diagram.schedule[direction];
    if (schedule == null) {
      return departures;
    }

    // Iterate through hours from current time onwards
    final startHour = currentTime.hour;
    for (int hour = startHour; hour < 24 && departures.length < count; hour++) {
      final hourDepartures = schedule[hour] ?? [];

      for (final departureTime in hourDepartures) {
        final timeOfDay = TimeOfDay(hour: hour, minute: departureTime.minute);

        // Skip if this departure is in the past
        if (hour == startHour && timeOfDay.isBefore(currentTime)) {
          continue;
        }

        final arrivalTime = _calculateArrivalTime(
          timeOfDay,
          line,
          departureTime.isVia,
        );

        final departure = DepartureEntity(
          departureTime: timeOfDay,
          arrivalTime: arrivalTime,
          lineId: line.id,
          direction: direction,
          diagramId: diagramId,
          destination: departureTime.destination,
          isVia: departureTime.isVia,
          elapsedMinutes: _getElapsedMinutes(line, departureTime.isVia),
        );

        departures.add(departure);

        if (departures.length >= count) {
          break;
        }
      }
    }

    return departures;
  }

  /// Calculate arrival time based on departure time and line information
  TimeOfDay _calculateArrivalTime(
    TimeOfDay departureTime,
    LineEntity line,
    bool? isVia,
  ) {
    int elapsedMinutes = _getElapsedMinutes(line, isVia);
    return departureTime.addMinutes(elapsedMinutes);
  }

  /// Get elapsed minutes for the journey
  int _getElapsedMinutes(LineEntity line, bool? isVia) {
    if (line.elapsedTime == null) {
      return 0; // Default for trains or unknown
    }

    if (isVia == true && line.elapsedTime!.via != null) {
      return line.elapsedTime!.via!;
    }

    // Use forward time as default
    return line.elapsedTime!.forward;
  }

  /// Get the nearest single departure
  DepartureEntity? getNearestDeparture({
    required LineEntity line,
    required RouteDirection direction,
    required DiagramId diagramId,
    required TimeOfDay currentTime,
  }) {
    final departures = getNextDepartures(
      line: line,
      direction: direction,
      diagramId: diagramId,
      currentTime: currentTime,
      count: 1,
    );

    return departures.isNotEmpty ? departures.first : null;
  }
}

@riverpod
TimetableQuery timetableQuery(Ref ref) {
  return const TimetableQuery();
}
