import 'package:fpdart/fpdart.dart';
import '../entity/user.dart';
import '../failure/auth_failure.dart';

/// 認証機能を提供するリポジトリのインターフェース
abstract class AuthRepository {
  /// 学籍番号とパスワードを使用してサインインを実行
  ///
  /// [id] 学籍番号
  /// [pw] パスワード
  ///
  /// 成功時は[User]、失敗時は[AuthFailure]を返す
  Future<Either<AuthFailure, User>> signIn(String id, String pw);
}
