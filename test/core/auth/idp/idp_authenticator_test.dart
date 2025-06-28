import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:passpal/core/auth/idp/idp_authenticator.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';
import 'package:passpal/core/config/models/api_config.dart';

import 'idp_authenticator_test.mocks.dart';

@GenerateMocks([Dio, CookieJar])
void main() {
  group('IdpAuthenticator', () {
    late MockDio mockDio;
    late MockCookieJar mockCookieJar;
    late IdpAuthenticator authenticator;
    late ApiConfig apiConfig;

    setUp(() {
      mockDio = MockDio();
      mockCookieJar = MockCookieJar();
      apiConfig = ApiConfig.defaultConfig;
      authenticator = IdpAuthenticator(
        dio: mockDio,
        cookieJar: mockCookieJar,
        apiConfig: apiConfig,
      );
    });

    group('login', () {
      test(
        'should throw AuthenticationException when portal is in maintenance (503)',
        () async {
          // Arrange
          final response = Response<String>(
            data: 'Service Unavailable',
            statusCode: 503,
            requestOptions: RequestOptions(path: ''),
          );
          when(mockDio.get(any)).thenAnswer((_) async => response);

          // Act & Assert
          expect(
            () => authenticator.login(
              portal: Portal.albo,
              username: 'test',
              password: 'password',
            ),
            throwsA(isA<AuthenticationException>()),
          );
        },
      );

      test(
        'should throw AuthenticationException when SAMLRequest location is missing',
        () async {
          // Arrange
          final response = Response<String>(
            data: 'OK',
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
            headers: Headers(),
          );
          when(mockDio.get(any)).thenAnswer((_) async => response);

          // Act & Assert
          expect(
            () => authenticator.login(
              portal: Portal.albo,
              username: 'test',
              password: 'password',
            ),
            throwsA(isA<AuthenticationException>()),
          );
        },
      );

      test(
        'should throw AuthenticationException.invalidCredential when login form contains no SAML response',
        () async {
          // Arrange
          final entryResponse = Response<String>(
            data: 'Redirect',
            statusCode: 302,
            requestOptions: RequestOptions(path: ''),
            headers: Headers.fromMap({
              'location': ['https://shib.chukyo-u.ac.jp/auth'],
            }),
          );

          final authStateResponse = Response<String>(
            data: 'Redirect',
            statusCode: 302,
            requestOptions: RequestOptions(path: ''),
            headers: Headers.fromMap({
              'location': [
                'https://shib.chukyo-u.ac.jp/login?AuthState=test123',
              ],
            }),
          );

          final loginResponse = Response<String>(
            data: '<html><body>Invalid credentials</body></html>',
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          );

          when(
            mockDio.get(Portal.albo.getEntryUrl(apiConfig)),
          ).thenAnswer((_) async => entryResponse);
          when(
            mockDio.get('https://shib.chukyo-u.ac.jp/auth'),
          ).thenAnswer((_) async => authStateResponse);
          when(
            mockDio.post(any, data: anyNamed('data')),
          ).thenAnswer((_) async => loginResponse);

          // Act & Assert
          expect(
            () => authenticator.login(
              portal: Portal.albo,
              username: 'wrong',
              password: 'password',
            ),
            throwsA(isA<AuthenticationException>()),
          );
        },
      );
    });

    group('Portal enum', () {
      test('should have correct entry URLs for each portal', () {
        expect(
          Portal.albo.getEntryUrl(apiConfig),
          '${apiConfig.alboBaseUrl}/uniprove_pt/UnLoginControl',
        );
        expect(
          Portal.manabo.getEntryUrl(apiConfig),
          '${apiConfig.manaboBaseUrl}/auth/shibboleth/',
        );
        expect(
          Portal.cubics.getEntryUrl(apiConfig),
          '${apiConfig.cubicsBaseUrl}/unias/UnSSOLoginControl2?',
        );
      });

      test('should have correct SAML endpoints for each portal', () {
        expect(
          Portal.albo.getSamlEndpoint(apiConfig),
          '${apiConfig.alboBaseUrl}/Shibboleth.sso/SAML2/POST',
        );
        expect(
          Portal.manabo.getSamlEndpoint(apiConfig),
          '${apiConfig.manaboBaseUrl}/Shibboleth.sso/SAML2/POST',
        );
        expect(
          Portal.cubics.getSamlEndpoint(apiConfig),
          '${apiConfig.cubicsBaseUrl}/Shibboleth.sso/SAML2/POST',
        );
      });

      test('should have correct required cookies for each portal', () {
        expect(Portal.albo.requiredCookies, ['JSESSIONID', '_shibsession']);
        expect(Portal.manabo.requiredCookies, ['GlexaSESSID', '_shibsession']);
        expect(Portal.cubics.requiredCookies, ['JSESSIONID', '_shibsession']);
      });
    });
  });
}
