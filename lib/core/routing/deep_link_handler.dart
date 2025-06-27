import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/models/route_data.dart';
import 'package:passpal/core/error/app_exception.dart';

/// Handles deep links from various sources (URI, FCM, Widget taps)
class DeepLinkHandler {
  const DeepLinkHandler(this._goRouter);

  final GoRouter _goRouter;

  /// Handle a deep link from URI or push notification
  Future<void> handle(Uri uri, {Object? pushPayload}) async {
    try {
      final routeData = _parseRouteData(uri, pushPayload);
      _goRouter.go(uri.path, extra: routeData);
    } on RouteParsingException catch (e) {
      // Navigate to error page with parsing exception
      _goRouter.go(
        '/error',
        extra: ErrorPageArgs(
          title: 'ページが見つかりません',
          message: e.message,
          canRetry: false,
        ),
      );
    } catch (e) {
      // Handle unexpected parsing errors
      _goRouter.go(
        '/error',
        extra: ErrorPageArgs(
          title: '予期しないエラーが発生しました',
          message: e.toString(),
          canRetry: true,
        ),
      );
    }
  }

  /// Parse route data from URI and push payload
  Object? _parseRouteData(Uri uri, Object? pushPayload) {
    // Extract route arguments from path parameters
    final pathSegments = uri.pathSegments;

    try {
      // Handle course detail routes: /main/timetable/:courseId/detail
      if (pathSegments.length == 4 &&
          pathSegments[0] == 'main' &&
          pathSegments[1] == 'timetable' &&
          pathSegments[3] == 'detail') {
        final courseId = pathSegments[2];
        if (courseId.isEmpty) {
          throw RouteParsingException(
            message: 'courseId cannot be empty for course detail route',
            originalUri: uri,
            routePath: uri.path,
          );
        }
        return CourseDetailArgs(courseId: courseId);
      }

      // Handle course materials routes: /main/timetable/:courseId/materials
      if (pathSegments.length == 4 &&
          pathSegments[0] == 'main' &&
          pathSegments[1] == 'timetable' &&
          pathSegments[3] == 'materials') {
        final courseId = pathSegments[2];
        if (courseId.isEmpty) {
          throw RouteParsingException(
            message: 'courseId cannot be empty for course materials route',
            originalUri: uri,
            routePath: uri.path,
          );
        }
        return CourseMaterialsArgs(courseId: courseId);
      }

      // Handle assignment detail from push payload
      if (pushPayload is Map<String, dynamic>) {
        final courseId = pushPayload['courseId'] as String?;
        final assignmentId = pushPayload['assignmentId'] as String?;

        if (courseId != null && assignmentId != null) {
          return AssignmentDetailArgs(
            courseId: courseId,
            assignmentId: assignmentId,
          );
        }
      }

      // Handle known simple routes
      final knownSimpleRoutes = {
        '/main/home',
        '/main/timetable',
        '/assignment',
        '/login/student-id',
        '/login/password',
        '/login/totp',
        '/maintenance',
        '/force-update',
        '/error',
      };

      if (knownSimpleRoutes.contains(uri.path)) {
        // Handle query parameters for simple routes
        final queryParams = uri.queryParameters;
        if (queryParams.isNotEmpty) {
          return DeepLinkData(
            uri: uri,
            pushPayload: pushPayload as Map<String, dynamic>?,
            timestamp: DateTime.now(),
          );
        }
        return null;
      }

      // If we reach here, the route pattern is not recognized
      throw RouteParsingException(
        message: 'Unrecognized route pattern: ${uri.path}',
        originalUri: uri,
        routePath: uri.path,
      );
    } catch (e) {
      if (e is RouteParsingException) {
        rethrow;
      }
      throw RouteParsingException(
        message: 'Failed to parse route data from ${uri.path}: ${e.toString()}',
        originalUri: uri,
        routePath: uri.path,
      );
    }
  }

  /// Create deep link data from FCM message
  static DeepLinkData fromFCM(Map<String, dynamic> data) {
    final deepLink = data['deeplink'] as String?;
    if (deepLink == null) {
      throw RouteParsingException(
        message: 'No deeplink found in FCM data',
        routePath: null,
      );
    }

    return DeepLinkData(
      uri: Uri.parse(deepLink),
      pushPayload: data,
      timestamp: DateTime.now(),
    );
  }
}
