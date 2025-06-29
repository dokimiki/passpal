import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/departure.dart';
import '../../domain/value_objects.dart';

part 'schedule_controller.freezed.dart';
part 'schedule_controller.g.dart';

/// State for timetable feature
@freezed
class TimetableState with _$TimetableState {
  const factory TimetableState.loading() = TimetableLoading;
  const factory TimetableState.loaded(List<DepartureDTO> items) =
      TimetableLoaded;
  const factory TimetableState.error(String message) = TimetableError;
}

/// Controller for bus/train schedule functionality
@riverpod
class ScheduleController extends _$ScheduleController {
  @override
  TimetableState build(LineId lineId, RouteDirection direction) {
    return const TimetableState.loading();
  }

  /// Load departures for the current line and direction
  Future<void> loadDepartures() async {
    state = const TimetableState.loading();

    try {
      // Create mock data for now since dependencies aren't fully set up
      final mockDepartures = [
        const DepartureDTO(
          lineDisplayName: 'Toyota Line',
          departureTime: TimeOfDay(hour: 9, minute: 30),
          arrivalTime: TimeOfDay(hour: 9, minute: 45),
          destinationName: 'Toyota Campus',
          direction: RouteDirection.forward,
          isNearestDeparture: true,
          isVia: false,
        ),
        const DepartureDTO(
          lineDisplayName: 'Toyota Line',
          departureTime: TimeOfDay(hour: 10, minute: 0),
          arrivalTime: TimeOfDay(hour: 10, minute: 15),
          destinationName: 'Toyota Station',
          direction: RouteDirection.forward,
          isNearestDeparture: false,
          isVia: false,
        ),
      ];

      state = TimetableState.loaded(mockDepartures);
    } catch (e) {
      state = TimetableState.error(e.toString());
    }
  }

  /// Check if today is a holiday
  Future<bool> isHoliday() async {
    // Return false for now until holiday repository is properly wired
    return false;
  }
}
