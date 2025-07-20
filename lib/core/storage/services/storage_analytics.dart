/// Storage Analytics Service
///
/// Provides Firebase Analytics integration for storage operations,
/// performance monitoring, and privacy-safe tracking of storage usage patterns.
///
/// Features:
/// - Event tracking for storage operations
/// - Performance metrics collection
/// - Cache hit rate monitoring
/// - Privacy-safe key hashing
/// - Error rate tracking
/// - Storage capacity monitoring
library;

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// Storage operation types for analytics
enum StorageOperationType { read, write, delete, clear, migrate, invalidate }

/// Storage subsystem types
enum StorageSubsystem { secure, cache, preference, credential }

/// Performance metrics for storage operations
class StoragePerformanceMetrics {
  final Duration latency;
  final int? dataSize;
  final bool success;
  final String? errorType;

  const StoragePerformanceMetrics({
    required this.latency,
    this.dataSize,
    required this.success,
    this.errorType,
  });
}

/// Cache performance metrics
class CacheMetrics {
  final int hitCount;
  final int missCount;
  final int totalRequests;
  final double hitRate;
  final Duration averageLatency;
  final int totalDataSize;

  const CacheMetrics({
    required this.hitCount,
    required this.missCount,
    required this.totalRequests,
    required this.hitRate,
    required this.averageLatency,
    required this.totalDataSize,
  });

  Map<String, dynamic> toAnalyticsParameters() => {
    'cache_hit_count': hitCount,
    'cache_miss_count': missCount,
    'cache_total_requests': totalRequests,
    'cache_hit_rate': (hitRate * 100).round(),
    'cache_avg_latency_ms': averageLatency.inMilliseconds,
    'cache_total_size_kb': (totalDataSize / 1024).round(),
  };
}

/// Storage Analytics Service
///
/// Tracks storage operations and performance metrics with Firebase Analytics
/// while maintaining user privacy through key hashing and data aggregation.
class StorageAnalytics {
  final FirebaseAnalytics _analytics;
  final Map<String, int> _operationCounts = {};
  final Map<String, List<Duration>> _operationLatencies = {};
  final Map<String, int> _errorCounts = {};

  // Cache metrics tracking
  int _cacheHits = 0;
  int _cacheMisses = 0;
  final List<Duration> _cacheLatencies = [];
  int _totalCacheDataSize = 0;

  StorageAnalytics(this._analytics);

  /// Create privacy-safe hash of storage key for analytics
  String _hashKey(String key) {
    final bytes = utf8.encode(key);
    final digest = sha256.convert(bytes);
    // Use first 8 characters for analytics (sufficient for grouping, safe for privacy)
    return digest.toString().substring(0, 8);
  }

  /// Generate operation identifier for analytics
  String _operationId(
    StorageSubsystem subsystem,
    StorageOperationType operation,
  ) {
    return '${subsystem.name}_${operation.name}';
  }

  /// Track storage operation with performance metrics
  Future<void> trackOperation({
    required StorageSubsystem subsystem,
    required StorageOperationType operation,
    required StoragePerformanceMetrics metrics,
    String? key,
    Map<String, dynamic>? customParameters,
  }) async {
    try {
      final operationId = _operationId(subsystem, operation);

      // Update internal counters
      _operationCounts[operationId] = (_operationCounts[operationId] ?? 0) + 1;
      _operationLatencies[operationId] ??= [];
      _operationLatencies[operationId]!.add(metrics.latency);

      if (!metrics.success && metrics.errorType != null) {
        final errorKey = '${operationId}_${metrics.errorType}';
        _errorCounts[errorKey] = (_errorCounts[errorKey] ?? 0) + 1;
      }

      // Prepare analytics parameters
      final parameters = <String, dynamic>{
        'subsystem': subsystem.name,
        'operation': operation.name,
        'success': metrics.success,
        'latency_ms': metrics.latency.inMilliseconds,
      };

      if (metrics.dataSize != null) {
        parameters['data_size_bytes'] = metrics.dataSize;
      }

      if (metrics.errorType != null) {
        parameters['error_type'] = metrics.errorType;
      }

      if (key != null) {
        parameters['key_hash'] = _hashKey(key);
      }

      // Add custom parameters
      if (customParameters != null) {
        parameters.addAll(customParameters);
      }

      // Send to Firebase Analytics
      await _analytics.logEvent(
        name: 'storage_operation',
        parameters: Map<String, Object>.from(parameters),
      );

      // Track cache-specific metrics
      if (subsystem == StorageSubsystem.cache) {
        _trackCacheOperation(operation, metrics);
      }
    } catch (e) {
      // Silent fail - analytics shouldn't break app functionality
      // Could log to crashlytics here if needed
    }
  }

  /// Track cache-specific operation metrics
  void _trackCacheOperation(
    StorageOperationType operation,
    StoragePerformanceMetrics metrics,
  ) {
    switch (operation) {
      case StorageOperationType.read:
        if (metrics.success) {
          _cacheHits++;
        } else {
          _cacheMisses++;
        }
        _cacheLatencies.add(metrics.latency);
        break;
      case StorageOperationType.write:
        if (metrics.dataSize != null) {
          _totalCacheDataSize += metrics.dataSize!;
        }
        break;
      default:
        break;
    }
  }

  /// Track storage error with context
  Future<void> trackError({
    required StorageSubsystem subsystem,
    required StorageOperationType operation,
    required Exception error,
    String? key,
    Map<String, dynamic>? context,
  }) async {
    try {
      final parameters = <String, dynamic>{
        'subsystem': subsystem.name,
        'operation': operation.name,
        'error_type': error.runtimeType.toString(),
        'error_message': error.toString(),
      };

      if (key != null) {
        parameters['key_hash'] = _hashKey(key);
      }

      if (context != null) {
        // Only include safe context data
        final safeContext = context.entries
            .where((entry) => _isSafeForAnalytics(entry.value))
            .take(5) // Limit context size
            .map((entry) => MapEntry('context_${entry.key}', entry.value));
        parameters.addAll(Map.fromEntries(safeContext));
      }

      await _analytics.logEvent(
        name: 'storage_error',
        parameters: Map<String, Object>.from(parameters),
      );
    } catch (e) {
      // Silent fail
    }
  }

  /// Check if value is safe to include in analytics
  bool _isSafeForAnalytics(dynamic value) {
    if (value == null) return true;
    if (value is bool || value is num) return true;
    if (value is String) {
      // Avoid sending potentially sensitive strings
      return value.length < 50 && !_containsSensitivePattern(value);
    }
    return false;
  }

  /// Check for sensitive patterns in strings
  bool _containsSensitivePattern(String value) {
    final lowerValue = value.toLowerCase();
    final sensitivePatterns = [
      'password',
      'token',
      'key',
      'secret',
      'auth',
      'credential',
      'session',
      'cookie',
      'bearer',
    ];
    return sensitivePatterns.any((pattern) => lowerValue.contains(pattern));
  }

  /// Get current cache metrics
  CacheMetrics getCacheMetrics() {
    final totalRequests = _cacheHits + _cacheMisses;
    final hitRate = totalRequests > 0 ? _cacheHits / totalRequests : 0.0;

    final avgLatency = _cacheLatencies.isNotEmpty
        ? Duration(
            microseconds:
                _cacheLatencies
                    .map((d) => d.inMicroseconds)
                    .reduce((a, b) => a + b) ~/
                _cacheLatencies.length,
          )
        : Duration.zero;

    return CacheMetrics(
      hitCount: _cacheHits,
      missCount: _cacheMisses,
      totalRequests: totalRequests,
      hitRate: hitRate,
      averageLatency: avgLatency,
      totalDataSize: _totalCacheDataSize,
    );
  }

  /// Send periodic performance report
  Future<void> sendPerformanceReport() async {
    try {
      final cacheMetrics = getCacheMetrics();

      // Send cache performance metrics
      await _analytics.logEvent(
        name: 'storage_performance_report',
        parameters: Map<String, Object>.from({
          'report_type': 'cache_performance',
          ...cacheMetrics.toAnalyticsParameters(),
        }),
      );

      // Send operation summary
      if (_operationCounts.isNotEmpty) {
        await _analytics.logEvent(
          name: 'storage_performance_report',
          parameters: Map<String, Object>.from({
            'report_type': 'operation_summary',
            'total_operations': _operationCounts.values.fold<int>(
              0,
              (a, b) => a + b,
            ),
            'unique_operation_types': _operationCounts.length,
            'total_errors': _errorCounts.values.fold(0, (a, b) => a + b),
          }),
        );
      }

      // Send latency percentiles for each operation type
      for (final entry in _operationLatencies.entries) {
        if (entry.value.isNotEmpty) {
          final latencies = entry.value.map((d) => d.inMilliseconds).toList()
            ..sort();
          await _analytics.logEvent(
            name: 'storage_latency_report',
            parameters: Map<String, Object>.from({
              'operation_type': entry.key,
              'sample_count': latencies.length,
              'median_ms': _percentile(latencies, 0.5).round(),
              'p95_ms': _percentile(latencies, 0.95).round(),
              'p99_ms': _percentile(latencies, 0.99).round(),
            }),
          );
        }
      }
    } catch (e) {
      // Silent fail
    }
  }

  /// Calculate percentile from sorted list
  double _percentile(List<int> sortedList, double percentile) {
    if (sortedList.isEmpty) return 0;
    final index = (sortedList.length * percentile).ceil() - 1;
    return sortedList[max(0, min(index, sortedList.length - 1))].toDouble();
  }

  /// Reset metrics (useful for testing or periodic resets)
  void resetMetrics() {
    _operationCounts.clear();
    _operationLatencies.clear();
    _errorCounts.clear();
    _cacheHits = 0;
    _cacheMisses = 0;
    _cacheLatencies.clear();
    _totalCacheDataSize = 0;
  }

  /// Track storage capacity usage
  Future<void> trackCapacityUsage({
    required StorageSubsystem subsystem,
    required int usedBytes,
    required int totalBytes,
    int? itemCount,
  }) async {
    try {
      final usagePercentage = (usedBytes / totalBytes * 100).round();

      await _analytics.logEvent(
        name: 'storage_capacity',
        parameters: Map<String, Object>.from({
          'subsystem': subsystem.name,
          'used_bytes': usedBytes,
          'total_bytes': totalBytes,
          'usage_percentage': usagePercentage,
          if (itemCount != null) 'item_count': itemCount,
        }),
      );
    } catch (e) {
      // Silent fail
    }
  }

  /// Track migration events
  Future<void> trackMigration({
    required String fromVersion,
    required String toVersion,
    required bool success,
    Duration? duration,
    int? migratedItems,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'storage_migration',
        parameters: Map<String, Object>.from({
          'from_version': fromVersion,
          'to_version': toVersion,
          'success': success,
          if (duration != null) 'duration_ms': duration.inMilliseconds,
          if (migratedItems != null) 'migrated_items': migratedItems,
        }),
      );
    } catch (e) {
      // Silent fail
    }
  }
}
