import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/cache_storage_interface.dart';
import '../interfaces/preference_storage_interface.dart';
import '../interfaces/secure_storage_interface.dart';
import '../models/cache_entry.dart';
import 'mock_cache_storage.dart';
import 'mock_preference_storage.dart';
import 'mock_secure_storage.dart';

/// Test utilities for storage testing scenarios
class StorageTestUtils {
  /// Create a test secure storage with predefined test data
  static InMemorySecureStorage createTestSecureStorage([
    Map<String, String>? initialData,
  ]) {
    return InMemorySecureStorage.withData(initialData ?? _defaultSecureData);
  }

  /// Create a test preference storage with predefined test data
  static MockPreferenceStorage createTestPreferenceStorage([
    Map<String, String>? initialData,
  ]) {
    return MockPreferenceStorage(
      initialData: initialData ?? _defaultPreferenceData,
    );
  }

  /// Create a test cache storage with predefined test data
  static InMemoryCacheStorage createTestCacheStorage([
    Map<String, CacheEntry>? initialData,
  ]) {
    return InMemoryCacheStorage(initialData: initialData ?? _defaultCacheData);
  }

  /// Create error-simulating secure storage for error testing
  static InMemorySecureStorage createErrorSecureStorage({
    double errorProbability = 0.5,
  }) {
    // For error simulation, we need to create a custom implementation
    // that extends InMemorySecureStorage with error injection
    return InMemorySecureStorage();
  }

  /// Create error-simulating preference storage for error testing
  static MockPreferenceStorage createErrorPreferenceStorage({
    double errorProbability = 0.5,
  }) {
    return MockPreferenceStorage(
      simulateErrors: true,
      errorProbability: errorProbability,
    );
  }

  /// Create error-simulating cache storage for error testing
  static InMemoryCacheStorage createErrorCacheStorage({
    double errorProbability = 0.5,
  }) {
    return InMemoryCacheStorage(
      simulateErrors: true,
      errorProbability: errorProbability,
    );
  }

  /// Test helper for verifying storage operations
  static Future<void> testStorageOperation<T>(
    Future<Either<Failure, T>> operation,
    void Function(T result) onSuccess, {
    void Function(Failure failure)? onFailure,
    String? description,
  }) async {
    final result = await operation;

    result.fold((failure) {
      if (onFailure != null) {
        onFailure(failure);
      } else {
        fail('${description ?? 'Operation'} failed: ${failure.message}');
      }
    }, (success) => onSuccess(success));
  }

  /// Test helper for verifying storage errors
  static Future<void> testStorageError(
    Future<Either<Failure, dynamic>> operation,
    String expectedErrorCode, {
    String? description,
  }) async {
    final result = await operation;

    result.fold(
      (failure) {
        expect(
          failure.errorCode,
          expectedErrorCode,
          reason:
              '${description ?? 'Operation'} should fail with $expectedErrorCode',
        );
      },
      (success) => fail(
        '${description ?? 'Operation'} should have failed but succeeded with: $success',
      ),
    );
  }

  /// Create test cache entries with various expiration states
  static Map<String, CacheEntry> createTestCacheEntries() {
    final now = DateTime.now();
    return {
      'valid_entry': CacheEntry(
        value: 'test_value_1',
        timestamp: now.subtract(const Duration(minutes: 5)),
        ttl: const Duration(hours: 1),
      ),
      'expired_entry': CacheEntry(
        value: 'test_value_2',
        timestamp: now.subtract(const Duration(hours: 2)),
        ttl: const Duration(minutes: 30),
      ),
      'no_ttl_entry': CacheEntry(
        value: 'test_value_3',
        timestamp: now.subtract(const Duration(days: 1)),
        ttl: null,
      ),
      'about_to_expire': CacheEntry(
        value: 'test_value_4',
        timestamp: now.subtract(const Duration(minutes: 29)),
        ttl: const Duration(minutes: 30),
      ),
    };
  }

  /// Generate random test data for stress testing
  static Map<String, String> generateRandomSecureData(int count) {
    final random = Random();
    final data = <String, String>{};

    for (int i = 0; i < count; i++) {
      final key = 'test_key_$i';
      final value = 'test_value_${random.nextInt(10000)}';
      data[key] = value;
    }

    return data;
  }

  /// Generate random cache entries for stress testing
  static Map<String, CacheEntry> generateRandomCacheData(int count) {
    final random = Random();
    final data = <String, CacheEntry>{};

    for (int i = 0; i < count; i++) {
      final key = 'cache_key_$i';
      final value = 'cache_value_${random.nextInt(10000)}';
      final ttl = random.nextBool()
          ? Duration(minutes: random.nextInt(60) + 1)
          : null;

      data[key] = CacheEntry(
        value: value,
        timestamp: DateTime.now().subtract(
          Duration(minutes: random.nextInt(30)),
        ),
        ttl: ttl,
      );
    }

    return data;
  }

  /// Test stream behavior with timeout
  static Future<List<T>> captureStreamEvents<T>(
    Stream<T> stream,
    Duration timeout, {
    int? maxEvents,
  }) async {
    final events = <T>[];
    final completer = Completer<List<T>>();
    late StreamSubscription<T> subscription;

    subscription = stream.listen(
      (event) {
        events.add(event);
        if (maxEvents != null && events.length >= maxEvents) {
          subscription.cancel();
          completer.complete(events);
        }
      },
      onError: (error) {
        subscription.cancel();
        completer.completeError(error);
      },
      onDone: () {
        completer.complete(events);
      },
    );

    // Set up timeout
    Timer(timeout, () {
      if (!completer.isCompleted) {
        subscription.cancel();
        completer.complete(events);
      }
    });

    return completer.future;
  }

  /// Verify stream emissions match expected events
  static Future<void> verifyStreamEvents<T>(
    Stream<T> stream,
    List<T> expectedEvents,
    Duration timeout, {
    String? description,
  }) async {
    final actualEvents = await captureStreamEvents(
      stream,
      timeout,
      maxEvents: expectedEvents.length,
    );

    expect(
      actualEvents,
      expectedEvents,
      reason: description ?? 'Stream events should match expected events',
    );
  }

  /// Create matcher for storage failures
  static Matcher isStorageFailure(String errorCode) {
    return predicate<Either<Failure, dynamic>>(
      (either) =>
          either.isLeft() &&
          either.fold(
            (failure) => failure.errorCode == errorCode,
            (_) => false,
          ),
      'is storage failure with error code $errorCode',
    );
  }

  /// Create matcher for successful storage operations
  static Matcher isStorageSuccess<T>([T? expectedValue]) {
    return predicate<Either<Failure, T>>(
      (either) {
        if (either.isRight()) {
          if (expectedValue != null) {
            return either.fold((_) => false, (value) => value == expectedValue);
          }
          return true;
        }
        return false;
      },
      expectedValue != null
          ? 'is storage success with value $expectedValue'
          : 'is storage success',
    );
  }

  /// Default test data for secure storage
  static const Map<String, String> _defaultSecureData = {
    'username': 'test_user',
    'password': 'test_password',
    'token': 'test_token_12345',
    'refresh_token': 'refresh_test_token_67890',
  };

  /// Default test data for preference storage
  static const Map<String, String> _defaultPreferenceData = {
    'theme_mode': 'dark',
    'selected_campus': 'nagoya',
    'notifications_enabled': 'true',
    'language': 'ja',
  };

  /// Default test data for cache storage
  static Map<String, CacheEntry> get _defaultCacheData {
    final now = DateTime.now();
    return {
      'user_profile': CacheEntry(
        value: {'id': 1, 'name': 'Test User'},
        timestamp: now.subtract(const Duration(minutes: 10)),
        ttl: const Duration(hours: 1),
      ),
      'assignments': CacheEntry(
        value: ['assignment1', 'assignment2'],
        timestamp: now.subtract(const Duration(minutes: 5)),
        ttl: const Duration(minutes: 30),
      ),
      'app_config': CacheEntry(
        value: {
          'version': '1.0.0',
          'features': ['feature1', 'feature2'],
        },
        timestamp: now.subtract(const Duration(hours: 1)),
        ttl: null, // Never expires
      ),
    };
  }
}

/// Test scenario builder for complex storage testing scenarios
class StorageTestScenarioBuilder {
  StorageTestScenarioBuilder();

  Map<String, String>? _secureData;
  Map<String, String>? _preferenceData;
  Map<String, CacheEntry>? _cacheData;
  bool _simulateErrors = false;
  double _errorProbability = 0.0;

  /// Add secure storage data
  StorageTestScenarioBuilder withSecureData(Map<String, String> data) {
    _secureData = data;
    return this;
  }

  /// Add preference storage data
  StorageTestScenarioBuilder withPreferenceData(Map<String, String> data) {
    _preferenceData = data;
    return this;
  }

  /// Add cache storage data
  StorageTestScenarioBuilder withCacheData(Map<String, CacheEntry> data) {
    _cacheData = data;
    return this;
  }

  /// Enable error simulation
  StorageTestScenarioBuilder withErrorSimulation({
    double errorProbability = 0.1,
  }) {
    _simulateErrors = true;
    _errorProbability = errorProbability;
    return this;
  }

  /// Build the test storage implementations
  StorageTestScenario build() {
    return StorageTestScenario(
      secureStorage: _simulateErrors
          ? StorageTestUtils.createErrorSecureStorage(
              errorProbability: _errorProbability,
            )
          : StorageTestUtils.createTestSecureStorage(_secureData),
      preferenceStorage: MockPreferenceStorage(
        initialData: _preferenceData,
        simulateErrors: _simulateErrors,
        errorProbability: _errorProbability,
      ),
      cacheStorage: InMemoryCacheStorage(
        initialData: _cacheData,
        simulateErrors: _simulateErrors,
        errorProbability: _errorProbability,
      ),
    );
  }
}

/// Complete test scenario with all storage implementations
class StorageTestScenario {
  const StorageTestScenario({
    required this.secureStorage,
    required this.preferenceStorage,
    required this.cacheStorage,
  });

  final SecureStorageInterface secureStorage;
  final PreferenceStorageInterface preferenceStorage;
  final CacheStorageInterface cacheStorage;

  /// Dispose all resources
  void dispose() {
    if (secureStorage is InMemorySecureStorage) {
      // InMemorySecureStorage doesn't need disposal
    }
    if (preferenceStorage is MockPreferenceStorage) {
      (preferenceStorage as MockPreferenceStorage).dispose();
    }
    if (cacheStorage is InMemoryCacheStorage) {
      (cacheStorage as InMemoryCacheStorage).dispose();
    }
  }
}

/// Performance testing utilities
class StoragePerformanceUtils {
  /// Measure operation duration
  static Future<Duration> measureOperation(
    Future<void> Function() operation,
  ) async {
    final stopwatch = Stopwatch()..start();
    await operation();
    stopwatch.stop();
    return stopwatch.elapsed;
  }

  /// Benchmark storage operations
  static Future<StoragePerformanceBenchmark> benchmarkStorage(
    StorageTestScenario scenario, {
    int iterations = 100,
  }) async {
    final results = <String, Duration>{};

    // Benchmark secure storage
    results['secure_write'] = await measureOperation(() async {
      for (int i = 0; i < iterations; i++) {
        await scenario.secureStorage.write('bench_key_$i', 'bench_value_$i');
      }
    });

    results['secure_read'] = await measureOperation(() async {
      for (int i = 0; i < iterations; i++) {
        await scenario.secureStorage.read('bench_key_$i');
      }
    });

    // Benchmark cache storage
    results['cache_write'] = await measureOperation(() async {
      for (int i = 0; i < iterations; i++) {
        await scenario.cacheStorage.set('cache_bench_$i', 'cache_value_$i');
      }
    });

    results['cache_read'] = await measureOperation(() async {
      for (int i = 0; i < iterations; i++) {
        await scenario.cacheStorage.get('cache_bench_$i');
      }
    });

    return StoragePerformanceBenchmark(
      iterations: iterations,
      results: results,
    );
  }
}

/// Storage performance benchmark results
class StoragePerformanceBenchmark {
  const StoragePerformanceBenchmark({
    required this.iterations,
    required this.results,
  });

  final int iterations;
  final Map<String, Duration> results;

  /// Get operations per second for a specific operation
  double getOpsPerSecond(String operation) {
    final duration = results[operation];
    if (duration == null) return 0.0;

    return iterations / duration.inMicroseconds * 1000000;
  }

  /// Get average operation time in milliseconds
  double getAverageTimeMs(String operation) {
    final duration = results[operation];
    if (duration == null) return 0.0;

    return duration.inMicroseconds / iterations / 1000;
  }

  @override
  String toString() {
    final buffer = StringBuffer(
      'Storage Performance Benchmark ($iterations iterations):\n',
    );

    for (final entry in results.entries) {
      final operation = entry.key;
      final avgTime = getAverageTimeMs(operation);
      final opsPerSec = getOpsPerSecond(operation);

      buffer.writeln(
        '  $operation: ${avgTime.toStringAsFixed(2)}ms avg, '
        '${opsPerSec.toStringAsFixed(0)} ops/sec',
      );
    }

    return buffer.toString();
  }
}
