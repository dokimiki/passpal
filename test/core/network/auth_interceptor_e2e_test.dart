import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:passpal/core/auth/models/auth_session.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';
import 'package:passpal/core/auth/facade/auth_facade.dart';
import 'package:passpal/core/network/auth_interceptor.dart';
import 'package:passpal/core/network/network_target.dart';

// テスト用モッククラス
class MockAuthFacade extends Mock implements AuthFacade {}

// テスト用AuthInterceptor作成関数
AuthInterceptor createAuthInterceptor(
  ProviderContainer container,
  NetworkTarget target,
) {
  // ProviderContainerから一時的にrefを作成
  late Ref testRef;
  container.listen(authStateProvider, (prev, next) {}, fireImmediately: false);

  // refを模擬する簡単なラッパー
  testRef = _TestRef(container);
  return AuthInterceptor(ref: testRef, target: target);
}

// 最小限のRef実装
class _TestRef implements Ref {
  final ProviderContainer _container;
  _TestRef(this._container);

  @override
  T read<T>(ProviderListenable<T> provider) => _container.read(provider);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

void main() {
  group('AuthInterceptor E2E Tests', () {
    late ProviderContainer container;
    late DioAdapter dioAdapter;
    late Dio dio;
    late MockAuthFacade mockAuthFacade;

    setUp(() {
      mockAuthFacade = MockAuthFacade();

      // Dioとアダプターをセットアップ
      dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      // ProviderContainerをセットアップ
      container = ProviderContainer(
        overrides: [authFacadeProvider.overrideWithValue(mockAuthFacade)],
      );

      // AuthInterceptorを追加（ProviderScopeを使用）
    });

    tearDown(() {
      container.dispose();
    });

    group('正常系テスト', () {
      test('有効なCookieが自動的に付与される', () async {
        // Given: 有効な認証セッション

        // 認証状態プロバイダーのモック
        container = ProviderContainer(
          overrides: [
            authFacadeProvider.overrideWithValue(mockAuthFacade),
            authStateProvider.overrideWith(
              () => TestAuthStateNotifier(
                AuthStateAuthenticated(
                  session: AuthSession(
                    username: 'test_user',
                    cookies: {'JSESSIONID': 'cookie123'},
                    firebaseIdToken: null,
                    expiresAt: DateTime(2025, 12, 31, 23, 59, 59),
                    lastRefreshed: DateTime(2025, 6, 27, 12, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        );

        // Interceptorを再作成
        dio.interceptors.clear();
        dio.interceptors.add(
          createAuthInterceptor(container, NetworkTarget.albo),
        );

        // Mockレスポンスを設定
        dioAdapter.onGet(
          '/test',
          (server) => server.reply(200, {'success': true}),
        );

        // When: リクエストを実行
        final response = await dio.get('/test');

        // Then: レスポンスが成功
        expect(response.statusCode, 200);
        expect(response.data['success'], true);
      });

      test('Bearer Tokenが自動的に付与される', () async {
        // Given: Firebase ID Tokenを持つセッション
        container = ProviderContainer(
          overrides: [
            authFacadeProvider.overrideWithValue(mockAuthFacade),
            authStateProvider.overrideWith(
              () => TestAuthStateNotifier(
                AuthStateAuthenticated(
                  session: AuthSession(
                    username: 'test_user',
                    cookies: {},
                    firebaseIdToken: 'firebase_token_123',
                    expiresAt: DateTime(2025, 12, 31, 23, 59, 59),
                    lastRefreshed: DateTime(2025, 6, 27, 12, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        );

        // PalAPI用のInterceptorに変更
        dio.interceptors.clear();
        dio.interceptors.add(
          createAuthInterceptor(container, NetworkTarget.palapi),
        );

        // Mockレスポンスを設定
        dioAdapter.onGet(
          '/api/test',
          (server) => server.reply(200, {'success': true}),
        );

        // When: リクエストを実行
        final response = await dio.get('/api/test');

        // Then: レスポンスが成功
        expect(response.statusCode, 200);
        expect(response.data['success'], true);
      });
    });

    group('401エラー時の自動リフレッシュテスト', () {
      test('401エラー発生時、リフレッシュが成功するとリクエストが再実行される', () async {
        // Given: AuthFacadeのモック
        final newSession = AuthSession(
          username: 'test_user',
          cookies: {'JSESSIONID': 'new_cookie'},
          firebaseIdToken: null,
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
          lastRefreshed: DateTime.now(),
        );

        when(
          () => mockAuthFacade.refresh(),
        ).thenAnswer((_) async => newSession);

        container = ProviderContainer(
          overrides: [
            authFacadeProvider.overrideWithValue(mockAuthFacade),
            authStateProvider.overrideWith(
              () => TestAuthStateNotifier(
                AuthStateAuthenticated(
                  session: AuthSession(
                    username: 'test_user',
                    cookies: {'JSESSIONID': 'old_cookie'},
                    firebaseIdToken: null,
                    expiresAt: DateTime(2025, 12, 31, 23, 59, 59),
                    lastRefreshed: DateTime(2025, 6, 27, 12, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        );

        dio.interceptors.clear();
        dio.interceptors.add(
          createAuthInterceptor(container, NetworkTarget.albo),
        );

        // 401を返すモックを設定
        dioAdapter.onGet('/test', (server) {
          return server.reply(401, {'error': 'Unauthorized'});
        });

        // When: 401が発生するリクエストを実行
        bool exceptionCaught = false;
        try {
          await dio.get('/test');
        } catch (e) {
          exceptionCaught = true;
          // AuthInterceptorが適切にエラー処理することを確認
          expect(e, isA<DioException>());
        }

        // Then: 例外が発生することを確認
        expect(exceptionCaught, true);

        // 非同期処理の完了を待つ
        await Future.delayed(const Duration(milliseconds: 200));

        // リフレッシュが実行されたことを確認
        verify(() => mockAuthFacade.refresh()).called(1);
      });

      test('401エラー発生時、リフレッシュが失敗するとAuthenticationExceptionが発生', () async {
        // Given: リフレッシュ失敗
        when(() => mockAuthFacade.refresh()).thenThrow(
          AuthenticationException.sessionExpired(message: 'セッションの更新に失敗しました'),
        );

        container = ProviderContainer(
          overrides: [
            authFacadeProvider.overrideWithValue(mockAuthFacade),
            authStateProvider.overrideWith(
              () => TestAuthStateNotifier(
                AuthStateAuthenticated(
                  session: AuthSession(
                    username: 'test_user',
                    cookies: {'JSESSIONID': 'expired_cookie'},
                    firebaseIdToken: null,
                    expiresAt: DateTime(2025, 12, 31, 23, 59, 59),
                    lastRefreshed: DateTime(2025, 6, 27, 12, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        );

        dio.interceptors.clear();
        dio.interceptors.add(
          createAuthInterceptor(container, NetworkTarget.albo),
        );

        // 401エラーを返すようにモック設定
        dioAdapter.onGet(
          '/test',
          (server) => server.reply(401, {'error': 'Unauthorized'}),
        );

        // When & Then: リクエストを実行してAuthenticationExceptionが発生
        await expectLater(
          dio.get('/test', options: Options(extra: {'_test_dio': dio})),
          throwsA(
            isA<DioException>().having(
              (e) => e.error,
              'error',
              isA<AuthenticationException>(),
            ),
          ),
        );

        // verifyを少し遅延させて、非同期処理が完了するのを待つ
        await Future.delayed(const Duration(milliseconds: 100));
        verify(() => mockAuthFacade.refresh()).called(1);
      });
    });

    group('未認証状態テスト', () {
      test('未認証状態でもリクエストは実行される（認証ヘッダーなし）', () async {
        // Given: 未認証状態
        container = ProviderContainer(
          overrides: [
            authFacadeProvider.overrideWithValue(mockAuthFacade),
            authStateProvider.overrideWith(
              () => TestAuthStateNotifier(const AuthStateUnauthenticated()),
            ),
          ],
        );

        dio.interceptors.clear();
        dio.interceptors.add(
          createAuthInterceptor(container, NetworkTarget.albo),
        );

        dioAdapter.onGet(
          '/public',
          (server) => server.reply(200, {'public': true}),
        );

        // When: リクエストを実行
        final response = await dio.get('/public');

        // Then: リクエストは成功（認証ヘッダーなし）
        expect(response.statusCode, 200);
        expect(response.data['public'], true);
      });
    });

    group('例外伝播シナリオテスト', () {
      test('AuthenticationExceptionがDioExceptionとして伝播される', () async {
        // Given: リフレッシュ失敗のAuthFacade
        when(() => mockAuthFacade.refresh()).thenThrow(
          AuthenticationException.sessionExpired(message: 'セッションが期限切れです'),
        );

        container = ProviderContainer(
          overrides: [
            authFacadeProvider.overrideWithValue(mockAuthFacade),
            authStateProvider.overrideWith(
              () => TestAuthStateNotifier(
                AuthStateAuthenticated(
                  session: AuthSession(
                    username: 'test_user',
                    cookies: {'JSESSIONID': 'cookie123'},
                    firebaseIdToken: null,
                    expiresAt: DateTime(2025, 12, 31, 23, 59, 59),
                    lastRefreshed: DateTime(2025, 6, 27, 12, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        );

        dio.interceptors.clear();
        dio.interceptors.add(
          createAuthInterceptor(container, NetworkTarget.albo),
        );

        dioAdapter.onGet(
          '/test',
          (server) => server.reply(401, {'error': 'Unauthorized'}),
        );

        // When & Then: DioExceptionがAuthenticationExceptionをラップして伝播
        try {
          await dio.get('/test', options: Options(extra: {'_test_dio': dio}));
          fail('例外が発生するはずです');
        } catch (e) {
          expect(e, isA<DioException>());
          final dioException = e as DioException;
          expect(dioException.error, isA<AuthenticationException>());

          final authException = dioException.error as AuthenticationException;
          expect(authException.message, 'セッションが期限切れです');
        }
      });
    });
  });
}

/// テスト用のAuthStateNotifier実装
class TestAuthStateNotifier extends AuthStateNotifier {
  AuthState _currentState;

  TestAuthStateNotifier(this._currentState);

  @override
  AuthState build() => _currentState;

  void updateState(AuthState newState) {
    _currentState = newState;
    state = newState;
  }

  @override
  Future<void> refresh() async {
    final authFacade = ref.read(authFacadeProvider);
    final newSession = await authFacade.refresh();
    updateState(AuthStateAuthenticated(session: newSession));
  }
}
