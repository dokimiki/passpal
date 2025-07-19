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

    group('Advanced LRU Capacity Management', () {
      test('should perform LRU cleanup when capacity is exceeded', () async {
        // Fill cache to about 80% capacity first
        await cacheStorage.set('key1', 'x' * 200);
        await Future.delayed(Duration(milliseconds: 10));
        await cacheStorage.set('key2', 'x' * 200);
        await Future.delayed(Duration(milliseconds: 10));
        await cacheStorage.set('key3', 'x' * 200);

        // Access key1 to make it most recently used
        await cacheStorage.get<String>('key1');

        // Try to add an entry that should trigger cleanup but fit after cleanup
        final additionalValue =
            'x' * 300; // Should trigger cleanup but then fit
        final result = await cacheStorage.set(
          'additional_key',
          additionalValue,
        );
        expect(result.isRight(), true);

        // Verify that cleanup happened by checking total size is reasonable
        final stats = await cacheStorage.getStats();
        expect(stats.isRight(), true);
        final statsData = stats.getOrElse(() => throw Exception());
        expect(statsData.totalSize, lessThan(1024)); // Should be under capacity
        expect(
          statsData.totalEntries,
          greaterThan(0),
        ); // Should have some entries left
      });

      test('should track access times for LRU', () async {
        await cacheStorage.set('accessed_key', 'value');
        await cacheStorage.set('not_accessed_key', 'value');

        // Access one key multiple times
        await cacheStorage.get<String>('accessed_key');
        await cacheStorage.get<String>('accessed_key');

        final cacheInfo = await cacheStorage.getCacheInfo();
        expect(cacheInfo.isRight(), true);

        final info = cacheInfo.getOrElse(() => []);
        final accessedInfo = info.firstWhere((i) => i.key == 'accessed_key');
        final notAccessedInfo = info.firstWhere(
          (i) => i.key == 'not_accessed_key',
        );

        expect(accessedInfo.hasBeenAccessed, true);
        expect(notAccessedInfo.hasBeenAccessed, false);
      });

      test('should perform auto cleanup when threshold is reached', () async {
        // Fill cache to trigger auto cleanup
        await cacheStorage.set('fill1', 'x' * 200);
        await cacheStorage.set('fill2', 'x' * 200);
        await cacheStorage.set('fill3', 'x' * 200);

        final cleanupResult = await cacheStorage.performAutoCleanup();
        expect(cleanupResult.isRight(), true);
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

      test('should emit value change events', () async {
        final valueEvents = <CacheValueEvent>[];
        final subscription = cacheStorage.valueChanges.listen(valueEvents.add);

        const key = 'value_event_test';
        const value1 = 'initial_value';
        const value2 = 'updated_value';

        await cacheStorage.set(key, value1);
        await cacheStorage.set(key, value2);
        await cacheStorage.delete(key);

        // Give stream time to emit events
        await Future.delayed(Duration(milliseconds: 10));

        expect(valueEvents.length, greaterThanOrEqualTo(2));
        expect(valueEvents.any((e) => e is CacheValueChanged), true);
        expect(valueEvents.any((e) => e is CacheValueDeleted), true);

        await subscription.cancel();
      });

      test('should watch specific key changes', () async {
        const key = 'watch_key';
        final keyChanges = <String?>[];

        final subscription = cacheStorage.watchKey<String>(key).listen((entry) {
          keyChanges.add(entry?.value);
        });

        // Should emit null initially since key doesn't exist
        await Future.delayed(Duration(milliseconds: 10));
        expect(keyChanges.first, null);

        await cacheStorage.set(key, 'value1');
        await Future.delayed(Duration(milliseconds: 10));

        await cacheStorage.set(key, 'value2');
        await Future.delayed(Duration(milliseconds: 10));

        await cacheStorage.delete(key);
        await Future.delayed(Duration(milliseconds: 10));

        expect(keyChanges.length, greaterThanOrEqualTo(3));
        expect(keyChanges.contains('value1'), true);
        expect(keyChanges.contains('value2'), true);

        await subscription.cancel();
      });

      test('should watch multiple keys', () async {
        final keys = ['key1', 'key2', 'key3'];
        final mapChanges = <Map<String, dynamic>>[];

        final subscription = cacheStorage.watchKeys(keys).listen((entryMap) {
          final valueMap = entryMap.map((k, v) => MapEntry(k, v?.value));
          mapChanges.add(valueMap);
        });

        // Initial state should have all null values
        await Future.delayed(Duration(milliseconds: 10));

        await cacheStorage.set('key1', 'value1');
        await Future.delayed(Duration(milliseconds: 10));

        await cacheStorage.set('key2', 'value2');
        await Future.delayed(Duration(milliseconds: 10));

        expect(mapChanges.length, greaterThanOrEqualTo(2));
        expect(mapChanges.last['key1'], 'value1');
        expect(mapChanges.last['key2'], 'value2');

        await subscription.cancel();
      });
    });

    group('Stale-While-Revalidate (SWR)', () {
      test(
        'should return stale data and trigger background revalidation',
        () async {
          const key = 'swr_test';
          const staleValue = 'stale_data';
          const freshValue = 'fresh_data';

          // Set initial data with short TTL
          await cacheStorage.set(
            key,
            staleValue,
            ttl: Duration(milliseconds: 50),
          );

          // Wait for expiration
          await Future.delayed(Duration(milliseconds: 100));

          bool revalidateCalled = false;
          Future<String> revalidate() async {
            revalidateCalled = true;
            await Future.delayed(
              Duration(milliseconds: 100),
            ); // Simulate network delay
            return freshValue;
          }

          // SWR should return stale data immediately
          final swrResult = await cacheStorage.swr(key, revalidate);
          expect(swrResult.isRight(), true);

          final entry = swrResult.getOrElse(() => null);
          expect(entry?.value, staleValue);
          expect(revalidateCalled, true);

          // Wait for background revalidation to complete
          await Future.delayed(Duration(milliseconds: 200));

          // Should now have fresh data
          final freshResult = await cacheStorage.get<String>(key);
          expect(freshResult.isRight(), true);
          expect(
            freshResult.getOrElse(() => throw Exception()).value,
            freshValue,
          );
        },
      );

      test(
        'should return null for cache miss and trigger revalidation',
        () async {
          const key = 'swr_miss_test';
          const freshValue = 'fresh_data';

          bool revalidateCalled = false;
          Future<String> revalidate() async {
            revalidateCalled = true;
            return freshValue;
          }

          // SWR for non-existent key should return null
          final swrResult = await cacheStorage.swr(key, revalidate);
          expect(swrResult.isRight(), true);
          expect(swrResult.getOrElse(() => throw Exception()), null);
          expect(revalidateCalled, true);

          // Wait for background revalidation
          await Future.delayed(Duration(milliseconds: 50));

          // Should now have fresh data
          final freshResult = await cacheStorage.get<String>(key);
          expect(freshResult.isRight(), true);
          expect(
            freshResult.getOrElse(() => throw Exception()).value,
            freshValue,
          );
        },
      );

      test('should handle SWR with fallback', () async {
        const key = 'swr_fallback_test';
        const freshValue = 'fresh_data';

        Future<String> revalidate() async {
          await Future.delayed(Duration(milliseconds: 50));
          return freshValue;
        }

        // SWR with fallback should wait for revalidation when no cache exists
        final result = await cacheStorage.swrWithFallback(key, revalidate);
        expect(result.isRight(), true);

        final entry = result.getOrElse(() => throw Exception());
        expect(entry.value, freshValue);
      });

      test('should handle SWR timeout', () async {
        const key = 'swr_timeout_test';

        Future<String> slowRevalidate() async {
          await Future.delayed(
            Duration(milliseconds: 500),
          ); // Slow revalidation
          return 'should_not_reach_here';
        }

        // SWR with short timeout should fail
        final result = await cacheStorage.swrWithFallback(
          key,
          slowRevalidate,
          timeout: Duration(milliseconds: 100),
        );
        expect(result.isLeft(), true);
      });

      test('should force revalidation when requested', () async {
        const key = 'swr_force_test';
        const staleValue = 'stale_data';
        const freshValue = 'fresh_data';

        await cacheStorage.set(key, staleValue);

        bool revalidateCalled = false;
        Future<String> revalidate() async {
          revalidateCalled = true;
          return freshValue;
        }

        // Force revalidation even though data is fresh
        final swrResult = await cacheStorage.swr(
          key,
          revalidate,
          forceRevalidate: true,
        );

        expect(revalidateCalled, true);

        // When forcing revalidation, swr returns null since it skips getting stale data
        final entry = swrResult.getOrElse(() => null);
        expect(entry, null);
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

      test('should handle corrupted cache entries gracefully', () async {
        const key = 'corrupted_test';

        // Manually set corrupted data
        final cacheKey = cacheStorage.buildKeyForTesting(key);
        await mockPrefs.setString(cacheKey, 'invalid_json{broken');

        // Should handle corrupted data gracefully
        final result = await cacheStorage.get<String>(key);
        expect(result.isLeft(), true);

        // Cleanup should remove corrupted entries
        final cleanupResult = await cacheStorage.cleanup();
        expect(cleanupResult.isRight(), true);
      });

      test('should handle empty cache gracefully', () async {
        final statsResult = await cacheStorage.getStats();
        expect(statsResult.isRight(), true);

        final stats = statsResult.getOrElse(() => throw Exception());
        expect(stats.totalEntries, 0);
        expect(stats.totalSize, 0);

        final cleanupResult = await cacheStorage.cleanup();
        expect(cleanupResult.isRight(), true);
      });

      test('should handle concurrent operations', () async {
        const key = 'concurrent_test';

        // Run multiple operations concurrently
        final futures = [
          cacheStorage.set(key, 'value1'),
          cacheStorage.set(key, 'value2'),
          cacheStorage.get<String>(key),
          cacheStorage.containsKey(key),
          cacheStorage.getStats(),
        ];

        final results = await Future.wait(futures);

        // All operations should complete without throwing
        expect(results.length, 5);
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
