import '../entities/timetable_slot.dart';
import '../entities/course.dart';
import '../entities/attendance_state.dart';
import '../value_objects/term.dart';

/// 時間割リポジトリのインターフェース
abstract class TimetableRepository {
  /// 指定学期の時間割を取得
  Future<List<TimetableSlot>> getTimetable(
    Term term, {
    bool forceRefresh = false,
  });

  /// 授業の詳細情報を取得
  Future<CourseDetail> getCourseDetail(int manaboClassId);

  /// 利用可能な学期一覧を取得
  Future<List<Term>> getAvailableTerms();
}

/// 出席リポジトリのインターフェース
abstract class AttendanceRepository {
  /// 出席状態を確認（30秒ごとにポーリング）
  Future<AttendanceState> checkState(int classId);

  /// 出席を登録
  Future<AttendanceState> submit(int classId, {String? password});

  /// 出席状態をリアルタイムで監視
  Stream<AttendanceState> watchState(int classId);
}
