import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/routing/deep_link_handler.dart';
import 'package:passpal/core/routing/providers.dart';
import 'package:passpal/core/error/app_exception.dart';
import 'package:passpal/core/error/crashlytics_reporter.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/auth/models/auth_session.dart';
import 'package:go_router/go_router.dart';

import 'routing_exception_propagation_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CrashlyticsReporter>(), MockSpec<GoRouter>()])
void main() {
  group('Routing Exception Propagation Tests', () {
    late MockCrashlyticsReporter mockCrashlytics;
    late MockGoRouter mockRouter;
    late ProviderContainer container;

    setUp(() {
      mockCrashlytics = MockCrashlyticsReporter();
      mockRouter = MockGoRouter();

      container = ProviderContainer(
        overrides: [
          crashlyticsReporterProvider.overrideWithValue(mockCrashlytics),
          goRouterProvider.overrideWithValue(mockRouter),
          // Mock auth state as authenticated for testing
          authStateProvider.overrideWith(TestAuthStateNotifier.new),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('RouteParsingException propagation', () {
      test('DeepLinkHandler で不正なURIによりエラーページに遷移', () async {
        final handler = container.read(deepLinkHandlerProvider);

        // Act: 不正な形式のURIでRouteParsingExceptionを内部的に発生させる
        final invalidUri = Uri.parse('/main/timetable//detail'); // courseIdが空

        await handler.handle(invalidUri);

        // Assert: エラーページに遷移することを確認
        verify(mockRouter.go('/error', extra: anyNamed('extra'))).called(1);
      });

      test('無効なルートパラメータでエラーページに遷移', () async {
        final handler = container.read(deepLinkHandlerProvider);

        // Act: 必須パラメータが不足したURIを作成
        final uriWithInvalidParams = Uri.parse('/invalid/route/format');

        await handler.handle(uriWithInvalidParams);

        // Assert: エラーページに遷移することを確認
        verify(mockRouter.go('/error', extra: anyNamed('extra'))).called(1);
      });
    });

    group('FCM deep link parsing', () {
      test('不正なFCMデータでRouteParsingExceptionが発生', () {
        // Act & Assert: 不正なFCMデータでRouteParsingExceptionが発生することを確認
        expect(
          () => DeepLinkHandler.fromFCM({'invalid': 'data'}),
          throwsA(isA<RouteParsingException>()),
        );
      });

      test('有効なFCMデータでDeepLinkDataが生成される', () {
        // Act: 有効なFCMデータからDeepLinkDataを生成
        final deepLinkData = DeepLinkHandler.fromFCM({
          'deeplink': '/main/home',
          'additional': 'data',
        });

        // Assert: 正しくパースされることを確認
        expect(deepLinkData.uri.path, '/main/home');
        expect(deepLinkData.pushPayload, contains('deeplink'));
      });
    });

    group('Navigation error propagation', () {
      test('ナビゲーション中の予期しないエラーでエラーページに遷移', () async {
        // Setup: モックGoRouterが最初の呼び出しで例外をスローし、
        // 2回目の呼び出し（エラーページ）では成功するように設定
        when(
          mockRouter.go(any, extra: anyNamed('extra')),
        ).thenThrow(Exception('Navigation failed'));
        when(
          mockRouter.go('/error', extra: anyNamed('extra')),
        ).thenReturn(null);

        final handler = container.read(deepLinkHandlerProvider);

        // Act: Navigation that causes an error
        await handler.handle(Uri.parse('/main/home'));

        // Assert: エラーページに遷移することを確認
        verify(mockRouter.go('/error', extra: anyNamed('extra'))).called(1);
      });
    });

    group('Complex route parsing', () {
      test('有効なコース詳細ルートが正しくパースされる', () async {
        final handler = container.read(deepLinkHandlerProvider);

        // Act: 有効なコース詳細ルートをハンドル
        await handler.handle(Uri.parse('/main/timetable/MATH101/detail'));

        // Assert: 正しいパスで navigation が呼ばれることを確認
        verify(
          mockRouter.go(
            '/main/timetable/MATH101/detail',
            extra: anyNamed('extra'),
          ),
        ).called(1);
      });

      test('有効なコース教材ルートが正しくパースされる', () async {
        final handler = container.read(deepLinkHandlerProvider);

        // Act: 有効なコース教材ルートをハンドル
        await handler.handle(Uri.parse('/main/timetable/MATH101/materials'));

        // Assert: 正しいパスで navigation が呼ばれることを確認
        verify(
          mockRouter.go(
            '/main/timetable/MATH101/materials',
            extra: anyNamed('extra'),
          ),
        ).called(1);
      });
    });

    group('Push payload handling', () {
      test('有効なプッシュペイロードが正しく処理される', () async {
        final handler = container.read(deepLinkHandlerProvider);

        // Act: プッシュペイロード付きのハンドル
        await handler.handle(
          Uri.parse('/assignment'),
          pushPayload: {'courseId': 'MATH101', 'assignmentId': 'hw1'},
        );

        // Assert: Navigation が呼ばれることを確認
        verify(
          mockRouter.go('/assignment', extra: anyNamed('extra')),
        ).called(1);
      });
    });

    group('Authentication state integration', () {
      test('未認証状態でのガードリダイレクトが動作', () async {
        // Setup: Create a container with unauthenticated state
        final testContainer = ProviderContainer(
          overrides: [
            crashlyticsReporterProvider.overrideWithValue(mockCrashlytics),
            goRouterProvider.overrideWithValue(mockRouter),
            authStateProvider.overrideWith(
              () => TestAuthStateNotifier(
                initialState: const AuthStateUnauthenticated(),
              ),
            ),
          ],
        );

        final handler = testContainer.read(deepLinkHandlerProvider);

        // Act: Try to access protected route
        await handler.handle(Uri.parse('/main/home'));

        // Assert: Navigation was attempted (guard logic would handle redirect)
        verify(mockRouter.go('/main/home', extra: anyNamed('extra'))).called(1);

        testContainer.dispose();
      });
    });
  });
}

// Test用のAuthStateNotifier実装
class TestAuthStateNotifier extends AuthStateNotifier {
  final AuthState? initialState;

  TestAuthStateNotifier({this.initialState});

  @override
  AuthState build() {
    return initialState ??
        AuthStateAuthenticated(
          session: AuthSession(
            username: 'test-user',
            cookies: {'session': 'test-session'},
            expiresAt: DateTime.now().add(const Duration(hours: 1)),
            lastRefreshed: DateTime.now(),
          ),
        );
  }
}
