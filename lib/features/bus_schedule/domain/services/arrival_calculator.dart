import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/line.dart';
import '../value_objects.dart';

part 'arrival_calculator.g.dart';

/// Service for calculating arrival times with bus-specific logic
class ArrivalCalculator {
  const ArrivalCalculator();

  /// Calculate arrival time for a bus journey
  TimeOfDay calculateBusArrival({
    required TimeOfDay departureTime,
    required LineEntity line,
    required RouteDirection direction,
    bool isVia = false,
  }) {
    if (line.type != TransportMode.bus) {
      throw ArgumentError('This method is only for bus lines');
    }

    final elapsedTime = line.elapsedTime;
    if (elapsedTime == null) {
      return departureTime; // No elapsed time data
    }

    int minutes;
    switch (direction) {
      case RouteDirection.forward:
        minutes = isVia && elapsedTime.via != null
            ? elapsedTime.via!
            : elapsedTime.forward;
        break;
      case RouteDirection.reverse:
        minutes = elapsedTime.reverse;
        break;
    }

    return departureTime.addMinutes(minutes);
  }

  /// Calculate arrival time for train (no special via logic)
  TimeOfDay calculateTrainArrival({
    required TimeOfDay departureTime,
    required LineEntity line,
  }) {
    if (line.type != TransportMode.train) {
      throw ArgumentError('This method is only for train lines');
    }

    // Trains don't have elapsed time data in our model
    // They arrive at the next station immediately for our purposes
    return departureTime;
  }

  /// Get display string for travel time
  String getElapsedTimeDisplay(
    LineEntity line,
    RouteDirection direction, {
    bool isVia = false,
  }) {
    if (line.type == TransportMode.train) {
      return ''; // No display for trains
    }

    final elapsedTime = line.elapsedTime;
    if (elapsedTime == null) {
      return '';
    }

    int minutes;
    String suffix = '';

    switch (direction) {
      case RouteDirection.forward:
        minutes = isVia && elapsedTime.via != null
            ? elapsedTime.via!
            : elapsedTime.forward;
        if (isVia && elapsedTime.via != null) {
          suffix = ' (経由)';
        }
        break;
      case RouteDirection.reverse:
        minutes = elapsedTime.reverse;
        break;
    }

    return '$minutes分$suffix';
  }
}

@riverpod
ArrivalCalculator arrivalCalculator(Ref ref) {
  return const ArrivalCalculator();
}
