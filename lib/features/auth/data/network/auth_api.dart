import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';

import 'package:passpal/core/network/env_config.dart';
import 'package:passpal/core/network/portal.dart';
import 'auth_failure.dart';

/// API client for authentication services
///
/// Handles authentication flows for ALBO, MaNaBo, and Cubics portals
/// using SAML-based SSO via Shibboleth IdP.
class AuthApi {
  /// Creates an AuthApi instance with the provided Dio client
  const AuthApi(this._dio);

  final Dio _dio;

  /// Performs login for the specified portal
  ///
  /// Returns a list of authentication cookies on success, or throws an AuthFailure on error.
  ///
  /// [portal] - The portal to authenticate against (albo, manabo, cubics)
  /// [id] - University student ID
  /// [pw] - University password
  Future<List<Cookie>> login({
    required Portal portal,
    required String id,
    required String pw,
  }) async {
    try {
      debugPrint('Starting login for ${portal.displayName}');

      // Get portal-specific URLs
      final urls = _getPortalUrls(portal);

      // Clear existing cookies
      await _clearCookies(urls.baseUrl);

      // Perform SAML login flow
      final cookies = await _performSamlLogin(
        urls: urls,
        username: id,
        password: pw,
      );

      debugPrint('Login successful for ${portal.displayName}');
      return cookies;
    } on AuthFailure {
      rethrow;
    } catch (e, stackTrace) {
      debugPrint('Unexpected error during login: $e');
      debugPrint('Stack trace: $stackTrace');
      throw UnexpectedError(
        message: 'ログイン処理中に予期しないエラーが発生しました。',
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Refreshes the current session
  ///
  /// Throws an AuthFailure if refresh fails.
  Future<void> refresh() async {
    try {
      debugPrint('Starting session refresh');

      // For now, we implement a simple refresh by making a test request
      // In a full implementation, this would use specific refresh endpoints
      await _dio.get('/');

      debugPrint('Session refresh successful');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        throw const SessionRefreshFailed(
          message: 'セッションの更新に失敗しました。再度ログインしてください。',
        );
      }
      throw _handleDioException(e);
    } catch (e) {
      throw UnexpectedError(
        message: 'セッション更新中に予期しないエラーが発生しました。',
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Performs the SAML authentication flow
  Future<List<Cookie>> _performSamlLogin({
    required _PortalUrls urls,
    required String username,
    required String password,
  }) async {
    try {
      // Step 1: Get SAML AuthnRequest
      final authnRequestUrl = await _getSamlAuthnRequest(urls);

      // Step 2: Get AuthState
      final authState = await _getAuthState(authnRequestUrl);

      // Step 3: Perform login
      final samlData = await _performLogin(authState, username, password);

      // Step 4: Post SAML Response
      await _postSamlResponse(urls.postSamlEntry, samlData);

      // Step 5: Extract cookies
      return await _extractCookies(urls);
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw UnexpectedError(
        message: 'SAML認証フローでエラーが発生しました。',
        originalException: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Step 1: Get SAML AuthnRequest URL
  Future<String> _getSamlAuthnRequest(_PortalUrls urls) async {
    try {
      final response = await _dio.get(urls.shibEntry);

      if (response.statusCode == 503) {
        throw ServiceUnavailable(
          serviceName: urls.serviceName,
          message: '${urls.serviceName}がメンテナンス中です。しばらくしてから再度お試しください。',
        );
      }

      final locationHeader = response.headers.value('location');
      if (locationHeader == null) {
        throw const SamlRequestFailed(
          step: 'SAMLRequest取得',
          message: 'SAMLRequestの取得に失敗しました。',
        );
      }

      debugPrint('AuthnRequest URL取得完了');
      return locationHeader;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Step 2: Get AuthState from login form
  Future<String> _getAuthState(String authnRequestUrl) async {
    try {
      final response = await _dio.get(authnRequestUrl);

      final loginFormUrl = response.headers.value('location');
      if (loginFormUrl == null) {
        throw const SamlRequestFailed(
          step: 'ログインフォームURL取得',
          message: 'ログインフォームURLの取得に失敗しました。',
        );
      }

      final loginFormUri = Uri.parse(loginFormUrl);
      final authState = loginFormUri.queryParameters['AuthState'];
      if (authState == null) {
        throw const SamlRequestFailed(
          step: 'AuthState取得',
          message: 'AuthStateの取得に失敗しました。',
        );
      }

      debugPrint('AuthState取得完了');
      return authState;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Step 3: Perform login with credentials
  Future<_SamlResponseData> _performLogin(
    String authState,
    String username,
    String password,
  ) async {
    try {
      final loginUrl =
          '${EnvConfig.ssoBaseUrl}/cloudlink/module.php/core/loginuserpass.php?';

      final loginFormData = FormData.fromMap({
        'username': username,
        'password': password,
        'login': 'Processing...', // Required constant
        'AuthState': authState,
      });

      final response = await _dio.post(loginUrl, data: loginFormData);
      final responseHtml = response.data.toString();

      // Extract SAML response and relay state
      final samlResponseMatch = RegExp(
        r'<input[^<>]+name="SAMLResponse" value="([^<>]+)" />',
      ).firstMatch(responseHtml);

      final relayStateMatch = RegExp(
        r'<input[^<>]+name="RelayState" value="([^<>]+)\n?" />',
      ).firstMatch(responseHtml);

      final samlResponse = samlResponseMatch?.group(1);
      final relayState = relayStateMatch?.group(1);

      if (samlResponse == null || relayState == null) {
        throw const InvalidCredentials(message: 'ユーザIDまたはパスワードが間違っています。');
      }

      debugPrint('ログイン完了、SAMLResponse取得');
      return _SamlResponseData(
        samlResponse: samlResponse,
        relayState: relayState,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Step 4: Post SAML response to complete authentication
  Future<void> _postSamlResponse(
    String postSamlEntry,
    _SamlResponseData samlData,
  ) async {
    try {
      final postData = {
        'SAMLResponse': samlData.samlResponse,
        'RelayState': samlData.relayState,
      };

      await _dio.post(
        postSamlEntry,
        data: postData,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      debugPrint('SAMLResponse送信完了');
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Step 5: Extract authentication cookies
  Future<List<Cookie>> _extractCookies(_PortalUrls urls) async {
    try {
      // Make a request to refresh cookies
      await _dio.get(urls.shibEntry);

      // Extract cookies using the CookieManager
      final cookieManager = _dio.interceptors
          .whereType<CookieManager>()
          .firstOrNull;

      if (cookieManager == null) {
        throw const CookieExtractionFailed(
          cookieName: 'CookieManager',
          message: 'CookieManagerが見つかりません。',
        );
      }

      final allCookies = await cookieManager.cookieJar.loadForRequest(
        Uri.parse(urls.baseUrl),
      );

      // Get portal-specific cookies
      final requiredCookies = _getRequiredCookies(urls.portal, allCookies);

      debugPrint(
        'Cookie取得完了: ${requiredCookies.map((c) => c.name).join(', ')}',
      );
      return requiredCookies;
    } catch (e) {
      if (e is AuthFailure) rethrow;
      throw CookieExtractionFailed(
        cookieName: 'すべて',
        message: 'Cookieの取得に失敗しました。',
      );
    }
  }

  /// Get required cookies for the specific portal
  List<Cookie> _getRequiredCookies(Portal portal, List<Cookie> allCookies) {
    switch (portal) {
      case Portal.albo:
      case Portal.cubics:
        final jSessionId = allCookies.firstWhere(
          (cookie) => cookie.name == 'JSESSIONID',
          orElse: () => throw const CookieExtractionFailed(
            cookieName: 'JSESSIONID',
            message: 'JSESSIONIDの取得に失敗しました。',
          ),
        );
        final shibSession = allCookies.firstWhere(
          (cookie) => cookie.name.startsWith('_shibsession'),
          orElse: () => throw const CookieExtractionFailed(
            cookieName: '_shibsession',
            message: 'Shibbolethセッションの取得に失敗しました。',
          ),
        );
        return [jSessionId, shibSession];

      case Portal.manabo:
        final glexaSessionId = allCookies.firstWhere(
          (cookie) => cookie.name == 'GlexaSESSID',
          orElse: () => throw const CookieExtractionFailed(
            cookieName: 'GlexaSESSID',
            message: 'GlexaSESSIDの取得に失敗しました。',
          ),
        );
        final shibSession = allCookies.firstWhere(
          (cookie) => cookie.name.startsWith('_shibsession'),
          orElse: () => throw const CookieExtractionFailed(
            cookieName: '_shibsession',
            message: 'Shibbolethセッションの取得に失敗しました。',
          ),
        );
        return [glexaSessionId, shibSession];

      case Portal.sso:
        // For SSO, return all cookies
        return allCookies;
    }
  }

  /// Clear existing cookies for the base URL
  Future<void> _clearCookies(String baseUrl) async {
    try {
      final cookieManager = _dio.interceptors
          .whereType<CookieManager>()
          .firstOrNull;

      if (cookieManager != null) {
        await cookieManager.cookieJar.delete(Uri.parse(baseUrl));
      }
    } catch (e) {
      debugPrint('Cookie削除でエラー: $e');
      // Cookie deletion failure is not critical, continue
    }
  }

  /// Get portal-specific URLs
  _PortalUrls _getPortalUrls(Portal portal) {
    switch (portal) {
      case Portal.albo:
        return _PortalUrls(
          portal: Portal.albo,
          serviceName: 'ALBO',
          baseUrl: EnvConfig.alboBaseUrl,
          shibEntry: '${EnvConfig.alboBaseUrl}/uniprove_pt/UnLoginControl',
          postSamlEntry: '${EnvConfig.alboBaseUrl}/Shibboleth.sso/SAML2/POST',
        );

      case Portal.manabo:
        return _PortalUrls(
          portal: Portal.manabo,
          serviceName: 'MaNaBo',
          baseUrl: EnvConfig.manaboBaseUrl,
          shibEntry: '${EnvConfig.manaboBaseUrl}/auth/shibboleth/',
          postSamlEntry: '${EnvConfig.manaboBaseUrl}/Shibboleth.sso/SAML2/POST',
        );

      case Portal.cubics:
        return _PortalUrls(
          portal: Portal.cubics,
          serviceName: 'Cubics',
          baseUrl: EnvConfig.cubicsBaseUrl,
          shibEntry: '${EnvConfig.cubicsBaseUrl}/uniprove_pt/UnLoginControl',
          postSamlEntry: '${EnvConfig.cubicsBaseUrl}/Shibboleth.sso/SAML2/POST',
        );

      case Portal.sso:
        return _PortalUrls(
          portal: Portal.sso,
          serviceName: 'SSO',
          baseUrl: EnvConfig.ssoBaseUrl,
          shibEntry: '${EnvConfig.ssoBaseUrl}/cloudlink/',
          postSamlEntry: '${EnvConfig.ssoBaseUrl}/Shibboleth.sso/SAML2/POST',
        );
    }
  }

  /// Handle DioException and convert to AuthFailure
  AuthFailure _handleDioException(DioException e) {
    if (e.error is SocketException) {
      return NetworkError(
        message: 'ネットワーク接続エラーが発生しました。インターネット接続を確認してください。',
        originalException: e.error as Exception,
      );
    }

    if (e.response?.statusCode == 503) {
      return const ServiceUnavailable(
        serviceName: 'サーバー',
        message: 'サービスが一時的に利用できません。',
      );
    }

    if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
      return const InvalidCredentials(message: '認証に失敗しました。');
    }

    return NetworkError(
      message: 'ネットワークエラーが発生しました: ${e.message}',
      originalException: e,
    );
  }
}

/// Internal class to hold portal-specific URLs
class _PortalUrls {
  const _PortalUrls({
    required this.portal,
    required this.serviceName,
    required this.baseUrl,
    required this.shibEntry,
    required this.postSamlEntry,
  });

  final Portal portal;
  final String serviceName;
  final String baseUrl;
  final String shibEntry;
  final String postSamlEntry;
}

/// Internal class to hold SAML response data
class _SamlResponseData {
  const _SamlResponseData({
    required this.samlResponse,
    required this.relayState,
  });

  final String samlResponse;
  final String relayState;
}
