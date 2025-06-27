import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/auth/models/auth_session.dart';

part 'auth_state.freezed.dart';

/// 認証状態
@freezed
sealed class AuthState with _$AuthState {
  /// 未認証
  const factory AuthState.unauthenticated() = _AuthStateUnauthenticated;

  /// 認証中
  const factory AuthState.authenticating() = _AuthStateAuthenticating;

  /// 認証済み
  const factory AuthState.authenticated({required AuthSession session}) =
      _AuthStateAuthenticated;

  /// リフレッシュ中
  const factory AuthState.refreshing({required AuthSession session}) =
      _AuthStateRefreshing;

  /// エラー
  const factory AuthState.error({
    required String message,
    Object? exception,
    StackTrace? stack,
  }) = _AuthStateError;
}

/// 認証状態拡張
extension AuthStateExtension on AuthState {
  /// 認証済みかどうか
  bool get isAuthenticated => this is _AuthStateAuthenticated;

  /// セッション情報を取得（認証済みまたはリフレッシュ中の場合）
  AuthSession? get session {
    return switch (this) {
      _AuthStateAuthenticated(:final session) => session,
      _AuthStateRefreshing(:final session) => session,
      _ => null,
    };
  }

  /// エラー状態かどうか
  bool get isError => this is _AuthStateError;

  /// 処理中かどうか
  bool get isLoading {
    return switch (this) {
      _AuthStateAuthenticating() => true,
      _AuthStateRefreshing() => true,
      _ => false,
    };
  }
}

/// 認証状態管理用Notifier
class AuthStateNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState.unauthenticated();
  }

  /// 認証開始
  void startAuthentication() {
    state = const AuthState.authenticating();
  }

  /// 認証成功
  void setAuthenticated(AuthSession session) {
    state = AuthState.authenticated(session: session);
  }

  /// リフレッシュ開始
  void startRefreshing(AuthSession currentSession) {
    state = AuthState.refreshing(session: currentSession);
  }

  /// リフレッシュ成功
  void refreshCompleted(AuthSession updatedSession) {
    state = AuthState.authenticated(session: updatedSession);
  }

  /// エラー状態に遷移
  void setError({
    required String message,
    Object? exception,
    StackTrace? stack,
  }) {
    state = AuthState.error(
      message: message,
      exception: exception,
      stack: stack,
    );
  }

  /// 未認証状態に戻す
  void setUnauthenticated() {
    state = const AuthState.unauthenticated();
  }

  /// セッション情報を更新
  void updateSession(AuthSession session) {
    if (state.isAuthenticated) {
      state = AuthState.authenticated(session: session);
    }
  }
}
