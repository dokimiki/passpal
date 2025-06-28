import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/routes.dart';
import 'package:passpal/core/routing/models/route_data.dart';
import 'package:passpal/core/routing/guards/force_update_guard.dart';
import 'package:passpal/core/routing/guards/maintenance_guard.dart';
import 'package:passpal/core/routing/guards/auth_guard.dart';
import 'package:passpal/core/routing/guards/setup_guard.dart';
import 'package:passpal/core/routing/providers.dart';
import 'package:passpal/core/routing/pages/error_page.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';

/// Create the app router with all guards and routes
GoRouter createAppRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoute.mainHome.path,
    routes: _buildRoutes(),
    redirect: (context, state) => _handleRedirect(context, state, ref),
    errorBuilder: (context, state) => _buildErrorPage(context, state),
    observers: [ref.read(navigationObserverProvider)],
    debugLogDiagnostics: true,
  );
}

/// Build all application routes
List<RouteBase> _buildRoutes() {
  return [
    // Login routes
    GoRoute(
      path: AppRoute.loginStudentId.path,
      name: AppRoute.loginStudentId.name,
      builder: (context, state) =>
          const Placeholder(), // TODO: Implement LoginPage
    ),
    GoRoute(
      path: AppRoute.loginGoogle.path,
      name: AppRoute.loginGoogle.name,
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: AppRoute.loginCuId.path,
      name: AppRoute.loginCuId.name,
      builder: (context, state) => const Placeholder(),
    ),

    // Setup routes
    GoRoute(
      path: AppRoute.setupCampus.path,
      name: AppRoute.setupCampus.name,
      builder: (context, state) =>
          const Placeholder(), // TODO: Implement SetupPage
    ),
    GoRoute(
      path: AppRoute.setupNotification.path,
      name: AppRoute.setupNotification.name,
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: AppRoute.setupStart.path,
      name: AppRoute.setupStart.name,
      builder: (context, state) => const Placeholder(),
    ),

    // Main routes (ShellRoute for tabs)
    ShellRoute(
      builder: (context, state, child) {
        // TODO: Implement main shell with bottom navigation
        return Scaffold(
          body: child,
          bottomNavigationBar:
              const Placeholder(), // TODO: Implement BottomNavBar
        );
      },
      routes: [
        GoRoute(
          path: AppRoute.mainHome.path,
          name: AppRoute.mainHome.name,
          builder: (context, state) =>
              const Placeholder(), // TODO: Implement HomePage
        ),
        GoRoute(
          path: AppRoute.mainTimetable.path,
          name: AppRoute.mainTimetable.name,
          builder: (context, state) =>
              const Placeholder(), // TODO: Implement TimetablePage
          routes: [
            GoRoute(
              path:
                  'detail', // Relative path for /main/timetable/:courseId/detail
              name: AppRoute.courseDetail.name,
              builder: (context, state) =>
                  const Placeholder(), // TODO: Implement CourseDetailPage
            ),
            GoRoute(
              path:
                  'materials', // Relative path for /main/timetable/:courseId/materials
              name: AppRoute.courseMaterials.name,
              builder: (context, state) =>
                  const Placeholder(), // TODO: Implement CourseMaterialsPage
            ),
          ],
        ),
        GoRoute(
          path: AppRoute.mainBus.path,
          name: AppRoute.mainBus.name,
          builder: (context, state) =>
              const Placeholder(), // TODO: Implement BusPage
        ),
        GoRoute(
          path: AppRoute.mainAssignments.path,
          name: AppRoute.mainAssignments.name,
          builder: (context, state) =>
              const Placeholder(), // TODO: Implement AssignmentsPage
        ),
      ],
    ),

    // Special routes
    GoRoute(
      path: AppRoute.settings.path,
      name: AppRoute.settings.name,
      builder: (context, state) =>
          const Placeholder(), // TODO: Implement SettingsPage
    ),
    GoRoute(
      path: AppRoute.maintenance.path,
      name: AppRoute.maintenance.name,
      builder: (context, state) =>
          const Placeholder(), // TODO: Implement MaintenancePage
    ),
    GoRoute(
      path: AppRoute.forceUpdate.path,
      name: AppRoute.forceUpdate.name,
      builder: (context, state) =>
          const Placeholder(), // TODO: Implement ForceUpdatePage
    ),
    GoRoute(
      path: AppRoute.error.path,
      name: AppRoute.error.name,
      builder: (context, state) => ErrorPage(
        args:
            state.extra as ErrorPageArgs? ??
            const ErrorPageArgs(
              title: 'エラーが発生しました',
              message: '予期しないエラーが発生しました',
            ),
      ),
    ),
  ];
}

/// Handle route redirection with guards
Future<String?> _handleRedirect(
  BuildContext context,
  GoRouterState state,
  Ref ref,
) async {
  final currentPath = state.matchedLocation;

  // 1. Force-Update Guard (highest priority)
  final remoteConfig = ref.read(remoteConfigProvider);
  final forceUpdateGuard = ForceUpdateGuard();
  final forceUpdateRedirect = forceUpdateGuard.evaluate(
    currentVersion: '1.0.0', // TODO: Get actual app version
    minimumVersion: await remoteConfig.minimumVersion,
    currentPath: currentPath,
  );
  if (forceUpdateRedirect != null) return forceUpdateRedirect;

  // 2. Maintenance Guard
  final isMaintenanceMode = ref.read(maintenanceFlagProvider);
  final maintenanceGuard = MaintenanceGuard();
  final maintenanceRedirect = maintenanceGuard.evaluate(
    isMaintenanceMode: isMaintenanceMode,
    currentPath: currentPath,
  );
  if (maintenanceRedirect != null) return maintenanceRedirect;

  // 3. Auth Guard
  final authState = ref.read(authStateProvider);
  final authGuard = AuthGuard();
  final authRedirect = authGuard.evaluate(
    authState: authState,
    currentPath: currentPath,
  );
  if (authRedirect != null) return authRedirect;

  // 4. Setup Guard (lowest priority)
  final isSetupCompleted = ref.read(setupCompletedProvider);
  final setupGuard = SetupGuard();
  final setupRedirect = setupGuard.evaluate(
    authState: authState,
    isSetupCompleted: isSetupCompleted,
    currentPath: currentPath,
  );
  if (setupRedirect != null) return setupRedirect;

  return null; // No redirect needed
}

/// Build error page from GoRouter error
Widget _buildErrorPage(BuildContext context, GoRouterState state) {
  final error = state.error;

  if (error is RouteParsingException) {
    return ErrorPage(
      args: ErrorPageArgs(
        title: 'ページが見つかりません',
        message: (error as RouteParsingException).message,
        canRetry: false,
      ),
    );
  }

  return ErrorPage(
    args: ErrorPageArgs(
      title: '予期しないエラーが発生しました',
      message: error?.toString() ?? 'Unknown error',
      canRetry: true,
    ),
  );
}
