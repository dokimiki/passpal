import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/repositories/timetable_repository.dart';
import '../domain/repositories/attendance_repository.dart' as attendance_repo;
import '../data/repositories/timetable_repository_impl.dart';
import '../data/repositories/attendance_repository_impl.dart';
import '../data/datasources/manabo_timetable_remote_ds.dart';
import '../data/datasources/cubics_timetable_remote_ds.dart';
import '../data/datasources/manabo_class_remote_ds.dart';
import '../data/datasources/manabo_attendance_remote_ds.dart';
import '../../../core/network/providers.dart';
import '../../../core/network/network_target.dart';

part 'providers.g.dart';

// Repository Providers

@riverpod
TimetableRepository timetableRepository(Ref ref) {
  return TimetableRepositoryImpl(
    manaboTimetableDataSource: ref.read(
      manaboTimetableRemoteDataSourceProvider,
    ),
    cubicsTimetableDataSource: ref.read(
      cubicsTimetableRemoteDataSourceProvider,
    ),
    manaboClassDataSource: ref.read(manaboClassRemoteDataSourceProvider),
  );
}

@riverpod
attendance_repo.AttendanceRepository attendanceRepository(
  Ref ref,
) {
  return AttendanceRepositoryImpl(
    attendanceDataSource: ref.read(manaboAttendanceRemoteDataSourceProvider),
  );
}

// DataSource Providers

@riverpod
ManaboTimetableRemoteDataSource manaboTimetableRemoteDataSource(
  Ref ref,
) {
  final dio = ref.watch(networkClientProvider(NetworkTarget.manabo));
  return ManaboTimetableRemoteDataSourceImpl(dio);
}

@riverpod
CubicsTimetableRemoteDataSource cubicsTimetableRemoteDataSource(
  Ref ref,
) {
  final dio = ref.watch(networkClientProvider(NetworkTarget.cubics));
  return CubicsTimetableRemoteDataSourceImpl(dio);
}

@riverpod
ManaboClassRemoteDataSource manaboClassRemoteDataSource(
  Ref ref,
) {
  final dio = ref.watch(networkClientProvider(NetworkTarget.manabo));
  return ManaboClassRemoteDataSourceImpl(dio);
}

@riverpod
ManaboAttendanceRemoteDataSource manaboAttendanceRemoteDataSource(
  Ref ref,
) {
  final dio = ref.watch(networkClientProvider(NetworkTarget.manabo));
  return ManaboAttendanceRemoteDataSourceImpl(dio);
}
