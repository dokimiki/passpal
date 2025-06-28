import '../entities/attendance_state.dart';

/// 出席リポジトリのインターフェース
abstract class AttendanceRepository {
  /// 出席状態を確認（30秒ごとにポーリング）
  Future<AttendanceState> checkState(int classId);

  /// 出席を登録
  Future<AttendanceState> submit(int classId, {String? password});

  /// 出席状態をリアルタイムで監視
  Stream<AttendanceState> watchState(int classId);
}
