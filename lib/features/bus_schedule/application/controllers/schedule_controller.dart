import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/departure.dart';
import '../../domain/value_objects.dart';

part 'schedule_controller.freezed.dart';
part 'schedule_controller.g.dart';

/// Simple error class for now
class SimpleError {
  final String message;
  const SimpleError(this.message);
}

/// State for timetable feature
@freezed
abstract class TimetableState with _$TimetableState {
  const factory TimetableState({
    @Default([]) List<DepartureDTO> items,
    @Default(false) bool loading,
    SimpleError? error,
  }) = _TimetableState;
}

/// Controller for bus/train schedule functionality
@riverpod
class ScheduleController extends _$ScheduleController {
  @override
  TimetableState build(LineId lineId, RouteDirection direction) {
    return const TimetableState(loading: true);
  }

  /// Load departures for the current line and direction
  Future<void> loadDepartures() async {
    state = state.copyWith(loading: true, error: null);

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

      state = state.copyWith(items: mockDepartures, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: SimpleError(e.toString()));
    }
  }

  /// Check if today is a holiday
  Future<bool> isHoliday() async {
    // Return false for now until holiday repository is properly wired
    return false;
  }
}
