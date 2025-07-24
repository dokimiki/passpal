import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:passpal/core/network/interceptors/auth_interceptor.dart';
import 'package:passpal/core/network/models/service_config.dart';
import 'package:passpal/core/error/providers.dart';
import '../mocks/mock_error_services.dart';

void main() {
  group('AuthInterceptor', () {
    late MockAuthProvider mockAuthProvider;
    late ServiceConfig serviceConfig;
    late AuthInterceptor authInterceptor;

    setUp(() {
      final mockErrorReporter = MockErrorReporter();
      mockAuthProvider = MockAuthProvider(
        logger: AppLogger(tag: 'MockAuth', errorReporter: mockErrorReporter),
      );
      serviceConfig = ServiceConfigs.palapi;
      authInterceptor = AuthInterceptor(
        serviceConfig: serviceConfig,
        authProvider: mockAuthProvider,
        logger: AppLogger(
          tag: 'AuthInterceptor',
          errorReporter: mockErrorReporter,
        ),
      );
    });

    group('onRequest', () {
      test('skips authentication for services that do not require auth', () {
        // Arrange
        final noAuthConfig = ServiceConfigs.palapi.copyWith(
          authType: AuthType.none,
        );
        final mockErrorReporter = MockErrorReporter();
        final interceptor = AuthInterceptor(
          serviceConfig: noAuthConfig,
          authProvider: mockAuthProvider,
          logger: AppLogger(
            tag: 'AuthInterceptor',
            errorReporter: mockErrorReporter,
          ),
        );
        final options = RequestOptions(path: '/test');
        final handler = _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(handler.nextCalled, isTrue);
      });

      test('adds Bearer token for token auth type', () async {
        // Arrange
        const token = 'test_access_token';
        mockAuthProvider.setMockToken(serviceConfig.serviceId, token);

        final options = RequestOptions(path: '/test');
        final handler = _MockRequestInterceptorHandler();

        // Act
        authInterceptor.onRequest(options, handler);

        // Allow async operations to complete
        await Future.delayed(const Duration(milliseconds: 50));

        // Assert
        expect(handler.nextCalled, isTrue);
        expect(options.headers['Authorization'], equals('Bearer $token'));
      });

      test('adds session cookies for cookie auth type', () async {
        // Arrange
        final cookieConfig = ServiceConfigs.manabo;
        final cookies = {'JSESSIONID': 'session123', 'SHIBSESSION': 'shib456'};
        mockAuthProvider.setMockCookies(cookieConfig.serviceId, cookies);

        final mockErrorReporter = MockErrorReporter();
        final interceptor = AuthInterceptor(
          serviceConfig: cookieConfig,
          authProvider: mockAuthProvider,
          logger: AppLogger(
            tag: 'AuthInterceptor',
            errorReporter: mockErrorReporter,
          ),
        );
        final options = RequestOptions(path: '/test');
        final handler = _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Allow async operations to complete
        await Future.delayed(const Duration(milliseconds: 50));

        // Assert
        expect(handler.nextCalled, isTrue);
        expect(
          options.headers['Cookie'],
          equals('JSESSIONID=session123; SHIBSESSION=shib456'),
        );
      });
    });

    group('onError', () {
      test('handles 401 authentication error', () async {
        // Arrange
        final requestOptions = RequestOptions(path: '/test');
        final dioError = DioException(
          requestOptions: requestOptions,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 401,
            statusMessage: 'Unauthorized',
          ),
          type: DioExceptionType.badResponse,
        );
        final handler = _MockErrorInterceptorHandler();

        // Act
        authInterceptor.onError(dioError, handler);

        // Allow async operations to complete
        await Future.delayed(const Duration(milliseconds: 150));

        // Assert - The error should be handled (either next called for failure or resolve called for success)
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('passes through non-auth errors', () {
        // Arrange
        final requestOptions = RequestOptions(path: '/test');
        final dioError = DioException(
          requestOptions: requestOptions,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 500,
            statusMessage: 'Internal Server Error',
          ),
          type: DioExceptionType.badResponse,
        );
        final handler = _MockErrorInterceptorHandler();

        // Act
        authInterceptor.onError(dioError, handler);

        // Assert
        expect(handler.nextCalled, isTrue);
      });
    });

    group('MockAuthProvider', () {
      late MockAuthProvider provider;

      setUp(() {
        final mockErrorReporter = MockErrorReporter();
        provider = MockAuthProvider(
          logger: AppLogger(tag: 'MockAuth', errorReporter: mockErrorReporter),
        );
      });

      test('returns null token initially', () async {
        final token = await provider.getAccessToken('palapi');
        expect(token, isNull);
      });

      test('can set and retrieve mock tokens', () async {
        const token = 'mock_token';
        provider.setMockToken('palapi', token);

        final retrievedToken = await provider.getAccessToken('palapi');
        expect(retrievedToken, equals(token));
      });

      test('can set and retrieve mock cookies', () async {
        final cookies = {'JSESSIONID': 'session123'};
        provider.setMockCookies('manabo', cookies);

        final retrievedCookies = await provider.getSessionCookies('manabo');
        expect(retrievedCookies, equals(cookies));
      });

      test('simulates successful token refresh for palapi', () async {
        final result = await provider.refreshToken('palapi');
        expect(result, isTrue);

        // Check that a new token was generated
        final token = await provider.getAccessToken('palapi');
        expect(token, isNotNull);
        expect(token!.startsWith('mock_refreshed_token_'), isTrue);
      });

      test(
        'simulates successful re-authentication for portal services',
        () async {
          final result = await provider.reauthenticate('manabo');
          expect(result, isTrue);

          // Check that cookies were generated
          final cookies = await provider.getSessionCookies('manabo');
          expect(cookies.containsKey('JSESSIONID'), isTrue);
          expect(cookies.containsKey('SHIBSESSION'), isTrue);
        },
      );

      test('returns false for unknown services', () async {
        final refreshResult = await provider.refreshToken('unknown');
        expect(refreshResult, isFalse);

        final reauthResult = await provider.reauthenticate('unknown');
        expect(reauthResult, isFalse);
      });

      test('clears authentication data', () async {
        // Set up some auth data
        provider.setMockToken('palapi', 'token');
        provider.setMockCookies('manabo', {'session': 'value'});

        // Clear auth for palapi
        await provider.clearAuthentication('palapi');

        // Verify palapi auth is cleared but manabo is not
        final palapiToken = await provider.getAccessToken('palapi');
        final manaboCookies = await provider.getSessionCookies('manabo');

        expect(palapiToken, isNull);
        expect(manaboCookies, isNotEmpty);
      });

      test('checks authentication status correctly', () async {
        // Initially not authenticated
        final initialStatus = await provider.isAuthenticated('palapi');
        expect(initialStatus, isFalse);

        // After setting token, should be authenticated
        provider.setMockToken('palapi', 'token');
        final authenticatedStatus = await provider.isAuthenticated('palapi');
        expect(authenticatedStatus, isTrue);
      });
    });
  });

  group('AuthInterceptor Provider Integration', () {
    test('creates AuthInterceptor with correct dependencies', () {
      final mockErrorReporter = MockErrorReporter();
      final container = ProviderContainer(
        overrides: [
          crashlyticsServiceProvider.overrideWithValue(
            mockErrorReporter.crashlyticsService,
          ),
          errorReporterProvider.overrideWithValue(mockErrorReporter),
          scopedLoggerProvider('AuthInterceptor').overrideWithValue(
            AppLogger(tag: 'AuthInterceptor', errorReporter: mockErrorReporter),
          ),
          scopedLoggerProvider('MockAuthProvider').overrideWithValue(
            AppLogger(
              tag: 'MockAuthProvider',
              errorReporter: mockErrorReporter,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final interceptor = container.read(
        authInterceptorProvider(ServiceConfigs.palapi),
      );

      expect(interceptor, isA<AuthInterceptor>());
      expect(interceptor.serviceConfig, equals(ServiceConfigs.palapi));
    });

    test('creates different interceptors for different services', () {
      final mockErrorReporter = MockErrorReporter();
      final container = ProviderContainer(
        overrides: [
          crashlyticsServiceProvider.overrideWithValue(
            mockErrorReporter.crashlyticsService,
          ),
          errorReporterProvider.overrideWithValue(mockErrorReporter),
          scopedLoggerProvider('AuthInterceptor').overrideWithValue(
            AppLogger(tag: 'AuthInterceptor', errorReporter: mockErrorReporter),
          ),
          scopedLoggerProvider('MockAuthProvider').overrideWithValue(
            AppLogger(
              tag: 'MockAuthProvider',
              errorReporter: mockErrorReporter,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final palapiInterceptor = container.read(
        authInterceptorProvider(ServiceConfigs.palapi),
      );
      final manaboInterceptor = container.read(
        authInterceptorProvider(ServiceConfigs.manabo),
      );

      expect(palapiInterceptor, isNot(equals(manaboInterceptor)));
      expect(palapiInterceptor.serviceConfig.serviceId, equals('palapi'));
      expect(manaboInterceptor.serviceConfig.serviceId, equals('manabo'));
    });
  });
}

/// Mock request interceptor handler for testing
class _MockRequestInterceptorHandler extends RequestInterceptorHandler {
  bool nextCalled = false;
  bool rejectCalled = false;
  DioException? rejectedError;

  @override
  void next(RequestOptions options) {
    nextCalled = true;
  }

  @override
  void reject(
    DioException error, [
    bool callFollowingResponseInterceptor = false,
  ]) {
    rejectCalled = true;
    rejectedError = error;
  }
}

/// Mock error interceptor handler for testing
class _MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  bool nextCalled = false;
  bool resolveCalled = false;
  Response? resolvedResponse;

  @override
  void next(DioException err) {
    nextCalled = true;
  }

  @override
  void resolve(
    Response response, [
    bool callFollowingResponseInterceptor = false,
  ]) {
    resolveCalled = true;
    resolvedResponse = response;
  }
}
