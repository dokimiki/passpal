import 'package:go_router/go_router.dart';

import 'pages/assignments_page.dart';

/// Navigation helpers for assignments feature
extension AssignmentsNavigation on GoRouter {
  /// Navigate to assignments page
  void pushAssignments() {
    push('/assignments');
  }

  /// Navigate to assignment detail
  void pushAssignmentDetail(String assignmentId) {
    push('/assignments/$assignmentId');
  }
}

/// Route definitions for assignments feature
class AssignmentsRoutes {
  static const String assignments = '/assignments';
  static const String assignmentDetail = '/assignments/:assignmentId';

  /// Get route configuration for assignments
  static List<RouteBase> get routes => [
    GoRoute(
      path: assignments,
      builder: (context, state) => const AssignmentsPage(),
    ),
    // TODO: Add assignment detail route when WebView integration is ready
  ];
}
