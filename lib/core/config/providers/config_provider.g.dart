// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appConfigHash() => r'e88a92e1540cb4393410e5c7fb5d25c40b1227f6';

/// Main configuration provider that manages app configuration
///
/// This provider handles:
/// - Configuration initialization and loading
/// - Memory caching with automatic expiration
/// - Error handling and recovery
/// - Configuration update monitoring
/// - Reactive configuration state management
///
/// Copied from [appConfig].
@ProviderFor(appConfig)
final appConfigProvider = AutoDisposeProvider<AppConfig>.internal(
  appConfig,
  name: r'appConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppConfigRef = AutoDisposeProviderRef<AppConfig>;
String _$loadedConfigHash() => r'49e12d94e7aa425c9ca9b39e61a0fbbdabe0abe2';

/// Load configuration from all sources
///
/// This method:
/// 1. Checks cache first for valid configuration
/// 2. If cache is invalid, loads from merged sources
/// 3. Updates cache with new configuration
/// 4. Handles errors gracefully
///
/// Copied from [loadedConfig].
@ProviderFor(loadedConfig)
final loadedConfigProvider = AutoDisposeFutureProvider<AppConfig>.internal(
  loadedConfig,
  name: r'loadedConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loadedConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoadedConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
String _$refreshedConfigHash() => r'88122bd02327200e08a57e3f8b25508a59ecc4fa';

/// Refresh configuration by clearing cache and reloading
///
/// Copied from [refreshedConfig].
@ProviderFor(refreshedConfig)
final refreshedConfigProvider = AutoDisposeFutureProvider<AppConfig>.internal(
  refreshedConfig,
  name: r'refreshedConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$refreshedConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RefreshedConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
String _$initializeConfigHash() => r'bf76137203ba49616c521a91724b022380b7b7f3';

/// Provider for configuration initialization
///
/// This provider handles the initialization of the configuration system
/// and should be called during app startup
///
/// Copied from [initializeConfig].
@ProviderFor(initializeConfig)
final initializeConfigProvider = AutoDisposeFutureProvider<void>.internal(
  initializeConfig,
  name: r'initializeConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$initializeConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InitializeConfigRef = AutoDisposeFutureProviderRef<void>;
String _$isConfigLoadingHash() => r'8d4fa05af1a748185353819335a4aa210dc81d73';

/// Provider for checking if configuration is loading
///
/// Copied from [isConfigLoading].
@ProviderFor(isConfigLoading)
final isConfigLoadingProvider = AutoDisposeProvider<bool>.internal(
  isConfigLoading,
  name: r'isConfigLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isConfigLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsConfigLoadingRef = AutoDisposeProviderRef<bool>;
String _$hasConfigErrorsHash() => r'611ca1ae9c14755dc0ff2746472cd83fc8c19e53';

/// Provider for checking if configuration has errors
///
/// Copied from [hasConfigErrors].
@ProviderFor(hasConfigErrors)
final hasConfigErrorsProvider = AutoDisposeProvider<bool>.internal(
  hasConfigErrors,
  name: r'hasConfigErrorsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasConfigErrorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasConfigErrorsRef = AutoDisposeProviderRef<bool>;
String _$apiConfigHash() => r'0367e4bc8abd8419555cf71e4d0434224162e18a';

/// Provider for getting specific configuration sections
///
/// Copied from [apiConfig].
@ProviderFor(apiConfig)
final apiConfigProvider = AutoDisposeProvider<ApiConfig>.internal(
  apiConfig,
  name: r'apiConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiConfigRef = AutoDisposeProviderRef<ApiConfig>;
String _$authConfigHash() => r'334d3e2a5bb2a29b39a284104951b89497e5329e';

/// See also [authConfig].
@ProviderFor(authConfig)
final authConfigProvider = AutoDisposeProvider<AuthConfig>.internal(
  authConfig,
  name: r'authConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthConfigRef = AutoDisposeProviderRef<AuthConfig>;
String _$debugConfigHash() => r'b1f7ff1ad1831d41c08613ff1e98b6f8e2cc56a8';

/// See also [debugConfig].
@ProviderFor(debugConfig)
final debugConfigProvider = AutoDisposeProvider<DebugConfig>.internal(
  debugConfig,
  name: r'debugConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debugConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DebugConfigRef = AutoDisposeProviderRef<DebugConfig>;
String _$featureFlagsHash() => r'685197c2f58edc3039add53244d78a96ef9bb489';

/// See also [featureFlags].
@ProviderFor(featureFlags)
final featureFlagsProvider = AutoDisposeProvider<FeatureFlags>.internal(
  featureFlags,
  name: r'featureFlagsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featureFlagsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeatureFlagsRef = AutoDisposeProviderRef<FeatureFlags>;
String _$adminConfigHash() => r'8ba82a93f2f4fd77bea066ca4be5c5de331551ed';

/// See also [adminConfig].
@ProviderFor(adminConfig)
final adminConfigProvider = AutoDisposeProvider<AdminConfig>.internal(
  adminConfig,
  name: r'adminConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$adminConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AdminConfigRef = AutoDisposeProviderRef<AdminConfig>;
String _$configVersionHash() => r'42bdd11c1c0602a92d2b152a4b0519c4f77f9d29';

/// Provider for configuration version
///
/// Copied from [configVersion].
@ProviderFor(configVersion)
final configVersionProvider = AutoDisposeProvider<String>.internal(
  configVersion,
  name: r'configVersionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$configVersionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConfigVersionRef = AutoDisposeProviderRef<String>;
String _$isFeatureEnabledHash() => r'360b7fe2472ae0f1cd2ce42f69a2da7b5aac6660';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for feature flag checks
///
/// Copied from [isFeatureEnabled].
@ProviderFor(isFeatureEnabled)
const isFeatureEnabledProvider = IsFeatureEnabledFamily();

/// Provider for feature flag checks
///
/// Copied from [isFeatureEnabled].
class IsFeatureEnabledFamily extends Family<bool> {
  /// Provider for feature flag checks
  ///
  /// Copied from [isFeatureEnabled].
  const IsFeatureEnabledFamily();

  /// Provider for feature flag checks
  ///
  /// Copied from [isFeatureEnabled].
  IsFeatureEnabledProvider call(String feature) {
    return IsFeatureEnabledProvider(feature);
  }

  @override
  IsFeatureEnabledProvider getProviderOverride(
    covariant IsFeatureEnabledProvider provider,
  ) {
    return call(provider.feature);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isFeatureEnabledProvider';
}

/// Provider for feature flag checks
///
/// Copied from [isFeatureEnabled].
class IsFeatureEnabledProvider extends AutoDisposeProvider<bool> {
  /// Provider for feature flag checks
  ///
  /// Copied from [isFeatureEnabled].
  IsFeatureEnabledProvider(String feature)
    : this._internal(
        (ref) => isFeatureEnabled(ref as IsFeatureEnabledRef, feature),
        from: isFeatureEnabledProvider,
        name: r'isFeatureEnabledProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isFeatureEnabledHash,
        dependencies: IsFeatureEnabledFamily._dependencies,
        allTransitiveDependencies:
            IsFeatureEnabledFamily._allTransitiveDependencies,
        feature: feature,
      );

  IsFeatureEnabledProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feature,
  }) : super.internal();

  final String feature;

  @override
  Override overrideWith(bool Function(IsFeatureEnabledRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsFeatureEnabledProvider._internal(
        (ref) => create(ref as IsFeatureEnabledRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feature: feature,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsFeatureEnabledProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsFeatureEnabledProvider && other.feature == feature;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feature.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsFeatureEnabledRef on AutoDisposeProviderRef<bool> {
  /// The parameter `feature` of this provider.
  String get feature;
}

class _IsFeatureEnabledProviderElement extends AutoDisposeProviderElement<bool>
    with IsFeatureEnabledRef {
  _IsFeatureEnabledProviderElement(super.provider);

  @override
  String get feature => (origin as IsFeatureEnabledProvider).feature;
}

String _$isDebugModeHash() => r'aa145f34e4f62b5d2e49e2d840b993fc9ffbaa60';

/// Provider for debug mode check
///
/// Copied from [isDebugMode].
@ProviderFor(isDebugMode)
final isDebugModeProvider = AutoDisposeProvider<bool>.internal(
  isDebugMode,
  name: r'isDebugModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isDebugModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsDebugModeRef = AutoDisposeProviderRef<bool>;
String _$isAnalyticsEnabledHash() =>
    r'e29d86ae3864406ed8da40a28bde407f54fe409d';

/// Provider for analytics check
///
/// Copied from [isAnalyticsEnabled].
@ProviderFor(isAnalyticsEnabled)
final isAnalyticsEnabledProvider = AutoDisposeProvider<bool>.internal(
  isAnalyticsEnabled,
  name: r'isAnalyticsEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAnalyticsEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAnalyticsEnabledRef = AutoDisposeProviderRef<bool>;
String _$isCrashReportingEnabledHash() =>
    r'428b60155367cc6295d418df08b0295cef57550f';

/// Provider for crash reporting check
///
/// Copied from [isCrashReportingEnabled].
@ProviderFor(isCrashReportingEnabled)
final isCrashReportingEnabledProvider = AutoDisposeProvider<bool>.internal(
  isCrashReportingEnabled,
  name: r'isCrashReportingEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isCrashReportingEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsCrashReportingEnabledRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
