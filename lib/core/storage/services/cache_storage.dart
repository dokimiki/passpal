import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/cache_storage_interface.dart';
import '../models/cache_entry.dart';
import '../models/storage_exceptions.dart';
import 'cache_manager.dart';

/// SharedPreferences-based implementation of CacheStorageInterface
///
/// Provides type-safe caching with TTL support and JSON serialization.
/// Uses SharedPreferences as the underlying storage mechanism with
/// automatic expiration handling and reactive updates.
class CacheStorage implements CacheStorageInterface {
  CacheStorage({
    required SharedPreferences sharedPreferences,
    this.keyPrefix = 'cache_',
    this.maxCapacity = 52428800, // 50MB in bytes
  }) : _prefs = sharedPreferences,
       _cacheManager = CacheManager(
         sharedPreferences: sharedPreferences,
         keyPrefix: keyPrefix,
         maxCapacity: maxCapacity,
       );

  final SharedPreferences _prefs;
  final String keyPrefix;
  final int maxCapacity;
  final CacheManager _cacheManager;

  // Stream controller for cache events
  final StreamController<CacheEvent> _eventController =
      StreamController<CacheEvent>.broadcast();

  // Stream controller for cache value changes
  final StreamController<CacheValueEvent> _valueController =
      StreamController<CacheValueEvent>.broadcast();

  // Stats tracking
  int _hitCount = 0;
  int _missCount = 0;
  int _expiredCount = 0;

  @override
  Stream<CacheEvent> get changes => _eventController.stream;

  @override
  Stream<CacheValueEvent> get valueChanges => _valueController.stream;

  @override
  Stream<CacheEntry<T>?> watchKey<T>(String key) {
    // Create a controller for this specific key
    late StreamController<CacheEntry<T>?> controller;
    late StreamSubscription subscription;

    controller = StreamController<CacheEntry<T>?>(
      onListen: () async {
        // Emit current value if it exists
        final current = await get<T>(key);
        if (current.isRight() && !controller.isClosed) {
          controller.add(
            current.getOrElse(() => throw Exception('Unexpected')),
          );
        } else if (!controller.isClosed) {
          controller.add(null);
        }

        // Listen to future changes
        subscription = valueChanges.where((event) => event.key == key).listen((
          event,
        ) async {
          if (controller.isClosed) return;

          if (event is CacheValueDeleted || event is CacheValueExpiredEvent) {
            controller.add(null);
          } else if (event is CacheValueChanged<T>) {
            if (event.newValue != null) {
              // Get the full cache entry
              final entry = await get<T>(key);
              if (entry.isRight()) {
                controller.add(
                  entry.getOrElse(() => throw Exception('Unexpected')),
                );
              } else {
                controller.add(null);
              }
            } else {
              controller.add(null);
            }
          }
        });
      },
      onCancel: () {
        subscription.cancel();
      },
    );

    return controller.stream;
  }

  @override
  Stream<Map<String, CacheEntry?>> watchKeys(List<String> keys) {
    late StreamController<Map<String, CacheEntry?>> controller;
    late StreamSubscription subscription;

    controller = StreamController<Map<String, CacheEntry?>>(
      onListen: () async {
        // Emit current values
        final currentValues = <String, CacheEntry?>{};
        for (final key in keys) {
          final current = await get(key);
          currentValues[key] = current.isRight()
              ? current.getOrElse(() => throw Exception('Unexpected'))
              : null;
        }
        if (!controller.isClosed) {
          controller.add(currentValues);
        }

        // Listen to future changes for any of the keys
        subscription = valueChanges
            .where((event) => keys.contains(event.key))
            .listen((event) async {
              if (controller.isClosed) return;

              // Rebuild the entire map when any key changes
              final updatedValues = <String, CacheEntry?>{};
              for (final key in keys) {
                final current = await get(key);
                updatedValues[key] = current.isRight()
                    ? current.getOrElse(() => throw Exception('Unexpected'))
                    : null;
              }
              controller.add(updatedValues);
            });
      },
      onCancel: () {
        subscription.cancel();
      },
    );

    return controller.stream;
  }

  @override
  Future<Either<Failure, CacheEntry<T>>> get<T>(String key) async {
    try {
      final cacheKey = _buildKey(key);
      final rawData = _prefs.getString(cacheKey);

      if (rawData == null) {
        _missCount++;
        return Left(
          StorageFailureFactory.keyNotFoundFailure(
            message: 'Cache key not found: $key',
          ),
        );
      }

      final cacheEntry = _deserializeCacheEntry<T>(rawData);

      if (cacheEntry.isExpired) {
        _expiredCount++;
        // Remove expired entry
        await _prefs.remove(cacheKey);
        _eventController.add(CacheEntryExpired(key));
        _valueController.add(CacheValueExpiredEvent(key));
        return Left(
          StorageFailureFactory.readFailure(message: 'Cache key expired: $key'),
        );
      }

      _hitCount++;
      // Record access for LRU tracking
      _cacheManager.recordAccess(key);
      return Right(cacheEntry);
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to read cache key $key: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> set<T>(
    String key,
    T value, {
    Duration? ttl,
  }) async {
    try {
      final cacheKey = _buildKey(key);

      // Check if key already existed before setting and get old value
      final keyExisted = _prefs.containsKey(cacheKey);
      T? oldValue;
      if (keyExisted) {
        final oldEntry = await get<T>(key);
        if (oldEntry.isRight()) {
          oldValue = oldEntry
              .getOrElse(() => throw Exception('Unexpected'))
              .value;
        }
      }

      final entry = CacheEntry<T>(
        value: value,
        timestamp: DateTime.now(),
        ttl: ttl,
      );

      final serializedData = _serializeCacheEntry(entry);

      // Check capacity before writing
      final capacityCheck = await _checkCapacity(serializedData.length);
      if (capacityCheck.isLeft()) {
        return capacityCheck.map((_) => unit);
      }

      final success = await _prefs.setString(cacheKey, serializedData);

      if (!success) {
        return Left(
          StorageFailureFactory.writeFailure(
            message: 'Failed to write cache key: $key',
          ),
        );
      }

      // Emit appropriate events
      _eventController.add(
        keyExisted ? CacheEntryUpdated(key) : CacheEntryAdded(key),
      );

      // Emit value change event
      _valueController.add(CacheValueChanged<T>(key, value, oldValue));

      return Right(unit);
    } catch (e) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to set cache key $key: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String key) async {
    try {
      final cacheKey = _buildKey(key);
      final removed = await _prefs.remove(cacheKey);

      if (removed) {
        _eventController.add(CacheEntryRemoved(key));
        _valueController.add(CacheValueDeleted(key));
      }

      return Right(unit);
    } catch (e) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to delete cache key $key: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> containsKey(String key) async {
    try {
      final cacheKey = _buildKey(key);
      final exists = _prefs.containsKey(cacheKey);

      if (!exists) {
        return Right(false);
      }

      // Check if the key exists and is not expired
      final result = await get(key);
      return Right(result.isRight());
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to check cache key $key: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> clear() async {
    try {
      final keys = _prefs
          .getKeys()
          .where((key) => key.startsWith(keyPrefix))
          .toList();

      for (final key in keys) {
        await _prefs.remove(key);
      }

      // Reset stats
      _hitCount = 0;
      _missCount = 0;
      _expiredCount = 0;

      return Right(unit);
    } catch (e) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to clear cache: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CacheStats>> getStats() async {
    try {
      final keys = _prefs
          .getKeys()
          .where((key) => key.startsWith(keyPrefix))
          .toList();

      int totalSize = 0;
      for (final key in keys) {
        final value = _prefs.getString(key);
        if (value != null) {
          totalSize += value.length * 2; // Approximate byte size (UTF-16)
        }
      }

      final stats = CacheStats(
        totalEntries: keys.length,
        totalSize: totalSize,
        hitCount: _hitCount,
        missCount: _missCount,
        expiredCount: _expiredCount,
        maxCapacity: maxCapacity,
      );

      return Right(stats);
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to get cache stats: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> cleanup() async {
    try {
      final keys = _prefs
          .getKeys()
          .where((key) => key.startsWith(keyPrefix))
          .toList();

      int cleanedCount = 0;
      for (final key in keys) {
        final rawData = _prefs.getString(key);
        if (rawData != null) {
          try {
            final entry = _deserializeCacheEntry(rawData);
            if (entry.isExpired) {
              await _prefs.remove(key);
              final originalKey = key.substring(keyPrefix.length);
              _eventController.add(CacheEntryExpired(originalKey));
              _valueController.add(CacheValueExpiredEvent(originalKey));
              cleanedCount++;
            }
          } catch (e) {
            // Remove corrupted entries
            await _prefs.remove(key);
            cleanedCount++;
          }
        }
      }

      _expiredCount += cleanedCount;
      return Right(unit);
    } catch (e) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to cleanup cache: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CacheEntry<T>?>> swr<T>(
    String key,
    Future<T> Function() revalidate, {
    Duration? ttl,
    bool forceRevalidate = false,
  }) async {
    try {
      CacheEntry<T>? staleEntry;

      // First, try to get existing cached data (even if stale)
      if (!forceRevalidate) {
        final staleResult = await getStale<T>(key);
        if (staleResult.isRight()) {
          staleEntry = staleResult.getOrElse(() => null);
        }
      }

      // Determine if we should revalidate
      bool shouldRevalidate = forceRevalidate;
      if (!shouldRevalidate && staleEntry != null) {
        // Check if entry is expired or close to expiring
        final timeToExpiry = staleEntry.timeToExpiry;
        shouldRevalidate =
            staleEntry.isExpired ||
            (timeToExpiry != null && timeToExpiry.inMinutes < 5);
      } else if (staleEntry == null) {
        // No cached data exists, must revalidate
        shouldRevalidate = true;
      }

      // Start background revalidation if needed
      if (shouldRevalidate) {
        // Fire and forget background revalidation
        _performBackgroundRevalidation(key, revalidate, ttl);
      }

      // Return stale data immediately if available
      if (staleEntry != null) {
        // Record access for LRU tracking
        _cacheManager.recordAccess(key);
        return Right(staleEntry);
      }

      // No stale data available and revalidation is running
      // For SWR pattern, we typically want to return null immediately
      // rather than waiting for revalidation
      return Right(null);
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed SWR operation for key $key: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CacheEntry<T>>> swrWithFallback<T>(
    String key,
    Future<T> Function() revalidate, {
    Duration? ttl,
    bool forceRevalidate = false,
    Duration? timeout,
  }) async {
    try {
      // First try the standard SWR approach
      final swrResult = await swr<T>(
        key,
        revalidate,
        ttl: ttl,
        forceRevalidate: forceRevalidate,
      );

      if (swrResult.isLeft()) {
        return swrResult.map((_) => throw Exception('Unreachable'));
      }

      final staleEntry = swrResult.getOrElse(() => null);

      // If we have stale data, return it immediately
      if (staleEntry != null) {
        return Right(staleEntry);
      }

      // No stale data available, wait for revalidation
      try {
        final Future<T> revalidationFuture = revalidate();
        final T freshData;

        if (timeout != null) {
          freshData = await revalidationFuture.timeout(timeout);
        } else {
          freshData = await revalidationFuture;
        }

        // Cache the fresh data
        final setResult = await set<T>(key, freshData, ttl: ttl);
        if (setResult.isLeft()) {
          return setResult.map((_) => throw Exception('Unreachable'));
        }

        // Return the fresh data as a cache entry
        final entry = CacheEntry<T>(
          value: freshData,
          timestamp: DateTime.now(),
          ttl: ttl,
        );

        return Right(entry);
      } on TimeoutException {
        return Left(
          StorageFailureFactory.readFailure(
            message: 'SWR revalidation timeout for key $key',
          ),
        );
      }
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed SWR with fallback for key $key: ${e.toString()}',
        ),
      );
    }
  }

  /// Perform background revalidation without blocking the caller
  void _performBackgroundRevalidation<T>(
    String key,
    Future<T> Function() revalidate,
    Duration? ttl,
  ) {
    // Run revalidation in background
    revalidate()
        .then((freshData) async {
          // Cache the fresh data
          await set<T>(key, freshData, ttl: ttl);
        })
        .catchError((error) {
          // Log error but don't propagate since this is background operation
          debugPrint('Background revalidation failed for key $key: $error');
        });
  }

  @override
  Future<Either<Failure, CacheEntry<T>?>> getStale<T>(String key) async {
    try {
      final cacheKey = _buildKey(key);
      final rawData = _prefs.getString(cacheKey);

      if (rawData == null) {
        _missCount++;
        return Right(null);
      }

      final cacheEntry = _deserializeCacheEntry<T>(rawData);

      // Return stale data even if expired (SWR pattern)
      _hitCount++;
      // Record access for LRU tracking
      _cacheManager.recordAccess(key);
      return Right(cacheEntry);
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to read stale cache key $key: ${e.toString()}',
        ),
      );
    }
  }

  /// Build cache key with prefix
  String _buildKey(String key) => '$keyPrefix$key';

  /// Serialize cache entry to JSON string
  String _serializeCacheEntry<T>(CacheEntry<T> entry) {
    final map = {
      'value': entry.value,
      'timestamp': entry.timestamp.millisecondsSinceEpoch,
      'ttl': entry.ttl?.inMilliseconds,
      'metadata': entry.metadata,
    };
    return jsonEncode(map);
  }

  /// Deserialize JSON string to cache entry
  CacheEntry<T> _deserializeCacheEntry<T>(String data) {
    final map = jsonDecode(data) as Map<String, dynamic>;

    return CacheEntry<T>(
      value: map['value'] as T,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      ttl: map['ttl'] != null
          ? Duration(milliseconds: map['ttl'] as int)
          : null,
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
    );
  }

  /// Check capacity and perform automatic cleanup if needed
  Future<Either<Failure, Unit>> _checkCapacity(int additionalBytes) async {
    try {
      final stats = await getStats();

      if (stats.isLeft()) {
        return stats.map((_) => unit);
      }

      final currentStats = stats.getOrElse(() => throw Exception('Unexpected'));
      final newSize = currentStats.totalSize + additionalBytes;

      // If adding this would exceed capacity, try LRU cleanup first
      if (newSize > maxCapacity) {
        // Calculate target size to accommodate the new entry
        // Leave some buffer (20%) and account for the new entry size
        final targetSize =
            maxCapacity - additionalBytes - (maxCapacity * 0.2).round();
        final cleanupResult = await _cacheManager.performLruCleanup(
          targetBytes: targetSize > 0
              ? targetSize
              : (maxCapacity * 0.3).round(),
        );

        if (cleanupResult.isLeft()) {
          return cleanupResult;
        }

        // Re-check stats after cleanup
        final newStats = await getStats();
        if (newStats.isLeft()) {
          return newStats.map((_) => unit);
        }

        final updatedStats = newStats.getOrElse(
          () => throw Exception('Unexpected'),
        );
        final sizeAfterCleanup = updatedStats.totalSize + additionalBytes;
        if (sizeAfterCleanup > maxCapacity) {
          return Left(
            StorageFailureFactory.capacityExceededFailure(
              message:
                  'Cache capacity exceeded even after cleanup: ${sizeAfterCleanup}B > ${maxCapacity}B',
            ),
          );
        }
      }

      return Right(unit);
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to check capacity: ${e.toString()}',
        ),
      );
    }
  }

  /// Perform automatic cleanup if needed based on cache size and entry count
  Future<Either<Failure, Unit>> performAutoCleanup() async {
    try {
      final shouldCleanup = await _cacheManager.shouldPerformCleanup();
      if (shouldCleanup.isLeft()) {
        return shouldCleanup.map((_) => unit);
      }

      if (shouldCleanup.getOrElse(() => false)) {
        return await _cacheManager.performLruCleanup();
      }

      return Right(unit);
    } catch (e) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to perform auto cleanup: ${e.toString()}',
        ),
      );
    }
  }

  /// Get detailed cache information for monitoring and debugging
  Future<Either<Failure, List<CacheEntryInfo>>> getCacheInfo() async {
    return _cacheManager.getCacheInfo();
  }

  /// Dispose resources
  void dispose() {
    _eventController.close();
    _valueController.close();
  }

  /// Test helper method to access key building logic
  @visibleForTesting
  String buildKeyForTesting(String key) => _buildKey(key);
}
