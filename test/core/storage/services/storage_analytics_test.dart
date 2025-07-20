/// Unit tests for StorageAnalytics service
///
/// Tests analytics tracking functionality, privacy-safe key hashing,
/// and performance metrics collection.
library;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:passpal/core/storage/services/storage_analytics.dart';

import 'storage_analytics_test.mocks.dart';

@GenerateMocks([FirebaseAnalytics])
void main() {
  group('StorageAnalytics', () {
    late MockFirebaseAnalytics mockAnalytics;
    late StorageAnalytics storageAnalytics;

    setUp(() {
      mockAnalytics = MockFirebaseAnalytics();
      storageAnalytics = StorageAnalytics(mockAnalytics);
    });

    tearDown(() {
      // Reset metrics after each test
      storageAnalytics.resetMetrics();
    });

    group('Operation Tracking', () {
      test('should track successful storage operation', () async {
        // Arrange
        const subsystem = StorageSubsystem.cache;
        const operation = StorageOperationType.read;
        const metrics = StoragePerformanceMetrics(
          latency: Duration(milliseconds: 50),
          dataSize: 1024,
          success: true,
        );

        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackOperation(
          subsystem: subsystem,
          operation: operation,
          metrics: metrics,
          key: 'test_key',
        );

        // Assert
        verify(
          mockAnalytics.logEvent(
            name: 'storage_operation',
            parameters: argThat(
              allOf([
                containsPair('subsystem', 'cache'),
                containsPair('operation', 'read'),
                containsPair('success', true),
                containsPair('latency_ms', 50),
                containsPair('data_size_bytes', 1024),
                contains('key_hash'),
              ]),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });

      test('should track failed storage operation', () async {
        // Arrange
        const subsystem = StorageSubsystem.secure;
        const operation = StorageOperationType.write;
        const metrics = StoragePerformanceMetrics(
          latency: Duration(milliseconds: 100),
          success: false,
          errorType: 'WriteFailure',
        );

        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackOperation(
          subsystem: subsystem,
          operation: operation,
          metrics: metrics,
        );

        // Assert
        verify(
          mockAnalytics.logEvent(
            name: 'storage_operation',
            parameters: argThat(
              allOf([
                containsPair('subsystem', 'secure'),
                containsPair('operation', 'write'),
                containsPair('success', false),
                containsPair('error_type', 'WriteFailure'),
              ]),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });

      test('should track custom parameters', () async {
        // Arrange
        const subsystem = StorageSubsystem.preference;
        const operation = StorageOperationType.delete;
        const metrics = StoragePerformanceMetrics(
          latency: Duration(milliseconds: 25),
          success: true,
        );
        const customParams = {'user_action': 'clear_preferences'};

        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackOperation(
          subsystem: subsystem,
          operation: operation,
          metrics: metrics,
          customParameters: customParams,
        );

        // Assert
        verify(
          mockAnalytics.logEvent(
            name: 'storage_operation',
            parameters: argThat(contains('user_action'), named: 'parameters'),
          ),
        ).called(1);
      });
    });

    group('Error Tracking', () {
      test('should track storage error with context', () async {
        // Arrange
        const subsystem = StorageSubsystem.cache;
        const operation = StorageOperationType.read;
        final error = Exception('Test error');
        const context = {'cache_size': 1024};

        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackError(
          subsystem: subsystem,
          operation: operation,
          error: error,
          key: 'error_key',
          context: context,
        );

        // Assert
        verify(
          mockAnalytics.logEvent(
            name: 'storage_error',
            parameters: argThat(
              allOf([
                containsPair('subsystem', 'cache'),
                containsPair('operation', 'read'),
                containsPair('error_type', '_Exception'),
                contains('error_message'),
                contains('key_hash'),
                contains('context_cache_size'),
              ]),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });
    });

    group('Cache Metrics', () {
      test('should track cache hits and misses', () async {
        // Arrange
        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act - Track cache hits
        await storageAnalytics.trackOperation(
          subsystem: StorageSubsystem.cache,
          operation: StorageOperationType.read,
          metrics: const StoragePerformanceMetrics(
            latency: Duration(milliseconds: 10),
            success: true,
          ),
        );

        await storageAnalytics.trackOperation(
          subsystem: StorageSubsystem.cache,
          operation: StorageOperationType.read,
          metrics: const StoragePerformanceMetrics(
            latency: Duration(milliseconds: 20),
            success: false, // Cache miss
          ),
        );

        // Assert
        final metrics = storageAnalytics.getCacheMetrics();
        expect(metrics.hitCount, equals(1));
        expect(metrics.missCount, equals(1));
        expect(metrics.totalRequests, equals(2));
        expect(metrics.hitRate, equals(0.5));
      });

      test('should calculate average latency', () async {
        // Arrange
        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackOperation(
          subsystem: StorageSubsystem.cache,
          operation: StorageOperationType.read,
          metrics: const StoragePerformanceMetrics(
            latency: Duration(milliseconds: 10),
            success: true,
          ),
        );

        await storageAnalytics.trackOperation(
          subsystem: StorageSubsystem.cache,
          operation: StorageOperationType.read,
          metrics: const StoragePerformanceMetrics(
            latency: Duration(milliseconds: 30),
            success: true,
          ),
        );

        // Assert
        final metrics = storageAnalytics.getCacheMetrics();
        expect(metrics.averageLatency.inMilliseconds, equals(20));
      });
    });

    group('Performance Reporting', () {
      test('should send performance report', () async {
        // Arrange
        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Add some test data
        await storageAnalytics.trackOperation(
          subsystem: StorageSubsystem.cache,
          operation: StorageOperationType.read,
          metrics: const StoragePerformanceMetrics(
            latency: Duration(milliseconds: 10),
            success: true,
          ),
        );

        // Act
        await storageAnalytics.sendPerformanceReport();

        // Assert
        verify(
          mockAnalytics.logEvent(
            name: 'storage_performance_report',
            parameters: argThat(
              containsPair('report_type', 'cache_performance'),
              named: 'parameters',
            ),
          ),
        ).called(1);

        verify(
          mockAnalytics.logEvent(
            name: 'storage_performance_report',
            parameters: argThat(
              containsPair('report_type', 'operation_summary'),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });
    });

    group('Privacy and Security', () {
      test('should hash keys for privacy', () async {
        // Arrange
        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackOperation(
          subsystem: StorageSubsystem.secure,
          operation: StorageOperationType.read,
          metrics: const StoragePerformanceMetrics(
            latency: Duration(milliseconds: 50),
            success: true,
          ),
          key: 'sensitive_user_data_key',
        );

        // Assert
        final captured = verify(
          mockAnalytics.logEvent(
            name: 'storage_operation',
            parameters: captureAnyNamed('parameters'),
          ),
        ).captured;

        final parameters = captured.first as Map<String, Object>;
        final keyHash = parameters['key_hash'] as String;

        // Key should be hashed, not the original
        expect(keyHash, isNot(equals('sensitive_user_data_key')));
        expect(keyHash.length, equals(8)); // First 8 chars of SHA256
      });

      test('should filter sensitive context data', () async {
        // Arrange
        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackError(
          subsystem: StorageSubsystem.secure,
          operation: StorageOperationType.write,
          error: Exception('Test error'),
          context: {
            'safe_number': 42,
            'safe_string': 'ok',
            'password': 'secret123', // Should be filtered
            'very_long_string': 'a' * 100, // Should be filtered
          },
        );

        // Assert
        final captured = verify(
          mockAnalytics.logEvent(
            name: 'storage_error',
            parameters: captureAnyNamed('parameters'),
          ),
        ).captured;

        final parameters = captured.first as Map<String, Object>;

        expect(parameters, containsPair('context_safe_number', 42));
        expect(parameters, containsPair('context_safe_string', 'ok'));
        expect(parameters, isNot(contains('context_password')));
        expect(parameters, isNot(contains('context_very_long_string')));
      });
    });

    group('Analytics Failures', () {
      test('should handle analytics failures gracefully', () async {
        // Arrange
        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenThrow(Exception('Analytics service unavailable'));

        // Act & Assert - Should not throw
        expect(
          () async => await storageAnalytics.trackOperation(
            subsystem: StorageSubsystem.cache,
            operation: StorageOperationType.read,
            metrics: const StoragePerformanceMetrics(
              latency: Duration(milliseconds: 10),
              success: true,
            ),
          ),
          returnsNormally,
        );
      });
    });

    group('Capacity Tracking', () {
      test('should track storage capacity usage', () async {
        // Arrange
        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackCapacityUsage(
          subsystem: StorageSubsystem.cache,
          usedBytes: 1024 * 1024, // 1MB
          totalBytes: 50 * 1024 * 1024, // 50MB
          itemCount: 100,
        );

        // Assert
        verify(
          mockAnalytics.logEvent(
            name: 'storage_capacity',
            parameters: argThat(
              allOf([
                containsPair('subsystem', 'cache'),
                containsPair('used_bytes', 1024 * 1024),
                containsPair('total_bytes', 50 * 1024 * 1024),
                containsPair('usage_percentage', 2), // 2%
                containsPair('item_count', 100),
              ]),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });
    });

    group('Migration Tracking', () {
      test('should track successful migration', () async {
        // Arrange
        when(
          mockAnalytics.logEvent(
            name: anyNamed('name'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await storageAnalytics.trackMigration(
          fromVersion: '1.0.0',
          toVersion: '2.0.0',
          success: true,
          duration: const Duration(milliseconds: 500),
          migratedItems: 50,
        );

        // Assert
        verify(
          mockAnalytics.logEvent(
            name: 'storage_migration',
            parameters: argThat(
              allOf([
                containsPair('from_version', '1.0.0'),
                containsPair('to_version', '2.0.0'),
                containsPair('success', true),
                containsPair('duration_ms', 500),
                containsPair('migrated_items', 50),
              ]),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });
    });
  });
}
