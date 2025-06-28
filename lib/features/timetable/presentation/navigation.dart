import 'package:go_router/go_router.dart';
import '../domain/entities/timetable_slot.dart';

/// 時間割関連のナビゲーションヘルパー
extension TimetableNavigation on GoRouter {
  /// 授業詳細ページへ遷移
  void pushCourseDetail(TimetableSlot slot) {
    push('/timetable/course/${slot.course?.manaboClassId}', extra: slot);
  }

  /// 時間割ページへ遷移
  void pushTimetable() {
    push('/timetable');
  }
}

/// 時間割ルート定義用のヘルパー
class TimetableRoutes {
  static const String timetable = '/timetable';
  static const String courseDetail = '/timetable/course/:classId';

  /// ルート設定を取得
  static List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: timetable,
        builder: (context, state) {
          // TimetablePage をインポートして返す
          // 現在はプレースホルダー
          throw UnimplementedError('TimetablePage import required');
        },
      ),
      GoRoute(
        path: courseDetail,
        builder: (context, state) {
          final slot = state.extra as TimetableSlot?;
          if (slot == null) {
            throw Exception('TimetableSlot is required');
          }
          // CourseDetailPage をインポートして返す
          // 現在はプレースホルダー
          throw UnimplementedError('CourseDetailPage import required');
        },
      ),
    ];
  }
}
