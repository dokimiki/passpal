import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:version/version.dart';

/// Provider for RemoteKillSwitch
final remoteKillSwitchProvider = Provider<RemoteKillSwitch>((ref) {
  return RemoteKillSwitch(FirebaseRemoteConfig.instance);
});

/// Manages Remote Config-based kill switches and feature flags
class RemoteKillSwitch {
  RemoteKillSwitch(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;
  final Map<String, _CacheEntry> _cache = {};

  static const Duration _cacheDuration = Duration(minutes: 15);

  /// Check if a parser is disabled via Remote Config
  Future<bool> isParserDisabled(String parserId) async {
    final key = 'disable_$parserId';
    return _getCachedBool(key);
  }

  /// Check if a force update is required based on current version
  Future<bool> isForceUpdateRequired(String currentVersion) async {
    try {
      await _fetchIfNeeded();
      final minVersionString = _remoteConfig.getString(
        'force_update_min_version',
      );

      if (minVersionString.isEmpty) return false;

      final currentVer = Version.parse(currentVersion);
      final minVer = Version.parse(minVersionString);

      return currentVer < minVer;
    } catch (e) {
      // If version parsing fails, don't force update
      return false;
    }
  }

  /// Get a feature flag value
  Future<bool> getFeatureFlag(String flagName) async {
    return _getCachedBool(flagName);
  }

  /// Get a configuration string value
  Future<String> getConfigString(String key) async {
    try {
      await _fetchIfNeeded();
      return _remoteConfig.getString(key);
    } catch (e) {
      return '';
    }
  }

  /// Clear the cache (for testing)
  void clearCache() {
    _cache.clear();
  }

  /// Get a boolean value with caching
  Future<bool> _getCachedBool(String key) async {
    final cacheEntry = _cache[key];

    if (cacheEntry != null && !cacheEntry.isExpired) {
      return cacheEntry.value as bool;
    }

    try {
      await _fetchIfNeeded();
      final value = _remoteConfig.getBool(key);
      _cache[key] = _CacheEntry(value, DateTime.now().add(_cacheDuration));
      return value;
    } catch (e) {
      // Return cached value if available, otherwise false
      return (cacheEntry?.value as bool?) ?? false;
    }
  }

  /// Fetch Remote Config if needed
  Future<void> _fetchIfNeeded() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      // Silently fail to use cached values
    }
  }
}

/// Internal cache entry for Remote Config values
class _CacheEntry {
  _CacheEntry(this.value, this.expiry);

  final dynamic value;
  final DateTime expiry;

  bool get isExpired => DateTime.now().isAfter(expiry);
}
