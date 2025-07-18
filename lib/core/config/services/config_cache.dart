import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_config.dart';

part 'config_cache.g.dart';

/// Memory cache for configuration data with automatic expiration
class ConfigCache {
  static const Duration _cacheExpiration = Duration(minutes: 15);

  AppConfig? _cachedConfig;
  DateTime? _cacheTime;
  final StreamController<AppConfig?> _cacheUpdateController =
      StreamController<AppConfig?>.broadcast();

  /// Get cached configuration if still valid
  AppConfig? get cachedConfig {
    if (_cachedConfig == null || _cacheTime == null) {
      return null;
    }

    if (DateTime.now().difference(_cacheTime!) > _cacheExpiration) {
      // Cache expired, invalidate
      _invalidateCache();
      return null;
    }

    return _cachedConfig;
  }

  /// Check if cache is valid (not expired)
  bool get isCacheValid {
    if (_cachedConfig == null || _cacheTime == null) {
      return false;
    }

    return DateTime.now().difference(_cacheTime!) <= _cacheExpiration;
  }

  /// Get time remaining before cache expires
  Duration? get timeUntilExpiration {
    if (_cacheTime == null) {
      return null;
    }

    final elapsed = DateTime.now().difference(_cacheTime!);
    final remaining = _cacheExpiration - elapsed;

    return remaining.isNegative ? null : remaining;
  }

  /// Cache configuration data
  void cacheConfig(AppConfig config) {
    _cachedConfig = config;
    _cacheTime = DateTime.now();
    _cacheUpdateController.add(config);
  }

  /// Manually invalidate cache
  void invalidateCache() {
    _invalidateCache();
  }

  /// Stream of cache updates (config changes or invalidations)
  Stream<AppConfig?> get cacheUpdateStream => _cacheUpdateController.stream;

  /// Private method to invalidate cache
  void _invalidateCache() {
    _cachedConfig = null;
    _cacheTime = null;
    _cacheUpdateController.add(null);
  }

  /// Dispose resources
  void dispose() {
    _cacheUpdateController.close();
  }

  /// Test helper to modify cache time (visible for testing)
  @visibleForTesting
  void setCacheTime(DateTime time) {
    _cacheTime = time;
  }
}

/// Riverpod provider for the config cache
@riverpod
ConfigCache configCache(Ref ref) {
  final cache = ConfigCache();

  // Auto-dispose when provider is disposed
  ref.onDispose(() {
    cache.dispose();
  });

  return cache;
}
