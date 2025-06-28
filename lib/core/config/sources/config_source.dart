/// 設定ソースの抽象インターフェース
abstract class ConfigSource {
  /// 設定ソースの名前
  String get sourceName;

  /// 初期化処理
  Future<void> initialize();

  /// 文字列値を取得
  Future<String?> getString(String key);

  /// ブール値を取得
  Future<bool?> getBool(String key);

  /// 整数値を取得
  Future<int?> getInt(String key);

  /// 浮動小数点値を取得
  Future<double?> getDouble(String key);

  /// 設定値が変更されたときに通知するストリーム
  Stream<String> get onConfigChanged;

  /// リソースのクリーンアップ
  Future<void> dispose();
}
