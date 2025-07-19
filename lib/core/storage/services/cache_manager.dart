import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/models/failure.dart';
import '../models/cache_entry.dart';
import '../models/storage_exceptions.dart';

/// Advanced cache manager with LRU eviction and capacity management
///
/// Extends basic cache functionality with intelligent capacity management
/// using Least Recently Used (LRU) algorithm for automatic cleanup when
/// capacity limits are reached.
class CacheManager {
  CacheManager({
    required SharedPreferences sharedPreferences,
    this.keyPrefix = 'cache_',
    this.maxCapacity = 52428800, // 50MB in bytes
    this.maxEntries = 10000, // Maximum number of cache entries
    this.cleanupThreshold = 0.8, // Cleanup when 80% capacity reached
  }) : _prefs = sharedPreferences;

  final SharedPreferences _prefs;
  final String keyPrefix;
  final int maxCapacity;
  final int maxEntries;
  final double cleanupThreshold;

  // LRU tracking - maps cache key to last access timestamp
  final Map<String, int> _accessTimes = {};
  int _accessCounter = 0;

  /// Perform LRU cleanup when capacity or entry limits are reached
  Future<Either<Failure, Unit>> performLruCleanup({
    int? targetBytes,
    int? targetEntries,
  }) async {
    try {
      final cacheKeys = _prefs
          .getKeys()
          .where((key) => key.startsWith(keyPrefix))
          .toList();

      if (cacheKeys.isEmpty) {
        return Right(unit);
      }

      // Build LRU list with cache entry metadata
      final List<CacheEntryMetadata> entries = [];
      int totalSize = 0;

      for (final fullKey in cacheKeys) {
        final originalKey = fullKey.substring(keyPrefix.length);
        final rawData = _prefs.getString(fullKey);

        if (rawData != null) {
          final entrySize = rawData.length * 2; // UTF-16 byte approximation
          totalSize += entrySize;

          // Get access time (default to 0 if not tracked)
          final accessTime = _accessTimes[originalKey] ?? 0;

          entries.add(
            CacheEntryMetadata(
              key: originalKey,
              fullKey: fullKey,
              accessTime: accessTime,
              size: entrySize,
              rawData: rawData,
            ),
          );
        }
      }

      // Sort by access time (oldest first for LRU)
      entries.sort((a, b) => a.accessTime.compareTo(b.accessTime));

      // Calculate cleanup targets
      final capacityTarget =
          targetBytes ?? (maxCapacity * cleanupThreshold).round();
      final entryTarget =
          targetEntries ?? (maxEntries * cleanupThreshold).round();

      int removedBytes = 0;
      int removedEntries = 0;
      final keysToRemove = <String>[];

      // Remove entries until we're under the targets
      for (final entry in entries) {
        if ((totalSize - removedBytes) <= capacityTarget &&
            (entries.length - removedEntries) <= entryTarget) {
          break;
        }

        // Check if entry is expired - prioritize removing expired entries
        try {
          final cacheEntry = _deserializeCacheEntry(entry.rawData);
          if (cacheEntry.isExpired) {
            keysToRemove.add(entry.fullKey);
            _accessTimes.remove(entry.key);
            removedBytes += entry.size;
            removedEntries++;
            continue;
          }
        } catch (e) {
          // Remove corrupted entries
          keysToRemove.add(entry.fullKey);
          _accessTimes.remove(entry.key);
          removedBytes += entry.size;
          removedEntries++;
          continue;
        }

        // Remove based on LRU if still over capacity
        if ((totalSize - removedBytes) > capacityTarget ||
            (entries.length - removedEntries) > entryTarget) {
          keysToRemove.add(entry.fullKey);
          _accessTimes.remove(entry.key);
          removedBytes += entry.size;
          removedEntries++;
        }
      }

      // Actually remove the keys
      for (final key in keysToRemove) {
        await _prefs.remove(key);
      }

      return Right(unit);
    } catch (e) {
      return Left(
        StorageFailureFactory.writeFailure(
          message: 'Failed to perform LRU cleanup: ${e.toString()}',
        ),
      );
    }
  }

  /// Check if cleanup is needed based on current capacity and entry count
  Future<Either<Failure, bool>> shouldPerformCleanup() async {
    try {
      final cacheKeys = _prefs
          .getKeys()
          .where((key) => key.startsWith(keyPrefix))
          .toList();

      // Check entry count limit
      if (cacheKeys.length >= maxEntries) {
        return Right(true);
      }

      // Check capacity limit
      int totalSize = 0;
      for (final key in cacheKeys) {
        final value = _prefs.getString(key);
        if (value != null) {
          totalSize += value.length * 2; // UTF-16 byte approximation
        }
      }

      final capacityRatio = totalSize / maxCapacity;
      return Right(capacityRatio >= cleanupThreshold);
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to check cleanup requirements: ${e.toString()}',
        ),
      );
    }
  }

  /// Record access to a cache key for LRU tracking
  void recordAccess(String key) {
    _accessTimes[key] = ++_accessCounter;
  }

  /// Get cache entry metadata for debugging and monitoring
  Future<Either<Failure, List<CacheEntryInfo>>> getCacheInfo() async {
    try {
      final cacheKeys = _prefs
          .getKeys()
          .where((key) => key.startsWith(keyPrefix))
          .toList();

      final List<CacheEntryInfo> info = [];

      for (final fullKey in cacheKeys) {
        final originalKey = fullKey.substring(keyPrefix.length);
        final rawData = _prefs.getString(fullKey);

        if (rawData != null) {
          try {
            final entry = _deserializeCacheEntry(rawData);
            final accessTime = _accessTimes[originalKey];

            info.add(
              CacheEntryInfo(
                key: originalKey,
                size: rawData.length * 2,
                isExpired: entry.isExpired,
                timestamp: entry.timestamp,
                ttl: entry.ttl,
                accessTime: accessTime,
                age: entry.age,
                timeToExpiry: entry.timeToExpiry,
              ),
            );
          } catch (e) {
            // Include corrupted entries in info
            info.add(
              CacheEntryInfo(
                key: originalKey,
                size: rawData.length * 2,
                isExpired: false,
                timestamp: DateTime.now(),
                isCorrupted: true,
              ),
            );
          }
        }
      }

      return Right(info);
    } catch (e) {
      return Left(
        StorageFailureFactory.readFailure(
          message: 'Failed to get cache info: ${e.toString()}',
        ),
      );
    }
  }

  /// Deserialize JSON string to cache entry
  CacheEntry _deserializeCacheEntry(String data) {
    final map = Map<String, dynamic>.from(
      // ignore: avoid_dynamic_calls
      const JsonCodec().decode(data) as Map<String, dynamic>,
    );

    return CacheEntry<dynamic>(
      value: map['value'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      ttl: map['ttl'] != null
          ? Duration(milliseconds: map['ttl'] as int)
          : null,
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
    );
  }
}

/// Internal metadata for cache entries during LRU processing
class CacheEntryMetadata {
  const CacheEntryMetadata({
    required this.key,
    required this.fullKey,
    required this.accessTime,
    required this.size,
    required this.rawData,
  });

  final String key;
  final String fullKey;
  final int accessTime;
  final int size;
  final String rawData;
}

/// Public cache entry information for monitoring
class CacheEntryInfo {
  const CacheEntryInfo({
    required this.key,
    required this.size,
    required this.isExpired,
    required this.timestamp,
    this.ttl,
    this.accessTime,
    this.age,
    this.timeToExpiry,
    this.isCorrupted = false,
  });

  final String key;
  final int size;
  final bool isExpired;
  final DateTime timestamp;
  final Duration? ttl;
  final int? accessTime;
  final Duration? age;
  final Duration? timeToExpiry;
  final bool isCorrupted;

  bool get isStale => isExpired || (timeToExpiry?.inSeconds ?? 1) <= 0;
  bool get hasBeenAccessed => accessTime != null;
}
