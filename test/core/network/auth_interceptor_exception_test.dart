import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:passpal/core/auth/models/auth_session.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';
import 'package:passpal/core/network/auth_interceptor.dart';
import 'package:passpal/core/network/network_target.dart';

// モッククラス
class MockRef extends Mock implements Ref {}

class MockAuthStateNotifier extends Mock implements AuthStateNotifier {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

// Fake DioException for fallback value
class FakeDioException extends Fake implements DioException {}

void main() {
  // registerFallbackValue for DioException
  setUpAll(() {
    registerFallbackValue(FakeDioException());
  });
  group('AuthInterceptor Exception Propagation Tests', () {
    late AuthInterceptor interceptor;
    late MockRef mockRef;
    late MockAuthStateNotifier mockAuthNotifier;
    late MockErrorInterceptorHandler mockErrorHandler;
    late RequestOptions requestOptions;

    setUp(() {
      mockRef = MockRef();
      mockAuthNotifier = MockAuthStateNotifier();
      mockErrorHandler = MockErrorInterceptorHandler();

      requestOptions = RequestOptions(path: '/test');

      interceptor = AuthInterceptor(ref: mockRef, target: NetworkTarget.albo);
    });

    test('AuthenticationException.sessionExpiredが正しく伝播される', () async {
      // Given: 認証セッション
      final session = AuthSession(
        username: 'test_user',
        cookies: {'JSESSIONID': 'test_cookie'},
        firebaseIdToken: null,
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
        lastRefreshed: DateTime.now(),
      );

      when(
        () => mockRef.read(authStateProvider),
      ).thenReturn(AuthStateAuthenticated(session: session));

      when(
        () => mockRef.read(authStateProvider.notifier),
      ).thenReturn(mockAuthNotifier);

      // リフレッシュ失敗をモック
      when(() => mockAuthNotifier.refresh()).thenThrow(
        AuthenticationException.sessionExpired(message: 'セッションが期限切れです'),
      );

      // 401エラー
      final dioError = DioException(
        requestOptions: requestOptions,
        response: Response(requestOptions: requestOptions, statusCode: 401),
      );

      // When: onErrorを実行
      interceptor.onError(dioError, mockErrorHandler);

      // Then: AuthenticationExceptionがDioExceptionとしてrejectされる
      verify(
        () => mockErrorHandler.reject(
          any(
            that: isA<DioException>().having(
              (e) => e.error,
              'error',
              isA<AuthenticationException>().having(
                (auth) => auth.message,
                'message',
                'セッションが期限切れです',
              ),
            ),
          ),
        ),
      ).called(1);
    });

    test('AuthenticationException.invalidCredentialが正しく伝播される', () async {
      // Given: 認証セッション
      final session = AuthSession(
        username: 'test_user',
        cookies: {'JSESSIONID': 'test_cookie'},
        firebaseIdToken: null,
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
        lastRefreshed: DateTime.now(),
      );

      when(
        () => mockRef.read(authStateProvider),
      ).thenReturn(AuthStateAuthenticated(session: session));

      when(
        () => mockRef.read(authStateProvider.notifier),
      ).thenReturn(mockAuthNotifier);

      // 認証失敗をモック
      when(() => mockAuthNotifier.refresh()).thenThrow(
        AuthenticationException.invalidCredential(message: '認証情報が無効です'),
      );

      // 401エラー
      final dioError = DioException(
        requestOptions: requestOptions,
        response: Response(requestOptions: requestOptions, statusCode: 401),
      );

      // When: onErrorを実行
      interceptor.onError(dioError, mockErrorHandler);

      // Then: AuthenticationExceptionがDioExceptionとしてrejectされる
      verify(
        () => mockErrorHandler.reject(
          any(
            that: isA<DioException>().having(
              (e) => e.error,
              'error',
              isA<AuthenticationException>().having(
                (auth) => auth.message,
                'message',
                '認証情報が無効です',
              ),
            ),
          ),
        ),
      ).called(1);
    });

    test('一般的な例外もAuthenticationExceptionとして伝播される', () async {
      // Given: 認証セッション
      final session = AuthSession(
        username: 'test_user',
        cookies: {'JSESSIONID': 'test_cookie'},
        firebaseIdToken: null,
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
        lastRefreshed: DateTime.now(),
      );

      when(
        () => mockRef.read(authStateProvider),
      ).thenReturn(AuthStateAuthenticated(session: session));

      when(
        () => mockRef.read(authStateProvider.notifier),
      ).thenReturn(mockAuthNotifier);

      // 一般的な例外をモック
      when(() => mockAuthNotifier.refresh()).thenThrow(Exception('ネットワークエラー'));

      // 401エラー
      final dioError = DioException(
        requestOptions: requestOptions,
        response: Response(requestOptions: requestOptions, statusCode: 401),
      );

      // When: onErrorを実行
      interceptor.onError(dioError, mockErrorHandler);

      // Then: 一般的な例外もAuthenticationExceptionとしてラップされる
      verify(
        () => mockErrorHandler.reject(
          any(
            that: isA<DioException>().having(
              (e) => e.error,
              'error',
              isA<AuthenticationException>().having(
                (auth) => auth.message,
                'message',
                '認証セッションが期限切れです。再ログインしてください。',
              ),
            ),
          ),
        ),
      ).called(1);
    });
  });
}
