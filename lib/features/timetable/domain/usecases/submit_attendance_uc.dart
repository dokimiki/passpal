import '../entities/attendance_state.dart';
import '../repositories/attendance_repository.dart';

/// 出席登録ユースケース
class SubmitAttendanceUseCase {
  const SubmitAttendanceUseCase(this._repository);

  final AttendanceRepository _repository;

  /// 出席を登録
  Future<AttendanceState> call(int classId, {String? password}) async {
    return await _repository.submit(classId, password: password);
  }
}
