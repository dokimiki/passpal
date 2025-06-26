import 'package:test/test.dart';
import 'package:passpal/core/storage/cache_policy/default_cache_policy.dart';

void main() {
  group('DefaultCachePolicy', () {
    group('isStale', () {
      test('should return false when data is fresh', () {
        final now = DateTime(2025, 6, 26, 12, 0, 0);
        final policy = DefaultCachePolicy(clock: () => now);
        
        // 30分前のデータ、TTL = 1時間
        final lastFetchedAt = DateTime(2025, 6, 26, 11, 30, 0).toIso8601String();
        const ttl = Duration(hours: 1);
        
        expect(policy.isStale(lastFetchedAt, ttl), isFalse);
      });

      test('should return true when data is stale', () {
        final now = DateTime(2025, 6, 26, 12, 0, 0);
        final policy = DefaultCachePolicy(clock: () => now);
        
        // 2時間前のデータ、TTL = 1時間
        final lastFetchedAt = DateTime(2025, 6, 26, 10, 0, 0).toIso8601String();
        const ttl = Duration(hours: 1);
        
        expect(policy.isStale(lastFetchedAt, ttl), isTrue);
      });

      test('should return true when data is exactly at TTL boundary', () {
        final now = DateTime(2025, 6, 26, 12, 0, 0);
        final policy = DefaultCachePolicy(clock: () => now);
        
        // ちょうど1時間前のデータ、TTL = 1時間
        final lastFetchedAt = DateTime(2025, 6, 26, 11, 0, 0).toIso8601String();
        const ttl = Duration(hours: 1);
        
        expect(policy.isStale(lastFetchedAt, ttl), isFalse);
      });

      test('should return true when data is just over TTL boundary', () {
        final now = DateTime(2025, 6, 26, 12, 0, 1);
        final policy = DefaultCachePolicy(clock: () => now);
        
        // 1時間1秒前のデータ、TTL = 1時間
        final lastFetchedAt = DateTime(2025, 6, 26, 11, 0, 0).toIso8601String();
        const ttl = Duration(hours: 1);
        
        expect(policy.isStale(lastFetchedAt, ttl), isTrue);
      });

      test('should return true for invalid timestamp', () {
        final now = DateTime(2025, 6, 26, 12, 0, 0);
        final policy = DefaultCachePolicy(clock: () => now);
        
        const invalidTimestamp = 'invalid-timestamp';
        const ttl = Duration(hours: 1);
        
        expect(policy.isStale(invalidTimestamp, ttl), isTrue);
      });

      test('should work with different TTL durations', () {
        final now = DateTime(2025, 6, 26, 12, 0, 0);
        final policy = DefaultCachePolicy(clock: () => now);
        
        // 30分前のデータ
        final lastFetchedAt = DateTime(2025, 6, 26, 11, 30, 0).toIso8601String();
        
        // TTL = 15分 → stale
        expect(policy.isStale(lastFetchedAt, const Duration(minutes: 15)), isTrue);
        
        // TTL = 45分 → fresh
        expect(policy.isStale(lastFetchedAt, const Duration(minutes: 45)), isFalse);
        
        // TTL = 3日 → fresh
        expect(policy.isStale(lastFetchedAt, const Duration(days: 3)), isFalse);
      });
    });

    group('now', () {
      test('should return current time when no clock provided', () {
        final policy = DefaultCachePolicy();
        final before = DateTime.now();
        final result = policy.now;
        final after = DateTime.now();
        
        expect(result.isAfter(before) || result.isAtSameMomentAs(before), isTrue);
        expect(result.isBefore(after) || result.isAtSameMomentAs(after), isTrue);
      });

      test('should return custom time when clock provided', () {
        final customTime = DateTime(2025, 6, 26, 12, 0, 0);
        final policy = DefaultCachePolicy(clock: () => customTime);
        
        expect(policy.now, equals(customTime));
      });
    });
  });
}
