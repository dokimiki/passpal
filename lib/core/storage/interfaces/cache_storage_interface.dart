import 'package:dartz/dartz.dart';

import '../../../core/error/models/failure.dart';
import '../models/cache_entry.dart';

/// Interface for cache storage operations with TTL support
///
/// Provides type-safe caching with automatic expiration, capacity management,
/// and reactive updates. Supports stale-while-revalidate patterns for
/// optimal user experience.
abstract interface class CacheStorageInterface {
  /// Read a cached value by key
  ///
  /// Returns [Right] with the cached entry or [Left] with [Failure] if
  /// the key doesn't exist, is expired, or an error occurs.
  Future<Either<Failure, CacheEntry<T>>> get<T>(String key);

  /// Write a value to cache with optional TTL
  ///
  /// Stores the [value] with the given [key] and optional [ttl].
  /// If [ttl] is null, the entry never expires.
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  Future<Either<Failure, Unit>> set<T>(String key, T value, {Duration? ttl});

  /// Delete a cached entry
  ///
  /// Removes the entry with the given [key] from cache.
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  /// Does not fail if the key doesn't exist.
  Future<Either<Failure, Unit>> delete(String key);

  /// Check if a key exists and is not expired
  ///
  /// Returns [Right] with true if the key exists and is valid, false otherwise.
  /// Returns [Left] with [Failure] if an error occurs during the check.
  Future<Either<Failure, bool>> containsKey(String key);

  /// Clear all cached entries
  ///
  /// Removes all cached entries from storage.
  /// Returns [Right] with [Unit] on success or [Left] with [Failure] on error.
  Future<Either<Failure, Unit>> clear();

  /// Get cache statistics
  ///
  /// Returns information about cache size, hit rate, and capacity usage.
  Future<Either<Failure, CacheStats>> getStats();

  /// Clean up expired entries
  ///
  /// Removes all expired entries from cache storage.
  /// This is automatically called periodically but can be manually triggered.
  Future<Either<Failure, Unit>> cleanup();

  /// Stream of cache entry changes
  ///
  /// Emits cache key when an entry is added, updated, or removed.
  /// Useful for reactive UI updates based on cache changes.
  Stream<CacheEvent> get changes;

  /// Get stale entry while revalidating
  ///
  /// Returns stale cached data immediately while triggering background refresh.
  /// Part of stale-while-revalidate (SWR) strategy for better UX.
  Future<Either<Failure, CacheEntry<T>?>> getStale<T>(String key);
}

/// Cache statistics for monitoring and debugging
class CacheStats {
  const CacheStats({
    required this.totalEntries,
    required this.totalSize,
    required this.hitCount,
    required this.missCount,
    required this.expiredCount,
    required this.maxCapacity,
  });

  final int totalEntries;
  final int totalSize; // in bytes
  final int hitCount;
  final int missCount;
  final int expiredCount;
  final int maxCapacity; // in bytes

  double get hitRate =>
      (hitCount + missCount) > 0 ? hitCount / (hitCount + missCount) : 0.0;

  double get capacityUsage => maxCapacity > 0 ? totalSize / maxCapacity : 0.0;
}

/// Cache event for reactive updates
sealed class CacheEvent {
  const CacheEvent(this.key);
  final String key;
}

class CacheEntryAdded extends CacheEvent {
  const CacheEntryAdded(super.key);
}

class CacheEntryUpdated extends CacheEvent {
  const CacheEntryUpdated(super.key);
}

class CacheEntryRemoved extends CacheEvent {
  const CacheEntryRemoved(super.key);
}

class CacheEntryExpired extends CacheEvent {
  const CacheEntryExpired(super.key);
}
