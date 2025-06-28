import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/features/timetable/domain/repositories/timetable_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/entities/attendance_state.dart';
import '../domain/usecases/monitor_attendance_uc.dart';
import '../domain/usecases/submit_attendance_uc.dart';

part 'attendance_controller.g.dart';

/// 出席コントローラー（Family）
@riverpod
class AttendanceController extends _$AttendanceController {
  @override
  AttendanceState build(int classId) {
    // 初期状態
    return AttendanceState(
      classId: classId,
      status: AttendanceStatus.none,
      lastUpdated: DateTime.now(),
    );
  }

  /// 出席状態をポーリング開始
  void startPolling() {
    final useCase = ref.read(monitorAttendanceUseCaseProvider);
    final stream = useCase(classId);

    // StreamをListenして状態更新
    stream.listen((newState) {
      state = newState;
    });
  }

  /// 出席登録
  Future<void> submitAttendance({String? password}) async {
    final useCase = ref.read(submitAttendanceUseCaseProvider);
    final result = await useCase(classId, password: password);
    state = result;
  }

  /// 出席状態を手動更新
  Future<void> refreshState() async {
    // TODO: checkAttendanceUseCase を実装して使用
    // 現在は仮実装
  }
}

/// UseCaseのプロバイダー
@riverpod
MonitorAttendanceUseCase monitorAttendanceUseCase(
  Ref ref,
) {
  final repository = ref.read(
    attendanceRepositoryProvider as ProviderListenable,
  );
  return MonitorAttendanceUseCase(repository);
}

@riverpod
SubmitAttendanceUseCase submitAttendanceUseCase(
  Ref ref,
) {
  final repository = ref.read(
    attendanceRepositoryProvider as ProviderListenable,
  );
  return SubmitAttendanceUseCase(repository);
}

// TODO: repositoryプロバイダーを後で実装
@riverpod
AttendanceRepository attendanceRepositoryProvider(
  Ref ref,
) {
  throw UnimplementedError('AttendanceRepository provider not implemented yet');
}
