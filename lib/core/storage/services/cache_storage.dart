import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/models/failure.dart';
import '../interfaces/cache_storage_interface.dart';
import '../models/cache_entry.dart';
import '../models/storage_exceptions.dart';

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
  }) : _prefs = sharedPreferences;

  final SharedPreferences _prefs;
  final String keyPrefix;
  final int maxCapacity;

  // Stream controller for cache events
  final StreamController<CacheEvent> _eventController =
      StreamController<CacheEvent>.broadcast();

  // Stats tracking
  int _hitCount = 0;
  int _missCount = 0;
  int _expiredCount = 0;

  @override
  Stream<CacheEvent> get changes => _eventController.stream;

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
        return Left(
          StorageFailureFactory.readFailure(message: 'Cache key expired: $key'),
        );
      }

      _hitCount++;
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

      // Check if key already existed before setting
      final keyExisted = _prefs.containsKey(cacheKey);

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

      // Emit appropriate event
      _eventController.add(
        keyExisted ? CacheEntryUpdated(key) : CacheEntryAdded(key),
      );

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

  /// Check if adding data would exceed capacity
  Future<Either<Failure, Unit>> _checkCapacity(int additionalBytes) async {
    try {
      final stats = await getStats();

      return stats.fold((failure) => Left(failure), (currentStats) {
        final newSize = currentStats.totalSize + additionalBytes;
        if (newSize > maxCapacity) {
          return Left(
            StorageFailureFactory.capacityExceededFailure(
              message: 'Cache capacity exceeded: ${newSize}B > ${maxCapacity}B',
            ),
          );
        }
        return Right(unit);
      });
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to check capacity: ${e.toString()}',
        ),
      );
    }
  }

  /// Dispose resources
  void dispose() {
    _eventController.close();
  }

  /// Test helper method to access key building logic
  @visibleForTesting
  String buildKeyForTesting(String key) => _buildKey(key);
}
