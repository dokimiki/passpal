import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:passpal/core/storage/interfaces/cache_storage_interface.dart';
import 'package:passpal/core/storage/services/cache_storage.dart';

void main() {
  group('CacheStorage', () {
    late CacheStorage cacheStorage;
    late SharedPreferences mockPrefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      mockPrefs = await SharedPreferences.getInstance();
      cacheStorage = CacheStorage(
        sharedPreferences: mockPrefs,
        keyPrefix: 'test_cache_',
        maxCapacity: 1024, // 1KB for testing
      );
    });

    tearDown(() {
      cacheStorage.dispose();
    });

    group('Basic Operations', () {
      test('should set and get string value', () async {
        const key = 'test_key';
        const value = 'test_value';

        final setResult = await cacheStorage.set(key, value);
        expect(setResult.isRight(), true);

        final getResult = await cacheStorage.get<String>(key);
        expect(getResult.isRight(), true);

        final entry = getResult.getOrElse(() => throw Exception());
        expect(entry.value, value);
        expect(entry.isValid, true);
      });

      test('should set and get complex object', () async {
        const key = 'test_object';
        final value = {
          'name': 'test',
          'count': 42,
          'items': ['a', 'b', 'c'],
        };

        final setResult = await cacheStorage.set(key, value);
        expect(setResult.isRight(), true);

        final getResult = await cacheStorage.get<Map<String, dynamic>>(key);
        expect(getResult.isRight(), true);

        final entry = getResult.getOrElse(() => throw Exception());
        expect(entry.value, value);
      });

      test('should return failure for non-existent key', () async {
        const key = 'non_existent_key';

        final result = await cacheStorage.get<String>(key);
        expect(result.isLeft(), true);
      });

      test('should delete entry successfully', () async {
        const key = 'test_delete';
        const value = 'test_value';

        await cacheStorage.set(key, value);

        final containsBefore = await cacheStorage.containsKey(key);
        expect(containsBefore.getOrElse(() => false), true);

        final deleteResult = await cacheStorage.delete(key);
        expect(deleteResult.isRight(), true);

        final containsAfter = await cacheStorage.containsKey(key);
        expect(containsAfter.getOrElse(() => true), false);
      });

      test('should clear all cache entries', () async {
        await cacheStorage.set('key1', 'value1');
        await cacheStorage.set('key2', 'value2');
        await cacheStorage.set('key3', 'value3');

        final clearResult = await cacheStorage.clear();
        expect(clearResult.isRight(), true);

        final key1Result = await cacheStorage.containsKey('key1');
        final key2Result = await cacheStorage.containsKey('key2');
        final key3Result = await cacheStorage.containsKey('key3');

        expect(key1Result.getOrElse(() => true), false);
        expect(key2Result.getOrElse(() => true), false);
        expect(key3Result.getOrElse(() => true), false);
      });
    });

    group('TTL Support', () {
      test('should expire entry after TTL', () async {
        const key = 'ttl_test';
        const value = 'test_value';
        final ttl = Duration(milliseconds: 100);

        await cacheStorage.set(key, value, ttl: ttl);

        // Should be valid immediately
        final immediateResult = await cacheStorage.get<String>(key);
        expect(immediateResult.isRight(), true);

        // Wait for expiration
        await Future.delayed(Duration(milliseconds: 150));

        // Should be expired now
        final expiredResult = await cacheStorage.get<String>(key);
        expect(expiredResult.isLeft(), true);
      });

      test('should return stale data with getStale', () async {
        const key = 'stale_test';
        const value = 'test_value';
        final ttl = Duration(milliseconds: 100);

        await cacheStorage.set(key, value, ttl: ttl);

        // Wait for expiration
        await Future.delayed(Duration(milliseconds: 150));

        // getStale should return data even if expired
        final staleResult = await cacheStorage.getStale<String>(key);
        expect(staleResult.isRight(), true);

        final entry = staleResult.getOrElse(() => null);
        expect(entry?.value, value);
        expect(entry?.isExpired, true);
      });

      test('should set entry without TTL (never expires)', () async {
        const key = 'no_ttl_test';
        const value = 'persistent_value';

        await cacheStorage.set(key, value); // No TTL

        final result = await cacheStorage.get<String>(key);
        expect(result.isRight(), true);

        final entry = result.getOrElse(() => throw Exception());
        expect(entry.ttl, null);
        expect(entry.isExpired, false);
        expect(entry.isValid, true);
      });
    });

    group('Capacity Management', () {
      test('should report cache statistics', () async {
        await cacheStorage.set('stats_key1', 'value1');
        await cacheStorage.set('stats_key2', 'value2');

        final statsResult = await cacheStorage.getStats();
        expect(statsResult.isRight(), true);

        final stats = statsResult.getOrElse(() => throw Exception());
        expect(stats.totalEntries, 2);
        expect(stats.totalSize, greaterThan(0));
        expect(stats.maxCapacity, 1024);
      });

      test('should fail when capacity is exceeded', () async {
        // Create a large value that exceeds the 1KB test capacity
        final largeValue = 'x' * 2000; // 2KB string

        final result = await cacheStorage.set('large_key', largeValue);
        expect(result.isLeft(), true);
      });
    });

    group('Cleanup Operations', () {
      test('should cleanup expired entries', () async {
        const shortTtl = Duration(milliseconds: 50);
        const longTtl = Duration(milliseconds: 500);

        await cacheStorage.set('short_key', 'short_value', ttl: shortTtl);
        await cacheStorage.set('long_key', 'long_value', ttl: longTtl);

        // Wait for short TTL to expire
        await Future.delayed(Duration(milliseconds: 100));

        final cleanupResult = await cacheStorage.cleanup();
        expect(cleanupResult.isRight(), true);

        // Short key should be gone
        final shortResult = await cacheStorage.containsKey('short_key');
        expect(shortResult.getOrElse(() => true), false);

        // Long key should still exist
        final longResult = await cacheStorage.containsKey('long_key');
        expect(longResult.getOrElse(() => false), true);
      });
    });

    group('Event Streams', () {
      test('should emit events for cache operations', () async {
        final events = <CacheEvent>[];
        final subscription = cacheStorage.changes.listen(events.add);

        const key = 'event_test';
        const value = 'test_value';

        await cacheStorage.set(key, value);
        await cacheStorage.set(key, 'updated_value'); // Update
        await cacheStorage.delete(key);

        // Give stream time to emit events
        await Future.delayed(Duration(milliseconds: 10));

        expect(events.length, greaterThanOrEqualTo(2));
        expect(events.any((e) => e is CacheEntryAdded), true);
        expect(events.any((e) => e is CacheEntryRemoved), true);

        await subscription.cancel();
      });
    });

    group('Error Handling', () {
      test('should handle JSON serialization errors gracefully', () async {
        // Create a circular reference object that can't be serialized
        final circular = <String, dynamic>{};
        circular['self'] = circular;

        final result = await cacheStorage.set('circular_key', circular);
        expect(result.isLeft(), true);
      });

      test('should handle containsKey for expired entries', () async {
        const key = 'contains_test';
        const value = 'test_value';
        final shortTtl = Duration(milliseconds: 50);

        await cacheStorage.set(key, value, ttl: shortTtl);

        // Should contain key initially
        final beforeExpiry = await cacheStorage.containsKey(key);
        expect(beforeExpiry.getOrElse(() => false), true);

        // Wait for expiration
        await Future.delayed(Duration(milliseconds: 100));

        // Should not contain key after expiry
        final afterExpiry = await cacheStorage.containsKey(key);
        expect(afterExpiry.getOrElse(() => true), false);
      });
    });

    group('Key Prefix', () {
      test('should use correct key prefix', () {
        const testKey = 'my_key';
        final builtKey = cacheStorage.buildKeyForTesting(testKey);
        expect(builtKey, 'test_cache_my_key');
      });

      test('should isolate cache keys with prefix', () async {
        // Create another cache storage with different prefix
        final otherCache = CacheStorage(
          sharedPreferences: mockPrefs,
          keyPrefix: 'other_cache_',
        );

        await cacheStorage.set('shared_key', 'value1');
        await otherCache.set('shared_key', 'value2');

        final result1 = await cacheStorage.get<String>('shared_key');
        final result2 = await otherCache.get<String>('shared_key');

        expect(result1.getOrElse(() => throw Exception()).value, 'value1');
        expect(result2.getOrElse(() => throw Exception()).value, 'value2');

        otherCache.dispose();
      });
    });
  });
}
