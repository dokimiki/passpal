import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error/providers.dart';
import '../models/service_config.dart';

part 'auth_interceptor.g.dart';

/// Authentication interceptor that handles token and cookie-based authentication
///
/// This interceptor:
/// - Adds authentication headers/cookies to requests
/// - Handles 401/403 errors with auto-refresh retry
/// - Supports different auth types per service
/// - Integrates with auth core providers (when available)
///
/// Supported authentication types:
/// - Token: Bearer tokens, API keys
/// - Cookie: Session cookies from authentication
/// - Form: Form-based authentication (handled separately)
/// - OAuth2: OAuth 2.0 tokens
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.serviceConfig,
    required this.authProvider,
    required this.logger,
  });

  final ServiceConfig serviceConfig;
  final AuthProvider authProvider;
  final AppLogger logger;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Skip authentication for services that don't require it
      if (!serviceConfig.requiresAuth) {
        logger.debug(
          'Skipping auth for service ${serviceConfig.serviceId} (no auth required)',
        );
        handler.next(options);
        return;
      }

      logger.debug(
        'Adding authentication for service ${serviceConfig.serviceId} '
        'with auth type: ${serviceConfig.authType}',
      );

      // Add authentication based on service auth type
      switch (serviceConfig.authType) {
        case AuthType.token:
          await _addTokenAuth(options);
          break;
        case AuthType.oauth2:
          await _addOAuth2Auth(options);
          break;
        case AuthType.cookie:
          await _addCookieAuth(options);
          break;
        case AuthType.form:
          // Form authentication is handled during login flow
          // No additional headers needed for subsequent requests
          logger.debug('Form auth - no additional headers needed');
          break;
        case AuthType.custom:
          await _addCustomAuth(options);
          break;
        case AuthType.none:
          // Already handled above
          break;
      }

      handler.next(options);
    } catch (error, stackTrace) {
      logger.error(
        'Failed to add authentication for ${serviceConfig.serviceId}: $error',
        stackTrace: stackTrace,
      );
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          message: 'Authentication failed: $error',
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle authentication errors with auto-refresh retry
    if (_isAuthError(err)) {
      logger.info(
        'Authentication error detected for ${serviceConfig.serviceId}: '
        '${err.response?.statusCode} ${err.response?.statusMessage}',
      );

      try {
        final shouldRetry = await _handleAuthError(err);
        if (shouldRetry) {
          logger.debug('Retrying request after auth refresh');
          final response = await _retryRequest(err.requestOptions);
          handler.resolve(response);
          return;
        }
      } catch (retryError, stackTrace) {
        logger.error(
          'Failed to retry request after auth error: $retryError',
          stackTrace: stackTrace,
        );
        // Fall through to original error
      }
    }

    handler.next(err);
  }

  /// Add token-based authentication (Bearer token)
  Future<void> _addTokenAuth(RequestOptions options) async {
    final token = await authProvider.getAccessToken(serviceConfig.serviceId);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      logger.debug('Added Bearer token for ${serviceConfig.serviceId}');
    } else {
      logger.warning(
        'No access token available for ${serviceConfig.serviceId}',
      );
    }
  }

  /// Add OAuth 2.0 authentication
  Future<void> _addOAuth2Auth(RequestOptions options) async {
    final token = await authProvider.getOAuth2Token(serviceConfig.serviceId);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      logger.debug('Added OAuth2 token for ${serviceConfig.serviceId}');
    } else {
      logger.warning(
        'No OAuth2 token available for ${serviceConfig.serviceId}',
      );
    }
  }

  /// Add cookie-based authentication
  Future<void> _addCookieAuth(RequestOptions options) async {
    final cookies = await authProvider.getSessionCookies(
      serviceConfig.serviceId,
    );
    if (cookies.isNotEmpty) {
      final cookieHeader = cookies.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('; ');
      options.headers['Cookie'] = cookieHeader;
      logger.debug(
        'Added session cookies for ${serviceConfig.serviceId} (${cookies.length} cookies)',
      );
    } else {
      logger.warning(
        'No session cookies available for ${serviceConfig.serviceId}',
      );
    }
  }

  /// Add custom authentication
  Future<void> _addCustomAuth(RequestOptions options) async {
    final customAuth = await authProvider.getCustomAuth(
      serviceConfig.serviceId,
    );
    if (customAuth.isNotEmpty) {
      options.headers.addAll(customAuth);
      logger.debug(
        'Added custom auth headers for ${serviceConfig.serviceId} (${customAuth.length} headers)',
      );
    } else {
      logger.warning('No custom auth available for ${serviceConfig.serviceId}');
    }
  }

  /// Check if the error is authentication-related
  bool _isAuthError(DioException err) {
    final statusCode = err.response?.statusCode;
    return statusCode == 401 || statusCode == 403;
  }

  /// Handle authentication error and attempt to refresh credentials
  Future<bool> _handleAuthError(DioException err) async {
    final statusCode = err.response?.statusCode;

    logger.info(
      'Handling auth error $statusCode for ${serviceConfig.serviceId}',
    );

    try {
      switch (serviceConfig.authType) {
        case AuthType.token:
        case AuthType.oauth2:
          // Attempt to refresh token
          final refreshed = await authProvider.refreshToken(
            serviceConfig.serviceId,
          );
          if (refreshed) {
            logger.info(
              'Successfully refreshed token for ${serviceConfig.serviceId}',
            );
            return true;
          }
          break;

        case AuthType.cookie:
        case AuthType.form:
          // For cookie/form auth, we need to re-authenticate
          final reauthenticated = await authProvider.reauthenticate(
            serviceConfig.serviceId,
          );
          if (reauthenticated) {
            logger.info(
              'Successfully re-authenticated for ${serviceConfig.serviceId}',
            );
            return true;
          }
          break;

        case AuthType.custom:
          // Custom auth handling
          final refreshed = await authProvider.refreshCustomAuth(
            serviceConfig.serviceId,
          );
          if (refreshed) {
            logger.info(
              'Successfully refreshed custom auth for ${serviceConfig.serviceId}',
            );
            return true;
          }
          break;

        case AuthType.none:
          // No authentication to refresh
          break;
      }
    } catch (error, stackTrace) {
      logger.error(
        'Failed to refresh authentication for ${serviceConfig.serviceId}: $error',
        stackTrace: stackTrace,
      );
    }

    logger.warning(
      'Could not refresh authentication for ${serviceConfig.serviceId}',
    );
    return false;
  }

  /// Retry the original request with refreshed authentication
  Future<Response> _retryRequest(RequestOptions options) async {
    // Create a new Dio instance to avoid infinite recursion
    final dio = Dio(
      BaseOptions(
        baseUrl: options.baseUrl,
        connectTimeout: options.connectTimeout,
        receiveTimeout: options.receiveTimeout,
        sendTimeout: options.sendTimeout,
        headers: Map<String, String>.from(options.headers),
        validateStatus: options.validateStatus,
        followRedirects: options.followRedirects,
        maxRedirects: options.maxRedirects,
      ),
    );

    // Re-add authentication for the retry
    await _addAuthenticationToOptions(options);

    // Execute the retry
    return await dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(
        method: options.method,
        headers: options.headers,
        contentType: options.contentType,
        responseType: options.responseType,
        extra: options.extra,
      ),
    );
  }

  /// Add authentication to request options based on service config
  Future<void> _addAuthenticationToOptions(RequestOptions options) async {
    switch (serviceConfig.authType) {
      case AuthType.token:
        await _addTokenAuth(options);
        break;
      case AuthType.oauth2:
        await _addOAuth2Auth(options);
        break;
      case AuthType.cookie:
        await _addCookieAuth(options);
        break;
      case AuthType.custom:
        await _addCustomAuth(options);
        break;
      case AuthType.form:
      case AuthType.none:
        // No additional auth needed
        break;
    }
  }
}

/// Abstract auth provider interface
///
/// This will be replaced by the actual Auth Core implementation
/// when it becomes available
abstract class AuthProvider {
  /// Get access token for the given service
  Future<String?> getAccessToken(String serviceId);

  /// Get OAuth2 token for the given service
  Future<String?> getOAuth2Token(String serviceId);

  /// Get session cookies for the given service
  Future<Map<String, String>> getSessionCookies(String serviceId);

  /// Get custom authentication headers for the given service
  Future<Map<String, String>> getCustomAuth(String serviceId);

  /// Refresh token for the given service
  Future<bool> refreshToken(String serviceId);

  /// Re-authenticate for cookie/form-based services
  Future<bool> reauthenticate(String serviceId);

  /// Refresh custom authentication for the given service
  Future<bool> refreshCustomAuth(String serviceId);

  /// Check if authentication is available for the given service
  Future<bool> isAuthenticated(String serviceId);

  /// Clear authentication data for the given service
  Future<void> clearAuthentication(String serviceId);
}

/// Mock auth provider for testing and development
///
/// This provides stub implementations until Auth Core is ready
class MockAuthProvider implements AuthProvider {
  MockAuthProvider({required this.logger});

  final AppLogger logger;

  // Mock storage for testing
  final Map<String, String> _tokens = {};
  final Map<String, Map<String, String>> _cookies = {};
  final Map<String, Map<String, String>> _customAuth = {};

  @override
  Future<String?> getAccessToken(String serviceId) async {
    logger.debug('MockAuthProvider: Getting access token for $serviceId');

    // Simulate token retrieval
    await Future.delayed(const Duration(milliseconds: 10));

    final token = _tokens[serviceId];
    if (token == null) {
      logger.warning('MockAuthProvider: No token found for $serviceId');
    }
    return token;
  }

  @override
  Future<String?> getOAuth2Token(String serviceId) async {
    logger.debug('MockAuthProvider: Getting OAuth2 token for $serviceId');
    return getAccessToken(serviceId); // Same implementation for mock
  }

  @override
  Future<Map<String, String>> getSessionCookies(String serviceId) async {
    logger.debug('MockAuthProvider: Getting session cookies for $serviceId');

    // Simulate cookie retrieval
    await Future.delayed(const Duration(milliseconds: 10));

    return _cookies[serviceId] ?? {};
  }

  @override
  Future<Map<String, String>> getCustomAuth(String serviceId) async {
    logger.debug('MockAuthProvider: Getting custom auth for $serviceId');

    await Future.delayed(const Duration(milliseconds: 10));

    return _customAuth[serviceId] ?? {};
  }

  @override
  Future<bool> refreshToken(String serviceId) async {
    logger.debug('MockAuthProvider: Refreshing token for $serviceId');

    // Simulate token refresh
    await Future.delayed(const Duration(milliseconds: 100));

    // Mock successful refresh for palapi
    if (serviceId == 'palapi') {
      _tokens[serviceId] =
          'mock_refreshed_token_${DateTime.now().millisecondsSinceEpoch}';
      return true;
    }

    return false;
  }

  @override
  Future<bool> reauthenticate(String serviceId) async {
    logger.debug('MockAuthProvider: Re-authenticating for $serviceId');

    // Simulate re-authentication
    await Future.delayed(const Duration(milliseconds: 200));

    // Mock successful re-auth for portal services
    if (serviceId == 'manabo' || serviceId == 'albo' || serviceId == 'cubics') {
      _cookies[serviceId] = {
        'JSESSIONID': 'mock_session_${DateTime.now().millisecondsSinceEpoch}',
        'SHIBSESSION':
            'mock_shib_session_${DateTime.now().millisecondsSinceEpoch}',
      };
      return true;
    }

    return false;
  }

  @override
  Future<bool> refreshCustomAuth(String serviceId) async {
    logger.debug('MockAuthProvider: Refreshing custom auth for $serviceId');

    await Future.delayed(const Duration(milliseconds: 50));

    return false; // No custom auth in mock
  }

  @override
  Future<bool> isAuthenticated(String serviceId) async {
    logger.debug(
      'MockAuthProvider: Checking authentication status for $serviceId',
    );

    await Future.delayed(const Duration(milliseconds: 5));

    switch (serviceId) {
      case 'palapi':
        return _tokens.containsKey(serviceId);
      case 'manabo':
      case 'albo':
      case 'cubics':
        return _cookies.containsKey(serviceId) &&
            _cookies[serviceId]!.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  Future<void> clearAuthentication(String serviceId) async {
    logger.debug('MockAuthProvider: Clearing authentication for $serviceId');

    _tokens.remove(serviceId);
    _cookies.remove(serviceId);
    _customAuth.remove(serviceId);
  }

  // Mock helper methods for testing
  void setMockToken(String serviceId, String token) {
    _tokens[serviceId] = token;
  }

  void setMockCookies(String serviceId, Map<String, String> cookies) {
    _cookies[serviceId] = cookies;
  }

  void setMockCustomAuth(String serviceId, Map<String, String> auth) {
    _customAuth[serviceId] = auth;
  }
}

/// Provider for mock auth provider (temporary until Auth Core is ready)
@riverpod
AuthProvider mockAuthProvider(Ref ref) {
  final logger = ref.watch(scopedLoggerProvider('MockAuthProvider'));
  return MockAuthProvider(logger: logger);
}

/// Provider for auth interceptor
@riverpod
AuthInterceptor authInterceptor(Ref ref, ServiceConfig serviceConfig) {
  final authProvider = ref.watch(mockAuthProviderProvider);
  final logger = ref.watch(scopedLoggerProvider('AuthInterceptor'));

  return AuthInterceptor(
    serviceConfig: serviceConfig,
    authProvider: authProvider,
    logger: logger,
  );
}
