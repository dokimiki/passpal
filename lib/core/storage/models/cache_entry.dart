/// A cache entry with value, timestamp, and TTL support
///
/// Represents a single cached item with metadata for expiration
/// and validation. Generic type T represents the cached value type.
class CacheEntry<T> {
  const CacheEntry({
    required this.value,
    required this.timestamp,
    this.ttl,
    this.metadata = const {},
  });

  /// The cached value
  final T value;

  /// When this entry was created
  final DateTime timestamp;

  /// Time-to-live duration, null means never expires
  final Duration? ttl;

  /// Additional metadata for the cache entry
  final Map<String, dynamic> metadata;

  /// Check if this cache entry is expired
  bool get isExpired {
    if (ttl == null) return false;
    return DateTime.now().isAfter(timestamp.add(ttl!));
  }

  /// Check if this cache entry is still valid (not expired)
  bool get isValid => !isExpired;

  /// Get the expiration time, null if never expires
  DateTime? get expiresAt => ttl != null ? timestamp.add(ttl!) : null;

  /// Get the age of this cache entry
  Duration get age => DateTime.now().difference(timestamp);

  /// Get the remaining time until expiration, null if never expires
  Duration? get timeToExpiry {
    if (ttl == null) return null;
    final expiry = timestamp.add(ttl!);
    final now = DateTime.now();
    if (now.isAfter(expiry)) return Duration.zero;
    return expiry.difference(now);
  }

  /// Create a new cache entry with updated TTL
  CacheEntry<T> withTtl(Duration? newTtl) => CacheEntry<T>(
    value: value,
    timestamp: timestamp,
    ttl: newTtl,
    metadata: metadata,
  );

  /// Create a new cache entry with updated value but same metadata
  CacheEntry<U> withValue<U>(U newValue) => CacheEntry<U>(
    value: newValue,
    timestamp: timestamp,
    ttl: ttl,
    metadata: metadata,
  );

  /// Create a new cache entry with additional metadata
  CacheEntry<T> withMetadata(Map<String, dynamic> additionalMetadata) =>
      CacheEntry<T>(
        value: value,
        timestamp: timestamp,
        ttl: ttl,
        metadata: {...metadata, ...additionalMetadata},
      );
}
