import 'package:passpal/core/storage/models/credentials.dart';

/// 認証情報の暗号化保存を行うインターフェース
abstract interface class CredentialStorage {
  /// 認証情報を暗号化して保存
  Future<void> save(Credentials credentials);

  /// 保存された認証情報を読み取り
  Future<Credentials?> read();

  /// 保存された認証情報を完全削除
  Future<void> purge();
}
