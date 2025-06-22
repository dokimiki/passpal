import 'package:fpdart/fpdart.dart';
import '../entity/user.dart';
import '../failure/auth_failure.dart';
import '../repository/auth_repository.dart';

/// サインイン処理を実行するユースケース
class SignIn {
  const SignIn(this._repo);

  final AuthRepository _repo;

  /// サインインを実行する
  ///
  /// [id] 学籍番号
  /// [pw] パスワード
  ///
  /// 成功時は[User]、失敗時は[AuthFailure]を返す
  Future<Either<AuthFailure, User>> call({
    required String id,
    required String pw,
  }) => _repo.signIn(id, pw);
}
