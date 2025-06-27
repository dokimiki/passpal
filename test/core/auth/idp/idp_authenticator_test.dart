import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:passpal/core/auth/idp/idp_authenticator.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';

import 'idp_authenticator_test.mocks.dart';

@GenerateMocks([Dio, CookieJar])
void main() {
  group('IdpAuthenticator', () {
    late MockDio mockDio;
    late MockCookieJar mockCookieJar;
    late IdpAuthenticator authenticator;

    setUp(() {
      mockDio = MockDio();
      mockCookieJar = MockCookieJar();
      authenticator = IdpAuthenticator(dio: mockDio, cookieJar: mockCookieJar);
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
            mockDio.get(Portal.albo.entryUrl),
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
          Portal.albo.entryUrl,
          'https://cubics-pt-out.mng.chukyo-u.ac.jp/uniprove_pt/UnLoginControl',
        );
        expect(
          Portal.manabo.entryUrl,
          'https://manabo.cnc.chukyo-u.ac.jp/auth/shibboleth/',
        );
        expect(
          Portal.cubics.entryUrl,
          'https://cubics-as-out.mng.chukyo-u.ac.jp/unias/UnSSOLoginControl2?',
        );
      });

      test('should have correct SAML endpoints for each portal', () {
        expect(
          Portal.albo.samlEndpoint,
          'https://cubics-pt-out.mng.chukyo-u.ac.jp/Shibboleth.sso/SAML2/POST',
        );
        expect(
          Portal.manabo.samlEndpoint,
          'https://manabo.cnc.chukyo-u.ac.jp/Shibboleth.sso/SAML2/POST',
        );
        expect(
          Portal.cubics.samlEndpoint,
          'https://cubics-as-out.mng.chukyo-u.ac.jp/Shibboleth.sso/SAML2/POST',
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
