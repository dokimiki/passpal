import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';

import '../interfaces/cache_storage_interface.dart';
import '../interfaces/preference_storage_interface.dart';
import '../interfaces/secure_storage_interface.dart';
import '../models/preference_types.dart';
import 'storage_test_utils.dart';

/// Performance testing utilities for storage operations
class StoragePerformanceTestUtils {
  /// Benchmark storage operations and measure performance
  static Future<PerformanceBenchmarkResult> benchmarkStorage({
    SecureStorageInterface? secureStorage,
    CacheStorageInterface? cacheStorage,
    PreferenceStorageInterface? preferenceStorage,
    int iterations = 1000,
    int concurrency = 10,
  }) async {
    final results = <String, PerformanceMetrics>{};

    // Use provided storages or create test ones
    final testSecure =
        secureStorage ?? StorageTestUtils.createTestSecureStorage();
    final testCache = cacheStorage ?? StorageTestUtils.createTestCacheStorage();
    final testPreference =
        preferenceStorage ?? StorageTestUtils.createTestPreferenceStorage();

    // Benchmark secure storage operations
    results['secure_write'] = await _benchmarkSecureWrite(
      testSecure,
      iterations,
      concurrency,
    );
    results['secure_read'] = await _benchmarkSecureRead(
      testSecure,
      iterations,
      concurrency,
    );
    results['secure_delete'] = await _benchmarkSecureDelete(
      testSecure,
      iterations,
      concurrency,
    );

    // Benchmark cache storage operations
    results['cache_write'] = await _benchmarkCacheWrite(
      testCache,
      iterations,
      concurrency,
    );
    results['cache_read'] = await _benchmarkCacheRead(
      testCache,
      iterations,
      concurrency,
    );
    results['cache_swr'] = await _benchmarkCacheSwr(
      testCache,
      iterations ~/ 10,
      concurrency,
    ); // Fewer iterations for SWR

    // Benchmark preference storage operations
    results['preference_write'] = await _benchmarkPreferenceWrite(
      testPreference,
      iterations,
      concurrency,
    );
    results['preference_read'] = await _benchmarkPreferenceRead(
      testPreference,
      iterations,
      concurrency,
    );

    return PerformanceBenchmarkResult(
      iterations: iterations,
      concurrency: concurrency,
      metrics: results,
    );
  }

  /// Benchmark secure storage write operations
  static Future<PerformanceMetrics> _benchmarkSecureWrite(
    SecureStorageInterface storage,
    int iterations,
    int concurrency,
  ) async {
    return _benchmarkOperation('Secure Write', iterations, concurrency, (
      int index,
    ) async {
      await storage.write('benchmark_key_$index', 'benchmark_value_$index');
    });
  }

  /// Benchmark secure storage read operations
  static Future<PerformanceMetrics> _benchmarkSecureRead(
    SecureStorageInterface storage,
    int iterations,
    int concurrency,
  ) async {
    // Pre-populate with test data
    for (int i = 0; i < iterations; i++) {
      await storage.write('read_benchmark_$i', 'value_$i');
    }

    return _benchmarkOperation('Secure Read', iterations, concurrency, (
      int index,
    ) async {
      await storage.read('read_benchmark_$index');
    });
  }

  /// Benchmark secure storage delete operations
  static Future<PerformanceMetrics> _benchmarkSecureDelete(
    SecureStorageInterface storage,
    int iterations,
    int concurrency,
  ) async {
    // Pre-populate with test data
    for (int i = 0; i < iterations; i++) {
      await storage.write('delete_benchmark_$i', 'value_$i');
    }

    return _benchmarkOperation('Secure Delete', iterations, concurrency, (
      int index,
    ) async {
      await storage.delete('delete_benchmark_$index');
    });
  }

  /// Benchmark cache storage write operations
  static Future<PerformanceMetrics> _benchmarkCacheWrite(
    CacheStorageInterface storage,
    int iterations,
    int concurrency,
  ) async {
    return _benchmarkOperation('Cache Write', iterations, concurrency, (
      int index,
    ) async {
      await storage.set(
        'cache_benchmark_$index',
        'cache_value_$index',
        ttl: const Duration(minutes: 5),
      );
    });
  }

  /// Benchmark cache storage read operations
  static Future<PerformanceMetrics> _benchmarkCacheRead(
    CacheStorageInterface storage,
    int iterations,
    int concurrency,
  ) async {
    // Pre-populate with test data
    for (int i = 0; i < iterations; i++) {
      await storage.set('cache_read_benchmark_$i', 'value_$i');
    }

    return _benchmarkOperation('Cache Read', iterations, concurrency, (
      int index,
    ) async {
      await storage.get('cache_read_benchmark_$index');
    });
  }

  /// Benchmark cache SWR operations
  static Future<PerformanceMetrics> _benchmarkCacheSwr(
    CacheStorageInterface storage,
    int iterations,
    int concurrency,
  ) async {
    // Pre-populate with stale data
    for (int i = 0; i < iterations; i++) {
      await storage.set(
        'swr_benchmark_$i',
        'stale_value_$i',
        ttl: const Duration(milliseconds: 1), // Immediately stale
      );
    }

    // Wait for data to become stale
    await Future.delayed(const Duration(milliseconds: 10));

    return _benchmarkOperation('Cache SWR', iterations, concurrency, (
      int index,
    ) async {
      await storage.swr('swr_benchmark_$index', () async {
        // Simulate network delay
        await Future.delayed(const Duration(milliseconds: 1));
        return 'fresh_value_$index';
      });
    });
  }

  /// Benchmark preference storage write operations
  static Future<PerformanceMetrics> _benchmarkPreferenceWrite(
    PreferenceStorageInterface storage,
    int iterations,
    int concurrency,
  ) async {
    return _benchmarkOperation('Preference Write', iterations, concurrency, (
      int index,
    ) async {
      final key = PreferenceKey<String>(
        key: 'benchmark_pref_$index',
        defaultValue: '',
        serializer: (value) => value,
        deserializer: (value) => value,
      );
      await storage.set(key, 'preference_value_$index');
    });
  }

  /// Benchmark preference storage read operations
  static Future<PerformanceMetrics> _benchmarkPreferenceRead(
    PreferenceStorageInterface storage,
    int iterations,
    int concurrency,
  ) async {
    // Pre-populate with test data
    final keys = <PreferenceKey<String>>[];
    for (int i = 0; i < iterations; i++) {
      final key = PreferenceKey<String>(
        key: 'read_benchmark_pref_$i',
        defaultValue: '',
        serializer: (value) => value,
        deserializer: (value) => value,
      );
      keys.add(key);
      await storage.set(key, 'value_$i');
    }

    return _benchmarkOperation('Preference Read', iterations, concurrency, (
      int index,
    ) async {
      await storage.get(keys[index]);
    });
  }

  /// Generic operation benchmarking utility
  static Future<PerformanceMetrics> _benchmarkOperation(
    String operationName,
    int iterations,
    int concurrency,
    Future<void> Function(int index) operation,
  ) async {
    final durations = <Duration>[];
    final errors = <Object>[];
    final stopwatch = Stopwatch();

    stopwatch.start();

    // Run operations in batches to control concurrency
    final batchSize = concurrency;
    final batches = (iterations / batchSize).ceil();

    for (int batch = 0; batch < batches; batch++) {
      final startIndex = batch * batchSize;
      final endIndex = math.min(startIndex + batchSize, iterations);

      final futures = <Future<void>>[];

      for (int i = startIndex; i < endIndex; i++) {
        final operationStopwatch = Stopwatch()..start();

        futures.add(
          operation(i)
              .then((_) {
                operationStopwatch.stop();
                durations.add(operationStopwatch.elapsed);
              })
              .catchError((error) {
                operationStopwatch.stop();
                durations.add(operationStopwatch.elapsed);
                errors.add(error);
              }),
        );
      }

      await Future.wait(futures);
    }

    stopwatch.stop();

    return PerformanceMetrics(
      operationName: operationName,
      totalTime: stopwatch.elapsed,
      totalOperations: iterations,
      successfulOperations: iterations - errors.length,
      failedOperations: errors.length,
      durations: durations,
      errors: errors,
    );
  }

  /// Stress test storage with high load
  static Future<StressTestResult> stressTestStorage({
    required StorageTestScenario scenario,
    int durationSeconds = 30,
    int concurrency = 50,
    double operationMix = 0.7, // 70% reads, 30% writes
  }) async {
    final random = math.Random();
    final operations = <Future<StressTestOperation>>[];
    final startTime = DateTime.now();
    final endTime = startTime.add(Duration(seconds: durationSeconds));

    // Pre-populate with some data
    for (int i = 0; i < 100; i++) {
      await scenario.secureStorage.write('stress_secure_$i', 'value_$i');
      await scenario.cacheStorage.set('stress_cache_$i', 'value_$i');
      await scenario.preferenceStorage.set(
        PreferenceKey<String>(
          key: 'stress_pref_$i',
          defaultValue: '',
          serializer: (value) => value,
          deserializer: (value) => value,
        ),
        'value_$i',
      );
    }

    int operationCounter = 0;

    // Start stress test
    while (DateTime.now().isBefore(endTime) &&
        operations.length < concurrency) {
      operations.add(
        _performRandomOperation(
          scenario,
          random,
          operationMix,
          operationCounter++,
        ),
      );

      // Maintain concurrency level
      if (operations.length >= concurrency) {
        final completed = await Future.any(
          operations.map((op) => op.then((result) => operations.indexOf(op))),
        );
        operations.removeAt(completed);
      }
    }

    // Wait for remaining operations to complete
    final results = await Future.wait(operations);

    return StressTestResult(
      duration: Duration(seconds: durationSeconds),
      totalOperations: results.length,
      successfulOperations: results.where((r) => r.success).length,
      failedOperations: results.where((r) => !r.success).length,
      averageLatency: _calculateAverageLatency(results),
      maxLatency: _calculateMaxLatency(results),
      operationsPerSecond: results.length / durationSeconds,
    );
  }

  /// Perform a random storage operation for stress testing
  static Future<StressTestOperation> _performRandomOperation(
    StorageTestScenario scenario,
    math.Random random,
    double readMixRatio,
    int operationId,
  ) async {
    final isRead = random.nextDouble() < readMixRatio;
    final storageType = random.nextInt(3); // 0: secure, 1: cache, 2: preference
    final key = 'stress_${storageType}_${random.nextInt(100)}';

    final stopwatch = Stopwatch()..start();

    try {
      if (isRead) {
        // Perform read operation
        switch (storageType) {
          case 0: // Secure storage
            await scenario.secureStorage.read(key);
            break;
          case 1: // Cache storage
            await scenario.cacheStorage.get(key);
            break;
          case 2: // Preference storage
            final prefKey = PreferenceKey<String>(
              key: key,
              defaultValue: '',
              serializer: (value) => value,
              deserializer: (value) => value,
            );
            await scenario.preferenceStorage.get(prefKey);
            break;
        }
      } else {
        // Perform write operation
        final value = 'stress_value_$operationId';
        switch (storageType) {
          case 0: // Secure storage
            await scenario.secureStorage.write(key, value);
            break;
          case 1: // Cache storage
            await scenario.cacheStorage.set(key, value);
            break;
          case 2: // Preference storage
            final prefKey = PreferenceKey<String>(
              key: key,
              defaultValue: '',
              serializer: (val) => val,
              deserializer: (val) => val,
            );
            await scenario.preferenceStorage.set(prefKey, value);
            break;
        }
      }

      stopwatch.stop();
      return StressTestOperation(
        operationId: operationId,
        operationType: isRead ? 'read' : 'write',
        storageType: ['secure', 'cache', 'preference'][storageType],
        duration: stopwatch.elapsed,
        success: true,
      );
    } catch (error) {
      stopwatch.stop();
      return StressTestOperation(
        operationId: operationId,
        operationType: isRead ? 'read' : 'write',
        storageType: ['secure', 'cache', 'preference'][storageType],
        duration: stopwatch.elapsed,
        success: false,
        error: error.toString(),
      );
    }
  }

  /// Calculate average latency from stress test results
  static Duration _calculateAverageLatency(List<StressTestOperation> results) {
    if (results.isEmpty) return Duration.zero;

    final totalMicroseconds = results
        .map((r) => r.duration.inMicroseconds)
        .reduce((a, b) => a + b);

    return Duration(microseconds: totalMicroseconds ~/ results.length);
  }

  /// Calculate maximum latency from stress test results
  static Duration _calculateMaxLatency(List<StressTestOperation> results) {
    if (results.isEmpty) return Duration.zero;

    return results
        .map((r) => r.duration)
        .reduce((a, b) => a.inMicroseconds > b.inMicroseconds ? a : b);
  }

  /// Memory usage testing for cache storage
  static Future<MemoryUsageResult> testCacheMemoryUsage({
    required CacheStorageInterface cacheStorage,
    int maxEntries = 10000,
    int entrySizeBytes = 1024,
  }) async {
    final results = <MemoryUsageDataPoint>[];
    final random = math.Random();

    // Generate test data of specified size
    final testData = String.fromCharCodes(
      List.generate(entrySizeBytes, (_) => random.nextInt(256)),
    );

    for (int i = 0; i < maxEntries; i += 100) {
      // Add 100 entries at a time
      for (int j = 0; j < 100 && (i + j) < maxEntries; j++) {
        await cacheStorage.set('memory_test_${i + j}', testData);
      }

      // Get cache stats
      final statsResult = await cacheStorage.getStats();
      statsResult.fold((failure) => {}, (stats) {
        results.add(
          MemoryUsageDataPoint(
            entryCount: i + 100,
            totalSizeBytes: stats.totalSize,
            capacityUsage: stats.capacityUsage,
            hitRate: stats.hitRate,
          ),
        );
      });

      // Small delay to allow cleanup operations
      if (i % 1000 == 0) {
        await Future.delayed(const Duration(milliseconds: 10));
      }
    }

    return MemoryUsageResult(
      maxEntries: maxEntries,
      entrySizeBytes: entrySizeBytes,
      dataPoints: results,
    );
  }
}

/// Performance metrics for a storage operation
class PerformanceMetrics {
  const PerformanceMetrics({
    required this.operationName,
    required this.totalTime,
    required this.totalOperations,
    required this.successfulOperations,
    required this.failedOperations,
    required this.durations,
    required this.errors,
  });

  final String operationName;
  final Duration totalTime;
  final int totalOperations;
  final int successfulOperations;
  final int failedOperations;
  final List<Duration> durations;
  final List<Object> errors;

  double get operationsPerSecond => totalOperations / totalTime.inSeconds;
  double get successRate => successfulOperations / totalOperations;
  Duration get averageLatency => Duration(
    microseconds: durations.isEmpty
        ? 0
        : durations.map((d) => d.inMicroseconds).reduce((a, b) => a + b) ~/
              durations.length,
  );
  Duration get maxLatency => durations.isEmpty
      ? Duration.zero
      : durations.reduce((a, b) => a.inMicroseconds > b.inMicroseconds ? a : b);
  Duration get minLatency => durations.isEmpty
      ? Duration.zero
      : durations.reduce((a, b) => a.inMicroseconds < b.inMicroseconds ? a : b);

  @override
  String toString() {
    return '$operationName: ${operationsPerSecond.toStringAsFixed(1)} ops/sec, '
        '${(successRate * 100).toStringAsFixed(1)}% success rate, '
        'avg: ${averageLatency.inMilliseconds}ms, '
        'max: ${maxLatency.inMilliseconds}ms';
  }
}

/// Benchmark result containing all performance metrics
class PerformanceBenchmarkResult {
  const PerformanceBenchmarkResult({
    required this.iterations,
    required this.concurrency,
    required this.metrics,
  });

  final int iterations;
  final int concurrency;
  final Map<String, PerformanceMetrics> metrics;

  @override
  String toString() {
    final buffer = StringBuffer(
      'Performance Benchmark ($iterations iterations, $concurrency concurrency):\n',
    );

    for (final entry in metrics.entries) {
      buffer.writeln('  ${entry.value}');
    }

    return buffer.toString();
  }
}

/// Stress test result
class StressTestResult {
  const StressTestResult({
    required this.duration,
    required this.totalOperations,
    required this.successfulOperations,
    required this.failedOperations,
    required this.averageLatency,
    required this.maxLatency,
    required this.operationsPerSecond,
  });

  final Duration duration;
  final int totalOperations;
  final int successfulOperations;
  final int failedOperations;
  final Duration averageLatency;
  final Duration maxLatency;
  final double operationsPerSecond;

  double get successRate => successfulOperations / totalOperations;
  double get errorRate => failedOperations / totalOperations;

  @override
  String toString() {
    return 'Stress Test (${duration.inSeconds}s): '
        '${operationsPerSecond.toStringAsFixed(1)} ops/sec, '
        '${(successRate * 100).toStringAsFixed(1)}% success rate, '
        'avg latency: ${averageLatency.inMilliseconds}ms';
  }
}

/// Individual stress test operation
class StressTestOperation {
  const StressTestOperation({
    required this.operationId,
    required this.operationType,
    required this.storageType,
    required this.duration,
    required this.success,
    this.error,
  });

  final int operationId;
  final String operationType;
  final String storageType;
  final Duration duration;
  final bool success;
  final String? error;
}

/// Memory usage test result
class MemoryUsageResult {
  const MemoryUsageResult({
    required this.maxEntries,
    required this.entrySizeBytes,
    required this.dataPoints,
  });

  final int maxEntries;
  final int entrySizeBytes;
  final List<MemoryUsageDataPoint> dataPoints;

  /// Get peak memory usage
  int get peakMemoryUsage => dataPoints.isEmpty
      ? 0
      : dataPoints.map((d) => d.totalSizeBytes).reduce(math.max);

  /// Get memory usage efficiency (entries per MB)
  double get memoryEfficiency {
    if (dataPoints.isEmpty) return 0.0;
    final lastPoint = dataPoints.last;
    return lastPoint.entryCount / (lastPoint.totalSizeBytes / (1024 * 1024));
  }

  @override
  String toString() {
    return 'Memory Usage Test: $maxEntries entries × ${entrySizeBytes}B, '
        'peak: ${(peakMemoryUsage / (1024 * 1024)).toStringAsFixed(1)}MB, '
        'efficiency: ${memoryEfficiency.toStringAsFixed(1)} entries/MB';
  }
}

/// Memory usage data point
class MemoryUsageDataPoint {
  const MemoryUsageDataPoint({
    required this.entryCount,
    required this.totalSizeBytes,
    required this.capacityUsage,
    required this.hitRate,
  });

  final int entryCount;
  final int totalSizeBytes;
  final double capacityUsage;
  final double hitRate;
}
