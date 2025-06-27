import 'package:passpal/core/error/app_exception.dart';

/// 認証関連の例外
sealed class AuthenticationException extends AppException {
  const AuthenticationException({
    required super.message,
    super.stack,
    super.isFatal = false,
  });

  /// 認証情報が無効
  const factory AuthenticationException.invalidCredential({
    required String message,
    StackTrace? stack,
  }) = _AuthenticationExceptionInvalidCredential;

  /// セッション期限切れ
  const factory AuthenticationException.sessionExpired({
    required String message,
    StackTrace? stack,
  }) = _AuthenticationExceptionSessionExpired;

  /// アカウント未リンク
  const factory AuthenticationException.accountNotLinked({
    required String message,
    StackTrace? stack,
  }) = _AuthenticationExceptionAccountNotLinked;

  /// 一般的な認証エラー
  const factory AuthenticationException.generic({
    required String message,
    StackTrace? stack,
  }) = _AuthenticationExceptionGeneric;

  AuthenticationExceptionKind get kind {
    return switch (this) {
      _AuthenticationExceptionInvalidCredential() =>
        AuthenticationExceptionKind.invalidCredential,
      _AuthenticationExceptionSessionExpired() =>
        AuthenticationExceptionKind.sessionExpired,
      _AuthenticationExceptionAccountNotLinked() =>
        AuthenticationExceptionKind.accountNotLinked,
      _AuthenticationExceptionGeneric() => AuthenticationExceptionKind.generic,
    };
  }
}

/// アカウントリンク関連の例外
sealed class AccountLinkException extends AppException {
  const AccountLinkException({
    required super.message,
    super.stack,
    super.isFatal = false,
  });

  /// ドメインミスマッチ
  const factory AccountLinkException.domainMismatch({
    required String message,
    StackTrace? stack,
  }) = _AccountLinkExceptionDomainMismatch;

  /// 未認証
  const factory AccountLinkException.emailNotVerified({
    required String message,
    StackTrace? stack,
  }) = _AccountLinkExceptionEmailNotVerified;

  AccountLinkExceptionKind get kind {
    return switch (this) {
      _AccountLinkExceptionDomainMismatch() =>
        AccountLinkExceptionKind.domainMismatch,
      _AccountLinkExceptionEmailNotVerified() =>
        AccountLinkExceptionKind.emailNotVerified,
    };
  }
}

enum AuthenticationExceptionKind {
  invalidCredential,
  sessionExpired,
  accountNotLinked,
  generic,
}

enum AccountLinkExceptionKind { domainMismatch, emailNotVerified }

// 実装クラス
final class _AuthenticationExceptionInvalidCredential
    extends AuthenticationException {
  const _AuthenticationExceptionInvalidCredential({
    required super.message,
    super.stack,
  });
}

final class _AuthenticationExceptionSessionExpired
    extends AuthenticationException {
  const _AuthenticationExceptionSessionExpired({
    required super.message,
    super.stack,
  });
}

final class _AuthenticationExceptionAccountNotLinked
    extends AuthenticationException {
  const _AuthenticationExceptionAccountNotLinked({
    required super.message,
    super.stack,
  });
}

final class _AuthenticationExceptionGeneric extends AuthenticationException {
  const _AuthenticationExceptionGeneric({required super.message, super.stack});
}

final class _AccountLinkExceptionDomainMismatch extends AccountLinkException {
  const _AccountLinkExceptionDomainMismatch({
    required super.message,
    super.stack,
  });
}

final class _AccountLinkExceptionEmailNotVerified extends AccountLinkException {
  const _AccountLinkExceptionEmailNotVerified({
    required super.message,
    super.stack,
  });
}
