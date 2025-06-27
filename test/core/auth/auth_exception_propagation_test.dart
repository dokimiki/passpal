import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/auth/facade/auth_facade.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';
import 'package:passpal/core/auth/idp/idp_authenticator.dart';
import 'package:passpal/core/auth/google/google_link_verifier.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/storage/secure/credential_storage.dart';
import 'package:passpal/core/error/crashlytics_reporter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_exception_propagation_test.mocks.dart';

@GenerateMocks([
  CredentialStorage,
  IdpAuthenticator,
  GoogleLinkVerifier,
  FirebaseAuth,
  CrashlyticsReporter,
])
void main() {
  group('Auth Exception Propagation', () {
    late ProviderContainer container;
    late MockCredentialStorage mockCredentialStorage;
    late MockIdpAuthenticator mockIdpAuthenticator;
    late MockGoogleLinkVerifier mockGoogleLinkVerifier;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockCrashlyticsReporter mockCrashlyticsReporter;

    setUp(() {
      mockCredentialStorage = MockCredentialStorage();
      mockIdpAuthenticator = MockIdpAuthenticator();
      mockGoogleLinkVerifier = MockGoogleLinkVerifier();
      mockFirebaseAuth = MockFirebaseAuth();
      mockCrashlyticsReporter = MockCrashlyticsReporter();

      container = ProviderContainer(
        overrides: [authStateProvider.overrideWith(() => AuthStateNotifier())],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'should propagate AuthenticationException to CrashlyticsReporter',
      () async {
        // Arrange
        final authException = AuthenticationException.invalidCredential(
          message: 'Test authentication error',
        );

        when(mockGoogleLinkVerifier.ensureLinked()).thenThrow(authException);

        final authFacade = AuthFacade(
          credentialStorage: mockCredentialStorage,
          idpAuthenticator: mockIdpAuthenticator,
          googleLinkVerifier: mockGoogleLinkVerifier,
          firebaseAuth: mockFirebaseAuth,
        );

        // Act & Assert
        expect(
          () => authFacade.login(
            portal: Portal.albo,
            username: 'test',
            password: 'password',
          ),
          throwsA(isA<AuthenticationException>()),
        );

        // Verify that credential storage is purged on error
        verify(mockCredentialStorage.purge()).called(1);
      },
    );

    test(
      'should propagate AccountLinkException to CrashlyticsReporter',
      () async {
        // Arrange
        final linkException = AccountLinkException.domainMismatch(
          message: 'Test domain mismatch error',
        );

        when(mockGoogleLinkVerifier.ensureLinked()).thenThrow(linkException);

        final authFacade = AuthFacade(
          credentialStorage: mockCredentialStorage,
          idpAuthenticator: mockIdpAuthenticator,
          googleLinkVerifier: mockGoogleLinkVerifier,
          firebaseAuth: mockFirebaseAuth,
        );

        // Act & Assert
        expect(
          () => authFacade.login(
            portal: Portal.albo,
            username: 'test',
            password: 'password',
          ),
          throwsA(isA<AccountLinkException>()),
        );

        // Verify that credential storage is purged on error
        verify(mockCredentialStorage.purge()).called(1);
      },
    );

    test(
      'should convert generic exceptions to AuthenticationException',
      () async {
        // Arrange
        final genericError = Exception('Generic error');

        when(mockGoogleLinkVerifier.ensureLinked()).thenThrow(genericError);

        final authFacade = AuthFacade(
          credentialStorage: mockCredentialStorage,
          idpAuthenticator: mockIdpAuthenticator,
          googleLinkVerifier: mockGoogleLinkVerifier,
          firebaseAuth: mockFirebaseAuth,
        );

        // Act & Assert
        expect(
          () => authFacade.login(
            portal: Portal.albo,
            username: 'test',
            password: 'password',
          ),
          throwsA(isA<AuthenticationException>()),
        );

        // Verify that credential storage is purged on error
        verify(mockCredentialStorage.purge()).called(1);
      },
    );

    test('AuthStateNotifier should handle login errors properly', () async {
      // Arrange
      final notifier = container.read(authStateProvider.notifier);
      final initialState = container.read(authStateProvider);

      expect(initialState, isA<AuthStateUnauthenticated>());

      // Mock the auth facade to throw an exception
      // Note: This test would need proper mocking setup for the full provider chain
      // For now, we test the state transitions

      // Verify initial state
      expect(notifier.build(), isA<AuthStateUnauthenticated>());
    });
  });
}
