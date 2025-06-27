import 'package:firebase_auth/firebase_auth.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';
import 'package:passpal/core/auth/models/auth_session.dart';
import 'package:passpal/core/auth/idp/idp_authenticator.dart';
import 'package:passpal/core/auth/google/google_link_verifier.dart';
import 'package:passpal/core/storage/secure/credential_storage.dart';
import 'package:passpal/core/storage/models/credentials.dart';

/// 認証ファサードクラス
class AuthFacade {
  const AuthFacade({
    required this.credentialStorage,
    required this.idpAuthenticator,
    required this.googleLinkVerifier,
    required this.firebaseAuth,
  });

  final CredentialStorage credentialStorage;
  final IdpAuthenticator idpAuthenticator;
  final GoogleLinkVerifier googleLinkVerifier;
  final FirebaseAuth firebaseAuth;

  /// ログイン処理
  Future<AuthSession> login({
    required Portal portal,
    required String username,
    required String password,
  }) async {
    try {
      // 1. Google認証の確認
      await googleLinkVerifier.ensureLinked();

      // 2. IdP認証
      final session = await idpAuthenticator.login(
        portal: portal,
        username: username,
        password: password,
      );

      // 3. Firebase ID Tokenを取得
      final idToken = await googleLinkVerifier.getCurrentIdToken();
      final updatedSession = session.updateFirebaseToken(idToken);

      // 4. 認証情報を保存
      final credentials = Credentials(
        username: username,
        password: password,
        sessionCookie: updatedSession.cookieString,
        expiresAt: updatedSession.expiresAt,
      );
      await credentialStorage.save(credentials);

      return updatedSession;
    } on AuthenticationException {
      // 認証エラーの場合は既存の認証情報を削除
      await credentialStorage.purge();
      rethrow;
    } on AccountLinkException {
      // アカウントリンクエラーの場合も既存の認証情報を削除
      await credentialStorage.purge();
      rethrow;
    } catch (e, stack) {
      await credentialStorage.purge();
      throw AuthenticationException.generic(
        message: 'ログイン処理中にエラーが発生しました: $e',
        stack: stack,
      );
    }
  }

  /// セッションリフレッシュ
  Future<AuthSession> refresh() async {
    try {
      // 保存された認証情報を取得
      final credentials = await credentialStorage.read();
      if (credentials == null) {
        throw const AuthenticationException.sessionExpired(
          message: '保存された認証情報が見つかりません。',
        );
      }

      // Google認証の確認
      await googleLinkVerifier.ensureLinked();

      // 自動再ログイン（一度のみ）
      final session = await idpAuthenticator.login(
        portal: Portal.albo, // デフォルトポータル（要検討）
        username: credentials.username,
        password: credentials.password,
      );

      // Firebase ID Tokenを更新
      final idToken = await googleLinkVerifier.refreshIdToken();
      final updatedSession = session.updateFirebaseToken(idToken);

      // 更新された認証情報を保存
      final updatedCredentials = credentials.copyWith(
        sessionCookie: updatedSession.cookieString,
        expiresAt: updatedSession.expiresAt,
      );
      await credentialStorage.save(updatedCredentials);

      return updatedSession;
    } on AuthenticationException {
      // リフレッシュに失敗した場合は認証情報を削除
      await credentialStorage.purge();
      rethrow;
    } on AccountLinkException {
      await credentialStorage.purge();
      rethrow;
    } catch (e, stack) {
      await credentialStorage.purge();
      throw AuthenticationException.sessionExpired(
        message: 'セッションの更新に失敗しました: $e',
        stack: stack,
      );
    }
  }

  /// ログアウト
  Future<void> logout() async {
    try {
      // Firebase認証をサインアウト
      await firebaseAuth.signOut();

      // 保存された認証情報を削除
      await credentialStorage.purge();
    } catch (e) {
      // ログアウトでエラーが発生しても認証情報は削除する
      await credentialStorage.purge();
      rethrow;
    }
  }

  /// 保存された認証情報から初期セッションを復元
  Future<AuthSession?> restoreSession() async {
    try {
      final credentials = await credentialStorage.read();
      if (credentials == null) return null;

      // Google認証状態を確認
      if (!googleLinkVerifier.isSignedIn) return null;

      // セッション有効期限を確認
      if (credentials.expiresAt != null &&
          DateTime.now().isAfter(credentials.expiresAt!)) {
        // 期限切れの場合は削除
        await credentialStorage.purge();
        return null;
      }

      // Cookieを解析
      final cookieMap = <String, String>{};
      if (credentials.sessionCookie != null) {
        final cookies = credentials.sessionCookie!.split('; ');
        for (final cookie in cookies) {
          final parts = cookie.split('=');
          if (parts.length == 2) {
            cookieMap[parts[0]] = parts[1];
          }
        }
      }

      // Firebase ID Tokenを取得
      final idToken = await googleLinkVerifier.getCurrentIdToken();

      return AuthSession(
        username: credentials.username,
        cookies: cookieMap,
        firebaseIdToken: idToken,
        expiresAt:
            credentials.expiresAt ??
            DateTime.now().add(const Duration(hours: 1)),
        lastRefreshed: DateTime.now(),
      );
    } catch (e) {
      // 復元に失敗した場合は認証情報を削除
      await credentialStorage.purge();
      return null;
    }
  }

  /// セッション状態を確認
  Future<bool> isSessionValid() async {
    final session = await restoreSession();
    return session != null && session.isValid;
  }

  /// セッションがリフレッシュ必要かどうか
  Future<bool> needsRefresh() async {
    final session = await restoreSession();
    return session != null && session.needsRefresh;
  }
}
