import 'package:passpal/core/config/models/api_config.dart';

/// Network targets for different endpoints
enum NetworkTarget {
  albo('ALBO'),
  manabo('MaNaBo'),
  cubics('Cubics'),
  sso('SSO'),
  palapi('PalAPI'),
  chukyolink('ChukyoLink');

  const NetworkTarget(this.displayName);

  final String displayName;

  /// Get the base URL for this target using the provided config
  String getBaseUrl(ApiConfig config) {
    return switch (this) {
      NetworkTarget.albo => config.alboBaseUrl,
      NetworkTarget.manabo => config.manaboBaseUrl,
      NetworkTarget.cubics => config.cubicsBaseUrl,
      NetworkTarget.sso => config.ssoBaseUrl,
      NetworkTarget.palapi => config.palapiBaseUrl,
      NetworkTarget.chukyolink => 'https://link.lanet.sist.chukyo-u.ac.jp',
    };
  }

  /// Whether this target requires authentication
  bool get requiresAuth {
    return switch (this) {
      NetworkTarget.albo => true,
      NetworkTarget.manabo => true,
      NetworkTarget.cubics => true,
      NetworkTarget.sso => false, // SSO handles auth itself
      NetworkTarget.palapi => true,
      NetworkTarget.chukyolink => false, // Public API
    };
  }

  /// Whether this target uses SSO cookies
  bool get usesSsoCookies {
    return switch (this) {
      NetworkTarget.albo => true,
      NetworkTarget.manabo => true,
      NetworkTarget.cubics => true,
      NetworkTarget.sso => false,
      NetworkTarget.palapi => false, // Uses Bearer token
      NetworkTarget.chukyolink => false, // Public API
    };
  }

  /// Whether this target uses Bearer token authentication
  bool get usesBearerToken {
    return switch (this) {
      NetworkTarget.palapi => true,
      _ => false,
    };
  }
}
