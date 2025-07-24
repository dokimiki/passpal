import '../models/network_request.dart';
import '../models/network_response.dart';
import '../models/connectivity_status.dart';

/// Abstract interface for network clients providing HTTP operations
abstract class NetworkClientInterface {
  /// Execute a network request and return response
  Future<NetworkResponse<T>> execute<T>(
    NetworkRequest request, {
    T Function(dynamic data)? fromJson,
  });

  /// Execute multiple requests concurrently
  Future<List<NetworkResponse<dynamic>>> executeBatch(
    List<NetworkRequest> requests,
  );

  /// Check if a URL is reachable
  Future<bool> isReachable(String url);

  /// Get current connectivity status
  Future<ConnectivityStatus> getConnectivityStatus();

  /// Stream of connectivity status changes
  Stream<ConnectivityStatus> get connectivityStream;

  /// Cancel all ongoing requests
  Future<void> cancelAll();

  /// Cancel specific request by tag
  Future<bool> cancelRequest(String tag);

  /// Clear all cached responses
  Future<void> clearCache();

  /// Clear cached responses for specific URL pattern
  Future<void> clearCacheForPattern(String pattern);

  /// Get cache size in bytes
  Future<int> getCacheSize();

  /// Set custom headers for all requests
  void setGlobalHeaders(Map<String, String> headers);

  /// Remove global headers
  void removeGlobalHeaders(List<String> headerNames);

  /// Get current global headers
  Map<String, String> getGlobalHeaders();
}

/// Interface for service-specific network clients
abstract class ServiceClientInterface extends NetworkClientInterface {
  /// Service identifier (e.g., 'palapi', 'albo', 'manabo')
  String get serviceId;

  /// Base URL for this service
  String get baseUrl;

  /// Whether this service requires authentication
  bool get requiresAuth;

  /// Default timeout for this service in milliseconds
  int get defaultTimeoutMs;

  /// Service-specific headers
  Map<String, String> get serviceHeaders;

  /// Authenticate with the service
  Future<bool> authenticate();

  /// Check if currently authenticated
  Future<bool> isAuthenticated();

  /// Refresh authentication if needed
  Future<bool> refreshAuth();

  /// Sign out from the service
  Future<void> signOut();

  /// Get service-specific error message
  String getErrorMessage(NetworkResponse response);
}

/// Interface for clients that support cookie-based authentication
abstract class CookieClientInterface extends ServiceClientInterface {
  /// Load cookies from storage
  Future<void> loadCookies();

  /// Save cookies to storage
  Future<void> saveCookies();

  /// Clear all cookies
  Future<void> clearCookies();

  /// Check if session is still valid
  Future<bool> isSessionValid();

  /// Extract session info from response
  Map<String, String>? extractSessionInfo(NetworkResponse response);
}

/// Interface for clients that support token-based authentication
abstract class TokenClientInterface extends ServiceClientInterface {
  /// Current authentication token
  String? get currentToken;

  /// Set authentication token
  void setToken(String token);

  /// Clear authentication token
  void clearToken();

  /// Refresh token if expired
  Future<String?> refreshToken();

  /// Check if token is expired
  bool isTokenExpired();

  /// Get token expiry time
  DateTime? getTokenExpiry();
}

/// Interface for monitoring network operations
abstract class NetworkMonitorInterface {
  /// Stream of network requests
  Stream<NetworkRequest> get requestStream;

  /// Stream of network responses
  Stream<NetworkResponse> get responseStream;

  /// Stream of network errors
  Stream<Exception> get errorStream;

  /// Get performance metrics
  Future<Map<String, dynamic>> getMetrics();

  /// Reset performance metrics
  Future<void> resetMetrics();

  /// Enable/disable request logging
  void setLoggingEnabled(bool enabled);

  /// Get current request count
  int get activeRequestCount;

  /// Get total requests sent
  int get totalRequestCount;

  /// Get success rate percentage
  double get successRate;
}

/// Interface for cache management
abstract class CacheManagerInterface {
  /// Get cached response for request
  Future<NetworkResponse<T>?> getCached<T>(
    NetworkRequest request, {
    T Function(dynamic data)? fromJson,
  });

  /// Store response in cache
  Future<void> store<T>(NetworkRequest request, NetworkResponse<T> response);

  /// Remove cached response
  Future<bool> remove(NetworkRequest request);

  /// Check if response is cached
  Future<bool> isCached(NetworkRequest request);

  /// Get cache entry age in milliseconds
  Future<int?> getCacheAge(NetworkRequest request);

  /// Validate cache entry (check if still fresh)
  Future<bool> isValid(NetworkRequest request);

  /// Invalidate all cache entries matching pattern
  Future<int> invalidatePattern(String pattern);

  /// Cleanup expired cache entries
  Future<int> cleanup();

  /// Get cache statistics
  Future<Map<String, dynamic>> getStats();
}
