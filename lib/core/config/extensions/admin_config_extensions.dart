import '../models/admin_config.dart';

/// Update requirement enumeration
enum UpdateRequirement {
  /// No update required
  none,

  /// Optional update available
  optional,

  /// Forced update required
  required,
}

/// Extended functionality for AdminConfig
extension AdminConfigExtensions on AdminConfig {
  /// Compare version strings using semantic versioning
  /// Returns:
  /// - 0 if versions are equal
  /// - > 0 if version1 is greater than version2
  /// - < 0 if version1 is less than version2
  static int compareVersions(String version1, String version2) {
    final v1Parts = version1.split('.').map(int.parse).toList();
    final v2Parts = version2.split('.').map(int.parse).toList();

    // Pad shorter version with zeros
    while (v1Parts.length < v2Parts.length) {
      v1Parts.add(0);
    }
    while (v2Parts.length < v1Parts.length) {
      v2Parts.add(0);
    }

    for (int i = 0; i < v1Parts.length; i++) {
      if (v1Parts[i] != v2Parts[i]) {
        return v1Parts[i].compareTo(v2Parts[i]);
      }
    }

    return 0;
  }

  /// Check if a version is valid semantic version format
  static bool isValidVersion(String version) {
    final versionRegex = RegExp(r'^\d+\.\d+\.\d+$');
    return versionRegex.hasMatch(version);
  }

  /// Get update requirement for a given current app version
  UpdateRequirement getUpdateRequirement(String currentVersion) {
    if (!isValidVersion(currentVersion) ||
        !isValidVersion(minSupportedVersion)) {
      return UpdateRequirement.none;
    }

    final comparison = compareVersions(currentVersion, minSupportedVersion);

    if (comparison < 0) {
      return UpdateRequirement.required;
    } else if (compareVersions(currentVersion, appVersion) < 0) {
      return UpdateRequirement.optional;
    } else {
      return UpdateRequirement.none;
    }
  }

  /// Check if forced update is required for current version
  bool isForceUpdateRequired(String currentVersion) {
    return getUpdateRequirement(currentVersion) == UpdateRequirement.required;
  }

  /// Check if optional update is available for current version
  bool isOptionalUpdateAvailable(String currentVersion) {
    return getUpdateRequirement(currentVersion) == UpdateRequirement.optional;
  }

  /// Check if app version is supported
  bool isVersionSupported(String version) {
    if (!isValidVersion(version) || !isValidVersion(minSupportedVersion)) {
      return false;
    }
    return compareVersions(version, minSupportedVersion) >= 0;
  }

  /// Check if the app should be blocked (maintenance mode or unsupported version)
  bool shouldBlockApp(String currentVersion) {
    return isMaintenanceMode || !isVersionSupported(currentVersion);
  }

  /// Get appropriate message for current app state
  String getAppMessage(String currentVersion) {
    if (isMaintenanceMode && maintenanceMessage.isNotEmpty) {
      return maintenanceMessage;
    }

    if (isForceUpdateRequired(currentVersion)) {
      return 'アプリの更新が必要です。最新バージョンをインストールしてください。';
    }

    if (isOptionalUpdateAvailable(currentVersion)) {
      return 'アプリの新しいバージョンが利用可能です。更新をお勧めします。';
    }

    return '';
  }

  /// Check if app can be used normally
  bool canUseApp(String currentVersion) {
    return !shouldBlockApp(currentVersion);
  }

  /// Get the version difference between current and latest
  String getVersionDifference(String currentVersion) {
    if (!isValidVersion(currentVersion) || !isValidVersion(appVersion)) {
      return '';
    }

    final comparison = compareVersions(currentVersion, appVersion);
    if (comparison < 0) {
      return '$currentVersion → $appVersion';
    } else if (comparison > 0) {
      return '$currentVersion (beta)';
    } else {
      return '$currentVersion (latest)';
    }
  }

  /// Create a copy with updated version information
  AdminConfig copyWithVersion({
    String? newAppVersion,
    String? newMinSupportedVersion,
  }) {
    return copyWith(
      appVersion: newAppVersion ?? appVersion,
      minSupportedVersion: newMinSupportedVersion ?? minSupportedVersion,
    );
  }

  /// Create a copy with updated maintenance information
  AdminConfig copyWithMaintenance({bool? maintenance, String? message}) {
    return copyWith(
      isMaintenanceMode: maintenance ?? isMaintenanceMode,
      maintenanceMessage: message ?? maintenanceMessage,
    );
  }
}
