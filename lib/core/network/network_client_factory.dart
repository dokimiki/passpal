import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/config/models/api_config.dart';

import 'auth_interceptor.dart';
import 'connectivity_interceptor.dart';
import 'logging_interceptor.dart';
import 'maintenance_interceptor.dart';
import 'network_target.dart';
import 'retry_interceptor.dart';

/// Factory for creating configured Dio instances for different network targets
class NetworkClientFactory {
  NetworkClientFactory({
    required this.apiConfig,
    Connectivity? connectivity,
    CookieJar? cookieJar,
    this.ref,
  }) : _connectivity = connectivity ?? Connectivity(),
       _cookieJar = cookieJar ?? CookieJar();

  final ApiConfig apiConfig;
  final Connectivity _connectivity;
  final CookieJar _cookieJar;
  final Ref? ref;

  /// Create a configured Dio instance for the specified target
  Dio create(NetworkTarget target) {
    final dio = Dio();

    // Base configuration
    dio.options = BaseOptions(
      baseUrl: target.getBaseUrl(apiConfig),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: _getDefaultHeaders(target),
      followRedirects: true,
      maxRedirects: 3,
    );

    // SSOの場合、特定の設定が必要
    if (target == NetworkTarget.sso) {
      dio.options.followRedirects = false;
      dio.options.validateStatus = (status) {
        if (status == null) return false;
        if (status == 503) return true; // 503: サービス利用不可は特例として成功とみなす
        if (status >= 100 && status <= 199) return true; // 1xx: 情報応答
        if (status >= 200 && status <= 299) return true; // 2xx: 成功応答
        if (status >= 300 && status <= 399) return true; // 3xx: リダイレクト
        if (status >= 400 && status <= 499) return false; // 4xx: クライアントエラー
        if (status >= 500 && status <= 599) return false; // 5xx: サーバーエラー
        return false; // その他のステータスコードは失敗とみなす
      };
    }

    // Add interceptors in the correct order
    // Order: Connectivity → Auth → Retry → Maintenance → Logging
    _addConnectivityInterceptor(dio);
    if (target.requiresAuth && ref != null) {
      dio.interceptors.add(AuthInterceptor(ref: ref!, target: target));
    }
    _addRetryInterceptor(dio);
    _addMaintenanceInterceptor(dio);
    _addLoggingInterceptor(dio);

    // Add cookie manager for SSO targets
    if (target.usesSsoCookies) {
      dio.interceptors.add(CookieManager(_cookieJar));
    }

    return dio;
  }

  Map<String, String> _getDefaultHeaders(NetworkTarget target) {
    final headers = <String, String>{
      'User-Agent': 'PassPal/1.0.0 (Mobile App)',
      'Accept': 'application/json, text/html, */*',
      'Accept-Language': 'ja-JP,ja;q=0.9,en;q=0.8',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
    };

    // Target-specific headers
    switch (target) {
      case NetworkTarget.albo:
      case NetworkTarget.manabo:
      case NetworkTarget.cubics:
        headers['Referer'] = target.getBaseUrl(apiConfig);
        break;
      case NetworkTarget.palapi:
        headers['Content-Type'] = 'application/json';
        break;
      case NetworkTarget.sso:
        // SSO might have specific requirements
        break;
      case NetworkTarget.chukyolink:
        break;
    }

    return headers;
  }

  void _addConnectivityInterceptor(Dio dio) {
    dio.interceptors.add(ConnectivityInterceptor(_connectivity));
  }

  void _addRetryInterceptor(Dio dio) {
    dio.interceptors.add(RetryInterceptor());
  }

  void _addMaintenanceInterceptor(Dio dio) {
    dio.interceptors.add(MaintenanceInterceptor());
  }

  void _addLoggingInterceptor(Dio dio) {
    dio.interceptors.add(LoggingInterceptor());
  }
}
