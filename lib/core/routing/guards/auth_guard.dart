import 'package:flutter/foundation.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';

/// Auth guard evaluates whether authentication is required
class AuthGuard {
  /// Evaluate if authentication redirect is required
  ///
  /// Returns redirect path if authentication is needed, null otherwise
  String? evaluate({
    required AuthState authState,
    required String currentPath,
  }) {
    debugPrint(
      'AuthGuard: evaluating - '
      'authState: ${authState.isAuthenticated}, '
      'currentPath: $currentPath',
    );

    // Already authenticated - no redirect
    if (authState.isAuthenticated) {
      debugPrint('AuthGuard: already authenticated, no redirect');
      return null;
    }

    // Already on login flow - no redirect
    if (currentPath.startsWith('/login')) {
      debugPrint('AuthGuard: already on login flow, no redirect');
      return null;
    }

    // Skip auth for special pages
    if (_isPublicRoute(currentPath)) {
      debugPrint('AuthGuard: public route, no redirect');
      return null;
    }

    // Not authenticated and on protected route - redirect to login
    debugPrint('AuthGuard: redirecting to /login/student-id');
    return '/login/student-id';
  }

  /// Check if route is publicly accessible
  bool _isPublicRoute(String path) {
    return path.startsWith('/maintenance') ||
        path.startsWith('/force-update') ||
        path == '/error';
  }
}
