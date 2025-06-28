import '../entities/course.dart';
import '../repositories/timetable_repository.dart';

/// 授業詳細取得ユースケース
class FetchCourseDetailUseCase {
  const FetchCourseDetailUseCase(this._repository);

  final TimetableRepository _repository;

  /// 授業の詳細情報を取得
  Future<CourseDetail> call(int manaboClassId) async {
    return await _repository.getCourseDetail(manaboClassId);
  }
}
