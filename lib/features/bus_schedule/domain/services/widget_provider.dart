import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/departure.dart';
import '../entities/line.dart';
import '../value_objects.dart';
import 'timetable_query.dart';

part 'widget_provider.g.dart';

/// Service for providing departure data specifically for home widgets
class WidgetProvider {
  const WidgetProvider({required this.timetableQuery});

  final TimetableQuery timetableQuery;

  /// Get the single nearest departure for home widget display
  DepartureDTO? getNearestDepartureForWidget({
    required LineEntity line,
    required RouteDirection direction,
    required DiagramId diagramId,
    required Campus campus,
  }) {
    final currentTime = TimeOfDay.now();

    final nearestDeparture = timetableQuery.getNearestDeparture(
      line: line,
      direction: direction,
      diagramId: diagramId,
      currentTime: currentTime,
    );

    if (nearestDeparture == null) {
      return null;
    }

    // Convert to DTO for widget consumption
    return DepartureDTO.fromEntity(
      nearestDeparture,
      line.name,
      _getDestinationDisplay(line, direction, nearestDeparture.destination),
      isNearestDeparture: true,
      platformInfo: _getPlatformInfo(line, direction),
    );
  }

  /// Get multiple departures for a line (for widget that shows more than one)
  List<DepartureDTO> getDeparturesForWidget({
    required LineEntity line,
    required RouteDirection direction,
    required DiagramId diagramId,
    required Campus campus,
    int count = 3,
  }) {
    final currentTime = TimeOfDay.now();

    final departures = timetableQuery.getNextDepartures(
      line: line,
      direction: direction,
      diagramId: diagramId,
      currentTime: currentTime,
      count: count,
    );

    return departures.asMap().entries.map((entry) {
      final index = entry.key;
      final departure = entry.value;

      return DepartureDTO.fromEntity(
        departure,
        line.name,
        _getDestinationDisplay(line, direction, departure.destination),
        isNearestDeparture: index == 0,
        platformInfo: _getPlatformInfo(line, direction),
      );
    }).toList();
  }

  /// Get display name for destination
  String _getDestinationDisplay(
    LineEntity line,
    RouteDirection direction,
    String? specificDestination,
  ) {
    if (specificDestination != null) {
      return specificDestination;
    }

    // Use line's destination mapping or default
    final destinations = line.destination;
    if (destinations != null) {
      final directionKey = direction == RouteDirection.forward
          ? 'forward'
          : 'reverse';
      final directionDestinations = destinations[directionKey];
      if (directionDestinations != null) {
        return directionDestinations['default'] ?? line.to;
      }
    }

    return direction == RouteDirection.forward ? line.to : line.from;
  }

  /// Get platform information for display
  String? _getPlatformInfo(LineEntity line, RouteDirection direction) {
    // This could be enhanced to provide platform-specific information
    if (line.type == TransportMode.train) {
      return direction == RouteDirection.forward ? '1番線' : '2番線';
    }
    return null; // No platform info for buses
  }

  /// Check if widget should be shown based on service availability
  bool shouldShowWidget({
    required LineEntity line,
    required DiagramId diagramId,
    required DateTime date,
  }) {
    // Check if there's service for the given diagram
    final diagram = line.diagram[diagramId.value];
    if (diagram == null) {
      return false;
    }

    // Check if there are any departures scheduled
    return diagram.schedule.values.any(
      (directionSchedule) => directionSchedule.values.any(
        (hourDepartures) => hourDepartures.isNotEmpty,
      ),
    );
  }
}

@riverpod
WidgetProvider widgetProvider(Ref ref) {
  final timetableQuery = ref.watch(timetableQueryProvider);
  return WidgetProvider(timetableQuery: timetableQuery);
}
