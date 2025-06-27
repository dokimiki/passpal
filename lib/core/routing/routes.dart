/// Application route enumeration
enum AppRoute {
  // 認証フロー
  loginStudentId('/login/student-id'),
  loginGoogle('/login/google'),
  loginCuId('/login/cu-id'),

  // セットアップフロー
  setupCampus('/setup/campus'),
  setupNotification('/setup/notification'),
  setupStart('/setup/start'),

  // メインフロー（ShellRoute）
  mainHome('/main/home'),
  mainTimetable('/main/timetable'),
  mainBus('/main/bus'),
  mainAssignments('/main/assignments'),

  // 詳細画面
  courseDetail('/main/timetable/:courseId/detail'),
  courseMaterials('/main/timetable/:courseId/materials'),

  // 特殊画面
  settings('/settings'),
  maintenance('/maintenance'),
  forceUpdate('/force-update'),
  error('/error');

  const AppRoute(this.path);

  final String path;

  /// Get route name from enum
  String get name => toString().split('.').last;
}

/// Route path constants (private)
class _RoutePaths {
  // ignore: unused_field
  static const String root = '/';

  // Auth paths
  static const String loginBase = '/login';
  // ignore: unused_field
  static const String loginStudentId = '/login/student-id';
  // ignore: unused_field
  static const String loginGoogle = '/login/google';
  // ignore: unused_field
  static const String loginCuId = '/login/cu-id';

  // Setup paths
  static const String setupBase = '/setup';
  // ignore: unused_field
  static const String setupCampus = '/setup/campus';
  // ignore: unused_field
  static const String setupNotification = '/setup/notification';
  // ignore: unused_field
  static const String setupStart = '/setup/start';

  // Main paths
  static const String mainBase = '/main';
  // ignore: unused_field
  static const String mainHome = '/main/home';
  // ignore: unused_field
  static const String mainTimetable = '/main/timetable';
  // ignore: unused_field
  static const String mainBus = '/main/bus';
  // ignore: unused_field
  static const String mainAssignments = '/main/assignments';

  // Detail paths
  // ignore: unused_field
  static const String courseDetail = '/main/timetable/:courseId/detail';
  // ignore: unused_field
  static const String courseMaterials = '/main/timetable/:courseId/materials';

  // Special paths
  static const String settings = '/settings';
  static const String maintenance = '/maintenance';
  static const String forceUpdate = '/force-update';
  static const String error = '/error';
}

/// Route validation utilities
class RouteValidator {
  /// Check if route requires authentication
  static bool requiresAuth(String path) {
    return !path.startsWith(_RoutePaths.loginBase) &&
        !path.startsWith(_RoutePaths.maintenance) &&
        !path.startsWith(_RoutePaths.forceUpdate) &&
        path != _RoutePaths.error;
  }

  /// Check if route requires setup completion
  static bool requiresSetup(String path) {
    return path.startsWith(_RoutePaths.mainBase) ||
        path == _RoutePaths.settings;
  }

  /// Check if route is login flow
  static bool isLoginFlow(String path) {
    return path.startsWith(_RoutePaths.loginBase);
  }

  /// Check if route is setup flow
  static bool isSetupFlow(String path) {
    return path.startsWith(_RoutePaths.setupBase);
  }

  /// Check if route is main flow
  static bool isMainFlow(String path) {
    return path.startsWith(_RoutePaths.mainBase);
  }
}
