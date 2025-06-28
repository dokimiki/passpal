import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart';
import 'package:passpal/core/auth/models/auth_session.dart';
import 'package:passpal/core/config/models/api_config.dart';

/// ポータル設定
enum Portal {
  albo('ALBO'),
  manabo('MaNaBo'),
  cubics('Cubics');

  const Portal(this.displayName);

  final String displayName;

  /// エントリポイントURL
  String getEntryUrl(ApiConfig apiConfig) {
    return switch (this) {
      Portal.albo => '${apiConfig.alboBaseUrl}/uniprove_pt/UnLoginControl',
      Portal.manabo => '${apiConfig.manaboBaseUrl}/auth/shibboleth/',
      Portal.cubics => '${apiConfig.cubicsBaseUrl}/unias/UnSSOLoginControl2?',
    };
  }

  /// SAMLエンドポイント
  String getSamlEndpoint(ApiConfig apiConfig) {
    return switch (this) {
      Portal.albo => '${apiConfig.alboBaseUrl}/Shibboleth.sso/SAML2/POST',
      Portal.manabo => '${apiConfig.manaboBaseUrl}/Shibboleth.sso/SAML2/POST',
      Portal.cubics => '${apiConfig.cubicsBaseUrl}/Shibboleth.sso/SAML2/POST',
    };
  }

  /// ベースURL
  String getBaseUrl(ApiConfig apiConfig) {
    return switch (this) {
      Portal.albo => '${apiConfig.alboBaseUrl}/uniprove_pt',
      Portal.manabo => apiConfig.manaboBaseUrl,
      Portal.cubics => '${apiConfig.cubicsBaseUrl}/unias',
    };
  }

  /// 必要なCookie名
  List<String> get requiredCookies {
    return switch (this) {
      Portal.albo => ['JSESSIONID', '_shibsession'],
      Portal.manabo => ['GlexaSESSID', '_shibsession'],
      Portal.cubics => ['JSESSIONID', '_shibsession'],
    };
  }
}

/// IdP認証処理クラス
class IdpAuthenticator {
  const IdpAuthenticator({
    required this.dio,
    required this.cookieJar,
    required this.apiConfig,
  });

  final Dio dio;
  final CookieJar cookieJar;
  final ApiConfig apiConfig;

  /// ログインURL（共通）
  String get _loginUrl =>
      '${apiConfig.ssoBaseUrl}/cloudlink/module.php/core/loginuserpass.php?';

  /// 指定されたポータルでSSO認証を実行
  Future<AuthSession> login({
    required Portal portal,
    required String username,
    required String password,
  }) async {
    try {
      // 既存のCookieを削除
      await cookieJar.deleteAll();

      // 1. エントリポイントにアクセスしてSAMLRequestを取得
      final authnRequestUrl = await _getAuthnRequestUrl(portal);

      // 2. AuthStateを取得
      final authState = await _getAuthState(authnRequestUrl);

      // 3. ログインフォームにPOSTして認証
      final samlData = await _performLogin(username, password, authState);

      // 4. SAMLResponseをPOSTしてセッション確立
      await _postSamlResponse(portal, samlData);

      // 5. Cookieを取得してセッション情報を構築
      final session = await _buildAuthSession(portal, username);

      return session;
    } on AuthenticationException {
      rethrow;
    } catch (e, stack) {
      throw AuthenticationException.generic(
        message: 'ログイン処理中にエラーが発生しました: $e',
        stack: stack,
      );
    }
  }

  /// エントリポイントにアクセスしてSAMLRequestを取得
  Future<String> _getAuthnRequestUrl(Portal portal) async {
    final response = await dio.get(portal.getEntryUrl(apiConfig));

    if (response.statusCode == 503) {
      throw AuthenticationException.generic(
        message: '${portal.displayName}がメンテナンス中です。しばらくしてから再度お試しください。',
      );
    }

    final authnRequestUrl = response.headers.value('location');
    if (authnRequestUrl == null) {
      throw AuthenticationException.generic(
        message: 'ログインシステムに問題が生じました。(SAMLRequestの取得に失敗)',
      );
    }

    return authnRequestUrl;
  }

  /// AuthStateを取得
  Future<String> _getAuthState(String authnRequestUrl) async {
    final response = await dio.get(authnRequestUrl);
    final loginFormUrl = response.headers.value('location');

    if (loginFormUrl == null) {
      throw AuthenticationException.generic(
        message: 'ログインシステムに問題が生じました。(ログインフォームURLの取得に失敗)',
      );
    }

    final loginFormUri = Uri.parse(loginFormUrl);
    final authState = loginFormUri.queryParameters['AuthState'];

    if (authState == null) {
      throw AuthenticationException.generic(
        message: 'ログインシステムに問題が生じました。(AuthStateの取得に失敗)',
      );
    }

    return authState;
  }

  /// ログインフォームに認証情報をPOST
  Future<Map<String, String>> _performLogin(
    String username,
    String password,
    String authState,
  ) async {
    final loginFormData = FormData.fromMap({
      'username': username,
      'password': password,
      'login': 'Processing...',
      'AuthState': authState,
    });

    final response = await dio.post(_loginUrl, data: loginFormData);
    final responseHtml = response.data.toString();

    // SAMLResponseとRelayStateを抽出
    final samlResponseMatch = RegExp(
      r'<input[^<>]+name="SAMLResponse" value="([^<>]+)" />',
    ).firstMatch(responseHtml);

    final relayStateMatch = RegExp(
      r'<input[^<>]+name="RelayState" value="([^<>]+)\n?" />',
    ).firstMatch(responseHtml);

    final samlResponse = samlResponseMatch?.group(1);
    final relayState = relayStateMatch?.group(1);

    if (samlResponse == null || relayState == null) {
      throw const AuthenticationException.invalidCredential(
        message: 'ユーザIDまたはパスワードが間違っています。',
      );
    }

    return {'SAMLResponse': samlResponse, 'RelayState': relayState};
  }

  /// SAMLResponseをPOSTしてセッション確立
  Future<void> _postSamlResponse(
    Portal portal,
    Map<String, String> samlData,
  ) async {
    await dio.post(
      portal.getSamlEndpoint(apiConfig),
      data: samlData,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }

  /// Cookieを取得してAuthSessionを構築
  Future<AuthSession> _buildAuthSession(Portal portal, String username) async {
    // Cookieを更新するために再度アクセス
    await dio.get(portal.getEntryUrl(apiConfig));

    final allCookies = await cookieJar.loadForRequest(
      Uri.parse(portal.getBaseUrl(apiConfig)),
    );
    final cookieMap = <String, String>{};

    // 必要なCookieを確認・取得
    for (final cookieName in portal.requiredCookies) {
      final cookie = _findCookie(allCookies, cookieName);
      if (cookie == null || cookie.value.isEmpty) {
        throw AuthenticationException.generic(
          message: 'ログインシステムに問題が生じました。($cookieNameの取得に失敗)',
        );
      }
      cookieMap[cookie.name] = cookie.value;
    }

    // セッション有効期限を設定（1時間）
    final expiresAt = DateTime.now().add(const Duration(hours: 1));

    return AuthSession(
      username: username,
      cookies: cookieMap,
      expiresAt: expiresAt,
      lastRefreshed: DateTime.now(),
    );
  }

  /// 指定された名前のCookieを検索
  Cookie? _findCookie(List<Cookie> cookies, String name) {
    for (final cookie in cookies) {
      if (cookie.name == name || cookie.name.startsWith(name)) {
        return cookie;
      }
    }
    return null;
  }
}
