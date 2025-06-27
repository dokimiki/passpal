import 'package:firebase_auth/firebase_auth.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';

/// Google認証のドメイン検証クラス
class GoogleLinkVerifier {
  const GoogleLinkVerifier({required this.firebaseAuth});

  final FirebaseAuth firebaseAuth;

  /// 許可されたドメイン
  static const _allowedDomain = '@m.chukyo-u.ac.jp';

  /// 現在のFirebaseユーザーが大学ドメインかつ認証済みかを確認
  Future<void> ensureLinked() async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw const AccountLinkException.domainMismatch(
        message: 'Googleアカウントでサインインしてください。',
      );
    }

    // メールアドレスの検証
    if (user.email == null || !user.email!.endsWith(_allowedDomain)) {
      throw AccountLinkException.domainMismatch(
        message: '中京大学のメールアドレス($_allowedDomain)でサインインしてください。',
      );
    }

    // メール認証の確認
    if (!user.emailVerified) {
      throw const AccountLinkException.emailNotVerified(
        message: 'メールアドレスの認証が完了していません。メールを確認して認証を完了してください。',
      );
    }
  }

  /// 現在のFirebase ID Tokenを取得
  Future<String?> getCurrentIdToken() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;

    try {
      return await user.getIdToken();
    } catch (e) {
      // トークン取得に失敗した場合はnullを返す
      return null;
    }
  }

  /// Firebase ID Tokenを強制的に更新
  Future<String?> refreshIdToken() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;

    try {
      return await user.getIdToken(true); // 強制更新
    } catch (e) {
      return null;
    }
  }

  /// 現在のユーザー情報を取得
  User? get currentUser => firebaseAuth.currentUser;

  /// ユーザーがサインイン済みかどうか
  bool get isSignedIn => firebaseAuth.currentUser != null;
}
