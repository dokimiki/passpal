import '../entities/attendance_state.dart';
import '../repositories/attendance_repository.dart';

/// 出席監視ユースケース
class MonitorAttendanceUseCase {
  const MonitorAttendanceUseCase(this._repository);

  final AttendanceRepository _repository;

  /// 出席状態をリアルタイムで監視
  Stream<AttendanceState> call(int classId) {
    return _repository.watchState(classId);
  }
}
