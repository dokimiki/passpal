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
    // Already authenticated - no redirect
    if (authState.isAuthenticated) {
      return null;
    }

    // Already on login flow - no redirect
    if (currentPath.startsWith('/login')) {
      return null;
    }

    // Skip auth for special pages
    if (_isPublicRoute(currentPath)) {
      return null;
    }

    // Not authenticated and on protected route - redirect to login
    return '/login/student-id';
  }

  /// Check if route is publicly accessible
  bool _isPublicRoute(String path) {
    return path.startsWith('/maintenance') ||
        path.startsWith('/force-update') ||
        path == '/error';
  }
}
