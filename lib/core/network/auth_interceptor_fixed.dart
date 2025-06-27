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
    // 401エラーの場合、リフレッシュを試行
    if (err.response?.statusCode == 401) {
      _handleAuthError(err, handler);
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

  /// 認証エラーハンドリング（同期実行）
  Future<void> _handleAuthError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      // リフレッシュを同期実行
      final authNotifier = ref.read(authStateProvider.notifier);
      await authNotifier.refresh();

      // リフレッシュ成功時は元のリクエストを再実行
      await _retryOriginalRequest(err, handler);
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

  /// 元のリクエストを再実行
  Future<void> _retryOriginalRequest(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final authState = ref.read(authStateProvider);
      final session = authState.session;

      if (session != null) {
        // 更新された認証情報でヘッダーを設定
        _addAuthHeaders(err.requestOptions, session);

        // 新しいDioインスタンスでリクエストを再実行
        // 注意: 同じインターセプターチェーンを通らないよう、新しいインスタンスを使用
        final dio = Dio();
        dio.options = BaseOptions(
          baseUrl: err.requestOptions.baseUrl,
          connectTimeout: err.requestOptions.connectTimeout,
          receiveTimeout: err.requestOptions.receiveTimeout,
          sendTimeout: err.requestOptions.sendTimeout,
        );

        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
      } else {
        // セッションがない場合は元のエラーを返す
        handler.next(err);
      }
    } catch (e) {
      if (e is DioException) {
        handler.next(e);
      } else {
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            error: e,
            type: DioExceptionType.unknown,
          ),
        );
      }
    }
  }
}
