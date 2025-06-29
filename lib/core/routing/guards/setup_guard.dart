import 'package:flutter/foundation.dart';
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
    debugPrint(
      'SetupGuard: evaluating - '
      'authState: ${authState.isAuthenticated}, '
      'setupCompleted: $isSetupCompleted, '
      'currentPath: $currentPath',
    );

    // Not authenticated - setup not relevant
    if (!authState.isAuthenticated) {
      debugPrint('SetupGuard: not authenticated, no redirect');
      return null;
    }

    // Setup already completed - no redirect
    if (isSetupCompleted) {
      debugPrint('SetupGuard: setup completed, no redirect');
      return null;
    }

    // Already on setup flow - no redirect
    if (currentPath.startsWith('/setup')) {
      debugPrint('SetupGuard: already on setup flow, no redirect');
      return null;
    }

    // Skip setup for special pages
    if (_isSpecialRoute(currentPath)) {
      debugPrint('SetupGuard: special route, no redirect');
      return null;
    }

    // Authenticated but setup not completed - redirect to setup
    debugPrint('SetupGuard: redirecting to /setup/campus');
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
