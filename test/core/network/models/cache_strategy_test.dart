import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/network/models/cache_strategy.dart';

void main() {
  group('CacheStrategy', () {
    test('should have all expected values', () {
      expect(CacheStrategy.values, hasLength(6));
      expect(CacheStrategy.values, contains(CacheStrategy.noCache));
      expect(CacheStrategy.values, contains(CacheStrategy.cacheOnly));
      expect(CacheStrategy.values, contains(CacheStrategy.cacheFirst));
      expect(CacheStrategy.values, contains(CacheStrategy.networkFirst));
      expect(
        CacheStrategy.values,
        contains(CacheStrategy.staleWhileRevalidate),
      );
      expect(CacheStrategy.values, contains(CacheStrategy.forceRefresh));
    });

    group('allowsCache', () {
      test('should return false for noCache', () {
        expect(CacheStrategy.noCache.allowsCache, isFalse);
      });

      test('should return false for forceRefresh', () {
        expect(CacheStrategy.forceRefresh.allowsCache, isFalse);
      });

      test('should return true for other strategies', () {
        expect(CacheStrategy.cacheOnly.allowsCache, isTrue);
        expect(CacheStrategy.cacheFirst.allowsCache, isTrue);
        expect(CacheStrategy.networkFirst.allowsCache, isTrue);
        expect(CacheStrategy.staleWhileRevalidate.allowsCache, isTrue);
      });
    });

    group('requiresNetwork', () {
      test('should return false for cacheOnly', () {
        expect(CacheStrategy.cacheOnly.requiresNetwork, isFalse);
      });

      test('should return false for cacheFirst', () {
        expect(CacheStrategy.cacheFirst.requiresNetwork, isFalse);
      });

      test('should return true for other strategies', () {
        expect(CacheStrategy.noCache.requiresNetwork, isTrue);
        expect(CacheStrategy.networkFirst.requiresNetwork, isTrue);
        expect(CacheStrategy.staleWhileRevalidate.requiresNetwork, isTrue);
        expect(CacheStrategy.forceRefresh.requiresNetwork, isTrue);
      });
    });

    group('shouldUpdateCache', () {
      test('should return false for noCache', () {
        expect(CacheStrategy.noCache.shouldUpdateCache, isFalse);
      });

      test('should return false for cacheOnly', () {
        expect(CacheStrategy.cacheOnly.shouldUpdateCache, isFalse);
      });

      test('should return true for other strategies', () {
        expect(CacheStrategy.cacheFirst.shouldUpdateCache, isTrue);
        expect(CacheStrategy.networkFirst.shouldUpdateCache, isTrue);
        expect(CacheStrategy.staleWhileRevalidate.shouldUpdateCache, isTrue);
        expect(CacheStrategy.forceRefresh.shouldUpdateCache, isTrue);
      });
    });
  });
}
