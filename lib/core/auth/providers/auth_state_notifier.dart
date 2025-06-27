import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/auth/models/auth_session.dart';
import 'package:passpal/core/auth/facade/auth_facade.dart';
import 'package:passpal/core/auth/idp/idp_authenticator.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';

/// 認証状態
sealed class AuthState {
  const AuthState();
}

/// 未認証
class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

/// 認証中
class AuthStateAuthenticating extends AuthState {
  const AuthStateAuthenticating();
}

/// 認証済み
class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated({required this.session});

  final AuthSession session;
}

/// リフレッシュ中
class AuthStateRefreshing extends AuthState {
  const AuthStateRefreshing({required this.session});

  final AuthSession session;
}

/// エラー
class AuthStateError extends AuthState {
  const AuthStateError({required this.message, this.exception, this.stack});

  final String message;
  final Object? exception;
  final StackTrace? stack;
}

/// 認証状態拡張
extension AuthStateExtension on AuthState {
  /// 認証済みかどうか
  bool get isAuthenticated => this is AuthStateAuthenticated;

  /// セッション情報を取得（認証済みまたはリフレッシュ中の場合）
  AuthSession? get session {
    return switch (this) {
      AuthStateAuthenticated(:final session) => session,
      AuthStateRefreshing(:final session) => session,
      _ => null,
    };
  }

  /// エラー状態かどうか
  bool get isError => this is AuthStateError;

  /// 処理中かどうか
  bool get isLoading {
    return switch (this) {
      AuthStateAuthenticating() => true,
      AuthStateRefreshing() => true,
      _ => false,
    };
  }
}

/// 認証状態管理用Notifier
class AuthStateNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // 初期化時にセッション復元を試行
    _initializeAuth();
    return const AuthStateUnauthenticated();
  }

  AuthFacade get _authFacade => ref.read(authFacadeProvider);

  /// 初期化時の認証状態確認
  Future<void> _initializeAuth() async {
    try {
      final session = await _authFacade.restoreSession();
      if (session != null) {
        state = AuthStateAuthenticated(session: session);
      }
    } catch (e) {
      // セッション復元に失敗した場合は未認証状態のまま
      state = const AuthStateUnauthenticated();
    }
  }

  /// ログイン処理
  Future<void> login({
    required Portal portal,
    required String username,
    required String password,
  }) async {
    state = const AuthStateAuthenticating();

    try {
      final session = await _authFacade.login(
        portal: portal,
        username: username,
        password: password,
      );
      state = AuthStateAuthenticated(session: session);
    } on AuthenticationException catch (e, stack) {
      state = AuthStateError(message: e.message, exception: e, stack: stack);
    } on AccountLinkException catch (e, stack) {
      state = AuthStateError(message: e.message, exception: e, stack: stack);
    } catch (e, stack) {
      state = AuthStateError(
        message: 'ログイン処理中にエラーが発生しました: $e',
        exception: e,
        stack: stack,
      );
    }
  }

  /// セッションリフレッシュ
  Future<void> refresh() async {
    final currentSession = state.session;
    if (currentSession == null) {
      state = const AuthStateError(message: 'リフレッシュするセッションがありません');
      return;
    }

    state = AuthStateRefreshing(session: currentSession);

    try {
      final updatedSession = await _authFacade.refresh();
      state = AuthStateAuthenticated(session: updatedSession);
    } on AuthenticationException catch (e, stack) {
      state = AuthStateError(message: e.message, exception: e, stack: stack);
    } on AccountLinkException catch (e, stack) {
      state = AuthStateError(message: e.message, exception: e, stack: stack);
    } catch (e, stack) {
      state = AuthStateError(
        message: 'セッションリフレッシュ中にエラーが発生しました: $e',
        exception: e,
        stack: stack,
      );
    }
  }

  /// ログアウト
  Future<void> logout() async {
    try {
      await _authFacade.logout();
    } catch (e) {
      // ログアウトのエラーは無視（既に状態は変更する）
    } finally {
      state = const AuthStateUnauthenticated();
    }
  }

  /// エラー状態をクリア
  void clearError() {
    if (state is AuthStateError) {
      state = const AuthStateUnauthenticated();
    }
  }

  /// セッション情報を更新
  void updateSession(AuthSession session) {
    if (state.isAuthenticated) {
      state = AuthStateAuthenticated(session: session);
    }
  }
}
