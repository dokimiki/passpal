import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passpal/core/auth/facade/auth_facade.dart';
import 'package:passpal/core/auth/idp/idp_authenticator.dart';
import 'package:passpal/core/auth/google/google_link_verifier.dart';
import 'package:passpal/core/auth/providers/auth_state_notifier.dart';
import 'package:passpal/core/network/providers.dart';
import 'package:passpal/core/network/network_target.dart';
import 'package:passpal/core/storage/storage_providers.dart';
import 'package:passpal/core/config/config_providers.dart';

/// Firebase Auth インスタンス
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Google認証検証プロバイダー
final googleLinkVerifierProvider = Provider<GoogleLinkVerifier>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final authConfig = ref
      .watch(appConfigProvider)
      .when(
        data: (config) => config.auth,
        loading: () => throw StateError('Auth config is loading'),
        error: (error, stack) =>
            throw StateError('Failed to load auth config: $error'),
      );

  return GoogleLinkVerifier(firebaseAuth: firebaseAuth, authConfig: authConfig);
});

/// IdP認証プロバイダー
final idpAuthenticatorProvider = Provider<IdpAuthenticator>((ref) {
  final dio = ref.watch(networkClientProvider(NetworkTarget.sso));
  final cookieJar = ref.watch(cookieJarProvider);
  dio.interceptors.add(CookieManager(cookieJar));
  final apiConfig = ref
      .watch(appConfigProvider)
      .when(
        data: (config) => config.api,
        loading: () => throw StateError('API config is loading'),
        error: (error, stack) =>
            throw StateError('Failed to load API config: $error'),
      );

  return IdpAuthenticator(dio: dio, cookieJar: cookieJar, apiConfig: apiConfig);
});

/// 認証ファサードプロバイダー
final authFacadeProvider = Provider<AuthFacade>((ref) {
  final credentialStorage = ref.watch(credentialStorageProvider);
  final idpAuthenticator = ref.watch(idpAuthenticatorProvider);
  final googleLinkVerifier = ref.watch(googleLinkVerifierProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return AuthFacade(
    credentialStorage: credentialStorage,
    idpAuthenticator: idpAuthenticator,
    googleLinkVerifier: googleLinkVerifier,
    firebaseAuth: firebaseAuth,
  );
});

/// 認証状態プロバイダー
final authStateProvider = NotifierProvider<AuthStateNotifier, AuthState>(
  AuthStateNotifier.new,
);
