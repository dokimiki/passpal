import 'package:passpal/core/storage/cache_policy/cache_policy.dart';

/// デフォルトのCachePolicyの実装
class DefaultCachePolicy implements CachePolicy {
  const DefaultCachePolicy({DateTime Function()? clock}) : _clock = clock;

  final DateTime Function()? _clock;

  @override
  DateTime get now => _clock?.call() ?? DateTime.now();

  @override
  bool isStale(String lastFetchedAt, Duration ttl) {
    try {
      final fetchedTime = DateTime.parse(lastFetchedAt);
      final elapsed = now.difference(fetchedTime);
      return elapsed > ttl;
    } catch (e) {
      // パース失敗時は古いデータとして扱う
      return true;
    }
  }
}
