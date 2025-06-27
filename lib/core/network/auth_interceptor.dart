import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/auth/models/auth_session.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';
import 'package:passpal/core/network/network_target.dart';

/// 認証インターセプター
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.ref, required this.target});

  final Ref ref;
  final NetworkTarget target;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // リトライ中の場合は認証ヘッダーは既に設定済みなのでスキップ
    if (options.extra.containsKey('_retry_in_progress')) {
      handler.next(options);
      return;
    }

    final authState = ref.read(authStateProvider);
    final session = authState.session;

    if (session != null) {
      // セッションがリフレッシュ必要かチェック
      if (session.needsRefresh) {
        // バックグラウンドでリフレッシュを試行
        _performBackgroundRefresh();
      }

      // 認証情報を追加
      _addAuthHeaders(options, session);
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // リトライ中の場合は401エラーハンドリングをスキップ
    if (err.requestOptions.extra.containsKey('_retry_in_progress')) {
      handler.next(err);
      return;
    }

    // 401エラーの場合、リフレッシュを試行
    if (err.response?.statusCode == 401) {
      // スケジュールされた非同期処理として実行し、エラーを適切にハンドル
      _handleAuthError(err, handler).catchError((error) {
        handler.next(err);
      });
      return;
    }

    handler.next(err);
  }

  /// 認証ヘッダーを追加
  void _addAuthHeaders(RequestOptions options, AuthSession session) {
    if (target.usesSsoCookies) {
      // SSO Cookieを追加
      final cookieString = session.cookieString;
      if (cookieString.isNotEmpty) {
        options.headers['Cookie'] = cookieString;
      }
    }

    if (target.usesBearerToken) {
      // Bearer Tokenを追加
      final idToken = session.firebaseIdToken;
      if (idToken != null && idToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $idToken';
      }
    }
  }

  /// バックグラウンドリフレッシュ
  void _performBackgroundRefresh() {
    // 非同期でリフレッシュを実行（レスポンスは待たない）
    Future(() async {
      try {
        final authNotifier = ref.read(authStateProvider.notifier);
        await authNotifier.refresh();
      } catch (e) {
        // バックグラウンドリフレッシュの失敗は無視
        // ログ出力のみ行う
      }
    });
  }

  /// 認証エラーハンドリング（非同期実行）
  Future<void> _handleAuthError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      // リフレッシュを同期実行
      final authNotifier = ref.read(authStateProvider.notifier);
      await authNotifier.refresh();

      // リフレッシュ成功時は更新された認証情報をヘッダーに追加
      final authState = ref.read(authStateProvider);
      final session = authState.session;

      if (session != null) {
        _addAuthHeaders(err.requestOptions, session);
        // リトライフラグを設定
        err.requestOptions.extra['_retry_after_refresh'] = true;
      }

      // リフレッシュが成功した場合、カスタムエラーを投げて上位レイヤーでリトライを促す
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: 'AUTH_REFRESH_SUCCESS',
          type: DioExceptionType.unknown,
        ),
      );
    } catch (e) {
      // リフレッシュ失敗時は認証エラーとして処理
      final authException = e is AuthenticationException
          ? e
          : AuthenticationException.sessionExpired(
              message: '認証セッションが期限切れです。再ログインしてください。',
            );

      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: authException,
          type: DioExceptionType.unknown,
        ),
      );
    }
  }
}
