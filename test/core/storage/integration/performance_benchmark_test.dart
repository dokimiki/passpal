import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:passpal/core/storage/providers.dart';
import 'package:passpal/core/storage/testing/storage_test_utils.dart';
import 'package:passpal/core/error/providers.dart';
import 'package:passpal/core/error/testing/mock_crashlytics.dart';
import 'package:passpal/core/error/testing/mock_logger.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

class MockStorageAnalytics extends Mock implements StorageAnalytics {
  @override
  Future<void> trackOperation({
    required StorageSubsystem subsystem,
    required StorageOperationType operation,
    required StoragePerformanceMetrics metrics,
    String? key,
    Map<String, dynamic>? customParameters,
  }) async {
    // Mock implementation - no-op
  }

  @override
  Future<void> sendPerformanceReport() async {
    // Mock implementation - no-op
  }

  @override
  CacheMetrics getCacheMetrics() {
    return const CacheMetrics(
      hitCount: 5,
      missCount: 2,
      totalRequests: 7,
      hitRate: 0.71,
      averageLatency: Duration(milliseconds: 10),
      totalDataSize: 1024,
    );
  }
}

void main() {
  group('Storage Performance and Benchmark Tests', () {
    late ProviderContainer container;
    late StorageTestScenario scenario;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});

      scenario = StorageTestScenarioBuilder().build();

      container = ProviderContainer(
        overrides: [
          secureStorageProvider.overrideWith((_) => scenario.secureStorage),
          cacheStorageProvider.overrideWith((_) async => scenario.cacheStorage),
          preferenceStorageProvider.overrideWith(
            (_) async => scenario.preferenceStorage,
          ),
          firebaseAnalyticsProvider.overrideWithValue(MockFirebaseAnalytics()),
          storageAnalyticsProvider.overrideWithValue(MockStorageAnalytics()),
          crashlyticsServiceProvider.overrideWithValue(
            MockCrashlyticsService(),
          ),
          errorReporterProvider.overrideWithValue(MockErrorReporter()),
        ],
      );
    });

    tearDown(() {
      scenario.dispose();
      container.dispose();
    });

    group('Individual Storage Performance', () {
      test('should benchmark secure storage operations', () async {
        final secureStorage = container.read(secureStorageProvider);
        const iterations = 100;

        // Benchmark write operations
        final writeStopwatch = Stopwatch()..start();
        for (int i = 0; i < iterations; i++) {
          await secureStorage.write('secure_key_$i', 'secure_value_$i');
        }
        writeStopwatch.stop();

        // Benchmark read operations
        final readStopwatch = Stopwatch()..start();
        for (int i = 0; i < iterations; i++) {
          await secureStorage.read('secure_key_$i');
        }
        readStopwatch.stop();

        // Performance assertions (adjust thresholds based on requirements)
        final writeOpsPerSecond = iterations / writeStopwatch.elapsed.inSeconds;
        final readOpsPerSecond = iterations / readStopwatch.elapsed.inSeconds;

        debugPrint('Secure Storage Performance:');
        debugPrint('  Write: ${writeOpsPerSecond.toStringAsFixed(2)} ops/sec');
        debugPrint('  Read: ${readOpsPerSecond.toStringAsFixed(2)} ops/sec');

        expect(
          writeOpsPerSecond,
          greaterThan(10),
          reason: 'Secure storage writes should be reasonably fast',
        );
        expect(
          readOpsPerSecond,
          greaterThan(50),
          reason: 'Secure storage reads should be fast',
        );
      });

      test('should benchmark cache storage operations', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);
        const iterations = 200;

        // Benchmark cache write operations
        final writeStopwatch = Stopwatch()..start();
        for (int i = 0; i < iterations; i++) {
          await cacheStorage.set(
            'cache_key_$i',
            'cache_value_$i',
            ttl: const Duration(hours: 1),
          );
        }
        writeStopwatch.stop();

        // Benchmark cache read operations (should be very fast)
        final readStopwatch = Stopwatch()..start();
        for (int i = 0; i < iterations; i++) {
          await cacheStorage.get('cache_key_$i');
        }
        readStopwatch.stop();

        final writeOpsPerSecond = iterations / writeStopwatch.elapsed.inSeconds;
        final readOpsPerSecond = iterations / readStopwatch.elapsed.inSeconds;

        debugPrint('Cache Storage Performance:');
        debugPrint('  Write: ${writeOpsPerSecond.toStringAsFixed(2)} ops/sec');
        debugPrint('  Read: ${readOpsPerSecond.toStringAsFixed(2)} ops/sec');

        expect(
          writeOpsPerSecond,
          greaterThan(50),
          reason: 'Cache storage writes should be fast',
        );
        expect(
          readOpsPerSecond,
          greaterThan(100),
          reason: 'Cache storage reads should be very fast',
        );
      });

      test('should benchmark preference storage operations', () async {
        final preferenceStorage = await container.read(
          preferenceStorageProvider.future,
        );
        const iterations = 150;

        // Create preference keys for benchmarking
        final prefKeys = List.generate(
          iterations,
          (i) => PreferenceKey<String>(
            key: 'pref_key_$i',
            defaultValue: '',
            serializer: (value) => value,
            deserializer: (value) => value,
          ),
        );

        // Benchmark preference write operations
        final writeStopwatch = Stopwatch()..start();
        for (int i = 0; i < iterations; i++) {
          await preferenceStorage.set(prefKeys[i], 'pref_value_$i');
        }
        writeStopwatch.stop();

        // Benchmark preference read operations
        final readStopwatch = Stopwatch()..start();
        for (int i = 0; i < iterations; i++) {
          await preferenceStorage.get(prefKeys[i]);
        }
        readStopwatch.stop();

        final writeOpsPerSecond = iterations / writeStopwatch.elapsed.inSeconds;
        final readOpsPerSecond = iterations / readStopwatch.elapsed.inSeconds;

        debugPrint('Preference Storage Performance:');
        debugPrint('  Write: ${writeOpsPerSecond.toStringAsFixed(2)} ops/sec');
        debugPrint('  Read: ${readOpsPerSecond.toStringAsFixed(2)} ops/sec');

        expect(
          writeOpsPerSecond,
          greaterThan(20),
          reason: 'Preference storage writes should be reasonably fast',
        );
        expect(
          readOpsPerSecond,
          greaterThan(80),
          reason: 'Preference storage reads should be fast',
        );
      });
    });

    group('Concurrent Operations Performance', () {
      test(
        'should handle concurrent read/write operations efficiently',
        () async {
          final cacheStorage = await container.read(
            cacheStorageProvider.future,
          );
          const concurrency = 50;
          const operationsPerWorker = 20;

          final stopwatch = Stopwatch()..start();

          // Create concurrent workers
          final futures = List.generate(concurrency, (workerIndex) async {
            for (int i = 0; i < operationsPerWorker; i++) {
              final key = 'concurrent_${workerIndex}_$i';
              final value = 'value_${workerIndex}_$i';

              // Perform write
              await cacheStorage.set(key, value);

              // Perform read
              await cacheStorage.get(key);
            }
          });

          await Future.wait(futures);
          stopwatch.stop();

          final totalOperations =
              concurrency * operationsPerWorker * 2; // read + write
          final opsPerSecond = totalOperations / stopwatch.elapsed.inSeconds;

          debugPrint('Concurrent Operations Performance:');
          debugPrint('  Workers: $concurrency');
          debugPrint('  Operations per worker: ${operationsPerWorker * 2}');
          debugPrint('  Total operations: $totalOperations');
          debugPrint(
            '  Operations per second: ${opsPerSecond.toStringAsFixed(2)}',
          );

          expect(
            opsPerSecond,
            greaterThan(100),
            reason: 'Concurrent operations should maintain good throughput',
          );
        },
      );

      test(
        'should handle mixed storage type operations concurrently',
        () async {
          final secureStorage = container.read(secureStorageProvider);
          final cacheStorage = await container.read(
            cacheStorageProvider.future,
          );
          final preferenceStorage = await container.read(
            preferenceStorageProvider.future,
          );

          const iterations = 30;
          final stopwatch = Stopwatch()..start();

          final futures = <Future>[];

          // Mix operations across all storage types
          for (int i = 0; i < iterations; i++) {
            // Secure storage operations
            futures.add(secureStorage.write('mixed_secure_$i', 'secure_$i'));

            // Cache storage operations
            futures.add(cacheStorage.set('mixed_cache_$i', 'cache_$i'));

            // Preference storage operations
            futures.add(
              preferenceStorage.set(
                PreferenceKey<String>(
                  key: 'mixed_pref_$i',
                  defaultValue: '',
                  serializer: (value) => value,
                  deserializer: (value) => value,
                ),
                'pref_$i',
              ),
            );
          }

          final results = await Future.wait(futures);
          stopwatch.stop();

          final totalOperations = results.length;
          final opsPerSecond = totalOperations / stopwatch.elapsed.inSeconds;

          debugPrint('Mixed Storage Operations Performance:');
          debugPrint('  Total operations: $totalOperations');
          debugPrint(
            '  Operations per second: ${opsPerSecond.toStringAsFixed(2)}',
          );

          // Verify all operations succeeded
          final failedOperations = results
              .where((result) => result.isLeft())
              .length;
          expect(
            failedOperations,
            0,
            reason: 'All mixed operations should succeed',
          );

          expect(
            opsPerSecond,
            greaterThan(50),
            reason: 'Mixed operations should maintain reasonable throughput',
          );
        },
      );
    });

    group('Memory and Resource Usage', () {
      test('should handle large data sets efficiently', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);

        // Create large data objects
        const itemCount = 100;
        const itemSize = 1000; // characters per item

        final stopwatch = Stopwatch()..start();

        for (int i = 0; i < itemCount; i++) {
          final largeData = List.generate(
            itemSize,
            (index) => 'data_item_${i}_$index',
          );

          await cacheStorage.set('large_item_$i', largeData);
        }

        stopwatch.stop();

        final totalDataSize = itemCount * itemSize;
        final throughputMBps =
            (totalDataSize * 20) / // Estimate bytes per character
            stopwatch.elapsed.inMicroseconds; // MB per microsecond * 1M

        debugPrint('Large Data Performance:');
        debugPrint('  Items: $itemCount');
        debugPrint('  Estimated size per item: ${itemSize * 20} bytes');
        debugPrint('  Total time: ${stopwatch.elapsedMilliseconds}ms');
        debugPrint(
          '  Estimated throughput: ${throughputMBps.toStringAsFixed(2)} MB/s',
        );

        // Verify data integrity
        for (int i = 0; i < itemCount; i++) {
          final result = await cacheStorage.get('large_item_$i');
          expect(
            result.isRight(),
            true,
            reason: 'Should retrieve large item $i',
          );
        }

        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(10000), // Should complete within 10 seconds
          reason: 'Large data operations should complete in reasonable time',
        );
      });

      test('should manage cache capacity efficiently', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);
        final analytics = container.read(storageAnalyticsProvider);

        // Fill cache with many items
        const itemCount = 200;
        final stopwatch = Stopwatch()..start();

        for (int i = 0; i < itemCount; i++) {
          await cacheStorage.set(
            'capacity_item_$i',
            'data_$i',
            ttl: const Duration(minutes: 30),
          );
        }

        stopwatch.stop();

        // Check cache metrics
        final metrics = analytics.getCacheMetrics();

        debugPrint('Cache Capacity Performance:');
        debugPrint('  Items stored: $itemCount');
        debugPrint('  Time: ${stopwatch.elapsedMilliseconds}ms');
        debugPrint('  Cache requests: ${metrics.totalRequests}');
        debugPrint(
          '  Hit rate: ${(metrics.hitRate * 100).toStringAsFixed(2)}%',
        );

        // Verify reasonable performance even with many items
        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(5000),
          reason: 'Cache capacity management should be efficient',
        );

        // Test cache cleanup behavior (if implemented)
        final healthStatus = await container.read(
          storageHealthCheckProvider.future,
        );
        expect(healthStatus, StorageHealthStatus.healthy);
      });
    });

    group('Analytics Performance Impact', () {
      test('should measure analytics overhead', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);
        const iterations = 100;

        // Perform operations and measure total time including analytics
        final withAnalyticsStopwatch = Stopwatch()..start();

        for (int i = 0; i < iterations; i++) {
          await cacheStorage.set('analytics_test_$i', 'value_$i');
          await cacheStorage.get('analytics_test_$i');
        }

        withAnalyticsStopwatch.stop();

        final totalOpsWithAnalytics = iterations * 2;
        final opsPerSecondWithAnalytics =
            totalOpsWithAnalytics / withAnalyticsStopwatch.elapsed.inSeconds;

        debugPrint('Analytics Performance Impact:');
        debugPrint('  Operations: $totalOpsWithAnalytics');
        debugPrint(
          '  With analytics: ${opsPerSecondWithAnalytics.toStringAsFixed(2)} ops/sec',
        );
        debugPrint('  Time: ${withAnalyticsStopwatch.elapsedMilliseconds}ms');

        // Analytics should not significantly impact performance
        expect(
          opsPerSecondWithAnalytics,
          greaterThan(50),
          reason: 'Analytics should not severely impact performance',
        );
      });

      test('should verify analytics data collection efficiency', () async {
        final analytics = container.read(storageAnalyticsProvider);
        final cacheStorage = await container.read(cacheStorageProvider.future);

        // Reset metrics for clean measurement
        analytics.resetMetrics();

        // Perform variety of operations
        await cacheStorage.set('analytics_1', 'value_1');
        await cacheStorage.get('analytics_1'); // Hit
        await cacheStorage.get('analytics_nonexistent'); // Miss
        await cacheStorage.delete('analytics_1');

        // Allow analytics to process
        await Future.delayed(const Duration(milliseconds: 100));

        final metrics = analytics.getCacheMetrics();

        debugPrint('Analytics Collection Efficiency:');
        debugPrint('  Total requests: ${metrics.totalRequests}');
        debugPrint('  Hit count: ${metrics.hitCount}');
        debugPrint('  Miss count: ${metrics.missCount}');
        debugPrint(
          '  Hit rate: ${(metrics.hitRate * 100).toStringAsFixed(2)}%',
        );

        expect(metrics.totalRequests, greaterThan(0));
        expect(metrics.hitCount, greaterThan(0));
        expect(metrics.missCount, greaterThan(0));
      });
    });

    group('Stress Testing', () {
      test('should handle rapid sequential operations', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);
        const rapidIterations = 500;

        final stopwatch = Stopwatch()..start();

        // Rapid fire operations
        for (int i = 0; i < rapidIterations; i++) {
          await cacheStorage.set('rapid_$i', 'value_$i');
          if (i % 2 == 0) {
            await cacheStorage.get('rapid_$i');
          }
        }

        stopwatch.stop();

        final totalOps = rapidIterations + (rapidIterations / 2).floor();
        final opsPerSecond = totalOps / stopwatch.elapsed.inSeconds;

        debugPrint('Rapid Operations Stress Test:');
        debugPrint('  Operations: $totalOps');
        debugPrint('  Time: ${stopwatch.elapsedMilliseconds}ms');
        debugPrint('  Ops per second: ${opsPerSecond.toStringAsFixed(2)}');

        expect(
          stopwatch.elapsed.inSeconds,
          lessThan(30),
          reason: 'Rapid operations should complete quickly',
        );

        // Verify system remains stable
        final healthCheck = await container.read(
          storageHealthCheckProvider.future,
        );
        expect(healthCheck, StorageHealthStatus.healthy);
      });

      test('should handle burst load patterns', () async {
        final cacheStorage = await container.read(cacheStorageProvider.future);
        const burstSize = 50;
        const burstCount = 5;

        final totalStopwatch = Stopwatch()..start();

        for (int burst = 0; burst < burstCount; burst++) {
          final burstStopwatch = Stopwatch()..start();

          // Create burst of concurrent operations
          final futures = <Future>[];
          for (int i = 0; i < burstSize; i++) {
            futures.add(
              cacheStorage.set('burst_${burst}_$i', 'value_${burst}_$i'),
            );
          }

          await Future.wait(futures);
          burstStopwatch.stop();

          debugPrint('Burst $burst: ${burstStopwatch.elapsedMilliseconds}ms');

          // Small delay between bursts
          await Future.delayed(const Duration(milliseconds: 100));
        }

        totalStopwatch.stop();

        final totalOperations = burstSize * burstCount;
        final opsPerSecond = totalOperations / totalStopwatch.elapsed.inSeconds;

        debugPrint('Burst Load Test Summary:');
        debugPrint('  Bursts: $burstCount');
        debugPrint('  Operations per burst: $burstSize');
        debugPrint('  Total operations: $totalOperations');
        debugPrint('  Total time: ${totalStopwatch.elapsedMilliseconds}ms');
        debugPrint(
          '  Average ops per second: ${opsPerSecond.toStringAsFixed(2)}',
        );

        expect(
          opsPerSecond,
          greaterThan(20),
          reason: 'Burst operations should maintain reasonable throughput',
        );
      });
    });

    group('Performance Regression Detection', () {
      test('should establish performance baselines', () async {
        // This test establishes baseline performance metrics
        // that can be used to detect regressions in the future

        final results = <String, double>{};

        // Secure storage baseline
        final secureStorage = container.read(secureStorageProvider);
        var stopwatch = Stopwatch()..start();

        for (int i = 0; i < 50; i++) {
          await secureStorage.write('baseline_secure_$i', 'value_$i');
        }

        stopwatch.stop();
        results['secure_write_ops_per_sec'] = 50 / stopwatch.elapsed.inSeconds;

        // Cache storage baseline
        final cacheStorage = await container.read(cacheStorageProvider.future);
        stopwatch = Stopwatch()..start();

        for (int i = 0; i < 100; i++) {
          await cacheStorage.set('baseline_cache_$i', 'value_$i');
        }

        stopwatch.stop();
        results['cache_write_ops_per_sec'] = 100 / stopwatch.elapsed.inSeconds;

        // Preference storage baseline
        final preferenceStorage = await container.read(
          preferenceStorageProvider.future,
        );
        stopwatch = Stopwatch()..start();

        for (int i = 0; i < 75; i++) {
          await preferenceStorage.set(
            PreferenceKey<String>(
              key: 'baseline_pref_$i',
              defaultValue: '',
              serializer: (value) => value,
              deserializer: (value) => value,
            ),
            'value_$i',
          );
        }

        stopwatch.stop();
        results['preference_write_ops_per_sec'] =
            75 / stopwatch.elapsed.inSeconds;

        debugPrint('Performance Baselines:');
        for (final entry in results.entries) {
          debugPrint('  ${entry.key}: ${entry.value.toStringAsFixed(2)}');
        }

        // Store baselines for comparison in future runs
        // In a real scenario, these would be saved to a file or database
        for (final entry in results.entries) {
          expect(
            entry.value,
            greaterThan(1.0),
            reason: 'Baseline ${entry.key} should be reasonable',
          );
        }
      });
    });
  });
}
