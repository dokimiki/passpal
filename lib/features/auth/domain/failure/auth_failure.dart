import 'package:meta/meta.dart';

/// 認証処理で発生する失敗を表すsealed class
@immutable
sealed class AuthFailure {
  const AuthFailure();
}

/// 認証情報が無効な場合の失敗
class InvalidCredential extends AuthFailure {
  const InvalidCredential();

  @override
  String toString() => 'AuthFailure.invalidCredential()';

  @override
  bool operator ==(Object other) => other is InvalidCredential;

  @override
  int get hashCode => 0;
}

/// ネットワーク接続に関する失敗
class Network extends AuthFailure {
  const Network();

  @override
  String toString() => 'AuthFailure.network()';

  @override
  bool operator ==(Object other) => other is Network;

  @override
  int get hashCode => 1;
}

/// サーバーエラーに関する失敗
class Server extends AuthFailure {
  const Server([this.code]);

  final int? code;

  @override
  String toString() => 'AuthFailure.server(${code ?? 'null'})';

  @override
  bool operator ==(Object other) => other is Server && other.code == code;

  @override
  int get hashCode => code.hashCode;
}

/// 不明なエラーに関する失敗
class Unknown extends AuthFailure {
  const Unknown();

  @override
  String toString() => 'AuthFailure.unknown()';

  @override
  bool operator ==(Object other) => other is Unknown;

  @override
  int get hashCode => 2;
}

/// ファクトリーコンストラクタのためのヘルパー関数
extension AuthFailureFactories on AuthFailure {
  static AuthFailure invalidCredential() => const InvalidCredential();
  static AuthFailure network() => const Network();
  static AuthFailure server([int? code]) => Server(code);
  static AuthFailure unknown() => const Unknown();
}
