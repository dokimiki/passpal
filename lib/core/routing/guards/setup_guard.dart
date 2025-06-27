import 'package:passpal/core/auth/providers/auth_state_notifier.dart';

/// Setup guard evaluates whether initial setup is completed
class SetupGuard {
  /// Evaluate if setup redirect is required
  ///
  /// Returns redirect path if setup is needed, null otherwise
  String? evaluate({
    required AuthState authState,
    required bool isSetupCompleted,
    required String currentPath,
  }) {
    // Not authenticated - setup not relevant
    if (!authState.isAuthenticated) {
      return null;
    }

    // Setup already completed - no redirect
    if (isSetupCompleted) {
      return null;
    }

    // Already on setup flow - no redirect
    if (currentPath.startsWith('/setup')) {
      return null;
    }

    // Skip setup for special pages
    if (_isSpecialRoute(currentPath)) {
      return null;
    }

    // Authenticated but setup not completed - redirect to setup
    return '/setup/campus';
  }

  /// Check if route is special and doesn't require setup
  bool _isSpecialRoute(String path) {
    return path.startsWith('/login') ||
        path.startsWith('/maintenance') ||
        path.startsWith('/force-update') ||
        path == '/error';
  }
}
