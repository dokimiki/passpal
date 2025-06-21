import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:passpal/core/network/portal.dart';
import 'package:passpal/features/auth/data/network/auth_api.dart';
import 'package:passpal/features/auth/data/network/auth_failure.dart';

import 'auth_api_test.mocks.dart';

@GenerateMocks([Dio, CookieJar])
void main() {
  group('AuthApi', () {
    late AuthApi authApi;
    late MockDio mockDio;
    late MockCookieJar mockCookieJar;

    setUp(() {
      mockDio = MockDio();
      mockCookieJar = MockCookieJar();
      authApi = AuthApi(mockDio);
    });

    group('login', () {
      test('should throw ServiceUnavailable when service returns 503', () async {
        // Arrange
        const portal = Portal.manabo;
        const id = 'test123';
        const pw = 'password';

        final interceptors = Interceptors();
        interceptors.add(CookieManager(mockCookieJar));
        when(mockDio.interceptors).thenReturn(interceptors);

        // Mock 503 response for entry point
        when(mockDio.get(any)).thenAnswer((_) async => Response(
              statusCode: 503,
              requestOptions: RequestOptions(path: ''),
            ));

        // Act & Assert
        expect(
          () => authApi.login(portal: portal, id: id, pw: pw),
          throwsA(isA<ServiceUnavailable>()),
        );
      });

      test('should throw NetworkError for connection issues', () async {
        // Arrange
        const portal = Portal.manabo;
        const id = 'test123';
        const pw = 'password';

        final interceptors = Interceptors();
        interceptors.add(CookieManager(mockCookieJar));
        when(mockDio.interceptors).thenReturn(interceptors);

        // Mock network error
        when(mockDio.get(any)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: const SocketException('Connection failed'),
          ),
        );

        // Act & Assert
        expect(
          () => authApi.login(portal: portal, id: id, pw: pw),
          throwsA(isA<NetworkError>()),
        );
      });
    });

    group('refresh', () {
      test('should complete successfully on valid session', () async {
        // Arrange
        when(mockDio.get('/')).thenAnswer((_) async => Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: '/'),
            ));

        // Act & Assert
        expect(() => authApi.refresh(), returnsNormally);
      });

      test('should throw SessionRefreshFailed on 401/403', () async {
        // Arrange
        when(mockDio.get('/')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/'),
            response: Response(
              statusCode: 401,
              requestOptions: RequestOptions(path: '/'),
            ),
          ),
        );

        // Act & Assert
        expect(
          () => authApi.refresh(),
          throwsA(isA<SessionRefreshFailed>()),
        );
      });
    });
  });
}
