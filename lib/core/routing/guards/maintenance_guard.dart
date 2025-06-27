/// Maintenance guard evaluates whether the app is in maintenance mode
class MaintenanceGuard {
  /// Evaluate if maintenance redirect is required
  ///
  /// Returns redirect path if maintenance is active, null otherwise
  String? evaluate({
    required bool isMaintenanceMode,
    required String currentPath,
  }) {
    // Not in maintenance mode - no redirect
    if (!isMaintenanceMode) {
      return null;
    }

    // Already on maintenance page - no redirect
    if (currentPath == '/maintenance') {
      return null;
    }

    // Maintenance mode active - redirect to maintenance page
    return '/maintenance';
  }
}
