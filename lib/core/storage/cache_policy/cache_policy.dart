/// キャッシュのTTL判定とSWRロジックを提供するインターフェース
abstract interface class CachePolicy {
  /// 指定した時刻から現在までの経過時間がTTLを超えているか判定
  bool isStale(String lastFetchedAt, Duration ttl);
  
  /// 現在時刻を取得（テスト用のオーバーライド可能）
  DateTime get now;
}
