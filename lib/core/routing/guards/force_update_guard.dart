import 'package:passpal/core/error/app_exception.dart';

/// Force update guard evaluates whether the app requires an update
class ForceUpdateGuard {
  /// Evaluate if force update is required
  ///
  /// Returns redirect path if update is required, null otherwise
  String? evaluate({
    required String currentVersion,
    required String? minimumVersion,
    required String currentPath,
  }) {
    // No minimum version set - no update required
    if (minimumVersion == null || minimumVersion.isEmpty) {
      return null;
    }

    // Already on force-update page - no redirect
    if (currentPath == '/force-update') {
      return null;
    }

    try {
      final currentVer = _parseVersion(currentVersion);
      final minimumVer = _parseVersion(minimumVersion);

      // Current version is below minimum - require update
      if (_compareVersions(currentVer, minimumVer) < 0) {
        return '/force-update';
      }

      return null;
    } catch (e) {
      throw ForceUpdateException(
        message: 'Failed to parse version: $e',
        currentVersion: currentVersion,
        minimumVersion: minimumVersion,
      );
    }
  }

  /// Parse version string into comparable parts
  List<int> _parseVersion(String version) {
    final parts = version.split('.');
    if (parts.length != 3) {
      throw ArgumentError('Version must be in format x.y.z, got: $version');
    }

    return parts.map((part) {
      final parsed = int.tryParse(part);
      if (parsed == null) {
        throw ArgumentError('Invalid version part: $part');
      }
      return parsed;
    }).toList();
  }

  /// Compare two version lists
  /// Returns: < 0 if version1 < version2, 0 if equal, > 0 if version1 > version2
  int _compareVersions(List<int> version1, List<int> version2) {
    for (int i = 0; i < 3; i++) {
      final diff = version1[i] - version2[i];
      if (diff != 0) return diff;
    }
    return 0;
  }
}
