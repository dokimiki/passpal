import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';

import 'package:path_provider/path_provider.dart';

/// A wrapper around Dio that provides configured HTTP client with:
/// - Cookie management with persistent storage
/// - Retry mechanism with exponential backoff for 503 and network errors
/// - Request/response logging in debug mode
class BaseDioWrapper {
  /// The configured Dio instance
  late final Dio dio;

  /// Base URL for all requests
  final String baseUrl;

  /// Request timeout duration
  final Duration timeout;

  /// Maximum number of retry attempts
  final int maxRetry;

  /// Creates a new BaseDioWrapper with the specified configuration
  BaseDioWrapper({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 20),
    this.maxRetry = 3,
  }) {
    _initializeDio();
  }

  /// Initializes the Dio instance with all required interceptors
  void _initializeDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        headers: {'User-Agent': 'Passpal/1.0', 'Accept-Language': 'ja'},
      ),
    );

    _setupInterceptors();
  }

  /// Sets up all required interceptors
  void _setupInterceptors() {
    // Setup cookie management asynchronously
    _setupCookieManager(); // Retry interceptor
    dio.interceptors.add(_RetryInterceptor(maxRetry: maxRetry, dio: dio));

    // Logging (debug mode only)
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
          error: true,
        ),
      );
    }
  }

  /// Sets up cookie management asynchronously
  void _setupCookieManager() {
    _createCookieJar()
        .then((cookieJar) {
          dio.interceptors.insert(0, CookieManager(cookieJar));
        })
        .catchError((error) {
          if (kDebugMode) {
            print('Failed to setup cookie manager: $error');
          }
        });
  }

  /// Creates a persistent cookie jar for session management
  Future<PersistCookieJar> _createCookieJar() async {
    final appDir = await getApplicationDocumentsDirectory();
    final cookieDir = Directory('${appDir.path}/cookies');
    if (!cookieDir.existsSync()) {
      cookieDir.createSync(recursive: true);
    }
    return PersistCookieJar(storage: FileStorage(cookieDir.path));
  }
}

/// Interceptor that handles retry logic with exponential backoff
class _RetryInterceptor extends Interceptor {
  final int maxRetry;
  final Dio dio;

  const _RetryInterceptor({required this.maxRetry, required this.dio});
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final shouldRetry = _shouldRetry(err);
    final retryCount = err.requestOptions.extra['retry_count'] as int? ?? 0;

    if (shouldRetry && retryCount < maxRetry) {
      try {
        final backoffDuration = _calculateBackoff(retryCount);
        await Future.delayed(backoffDuration);

        // Increment retry count
        err.requestOptions.extra['retry_count'] = retryCount + 1;

        // Retry the request
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        // If retry fails, pass the original error
        handler.next(err);
      }
    } else {
      // Max retries exceeded or shouldn't retry
      handler.next(err);
    }
  }

  /// Determines if the error should trigger a retry
  bool _shouldRetry(DioException err) {
    // Retry on 503 Service Unavailable
    if (err.response?.statusCode == 503) {
      return true;
    }

    // Retry on network errors (SocketException)
    if (err.error is SocketException) {
      return true;
    }

    // Retry on connection timeout
    if (err.type == DioExceptionType.connectionTimeout) {
      return true;
    }

    return false;
  }

  /// Calculates exponential backoff duration: 1s, 2s, 4s, 8s, etc.
  Duration _calculateBackoff(int retryCount) {
    final baseDelay = Duration(milliseconds: 1000);
    final exponentialDelay = baseDelay * (1 << retryCount); // 2^retryCount
    return exponentialDelay;
  }
}
