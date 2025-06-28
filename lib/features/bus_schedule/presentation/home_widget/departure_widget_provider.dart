import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/departure.dart';
import '../../domain/value_objects.dart';

part 'departure_widget_provider.g.dart';

/// Provider for home widget departure data
@riverpod
Future<DepartureDTO?> nearestDeparture(Ref ref, Campus campus) async {
  try {
    // Mock implementation for now
    // In a real implementation, this would:
    // 1. Get all lines for the campus
    // 2. Get next departures for each line
    // 3. Find the nearest one across all lines

    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
    final arrivalTime = TimeOfDay(hour: now.hour, minute: now.minute + 15);

    final mockDeparture = DepartureDTO(
      lineDisplayName: 'Toyota Line',
      departureTime: currentTime,
      arrivalTime: arrivalTime,
      destinationName: 'Toyota Campus',
      direction: RouteDirection.forward,
      isNearestDeparture: true,
      minutesUntilDeparture: 5,
    );

    return mockDeparture;
  } catch (e) {
    // Return null if there's an error - widget will show "No departures"
    return null;
  }
}

/// Provider that refreshes every minute for the home widget
@riverpod
Stream<DepartureDTO?> nearestDepartureStream(Ref ref, Campus campus) {
  return Stream.periodic(
    const Duration(minutes: 1),
    (_) => ref.read(nearestDepartureProvider(campus)).value,
  ).asyncMap((future) async => future);
}

/// Widget configuration for home screen integration
@riverpod
Map<String, dynamic> widgetConfig(Ref ref) {
  return {
    'refreshInterval': 60, // seconds
    'showNextThree': false, // Only show nearest for widget
    'campuses': [
      {'id': Campus.toyota.name, 'name': Campus.toyota.displayName},
      {'id': Campus.yagoto.name, 'name': Campus.yagoto.displayName},
    ],
  };
}
