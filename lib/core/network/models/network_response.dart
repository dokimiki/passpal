import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_response.freezed.dart';
part 'network_response.g.dart';

/// Network response model containing HTTP response data and metadata
@Freezed(genericArgumentFactories: true)
abstract class NetworkResponse<T> with _$NetworkResponse<T> {
  const factory NetworkResponse({
    /// HTTP status code
    required int statusCode,

    /// Response body data
    T? data,

    /// Response headers
    @Default({}) Map<String, List<String>> headers,

    /// Content type from response headers
    String? contentType,

    /// Response timestamp
    required DateTime timestamp,

    /// Whether the response came from cache
    @Default(false) bool fromCache,

    /// Cache age in milliseconds (if from cache)
    int? cacheAge,

    /// Original request URL
    String? requestUrl,

    /// Response time in milliseconds
    int? responseTimeMs,

    /// Additional metadata
    @Default({}) Map<String, dynamic> metadata,
  }) = _NetworkResponse<T>;

  factory NetworkResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$NetworkResponseFromJson(json, fromJsonT);
}

/// Extension methods for NetworkResponse
extension NetworkResponseExtension<T> on NetworkResponse<T> {
  /// Whether the response indicates success (2xx status codes)
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Whether the response indicates client error (4xx status codes)
  bool get isClientError => statusCode >= 400 && statusCode < 500;

  /// Whether the response indicates server error (5xx status codes)
  bool get isServerError => statusCode >= 500;

  /// Whether the response indicates redirect (3xx status codes)
  bool get isRedirect => statusCode >= 300 && statusCode < 400;

  /// Whether the response indicates an error (4xx or 5xx)
  bool get isError => isClientError || isServerError;

  /// Get header value by name (case-insensitive)
  String? getHeader(String name) {
    final key = headers.keys.firstWhere(
      (k) => k.toLowerCase() == name.toLowerCase(),
      orElse: () => '',
    );
    return key.isEmpty ? null : headers[key]?.first;
  }

  /// Get all header values by name (case-insensitive)
  List<String>? getHeaders(String name) {
    final key = headers.keys.firstWhere(
      (k) => k.toLowerCase() == name.toLowerCase(),
      orElse: () => '',
    );
    return key.isEmpty ? null : headers[key];
  }

  /// Whether the response is stale (from cache and older than threshold)
  bool isStale(Duration threshold) {
    if (!fromCache || cacheAge == null) return false;
    return Duration(milliseconds: cacheAge!) > threshold;
  }

  /// Create a copy with updated metadata
  NetworkResponse<T> withMetadata(Map<String, dynamic> additionalMetadata) {
    return copyWith(metadata: {...metadata, ...additionalMetadata});
  }
}

/// Factory methods for common response scenarios
extension NetworkResponseFactory on NetworkResponse {
  /// Create a success response
  static NetworkResponse<T> success<T>(
    T data, {
    int statusCode = 200,
    Map<String, List<String>> headers = const {},
    String? requestUrl,
    int? responseTimeMs,
  }) {
    return NetworkResponse<T>(
      statusCode: statusCode,
      data: data,
      headers: headers,
      timestamp: DateTime.now(),
      requestUrl: requestUrl,
      responseTimeMs: responseTimeMs,
    );
  }

  /// Create a cached response
  static NetworkResponse<T> cached<T>(
    T data, {
    int statusCode = 200,
    Map<String, List<String>> headers = const {},
    required int cacheAge,
    String? requestUrl,
  }) {
    return NetworkResponse<T>(
      statusCode: statusCode,
      data: data,
      headers: headers,
      timestamp: DateTime.now(),
      fromCache: true,
      cacheAge: cacheAge,
      requestUrl: requestUrl,
    );
  }

  /// Create an error response
  static NetworkResponse<T> error<T>(
    int statusCode, {
    T? data,
    Map<String, List<String>> headers = const {},
    String? requestUrl,
    int? responseTimeMs,
  }) {
    return NetworkResponse<T>(
      statusCode: statusCode,
      data: data,
      headers: headers,
      timestamp: DateTime.now(),
      requestUrl: requestUrl,
      responseTimeMs: responseTimeMs,
    );
  }
}
