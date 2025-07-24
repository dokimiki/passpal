import 'package:freezed_annotation/freezed_annotation.dart';
import 'cache_strategy.dart';

part 'network_request.freezed.dart';
part 'network_request.g.dart';

/// HTTP method enumeration
enum HttpMethod { get, post, put, patch, delete, head, options }

/// Network request model containing all necessary information for HTTP operations
@freezed
abstract class NetworkRequest with _$NetworkRequest {
  const factory NetworkRequest({
    /// HTTP method
    required HttpMethod method,

    /// Request URL
    required String url,

    /// Request headers
    @Default({}) Map<String, String> headers,

    /// Query parameters
    @Default({}) Map<String, dynamic> queryParameters,

    /// Request body (JSON serializable)
    Object? data,

    /// Caching strategy for this request
    @Default(CacheStrategy.networkFirst) CacheStrategy cacheStrategy,

    /// Request timeout in milliseconds
    int? timeoutMs,

    /// Whether to follow redirects
    @Default(true) bool followRedirects,

    /// Maximum number of redirects to follow
    @Default(5) int maxRedirects,

    /// Content type for request body
    String? contentType,

    /// Whether to validate SSL certificates
    @Default(true) bool validateStatus,

    /// Custom tag for request identification/debugging
    String? tag,

    /// Additional metadata for the request
    @Default({}) Map<String, dynamic> metadata,
  }) = _NetworkRequest;

  factory NetworkRequest.fromJson(Map<String, dynamic> json) =>
      _$NetworkRequestFromJson(json);
}

/// Extension methods for NetworkRequest
extension NetworkRequestExtension on NetworkRequest {
  /// Whether this request has a body
  bool get hasBody => data != null;

  /// Whether this request supports caching
  bool get supportsCaching => method == HttpMethod.get;

  /// Effective cache strategy considering request characteristics
  CacheStrategy get effectiveCacheStrategy {
    if (!supportsCaching) {
      return CacheStrategy.noCache;
    }
    return cacheStrategy;
  }

  /// Create a copy with updated headers
  NetworkRequest withHeaders(Map<String, String> additionalHeaders) {
    return copyWith(headers: {...headers, ...additionalHeaders});
  }

  /// Create a copy with updated query parameters
  NetworkRequest withQueryParameters(Map<String, dynamic> additionalParams) {
    return copyWith(queryParameters: {...queryParameters, ...additionalParams});
  }

  /// Create a copy with authentication header
  NetworkRequest withAuth(String token, {String scheme = 'Bearer'}) {
    return withHeaders({'Authorization': '$scheme $token'});
  }

  /// Create a copy with content type
  NetworkRequest withContentType(String type) {
    return withHeaders({'Content-Type': type});
  }
}
