/// Enumeration of available portals in the app
enum Portal {
  /// Manabo portal (course management)
  manabo,

  /// ALBO portal (assignment and grade management)
  albo,

  /// SSO portal (single sign-on)
  sso,
}

/// Extension methods for Portal enum
extension PortalExtension on Portal {
  /// Returns the display name for the portal
  String get displayName {
    switch (this) {
      case Portal.manabo:
        return 'MaNaBo';
      case Portal.albo:
        return 'ALBO';
      case Portal.sso:
        return 'SSO';
    }
  }

  /// Returns the internal identifier for the portal
  String get identifier {
    switch (this) {
      case Portal.manabo:
        return 'manabo';
      case Portal.albo:
        return 'albo';
      case Portal.sso:
        return 'sso';
    }
  }
}
