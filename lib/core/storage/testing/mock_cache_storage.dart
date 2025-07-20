import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/cache_storage_interface.dart';
import '../models/cache_entry.dart';
import '../models/storage_exceptions.dart';

/// Mock implementation of [CacheStorageInterface] for testing
class MockCacheStorage extends Mock implements CacheStorageInterface {}

/// In-memory implementation of [CacheStorageInterface] for testing
///
/// Provides a complete in-memory cache that mimics the behavior
/// of the real cache storage with TTL support, capacity management,
/// and reactive streams. Useful for unit tests and integration tests.
class InMemoryCacheStorage implements CacheStorageInterface {
  InMemoryCacheStorage({
    this.maxCapacity = 50 * 1024 * 1024, // 50MB default
    this.simulateErrors = false,
    this.errorProbability = 0.0,
    Map<String, CacheEntry>? initialData,
  }) : _storage = Map.from(initialData ?? {});

  final int maxCapacity;
  final bool simulateErrors;
  final double errorProbability;
  final Map<String, CacheEntry> _storage;

  // Statistics tracking
  int _hitCount = 0;
  int _missCount = 0;
  int _expiredCount = 0;

  // Stream controllers for reactive behavior
  final StreamController<CacheEvent> _eventController =
      StreamController<CacheEvent>.broadcast();
  final StreamController<CacheValueEvent> _valueController =
      StreamController<CacheValueEvent>.broadcast();
  final Map<String, StreamController<CacheEntry?>> _watchControllers = {};

  @override
  Stream<CacheEvent> get changes => _eventController.stream;

  @override
  Stream<CacheValueEvent> get valueChanges => _valueController.stream;

  @override
  Future<Either<Failure, CacheEntry<T>>> get<T>(String key) async {
    if (_shouldSimulateError()) {
      return Left(_createReadFailure('Simulated read error', key));
    }

    final entry = _storage[key];
    if (entry == null) {
      _missCount++;
      return Left(_createReadFailure('Cache miss', key));
    }

    // Check if expired
    if (entry.isExpired) {
      _expiredCount++;
      _storage.remove(key);
      _eventController.add(CacheEntryExpired(key));
      _valueController.add(CacheValueExpiredEvent(key));
      return Left(_createReadFailure('Cache entry expired', key));
    }

    _hitCount++;
    return Right(entry as CacheEntry<T>);
  }

  @override
  Future<Either<Failure, Unit>> set<T>(
    String key,
    T value, {
    Duration? ttl,
  }) async {
    if (_shouldSimulateError()) {
      return Left(_createWriteFailure('Simulated write error', key));
    }

    // Check capacity before adding
    final newEntry = CacheEntry<T>(
      value: value,
      timestamp: DateTime.now(),
      ttl: ttl,
    );

    final entrySize = _estimateEntrySize(key, newEntry);
    final currentSize = _calculateCurrentSize();

    if (currentSize + entrySize > maxCapacity) {
      // Try to cleanup expired entries first
      await _cleanupExpired();

      // If still over capacity, perform LRU cleanup
      final newCurrentSize = _calculateCurrentSize();
      if (newCurrentSize + entrySize > maxCapacity) {
        await _performLRUCleanup(entrySize);
      }
    }

    final oldEntry = _storage[key];
    _storage[key] = newEntry;

    // Emit events
    if (oldEntry == null) {
      _eventController.add(CacheEntryAdded(key));
    } else {
      _eventController.add(CacheEntryUpdated(key));
      _valueController.add(CacheValueChanged(key, value, oldEntry.value));
    }

    // Emit to specific watchers
    _emitToWatcher(key, newEntry);

    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> delete(String key) async {
    if (_shouldSimulateError()) {
      return Left(_createWriteFailure('Simulated delete error', key));
    }

    final removed = _storage.remove(key);
    if (removed != null) {
      _eventController.add(CacheEntryRemoved(key));
      _valueController.add(CacheValueDeleted(key));
      _emitToWatcher(key, null);
    }

    return const Right(unit);
  }

  @override
  Future<Either<Failure, bool>> containsKey(String key) async {
    if (_shouldSimulateError()) {
      return Left(_createReadFailure('Simulated containsKey error', key));
    }

    final entry = _storage[key];
    if (entry == null) return const Right(false);

    // Check if expired
    if (entry.isExpired) {
      _storage.remove(key);
      _eventController.add(CacheEntryExpired(key));
      return const Right(false);
    }

    return const Right(true);
  }

  @override
  Future<Either<Failure, Unit>> clear() async {
    if (_shouldSimulateError()) {
      return Left(_createWriteFailure('Simulated clear error', ''));
    }

    final keys = _storage.keys.toList();
    _storage.clear();

    // Emit events for all cleared entries
    for (final key in keys) {
      _eventController.add(CacheEntryRemoved(key));
      _valueController.add(CacheValueDeleted(key));
      _emitToWatcher(key, null);
    }

    return const Right(unit);
  }

  @override
  Future<Either<Failure, CacheStats>> getStats() async {
    if (_shouldSimulateError()) {
      return Left(_createReadFailure('Simulated getStats error', ''));
    }

    final totalSize = _calculateCurrentSize();
    final stats = CacheStats(
      totalEntries: _storage.length,
      totalSize: totalSize,
      hitCount: _hitCount,
      missCount: _missCount,
      expiredCount: _expiredCount,
      maxCapacity: maxCapacity,
    );

    return Right(stats);
  }

  @override
  Future<Either<Failure, Unit>> cleanup() async {
    if (_shouldSimulateError()) {
      return Left(_createWriteFailure('Simulated cleanup error', ''));
    }

    await _cleanupExpired();
    return const Right(unit);
  }

  @override
  Stream<CacheEntry<T>?> watchKey<T>(String key) {
    final controller =
        _watchControllers.putIfAbsent(
              key,
              () => StreamController<CacheEntry?>.broadcast(),
            )
            as StreamController<CacheEntry<T>?>;

    // Emit current value immediately
    get<T>(key).then((result) {
      result.fold(
        (failure) => controller.add(null),
        (entry) => controller.add(entry),
      );
    });

    return controller.stream;
  }

  @override
  Stream<Map<String, CacheEntry?>> watchKeys(List<String> keys) {
    final controller = StreamController<Map<String, CacheEntry?>>.broadcast();

    // Create subscription for each key
    final subscriptions = <StreamSubscription>[];

    for (final key in keys) {
      final subscription = watchKey(key).listen((_) {
        _emitCombinedKeys(controller, keys);
      });
      subscriptions.add(subscription);
    }

    // Emit initial values
    _emitCombinedKeys(controller, keys);

    // Clean up subscriptions when stream is cancelled
    controller.onCancel = () {
      for (final subscription in subscriptions) {
        subscription.cancel();
      }
    };

    return controller.stream;
  }

  @override
  Future<Either<Failure, CacheEntry<T>?>> getStale<T>(String key) async {
    if (_shouldSimulateError()) {
      return Left(_createReadFailure('Simulated getStale error', key));
    }

    final entry = _storage[key];
    if (entry == null) {
      _missCount++;
      return const Right(null);
    }

    // Return stale data even if expired
    _hitCount++;
    return Right(entry as CacheEntry<T>);
  }

  @override
  Future<Either<Failure, CacheEntry<T>?>> swr<T>(
    String key,
    Future<T> Function() revalidate, {
    Duration? ttl,
    bool forceRevalidate = false,
  }) async {
    // Get stale data first
    final staleResult = await getStale<T>(key);

    // Determine if we should revalidate
    bool shouldRevalidate = forceRevalidate;
    if (!shouldRevalidate) {
      final entry = _storage[key];
      shouldRevalidate = entry == null || entry.isExpired;
    }

    // Start background revalidation if needed
    if (shouldRevalidate) {
      _performBackgroundRevalidation(key, revalidate, ttl);
    }

    return staleResult;
  }

  @override
  Future<Either<Failure, CacheEntry<T>>> swrWithFallback<T>(
    String key,
    Future<T> Function() revalidate, {
    Duration? ttl,
    bool forceRevalidate = false,
    Duration? timeout,
  }) async {
    // Try to get stale data first
    final staleResult = await getStale<T>(key);

    return staleResult.fold(
      (failure) async {
        // No stale data, wait for revalidation
        try {
          final freshData = timeout != null
              ? await revalidate().timeout(timeout)
              : await revalidate();

          await set(key, freshData, ttl: ttl);
          final result = await get<T>(key);
          return result;
        } catch (e) {
          return Left(_createReadFailure('Revalidation failed: $e', key));
        }
      },
      (staleEntry) async {
        // Have stale data, start background revalidation if needed
        final entry = _storage[key];
        final shouldRevalidate =
            forceRevalidate || entry == null || entry.isExpired;

        if (shouldRevalidate) {
          _performBackgroundRevalidation(key, revalidate, ttl);
        }

        return Right(staleEntry!);
      },
    );
  }

  /// Perform background revalidation without blocking
  void _performBackgroundRevalidation<T>(
    String key,
    Future<T> Function() revalidate,
    Duration? ttl,
  ) {
    revalidate()
        .then((freshData) {
          set(key, freshData, ttl: ttl);
        })
        .catchError((error) {
          // Silently fail background revalidation
          // In a real implementation, this might be logged
        });
  }

  /// Emit combined values for multiple keys
  void _emitCombinedKeys(
    StreamController<Map<String, CacheEntry?>> controller,
    List<String> keys,
  ) {
    final result = <String, CacheEntry?>{};
    for (final key in keys) {
      final entry = _storage[key];
      if (entry != null && !entry.isExpired) {
        result[key] = entry;
      } else {
        result[key] = null;
      }
    }
    controller.add(result);
  }

  /// Emit value change to specific cache key watchers
  void _emitToWatcher(String key, CacheEntry? entry) {
    final controller = _watchControllers[key];
    if (controller != null) {
      controller.add(entry);
    }
  }

  /// Clean up expired entries
  Future<void> _cleanupExpired() async {
    final expiredKeys = <String>[];

    for (final entry in _storage.entries) {
      if (entry.value.isExpired) {
        expiredKeys.add(entry.key);
      }
    }

    for (final key in expiredKeys) {
      _storage.remove(key);
      _eventController.add(CacheEntryExpired(key));
      _valueController.add(CacheValueExpiredEvent(key));
      _emitToWatcher(key, null);
    }
  }

  /// Perform LRU cleanup to make space
  Future<void> _performLRUCleanup(int neededSpace) async {
    final entries = _storage.entries.toList();

    // Sort by timestamp (oldest first)
    entries.sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));

    int freedSpace = 0;
    final keysToRemove = <String>[];

    for (final entry in entries) {
      if (freedSpace >= neededSpace) break;

      keysToRemove.add(entry.key);
      freedSpace += _estimateEntrySize(entry.key, entry.value);
    }

    for (final key in keysToRemove) {
      _storage.remove(key);
      _eventController.add(CacheEntryRemoved(key));
      _valueController.add(CacheValueDeleted(key));
      _emitToWatcher(key, null);
    }
  }

  /// Calculate current storage size in bytes
  int _calculateCurrentSize() {
    int totalSize = 0;
    for (final entry in _storage.entries) {
      totalSize += _estimateEntrySize(entry.key, entry.value);
    }
    return totalSize;
  }

  /// Estimate the size of a cache entry in bytes
  int _estimateEntrySize(String key, CacheEntry entry) {
    // Rough estimation: key + value as JSON + metadata
    final keySize = utf8.encode(key).length;
    final valueSize = utf8.encode(jsonEncode(entry.value)).length;
    const metadataSize = 64; // Estimated size for timestamp, TTL, etc.

    return keySize + valueSize + metadataSize;
  }

  /// Determine if an error should be simulated
  bool _shouldSimulateError() {
    if (!simulateErrors) return false;

    final random = DateTime.now().millisecondsSinceEpoch % 100;
    return random < (errorProbability * 100);
  }

  /// Create a read failure
  Failure _createReadFailure(String message, String key) {
    return StorageFailureFactory.readFailure(
      message: message,
      context: {'key': key, 'simulated': simulateErrors},
    );
  }

  /// Create a write failure
  Failure _createWriteFailure(String message, String key) {
    return StorageFailureFactory.writeFailure(
      message: message,
      context: {'key': key, 'simulated': simulateErrors},
    );
  }

  /// Get current storage state for debugging
  Map<String, CacheEntry> get debugStorage => Map.unmodifiable(_storage);

  /// Get cache statistics for debugging
  Map<String, int> get debugStats => {
    'hitCount': _hitCount,
    'missCount': _missCount,
    'expiredCount': _expiredCount,
    'totalEntries': _storage.length,
  };

  /// Reset the cache to initial state
  void reset({Map<String, CacheEntry>? initialData}) {
    _storage.clear();
    if (initialData != null) {
      _storage.addAll(initialData);
    }
    _hitCount = 0;
    _missCount = 0;
    _expiredCount = 0;
  }

  /// Dispose all stream controllers
  void dispose() {
    _eventController.close();
    _valueController.close();
    for (final controller in _watchControllers.values) {
      controller.close();
    }
    _watchControllers.clear();
  }
}
