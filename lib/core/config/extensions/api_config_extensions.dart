import '../models/api_config.dart';

/// Service types for API configuration
enum ServiceType {
  /// MaNaBo portal service
  manabo,

  /// ALBO portal service
  albo,

  /// CUBICS portal service
  cubics,

  /// SSO service
  sso,

  /// PassPal API service
  palApi,
}

/// Extended functionality for ApiConfig
extension ApiConfigExtensions on ApiConfig {
  /// Get base URL for a specific service type
  String getBaseUrl(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.manabo:
        return manaboBaseUrl;
      case ServiceType.albo:
        return alboBaseUrl;
      case ServiceType.cubics:
        return cubicsBaseUrl;
      case ServiceType.sso:
        return ssoUrl;
      case ServiceType.palApi:
        return palApiBaseUrl;
    }
  }

  /// Get full URL for a specific service endpoint
  String getFullUrl(ServiceType serviceType, String endpoint) {
    final baseUrl = getBaseUrl(serviceType);
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    return '$baseUrl$cleanEndpoint';
  }

  /// Get service type from base URL
  ServiceType? getServiceTypeFromUrl(String url) {
    if (url.startsWith(manaboBaseUrl)) return ServiceType.manabo;
    if (url.startsWith(alboBaseUrl)) return ServiceType.albo;
    if (url.startsWith(cubicsBaseUrl)) return ServiceType.cubics;
    if (url.startsWith(ssoUrl)) return ServiceType.sso;
    if (url.startsWith(palApiBaseUrl)) return ServiceType.palApi;
    return null;
  }

  /// Check if URL is for a portal service (MaNaBo, ALBO, CUBICS)
  bool isPortalService(String url) {
    final serviceType = getServiceTypeFromUrl(url);
    return serviceType == ServiceType.manabo ||
        serviceType == ServiceType.albo ||
        serviceType == ServiceType.cubics;
  }

  /// Check if URL is for PassPal API service
  bool isPalApiService(String url) {
    return getServiceTypeFromUrl(url) == ServiceType.palApi;
  }

  /// Check if URL is for SSO service
  bool isSsoService(String url) {
    return getServiceTypeFromUrl(url) == ServiceType.sso;
  }

  /// Get all portal base URLs
  List<String> get allPortalUrls => [manaboBaseUrl, alboBaseUrl, cubicsBaseUrl];

  /// Get all external service URLs (excludes PassPal API)
  List<String> get allExternalUrls => [
    manaboBaseUrl,
    alboBaseUrl,
    cubicsBaseUrl,
    ssoUrl,
  ];

  /// Get all service URLs
  List<String> get allServiceUrls => [
    manaboBaseUrl,
    alboBaseUrl,
    cubicsBaseUrl,
    ssoUrl,
    palApiBaseUrl,
  ];

  /// Get service display name
  String getServiceDisplayName(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.manabo:
        return 'MaNaBo';
      case ServiceType.albo:
        return 'ALBO';
      case ServiceType.cubics:
        return 'CUBICS';
      case ServiceType.sso:
        return 'SSO';
      case ServiceType.palApi:
        return 'PassPal API';
    }
  }

  /// Check if all URLs are using HTTPS
  bool get allUrlsSecure =>
      allServiceUrls.every((url) => url.startsWith('https://'));

  /// Check if URL is in testing mode
  bool isTestingUrl(String url) {
    return url.contains('test.') ||
        url.contains('localhost') ||
        url.contains('127.0.0.1');
  }

  /// Check if any service is in testing mode
  bool get hasTestingServices => allServiceUrls.any(isTestingUrl);

  /// Get timeout configuration for a service type
  Duration getTimeoutForService(ServiceType serviceType) {
    // Portal services might need longer timeout due to SSO redirects
    if (isPortalService(getBaseUrl(serviceType))) {
      return Duration(seconds: receiveTimeoutSeconds * 2);
    }
    return receiveTimeout;
  }

  /// Create a copy with updated URL for a specific service
  ApiConfig withUpdatedUrl(ServiceType serviceType, String newUrl) {
    switch (serviceType) {
      case ServiceType.manabo:
        return copyWith(manaboBaseUrl: newUrl);
      case ServiceType.albo:
        return copyWith(alboBaseUrl: newUrl);
      case ServiceType.cubics:
        return copyWith(cubicsBaseUrl: newUrl);
      case ServiceType.sso:
        return copyWith(ssoUrl: newUrl);
      case ServiceType.palApi:
        return copyWith(palApiBaseUrl: newUrl);
    }
  }
}
