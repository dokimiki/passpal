import '../entities/timetable_slot.dart';
import '../repositories/timetable_repository.dart';
import '../value_objects/term.dart';

/// 時間割更新ユースケース
class RefreshTimetableUseCase {
  const RefreshTimetableUseCase(this._repository);

  final TimetableRepository _repository;

  /// 時間割を強制更新
  Future<List<TimetableSlot>> call(Term term) async {
    return await _repository.getTimetable(term, forceRefresh: true);
  }
}
