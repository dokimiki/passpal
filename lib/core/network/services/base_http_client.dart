import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error/providers.dart';
import '../interfaces/network_client_interface.dart';
import '../models/connectivity_status.dart';
import '../models/network_request.dart';
import '../models/network_response.dart';
import 'dio_factory.dart';

part 'base_http_client.g.dart';

/// Base HTTP client implementation using Dio
///
/// This class provides a concrete implementation of NetworkClientInterface
/// with:
/// - Dio integration for HTTP operations
/// - Request/response mapping between domain models and Dio types
/// - Error handling and logging
/// - Support for all HTTP methods
class BaseHttpClient implements NetworkClientInterface {
  BaseHttpClient({required this.dio, required this.logger});

  final Dio dio;
  final AppLogger logger;

  @override
  Future<NetworkResponse<T>> execute<T>(
    NetworkRequest request, {
    T Function(dynamic data)? fromJson,
  }) async {
    logger.debug(
      '${request.method.name.toUpperCase()} request to: ${request.url}',
    );

    try {
      final Response<dynamic> response;
      final options = _buildRequestOptions(request);

      switch (request.method) {
        case HttpMethod.get:
          response = await dio.get<dynamic>(
            request.url,
            queryParameters: request.queryParameters,
            options: options,
          );
          break;
        case HttpMethod.post:
          response = await dio.post<dynamic>(
            request.url,
            data: request.data,
            queryParameters: request.queryParameters,
            options: options,
          );
          break;
        case HttpMethod.put:
          response = await dio.put<dynamic>(
            request.url,
            data: request.data,
            queryParameters: request.queryParameters,
            options: options,
          );
          break;
        case HttpMethod.patch:
          response = await dio.patch<dynamic>(
            request.url,
            data: request.data,
            queryParameters: request.queryParameters,
            options: options,
          );
          break;
        case HttpMethod.delete:
          response = await dio.delete<dynamic>(
            request.url,
            data: request.data,
            queryParameters: request.queryParameters,
            options: options,
          );
          break;
        case HttpMethod.head:
          response = await dio.head<dynamic>(
            request.url,
            queryParameters: request.queryParameters,
            options: options,
          );
          break;
        case HttpMethod.options:
          response = await dio.request<dynamic>(
            request.url,
            options: options.copyWith(method: 'OPTIONS'),
            queryParameters: request.queryParameters,
          );
          break;
      }

      return _mapResponse<T>(response, fromJson, request.url);
    } on DioException catch (e) {
      logger.error(
        '${request.method.name.toUpperCase()} request failed: ${e.message}',
      );
      return _mapError<T>(e, request.url);
    } catch (e, stackTrace) {
      logger.error(
        'Unexpected error in ${request.method.name.toUpperCase()} request: $e',
        stackTrace: stackTrace,
      );
      return NetworkResponse(
        statusCode: 0,
        data: null,
        timestamp: DateTime.now(),
        requestUrl: request.url,
      );
    }
  }

  // Stub implementations for NetworkClientInterface methods
  @override
  Future<List<NetworkResponse<dynamic>>> executeBatch(
    List<NetworkRequest> requests,
  ) async {
    return Future.wait(requests.map((request) => execute(request)));
  }

  @override
  Future<bool> isReachable(String url) async {
    try {
      final response = await dio.head(url);
      return response.statusCode != null && response.statusCode! < 400;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<ConnectivityStatus> getConnectivityStatus() async {
    // This should be injected from connectivity monitor
    throw UnimplementedError('Use connectivity monitor provider instead');
  }

  @override
  Stream<ConnectivityStatus> get connectivityStream =>
      throw UnimplementedError('Use connectivity monitor provider instead');

  @override
  Future<void> cancelAll() async {
    dio.close(force: true);
  }

  @override
  Future<bool> cancelRequest(String tag) async {
    // Dio doesn't support cancelling by tag, would need custom implementation
    return false;
  }

  @override
  Future<void> clearCache() async {
    // Cache clearing would be handled by cache interceptor
  }

  @override
  Future<void> clearCacheForPattern(String pattern) async {
    // Cache clearing would be handled by cache interceptor
  }

  @override
  Future<int> getCacheSize() async {
    // Cache size would be handled by cache interceptor
    return 0;
  }

  @override
  void setGlobalHeaders(Map<String, String> headers) {
    dio.options.headers.addAll(headers);
  }

  @override
  void removeGlobalHeaders(List<String> headerNames) {
    for (final name in headerNames) {
      dio.options.headers.remove(name);
    }
  }

  @override
  Map<String, String> getGlobalHeaders() {
    return Map<String, String>.from(dio.options.headers);
  }

  /// Build Dio request options from NetworkRequest
  Options _buildRequestOptions(NetworkRequest request) {
    return Options(
      headers: request.headers,
      sendTimeout: request.timeoutMs != null
          ? Duration(milliseconds: request.timeoutMs!)
          : null,
      receiveTimeout: request.timeoutMs != null
          ? Duration(milliseconds: request.timeoutMs!)
          : null,
      extra: request.metadata,
      followRedirects: request.followRedirects,
      maxRedirects: request.maxRedirects,
      contentType: request.contentType,
    );
  }

  /// Map Dio response to NetworkResponse
  NetworkResponse<T> _mapResponse<T>(
    Response<dynamic> response,
    T Function(dynamic data)? fromJson,
    String requestUrl,
  ) {
    final statusCode = response.statusCode ?? 0;
    T? data;

    if (fromJson != null && response.data != null) {
      try {
        data = fromJson(response.data);
      } catch (e) {
        logger.error('Failed to parse response data: $e');
      }
    } else if (T == String) {
      data = response.data?.toString() as T?;
    } else if (response.data is T) {
      data = response.data as T?;
    }

    return NetworkResponse<T>(
      statusCode: statusCode,
      data: data,
      headers: response.headers.map,
      contentType: response.headers.value('content-type'),
      timestamp: DateTime.now(),
      requestUrl: requestUrl,
      responseTimeMs: response.extra['dio.response_time']?.inMilliseconds,
    );
  }

  /// Map DioException to NetworkResponse error
  NetworkResponse<T> _mapError<T>(DioException error, String requestUrl) {
    final statusCode = error.response?.statusCode ?? 0;
    String? message = error.message;

    // Extract more specific error messages
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection error';
        break;
      case DioExceptionType.unknown:
        message = 'Unknown network error';
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.badResponse:
        // Keep the existing message from DioException
        break;
    }

    return NetworkResponse<T>(
      statusCode: statusCode,
      data: null,
      headers: error.response?.headers.map ?? {},
      contentType: error.response?.headers.value('content-type'),
      timestamp: DateTime.now(),
      requestUrl: requestUrl,
      metadata: {'error': message ?? 'Network error'},
    );
  }
}

/// Provider for PalAPI HTTP client
@riverpod
BaseHttpClient palApiClient(Ref ref) {
  final dio = ref.watch(palApiDioProvider);
  final logger = ref.watch(scopedLoggerProvider('PalApiClient'));

  return BaseHttpClient(dio: dio, logger: logger);
}

/// Provider for MaNaBo HTTP client
@riverpod
BaseHttpClient manaboClient(Ref ref) {
  final dio = ref.watch(manaboDioProvider);
  final logger = ref.watch(scopedLoggerProvider('ManaboClient'));

  return BaseHttpClient(dio: dio, logger: logger);
}

/// Provider for ALBO HTTP client
@riverpod
BaseHttpClient alboClient(Ref ref) {
  final dio = ref.watch(alboDioProvider);
  final logger = ref.watch(scopedLoggerProvider('AlboClient'));

  return BaseHttpClient(dio: dio, logger: logger);
}

/// Provider for Cubics HTTP client
@riverpod
BaseHttpClient cubicsClient(Ref ref) {
  final dio = ref.watch(cubicsDioProvider);
  final logger = ref.watch(scopedLoggerProvider('CubicsClient'));

  return BaseHttpClient(dio: dio, logger: logger);
}

/// Provider for SSO HTTP client
@riverpod
BaseHttpClient ssoClient(Ref ref) {
  final dio = ref.watch(ssoDioProvider);
  final logger = ref.watch(scopedLoggerProvider('SsoClient'));

  return BaseHttpClient(dio: dio, logger: logger);
}
