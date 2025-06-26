/// Network targets for different endpoints
enum NetworkTarget {
  albo('ALBO'),
  manabo('MaNaBo'),
  cubics('Cubics'),
  sso('SSO'),
  palapi('PalAPI');

  const NetworkTarget(this.displayName);

  final String displayName;

  /// Get the base URL for this target
  String get baseUrl {
    return switch (this) {
      NetworkTarget.albo => 'https://albo.chukyonet.jp',
      NetworkTarget.manabo => 'https://manabo.chukyonet.jp',
      NetworkTarget.cubics => 'https://cubics.chukyonet.jp',
      NetworkTarget.sso => 'https://sso.chukyonet.jp',
      NetworkTarget.palapi => 'https://api.passpal.app',
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
