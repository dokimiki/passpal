/// JSONデータのキャッシュとストリーミング監視を行うインターフェース
abstract interface class KeyValueCache {
  /// JSONデータを指定キーで保存
  Future<void> putJson(String key, Map<String, dynamic> value);

  /// 指定キーのJSONデータを監視するストリーム
  Stream<Map<String, dynamic>?> watchJson(String key);

  /// 指定キーのデータを削除
  Future<void> remove(String key);
}
