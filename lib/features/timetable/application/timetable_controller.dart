import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/entities/timetable_slot.dart';
import '../domain/entities/course.dart';
import '../domain/repositories/timetable_repository.dart';
import '../domain/value_objects/term.dart';
import '../domain/usecases/fetch_timetable_uc.dart';
import '../domain/usecases/refresh_timetable_uc.dart';
import '../domain/usecases/fetch_course_detail_uc.dart';

part 'timetable_controller.g.dart';

/// 時間割コントローラー
@riverpod
class TimetableController extends _$TimetableController {
  @override
  FutureOr<List<TimetableSlot>> build() async {
    // デフォルトで現在の学期の時間割を取得
    final useCase = ref.read(fetchTimetableUseCaseProvider);
    return useCase(TermConstants.current2025Spring);
  }

  /// 時間割を更新
  Future<void> refresh({bool forceRefresh = false}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(refreshTimetableUseCaseProvider);
      return useCase(TermConstants.current2025Spring);
    });
  }

  /// 指定学期の時間割を取得
  Future<void> loadTerm(Term term) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(fetchTimetableUseCaseProvider);
      return useCase(term);
    });
  }
}

/// 授業詳細コントローラー（Family）
@riverpod
class CourseDetailController extends _$CourseDetailController {
  @override
  FutureOr<CourseDetail> build(int manaboClassId) async {
    final useCase = ref.read(fetchCourseDetailUseCaseProvider);
    return useCase(manaboClassId);
  }

  /// 授業詳細を更新
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(fetchCourseDetailUseCaseProvider);
      return useCase(manaboClassId);
    });
  }
}

/// UseCaseのプロバイダー
@riverpod
FetchTimetableUseCase fetchTimetableUseCase(FetchTimetableUseCaseRef ref) {
  final repository = ref.read(
    timetableRepositoryProvider as ProviderListenable,
  );
  return FetchTimetableUseCase(repository);
}

@riverpod
RefreshTimetableUseCase refreshTimetableUseCase(
  RefreshTimetableUseCaseRef ref,
) {
  final repository = ref.read(
    timetableRepositoryProvider as ProviderListenable,
  );
  return RefreshTimetableUseCase(repository);
}

@riverpod
FetchCourseDetailUseCase fetchCourseDetailUseCase(
  FetchCourseDetailUseCaseRef ref,
) {
  final repository = ref.read(
    timetableRepositoryProvider as ProviderListenable,
  );
  return FetchCourseDetailUseCase(repository);
}

// TODO: repositoryプロバイダーを後で実装
@riverpod
TimetableRepository timetableRepositoryProvider(
  TimetableRepositoryProviderRef ref,
) {
  throw UnimplementedError('TimetableRepository provider not implemented yet');
}
