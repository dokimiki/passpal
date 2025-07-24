import 'package:freezed_annotation/freezed_annotation.dart';
import 'cache_strategy.dart';

part 'service_config.freezed.dart';
part 'service_config.g.dart';

/// Authentication type for services
enum AuthType {
  /// No authentication required
  none,

  /// Token-based authentication (Bearer, API Key)
  token,

  /// Cookie-based authentication (session cookies)
  cookie,

  /// Form-based authentication (username/password)
  form,

  /// OAuth 2.0 authentication
  oauth2,

  /// Custom authentication mechanism
  custom,
}

/// Service configuration model for network clients
@freezed
abstract class ServiceConfig with _$ServiceConfig {
  const factory ServiceConfig({
    /// Service identifier
    required String serviceId,

    /// Display name for the service
    required String displayName,

    /// Base URL for the service
    required String baseUrl,

    /// Authentication type
    @Default(AuthType.none) AuthType authType,

    /// Default timeout in milliseconds
    @Default(30000) int timeoutMs,

    /// Connection timeout in milliseconds
    @Default(10000) int connectTimeoutMs,

    /// Read timeout in milliseconds
    @Default(30000) int readTimeoutMs,

    /// Write timeout in milliseconds
    @Default(30000) int writeTimeoutMs,

    /// Maximum number of redirects to follow
    @Default(5) int maxRedirects,

    /// Whether to follow redirects
    @Default(true) bool followRedirects,

    /// Default cache strategy for this service
    @Default(CacheStrategy.networkFirst) CacheStrategy defaultCacheStrategy,

    /// Cache TTL in milliseconds
    @Default(300000) int cacheTtlMs, // 5 minutes default
    /// Maximum cache size for this service in bytes
    @Default(10485760) int maxCacheSize, // 10MB default
    /// Default headers for all requests to this service
    @Default({}) Map<String, String> defaultHeaders,

    /// Base path to append to baseUrl for all requests
    String? basePath,

    /// API version (for versioned APIs)
    String? apiVersion,

    /// Rate limit configuration
    RateLimitConfig? rateLimit,

    /// Retry configuration
    RetryConfig? retryConfig,

    /// Whether to validate SSL certificates
    @Default(true) bool validateSsl,

    /// Whether to persist cookies
    @Default(true) bool persistCookies,

    /// Whether this service supports background operations
    @Default(true) bool supportsBackground,

    /// Whether requests to this service are critical
    @Default(false) bool isCritical,

    /// Custom configuration for the service
    @Default({}) Map<String, dynamic> customConfig,

    /// Additional metadata
    @Default({}) Map<String, dynamic> metadata,
  }) = _ServiceConfig;

  factory ServiceConfig.fromJson(Map<String, dynamic> json) =>
      _$ServiceConfigFromJson(json);
}

/// Rate limiting configuration
@freezed
abstract class RateLimitConfig with _$RateLimitConfig {
  const factory RateLimitConfig({
    /// Maximum requests per window
    required int maxRequests,

    /// Time window in milliseconds
    required int windowMs,

    /// Whether to queue requests when rate limited
    @Default(true) bool queueRequests,

    /// Maximum queue size
    @Default(100) int maxQueueSize,

    /// Delay between retries when rate limited in milliseconds
    @Default(1000) int retryDelayMs,
  }) = _RateLimitConfig;

  factory RateLimitConfig.fromJson(Map<String, dynamic> json) =>
      _$RateLimitConfigFromJson(json);
}

/// Retry configuration
@freezed
abstract class RetryConfig with _$RetryConfig {
  const factory RetryConfig({
    /// Maximum number of retries
    @Default(3) int maxRetries,

    /// Base delay between retries in milliseconds
    @Default(1000) int baseDelayMs,

    /// Maximum delay between retries in milliseconds
    @Default(30000) int maxDelayMs,

    /// Exponential backoff multiplier
    @Default(2.0) double backoffMultiplier,

    /// Whether to add jitter to retry delays
    @Default(true) bool enableJitter,

    /// HTTP status codes that should trigger retries
    @Default([408, 429, 500, 502, 503, 504]) List<int> retryableStatusCodes,

    /// Whether to retry on network errors
    @Default(true) bool retryOnNetworkError,

    /// Whether to retry on timeout
    @Default(true) bool retryOnTimeout,
  }) = _RetryConfig;

  factory RetryConfig.fromJson(Map<String, dynamic> json) =>
      _$RetryConfigFromJson(json);
}

/// Extension methods for ServiceConfig
extension ServiceConfigExtension on ServiceConfig {
  /// Get full URL by combining baseUrl and basePath
  String get fullBaseUrl {
    if (basePath == null) return baseUrl;
    final cleanBaseUrl = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final cleanBasePath = basePath!.startsWith('/')
        ? basePath!.substring(1)
        : basePath!;
    return '$cleanBaseUrl/$cleanBasePath';
  }

  /// Whether this service requires authentication
  bool get requiresAuth => authType != AuthType.none;

  /// Whether this service uses token-based authentication
  bool get usesTokenAuth =>
      authType == AuthType.token || authType == AuthType.oauth2;

  /// Whether this service uses cookie-based authentication
  bool get usesCookieAuth =>
      authType == AuthType.cookie || authType == AuthType.form;

  /// Whether this service supports caching
  bool get supportsCaching => defaultCacheStrategy != CacheStrategy.noCache;

  /// Whether this service has rate limiting
  bool get hasRateLimit => rateLimit != null;

  /// Whether this service has retry configuration
  bool get hasRetryConfig => retryConfig != null;

  /// Get effective timeout considering all timeout types
  int get effectiveTimeout => [
    timeoutMs,
    connectTimeoutMs,
    readTimeoutMs,
    writeTimeoutMs,
  ].reduce((a, b) => a > b ? a : b);

  /// Create a copy with updated headers
  ServiceConfig withHeaders(Map<String, String> additionalHeaders) {
    return copyWith(defaultHeaders: {...defaultHeaders, ...additionalHeaders});
  }

  /// Create a copy with updated cache strategy
  ServiceConfig withCacheStrategy(CacheStrategy strategy) {
    return copyWith(defaultCacheStrategy: strategy);
  }

  /// Create a copy with updated timeout
  ServiceConfig withTimeout(int timeoutMs) {
    return copyWith(timeoutMs: timeoutMs);
  }
}

/// Predefined service configurations
class ServiceConfigs {
  /// Configuration for Palapi (internal API)
  static const ServiceConfig palapi = ServiceConfig(
    serviceId: 'palapi',
    displayName: 'PassPal API',
    baseUrl: 'https://api.passpal.app',
    authType: AuthType.token,
    timeoutMs: 15000,
    defaultCacheStrategy: CacheStrategy.staleWhileRevalidate,
    cacheTtlMs: 300000, // 5 minutes
    isCritical: true,
    supportsBackground: true,
    retryConfig: RetryConfig(
      maxRetries: 3,
      baseDelayMs: 500,
      backoffMultiplier: 2.0,
    ),
  );

  /// Configuration for ALBO (announcement system)
  static const ServiceConfig albo = ServiceConfig(
    serviceId: 'albo',
    displayName: 'ALBO',
    baseUrl: 'https://albo.chukyodaigaku.ac.jp',
    authType: AuthType.cookie,
    timeoutMs: 30000,
    defaultCacheStrategy: CacheStrategy.staleWhileRevalidate,
    cacheTtlMs: 600000, // 10 minutes
    supportsBackground: true,
    retryConfig: RetryConfig(maxRetries: 2, baseDelayMs: 1000),
  );

  /// Configuration for MaNaBo (learning management system)
  static const ServiceConfig manabo = ServiceConfig(
    serviceId: 'manabo',
    displayName: 'MaNaBo',
    baseUrl: 'https://manabo.chukyodaigaku.ac.jp',
    authType: AuthType.cookie,
    timeoutMs: 45000,
    defaultCacheStrategy: CacheStrategy.networkFirst,
    cacheTtlMs: 300000, // 5 minutes
    supportsBackground: true,
    retryConfig: RetryConfig(maxRetries: 2, baseDelayMs: 1500),
  );

  /// Configuration for Cubics (academic system)
  static const ServiceConfig cubics = ServiceConfig(
    serviceId: 'cubics',
    displayName: 'CUBICS',
    baseUrl: 'https://cubics.chukyodaigaku.ac.jp',
    authType: AuthType.cookie,
    timeoutMs: 30000,
    defaultCacheStrategy: CacheStrategy.networkFirst,
    cacheTtlMs: 900000, // 15 minutes
    supportsBackground: false, // Academic data should be fresh
    retryConfig: RetryConfig(maxRetries: 1, baseDelayMs: 2000),
  );

  /// Configuration for SSO (single sign-on)
  static const ServiceConfig sso = ServiceConfig(
    serviceId: 'sso',
    displayName: 'Shibboleth SSO',
    baseUrl: 'https://sso.chukyodaigaku.ac.jp',
    authType: AuthType.form,
    timeoutMs: 20000,
    defaultCacheStrategy: CacheStrategy.noCache, // Never cache auth requests
    persistCookies: true,
    isCritical: true,
    retryConfig: RetryConfig(maxRetries: 1, baseDelayMs: 3000),
  );

  /// Get all predefined configurations
  static List<ServiceConfig> get all => [palapi, albo, manabo, cubics, sso];

  /// Get configuration by service ID
  static ServiceConfig? getById(String serviceId) {
    try {
      return all.firstWhere((config) => config.serviceId == serviceId);
    } catch (_) {
      return null;
    }
  }
}
