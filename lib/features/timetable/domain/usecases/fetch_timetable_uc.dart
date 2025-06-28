import '../entities/timetable_slot.dart';
import '../repositories/timetable_repository.dart';
import '../value_objects/term.dart';

/// 時間割取得ユースケース
class FetchTimetableUseCase {
  const FetchTimetableUseCase(this._repository);

  final TimetableRepository _repository;

  /// 指定学期の時間割を取得
  Future<List<TimetableSlot>> call(
    Term term, {
    bool forceRefresh = false,
  }) async {
    return await _repository.getTimetable(term, forceRefresh: forceRefresh);
  }
}
