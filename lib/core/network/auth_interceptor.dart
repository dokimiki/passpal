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

  final ProviderRef ref;
  final NetworkTarget target;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authState = ref.read(authStateProvider);
    final session = authState.session;

    if (session != null) {
      // セッションがリフレッシュ必要かチェック
      if (session.needsRefresh) {
        // バックグラウンドでリフレッシュを試行
        _performRefresh();
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
      if (idToken != null) {
        options.headers['Authorization'] = 'Bearer $idToken';
      }
    }
  }

  /// バックグラウンドリフレッシュ
  void _performRefresh() {
    // 非同期でリフレッシュを実行（レスポンスは待たない）
    Future(() async {
      try {
        final authNotifier = ref.read(authStateProvider.notifier);
        await authNotifier.refresh();
      } catch (e) {
        // バックグラウンドリフレッシュの失敗は無視
      }
    });
  }

  /// 認証エラーハンドリング
  void _handleAuthError(DioException err, ErrorInterceptorHandler handler) {
    // 単発リフレッシュを試行
    _performSingleRefresh()
        .then((success) {
          if (success) {
            // リフレッシュ成功時は元のリクエストを再実行
            _retryOriginalRequest(err, handler);
          } else {
            // リフレッシュ失敗時は認証エラーとして処理
            final authException = AuthenticationException.sessionExpired(
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
        })
        .catchError((e) {
          // リフレッシュ処理でエラーが発生した場合
          handler.next(err);
        });
  }

  /// 単発リフレッシュ実行
  Future<bool> _performSingleRefresh() async {
    try {
      final authNotifier = ref.read(authStateProvider.notifier);
      await authNotifier.refresh();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 元のリクエストを再実行
  void _retryOriginalRequest(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final authState = ref.read(authStateProvider);
    final session = authState.session;

    if (session != null) {
      // 更新された認証情報でヘッダーを設定
      _addAuthHeaders(err.requestOptions, session);

      // リクエストを再実行
      final dio = Dio();
      dio
          .fetch(err.requestOptions)
          .then((response) {
            handler.resolve(response);
          })
          .catchError((e) {
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
          });
    } else {
      handler.next(err);
    }
  }
}
