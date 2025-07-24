import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/providers.dart';
import '../../config/models/api_config.dart';
import '../../error/providers.dart';
import '../models/service_config.dart';

part 'dio_factory.g.dart';

/// Factory class for creating configured Dio instances for different services
///
/// This class provides configured Dio instances for different services:
/// - PalAPI: Firebase authenticated internal API
/// - Portal services (MaNaBo, ALBO, Cubics): Cookie-based authentication
/// - SSO: Form-based authentication for Shibboleth
///
/// Each service gets optimized configuration including:
/// - Custom timeouts
/// - Cookie management (where applicable)
/// - User agent headers
/// - Base interceptors
class DioFactory {
  DioFactory({required this.apiConfig, required this.logger});

  final ApiConfig apiConfig;
  final AppLogger logger;

  /// Create a Dio instance for PalAPI service
  ///
  /// PalAPI is the internal Firebase-authenticated API that provides:
  /// - User preferences
  /// - Push notification tokens
  /// - Analytics data
  /// - Feature flags
  Dio createPalApiClient() {
    logger.debug('Creating PalAPI Dio client');

    final dio = Dio(
      BaseOptions(
        baseUrl: apiConfig.palApiBaseUrl,
        connectTimeout: apiConfig.connectionTimeout,
        receiveTimeout: apiConfig.receiveTimeout,
        sendTimeout: apiConfig.connectionTimeout,
        headers: _getCommonHeaders(),
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _configureCommonInterceptors(dio);

    logger.debug(
      'PalAPI Dio client created with base URL: ${apiConfig.palApiBaseUrl}',
    );
    return dio;
  }

  /// Create a Dio instance for portal services (MaNaBo, ALBO, Cubics)
  ///
  /// Portal services use Shibboleth SSO with cookie-based authentication.
  /// They require:
  /// - Cookie jar for session management
  /// - Longer timeouts for slow university servers
  /// - Specific user agent to avoid blocking
  Dio createPortalClient(ServiceConfig config) {
    logger.debug(
      'Creating portal Dio client for service: ${config.displayName}',
    );

    final cookieJar = CookieJar();
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: Duration(milliseconds: config.connectTimeoutMs),
        receiveTimeout: Duration(milliseconds: config.readTimeoutMs),
        sendTimeout: Duration(milliseconds: config.writeTimeoutMs),
        headers: _getPortalHeaders(),
        validateStatus: (status) => status != null && status < 500,
        followRedirects: config.followRedirects,
        maxRedirects: config.maxRedirects,
      ),
    );

    // Add cookie manager for session handling
    dio.interceptors.add(CookieManager(cookieJar));

    _configureCommonInterceptors(dio);

    logger.debug(
      'Portal Dio client created for ${config.displayName} with base URL: ${config.baseUrl}',
    );
    return dio;
  }

  /// Create a Dio instance for SSO authentication
  ///
  /// SSO client is used for:
  /// - Initial Shibboleth authentication
  /// - Form submission to login pages
  /// - Redirect handling during login flow
  Dio createSsoClient() {
    logger.debug('Creating SSO Dio client');

    final cookieJar = CookieJar();
    final dio = Dio(
      BaseOptions(
        baseUrl: apiConfig.ssoUrl,
        connectTimeout: apiConfig.connectionTimeout,
        receiveTimeout: Duration(seconds: apiConfig.receiveTimeoutSeconds + 30),
        sendTimeout: apiConfig.connectionTimeout,
        headers: _getSsoHeaders(),
        validateStatus: (status) => status != null && status < 400,
        followRedirects: false, // Handle redirects manually for SSO flow
        maxRedirects: 0,
      ),
    );

    // Add cookie manager for SSO session handling
    dio.interceptors.add(CookieManager(cookieJar));

    _configureCommonInterceptors(dio);

    logger.debug('SSO Dio client created with base URL: ${apiConfig.ssoUrl}');
    return dio;
  }

  /// Configure common interceptors for all clients
  void _configureCommonInterceptors(Dio dio) {
    // Add request/response logging
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: false, // Don't log sensitive form data
        responseHeader: false,
        responseBody: false, // Don't log potentially large HTML responses
        error: true,
        logPrint: (object) => logger.debug(object.toString()),
      ),
    );
  }

  /// Get common headers for all requests
  Map<String, String> _getCommonHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'User-Agent': _getUserAgent(),
    };
  }

  /// Get headers specific to portal services
  Map<String, String> _getPortalHeaders() {
    return {
      'Accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Language': 'ja-JP,ja;q=0.9,en;q=0.8',
      'Accept-Encoding': 'gzip, deflate',
      'User-Agent': _getUserAgent(),
      'Cache-Control': 'no-cache',
    };
  }

  /// Get headers specific to SSO authentication
  Map<String, String> _getSsoHeaders() {
    return {
      'Accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Language': 'ja-JP,ja;q=0.9,en;q=0.8',
      'Accept-Encoding': 'gzip, deflate',
      'User-Agent': _getUserAgent(),
      'Cache-Control': 'no-cache',
      'Upgrade-Insecure-Requests': '1',
    };
  }

  /// Generate user agent string that mimics a real browser
  String _getUserAgent() {
    return 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) '
        'AppleWebKit/605.1.15 (KHTML, like Gecko) '
        'Version/17.0 Mobile/15E148 Safari/604.1 PassPal/1.0';
  }
}

/// Provider for DioFactory instance
@riverpod
DioFactory dioFactory(Ref ref) {
  final apiConfig = ref.watch(apiConfigProvider);
  final logger = ref.watch(scopedLoggerProvider('DioFactory'));

  return DioFactory(apiConfig: apiConfig, logger: logger);
}

/// Provider for PalAPI Dio client
@riverpod
Dio palApiDio(Ref ref) {
  final factory = ref.watch(dioFactoryProvider);
  return factory.createPalApiClient();
}

/// Provider for MaNaBo Dio client
@riverpod
Dio manaboDio(Ref ref) {
  final factory = ref.watch(dioFactoryProvider);
  return factory.createPortalClient(ServiceConfigs.manabo);
}

/// Provider for ALBO Dio client
@riverpod
Dio alboDio(Ref ref) {
  final factory = ref.watch(dioFactoryProvider);
  return factory.createPortalClient(ServiceConfigs.albo);
}

/// Provider for Cubics Dio client
@riverpod
Dio cubicsDio(Ref ref) {
  final factory = ref.watch(dioFactoryProvider);
  return factory.createPortalClient(ServiceConfigs.cubics);
}

/// Provider for SSO Dio client
@riverpod
Dio ssoDio(Ref ref) {
  final factory = ref.watch(dioFactoryProvider);
  return factory.createSsoClient();
}
