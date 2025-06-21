import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:path_provider/path_provider.dart';

/// A wrapper around Dio that provides configured HTTP client with:
/// - Cookie management with persistent storage
/// - Retry mechanism with exponential backoff for 503 and network errors
/// - TLS certificate pinning
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

  /// Whether to enable certificate pinning
  final bool enablePinning;

  /// Creates a new BaseDioWrapper with the specified configuration
  BaseDioWrapper({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 20),
    this.maxRetry = 3,
    this.enablePinning = true,
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
    _setupCookieManager();

    // Retry interceptor
    dio.interceptors.add(_RetryInterceptor(maxRetry: maxRetry, dio: dio));

    // Certificate pinning (if enabled)
    if (enablePinning) {
      dio.interceptors.add(_CertificatePinningInterceptor());
    }

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

/// Interceptor that handles TLS certificate pinning
class _CertificatePinningInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Get certificate pins from RemoteConfig (fallback to hardcoded values)
      final pins = await _getCertificatePins(
        options.uri.host,
      ); // Perform certificate pinning check
      try {
        await HttpCertificatePinning.check(
          serverURL: options.uri.toString(),
          headerHttp: options.headers.cast<String, String>(),
          sha: SHA.SHA256,
          allowedSHAFingerprints: pins,
          timeout: 30,
        );
      } catch (pinningError) {
        throw Exception('Certificate pinning validation failed: $pinningError');
      }

      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Certificate pinning validation failed: $e',
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  /// Gets certificate pins for the given host
  /// Fetches certificate pins from Firebase Remote Config with local fallback
  Future<List<String>> _getCertificatePins(String host) async {
    try {
      // Try to get pins from Firebase Remote Config
      final pins = await _getRemoteConfigPins(host);
      if (pins.isNotEmpty) {
        return pins;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch remote config pins: $e');
      }
    }

    // Fallback to local configuration
    return _getLocalPins(host);
  }

  /// Gets certificate pins from Firebase Remote Config
  Future<List<String>> _getRemoteConfigPins(String host) async {
    try {
      // Import firebase_remote_config dynamically to avoid issues if not initialized
      final remoteConfig = await _getRemoteConfig();
      if (remoteConfig == null) return [];

      final configKey = '${host.replaceAll('.', '_')}_cert_pins';
      final pinsJson = remoteConfig.getString(configKey);

      if (pinsJson.isEmpty) return [];

      // Parse JSON array of certificate pins
      final dynamic decoded = json.decode(pinsJson);
      if (decoded is List) {
        return decoded.cast<String>().where((pin) => pin.isNotEmpty).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing remote config pins: $e');
      }
    }

    return [];
  }

  /// Gets local fallback certificate pins
  List<String> _getLocalPins(String host) {
    // Use environment configuration as fallback
    final pins = <String>[];

    // Add hardcoded pins for known university domains
    if (host.contains('tokai-u.jp') || host.contains('tokai.ac.jp')) {
      // These would be the actual certificate pins for Tokai University
      // For development, return empty list to disable pinning
      if (kDebugMode) {
        return []; // Disable pinning in debug mode
      }

      // In production, these should be the actual pins from env config
      const String mainPin = String.fromEnvironment(
        'CERT_PIN_MAIN',
        defaultValue: '',
      );
      const String backupPin = String.fromEnvironment(
        'CERT_PIN_BACKUP',
        defaultValue: '',
      );

      if (mainPin.isNotEmpty) pins.add(mainPin);
      if (backupPin.isNotEmpty) pins.add(backupPin);
    }

    return pins;
  }

  /// Gets Firebase Remote Config instance if available
  Future<FirebaseRemoteConfig?> _getRemoteConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(minutes: 5),
        ),
      );
      await remoteConfig.fetchAndActivate();
      return remoteConfig;
    } catch (e) {
      if (kDebugMode) {
        print('Firebase Remote Config not available: $e');
      }
      return null;
    }
  }
}
