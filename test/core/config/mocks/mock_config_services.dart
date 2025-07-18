import 'dart:async';

import 'package:mockito/mockito.dart';

import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/services/config_cache.dart';
import 'package:passpal/core/config/services/config_merger.dart';
import 'package:passpal/core/config/services/config_update_monitor.dart';
import 'package:passpal/core/config/services/config_validation.dart';
import 'mock_config_providers.dart';

/// Mock configuration cache for testing
class MockConfigCache extends ConfigCache {
  AppConfig? _cachedConfig;
  DateTime? _cacheTime;
  final StreamController<AppConfig?> _updateController =
      StreamController<AppConfig?>.broadcast();

  @override
  AppConfig? get cachedConfig => _cachedConfig;

  DateTime? get cacheTime => _cacheTime;

  @override
  bool get isCacheValid {
    if (_cachedConfig == null || _cacheTime == null) return false;
    return DateTime.now().difference(_cacheTime!).inMinutes < 15;
  }

  @override
  void cacheConfig(AppConfig config) {
    _cachedConfig = config;
    _cacheTime = DateTime.now();
    _updateController.add(config);
  }

  @override
  void invalidateCache() {
    _cachedConfig = null;
    _cacheTime = null;
    _updateController.add(null);
  }

  @override
  Stream<AppConfig?> get cacheUpdateStream => _updateController.stream;

  /// Set mock cached configuration
  void setMockCachedConfig(AppConfig config, {DateTime? cacheTime}) {
    _cachedConfig = config;
    _cacheTime = cacheTime ?? DateTime.now();
  }

  /// Set mock cache time
  void setMockCacheTime(DateTime time) {
    _cacheTime = time;
  }

  /// Clear mock cache
  void clearMockCache() {
    _cachedConfig = null;
    _cacheTime = null;
  }

  /// Dispose of mock cache
  @override
  void dispose() {
    _updateController.close();
  }
}

/// Mock configuration merger for testing
class MockConfigMerger extends ConfigMerger {
  AppConfig? _mockConfig;
  bool _shouldThrowError = false;
  String? _errorMessage;

  MockConfigMerger({
    required super.envConfigSource,
    required super.remoteConfigSource,
  });

  @override
  Future<AppConfig> mergeConfigs() async {
    if (_shouldThrowError) {
      throw Exception(_errorMessage ?? 'Mock merge error');
    }

    // Simulate merge delay
    await Future.delayed(const Duration(milliseconds: 50));

    return _mockConfig ?? getTestConfig();
  }

  /// Set mock configuration result
  void setMockConfig(AppConfig config) {
    _mockConfig = config;
  }

  /// Set error state
  void setErrorState(bool shouldThrow, [String? errorMessage]) {
    _shouldThrowError = shouldThrow;
    _errorMessage = errorMessage;
  }

  /// Clear mock configuration
  void clearMockConfig() {
    _mockConfig = null;
  }
}

/// Mock configuration update monitor for testing
class MockConfigUpdateMonitor extends Mock implements ConfigUpdateMonitor {
  final StreamController<AppConfig?> _updateController =
      StreamController<AppConfig?>.broadcast();
  bool _isMonitoring = false;
  AppConfig? _lastConfig;

  Stream<AppConfig?> get updateStream => _updateController.stream;

  bool get isMonitoring => _isMonitoring;

  @override
  Future<void> startMonitoring() async {
    _isMonitoring = true;
  }

  @override
  Future<void> stopMonitoring() async {
    _isMonitoring = false;
  }

  @override
  Future<void> dispose() async {
    _updateController.close();
  }

  /// Simulate configuration update
  void simulateConfigUpdate(AppConfig config) {
    _lastConfig = config;
    _updateController.add(config);
  }

  /// Simulate configuration clear
  void simulateConfigClear() {
    _lastConfig = null;
    _updateController.add(null);
  }

  /// Get last configuration
  AppConfig? get lastConfig => _lastConfig;
}

/// Mock configuration validation service for testing
class MockConfigValidation extends ConfigValidation {
  final List<String> _validationErrors = [];
  bool _shouldThrowError = false;
  String? _errorMessage;

  Future<bool> validateConfig(AppConfig config) async {
    if (_shouldThrowError) {
      throw Exception(_errorMessage ?? 'Mock validation error');
    }

    // Simulate validation delay
    await Future.delayed(const Duration(milliseconds: 10));

    return _validationErrors.isEmpty;
  }

  List<String> getValidationErrors(AppConfig config) {
    return List.from(_validationErrors);
  }

  /// Add mock validation error
  void addValidationError(String error) {
    _validationErrors.add(error);
  }

  /// Remove mock validation error
  void removeValidationError(String error) {
    _validationErrors.remove(error);
  }

  /// Clear all validation errors
  void clearValidationErrors() {
    _validationErrors.clear();
  }

  /// Set error state
  void setErrorState(bool shouldThrow, [String? errorMessage]) {
    _shouldThrowError = shouldThrow;
    _errorMessage = errorMessage;
  }

  /// Get validation error count
  int get validationErrorCount => _validationErrors.length;
}

/// Factory class for creating mock configuration services
class MockConfigServiceFactory {
  /// Create mock configuration cache
  static MockConfigCache createCache({
    AppConfig? cachedConfig,
    DateTime? cacheTime,
  }) {
    final cache = MockConfigCache();
    if (cachedConfig != null) {
      cache.setMockCachedConfig(cachedConfig, cacheTime: cacheTime);
    }
    return cache;
  }

  /// Create expired mock configuration cache
  static MockConfigCache createExpiredCache() {
    final cache = MockConfigCache();
    cache.setMockCachedConfig(
      getTestConfig(),
      cacheTime: DateTime.now().subtract(const Duration(minutes: 20)),
    );
    return cache;
  }

  /// Create mock configuration merger
  static MockConfigMerger createMerger({
    required dynamic envConfigSource,
    required dynamic remoteConfigSource,
    AppConfig? mockConfig,
    bool shouldThrowError = false,
    String? errorMessage,
  }) {
    final merger = MockConfigMerger(
      envConfigSource: envConfigSource,
      remoteConfigSource: remoteConfigSource,
    );

    if (mockConfig != null) {
      merger.setMockConfig(mockConfig);
    }

    if (shouldThrowError) {
      merger.setErrorState(true, errorMessage);
    }

    return merger;
  }

  /// Create mock configuration update monitor
  static MockConfigUpdateMonitor createUpdateMonitor() {
    return MockConfigUpdateMonitor();
  }

  /// Create mock configuration validation service
  static MockConfigValidation createValidation({
    List<String>? validationErrors,
    bool shouldThrowError = false,
    String? errorMessage,
  }) {
    final validation = MockConfigValidation();

    if (validationErrors != null) {
      for (final error in validationErrors) {
        validation.addValidationError(error);
      }
    }

    if (shouldThrowError) {
      validation.setErrorState(true, errorMessage);
    }

    return validation;
  }
}
