import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

/// 認証済みセッション情報
@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String username,
    required Map<String, String> cookies,
    String? firebaseIdToken,
    required DateTime expiresAt,
    required DateTime lastRefreshed,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}

/// 認証セッションの有効性チェック拡張
extension AuthSessionExtension on AuthSession {
  /// セッションが有効かどうか
  bool get isValid {
    return DateTime.now().isBefore(expiresAt);
  }

  /// セッションの有効期限まで5分未満かどうか
  bool get needsRefresh {
    final fiveMinutesFromNow = DateTime.now().add(const Duration(minutes: 5));
    return fiveMinutesFromNow.isAfter(expiresAt);
  }

  /// Cookie文字列を生成
  String get cookieString {
    return cookies.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('; ');
  }

  /// 特定のCookieを取得
  String? getCookie(String name) {
    return cookies[name];
  }

  /// Cookieを更新した新しいセッションを作成
  AuthSession updateCookies(Map<String, String> newCookies) {
    return copyWith(
      cookies: {...cookies, ...newCookies},
      lastRefreshed: DateTime.now(),
    );
  }

  /// 有効期限を更新した新しいセッションを作成
  AuthSession updateExpiry(DateTime newExpiry) {
    return copyWith(expiresAt: newExpiry, lastRefreshed: DateTime.now());
  }

  /// Firebase ID Tokenを更新した新しいセッションを作成
  AuthSession updateFirebaseToken(String? token) {
    return copyWith(firebaseIdToken: token, lastRefreshed: DateTime.now());
  }
}
