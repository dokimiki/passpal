import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
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

      debugPrint('IdP認証開始: ${portal.displayName}');

      // 1. エントリポイントにアクセスしてSAMLRequestを取得
      debugPrint('ステップ1: SAMLRequest取得中...');
      final authnRequestUrl = await _getAuthnRequestUrl(portal);

      // 2. AuthStateを取得
      debugPrint('ステップ2: AuthState取得中...');
      final authState = await _getAuthState(authnRequestUrl);

      // 3. ログインフォームにPOSTして認証
      debugPrint('ステップ3: ログイン認証中...');
      final samlData = await _performLogin(username, password, authState);

      // 4. SAMLResponseをPOSTしてセッション確立
      debugPrint('ステップ4: セッション確立中...');
      await _postSamlResponse(portal, samlData);

      // 5. Cookieを取得してセッション情報を構築
      debugPrint('ステップ5: セッション情報構築中...');
      final session = await _buildAuthSession(portal, username);

      debugPrint('IdP認証完了: ${portal.displayName}');
      return session;
    } on AuthenticationException {
      rethrow;
    } on DioException catch (e) {
      debugPrint('DioException during login: ${e.type}, ${e.message}');
      if (e.type == DioExceptionType.unknown &&
          e.message?.contains('Redirect limit exceeded') == true) {
        throw AuthenticationException.generic(
          message: 'ログインシステムでリダイレクトエラーが発生しました。再度お試しください。',
        );
      }
      throw AuthenticationException.generic(
        message: 'ネットワークエラーが発生しました: ${e.message}',
      );
    } catch (e, stack) {
      debugPrint('IdP認証エラー: $e');
      debugPrint('stack trace: $stack');
      throw AuthenticationException.generic(
        message: 'ログイン処理中にエラーが発生しました: $e',
        stack: stack,
      );
    }
  }

  /// エントリポイントにアクセスしてSAMLRequestを取得
  Future<String> _getAuthnRequestUrl(Portal portal) async {
    try {
      final response = await dio.get(
        portal.getEntryUrl(apiConfig),
        options: Options(
          followRedirects: false, // リダイレクトを手動で処理
          validateStatus: (status) => status! < 400, // 3xxも成功として扱う
        ),
      );

      if (response.statusCode == 503) {
        throw AuthenticationException.generic(
          message: '${portal.displayName}がメンテナンス中です。しばらくしてから再度お試しください。',
        );
      }

      // リダイレクトレスポンスの場合
      if (response.statusCode == 302 || response.statusCode == 301) {
        final authnRequestUrl = response.headers.value('location');
        if (authnRequestUrl == null) {
          throw AuthenticationException.generic(
            message: 'ログインシステムに問題が生じました。(SAMLRequestの取得に失敗)',
          );
        }
        return authnRequestUrl;
      }

      // 直接レスポンスの場合（稀なケース）
      throw AuthenticationException.generic(
        message: 'ログインシステムに問題が生じました。(予期しないレスポンス形式)',
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown &&
          e.message?.contains('Redirect limit exceeded') == true) {
        throw AuthenticationException.generic(
          message: 'ログインシステムでリダイレクトエラーが発生しました。しばらくしてから再度お試しください。',
        );
      }
      rethrow;
    }
  }

  /// AuthStateを取得
  Future<String> _getAuthState(String authnRequestUrl) async {
    try {
      final response = await dio.get(
        authnRequestUrl,
        options: Options(
          followRedirects: false, // リダイレクトを手動で処理
          validateStatus: (status) => status! < 400, // 3xxも成功として扱う
        ),
      );

      // リダイレクトレスポンスの場合
      if (response.statusCode == 302 || response.statusCode == 301) {
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

      // 直接レスポンスの場合（稀なケース）
      throw AuthenticationException.generic(
        message: 'ログインシステムに問題が生じました。(予期しないレスポンス形式)',
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown &&
          e.message?.contains('Redirect limit exceeded') == true) {
        throw AuthenticationException.generic(
          message: 'ログインシステムでリダイレクトエラーが発生しました。しばらくしてから再度お試しください。',
        );
      }
      rethrow;
    }
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
    try {
      // Cookieを更新するために再度アクセス
      await dio.get(
        portal.getEntryUrl(apiConfig),
        options: Options(
          followRedirects: true, // ここではリダイレクトを許可（Cookieセット目的）
          maxRedirects: 10, // リダイレクト制限を緩和
          validateStatus: (status) => status! < 400,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown &&
          e.message?.contains('Redirect limit exceeded') == true) {
        // Cookieの取得でリダイレクトエラーが発生した場合でも処理を続行
        debugPrint('Cookie取得時にリダイレクトエラーが発生しましたが、処理を続行します: $e');
      } else {
        rethrow;
      }
    }

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
