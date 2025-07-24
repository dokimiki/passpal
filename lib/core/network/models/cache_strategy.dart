/// Caching strategy for network requests
enum CacheStrategy {
  /// No caching - always fetch fresh data
  noCache,

  /// Cache only - return cached data, fail if not available
  cacheOnly,

  /// Cache first - return cached data if available, otherwise fetch
  cacheFirst,

  /// Network first - fetch from network, fallback to cache on failure
  networkFirst,

  /// Stale while revalidate - return cached data immediately, fetch in background
  staleWhileRevalidate,

  /// Force refresh - fetch from network and update cache
  forceRefresh,
}

/// Extension methods for CacheStrategy
extension CacheStrategyExtension on CacheStrategy {
  /// Whether this strategy allows returning cached data
  bool get allowsCache => switch (this) {
    CacheStrategy.noCache => false,
    CacheStrategy.forceRefresh => false,
    _ => true,
  };

  /// Whether this strategy requires network access
  bool get requiresNetwork => switch (this) {
    CacheStrategy.cacheOnly => false,
    CacheStrategy.cacheFirst => false,
    _ => true,
  };

  /// Whether this strategy should update cache after network request
  bool get shouldUpdateCache => switch (this) {
    CacheStrategy.noCache => false,
    CacheStrategy.cacheOnly => false,
    _ => true,
  };
}
