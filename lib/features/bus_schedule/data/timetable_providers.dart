import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/departure.dart';
import '../domain/entities/line.dart';
import '../domain/value_objects.dart';
import 'repository/holiday_repository.dart';
import 'repository/bus_diagram_repository.dart';
import 'repository/timetable_repository.dart';
import 'sources/holidays_remote_ds.dart';
import 'sources/bus_diagram_remote_ds.dart';
import 'sources/timetable_remote_ds.dart';

part 'timetable_providers.g.dart';

// Repository providers
@riverpod
HolidayRepository holidayRepository(Ref ref) {
  final remoteDataSource = ref.watch(holidaysRemoteDataSourceProvider);
  return HolidayRepositoryImpl(remoteDataSource);
}

@riverpod
BusDiagramRepository busDiagramRepository(Ref ref) {
  final remoteDataSource = ref.watch(busDiagramRemoteDataSourceProvider);
  return BusDiagramRepositoryImpl(remoteDataSource);
}

@riverpod
TimetableRepository timetableRepository(Ref ref) {
  final remoteDataSource = ref.watch(timetableRemoteDataSourceProvider);
  return TimetableRepositoryImpl(remoteDataSource);
}

// Family providers for specific queries
@riverpod
Future<List<DepartureEntity>> nextDepartures(Ref ref, LineId lineId) async {
  final repository = ref.watch(timetableRepositoryProvider);
  final currentTime = TimeOfDay.now();
  return repository.getNextDepartures(lineId, currentTime);
}

@riverpod
Future<List<DepartureEntity>> departures(
  Ref ref,
  LineId lineId,
  DiagramId diagramId,
) async {
  final repository = ref.watch(timetableRepositoryProvider);
  return repository.getDepartures(lineId, diagramId);
}

@riverpod
Future<bool> isHoliday(Ref ref, DateTime date) async {
  final repository = ref.watch(holidayRepositoryProvider);
  return repository.isHoliday(date);
}

// Campus-related providers
@riverpod
Future<List<LineEntity>> campusLines(Ref ref, Campus campus) async {
  final repository = ref.watch(busDiagramRepositoryProvider);
  return repository.getLinesForCampus(campus);
}
