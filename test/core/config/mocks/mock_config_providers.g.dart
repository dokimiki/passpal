// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_config_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$testAppConfigHash() => r'8ccba2a59240365282ee20f5851075a86258c012';

/// Mock test configuration provider
///
/// Copied from [testAppConfig].
@ProviderFor(testAppConfig)
final testAppConfigProvider = AutoDisposeProvider<AppConfig>.internal(
  testAppConfig,
  name: r'testAppConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testAppConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestAppConfigRef = AutoDisposeProviderRef<AppConfig>;
String _$testLoadedConfigHash() => r'986b7ccbe476a39227671c7c26e05c84425954c7';

/// Mock loaded configuration provider for testing
///
/// Copied from [testLoadedConfig].
@ProviderFor(testLoadedConfig)
final testLoadedConfigProvider = AutoDisposeFutureProvider<AppConfig>.internal(
  testLoadedConfig,
  name: r'testLoadedConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testLoadedConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestLoadedConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
String _$testLoadingConfigHash() => r'6857bd2ceaa9700718cdf5912db485bc33100c7e';

/// Mock configuration provider that always returns loading state
///
/// Copied from [testLoadingConfig].
@ProviderFor(testLoadingConfig)
final testLoadingConfigProvider = AutoDisposeFutureProvider<AppConfig>.internal(
  testLoadingConfig,
  name: r'testLoadingConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testLoadingConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestLoadingConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
String _$testErrorConfigHash() => r'f44016e91ee976918ce06ce4c8a647274891f3b4';

/// Mock configuration provider that always throws an error
///
/// Copied from [testErrorConfig].
@ProviderFor(testErrorConfig)
final testErrorConfigProvider = AutoDisposeFutureProvider<AppConfig>.internal(
  testErrorConfig,
  name: r'testErrorConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testErrorConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestErrorConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
String _$testCustomConfigHash() => r'941e515a8a327cb6dea33cfd19ec1fd77ca5d4b8';

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

/// Mock configuration provider with custom config
///
/// Copied from [testCustomConfig].
@ProviderFor(testCustomConfig)
const testCustomConfigProvider = TestCustomConfigFamily();

/// Mock configuration provider with custom config
///
/// Copied from [testCustomConfig].
class TestCustomConfigFamily extends Family<AppConfig> {
  /// Mock configuration provider with custom config
  ///
  /// Copied from [testCustomConfig].
  const TestCustomConfigFamily();

  /// Mock configuration provider with custom config
  ///
  /// Copied from [testCustomConfig].
  TestCustomConfigProvider call(AppConfig config) {
    return TestCustomConfigProvider(config);
  }

  @override
  TestCustomConfigProvider getProviderOverride(
    covariant TestCustomConfigProvider provider,
  ) {
    return call(provider.config);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'testCustomConfigProvider';
}

/// Mock configuration provider with custom config
///
/// Copied from [testCustomConfig].
class TestCustomConfigProvider extends AutoDisposeProvider<AppConfig> {
  /// Mock configuration provider with custom config
  ///
  /// Copied from [testCustomConfig].
  TestCustomConfigProvider(AppConfig config)
    : this._internal(
        (ref) => testCustomConfig(ref as TestCustomConfigRef, config),
        from: testCustomConfigProvider,
        name: r'testCustomConfigProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$testCustomConfigHash,
        dependencies: TestCustomConfigFamily._dependencies,
        allTransitiveDependencies:
            TestCustomConfigFamily._allTransitiveDependencies,
        config: config,
      );

  TestCustomConfigProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.config,
  }) : super.internal();

  final AppConfig config;

  @override
  Override overrideWith(
    AppConfig Function(TestCustomConfigRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TestCustomConfigProvider._internal(
        (ref) => create(ref as TestCustomConfigRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        config: config,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AppConfig> createElement() {
    return _TestCustomConfigProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TestCustomConfigProvider && other.config == config;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, config.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TestCustomConfigRef on AutoDisposeProviderRef<AppConfig> {
  /// The parameter `config` of this provider.
  AppConfig get config;
}

class _TestCustomConfigProviderElement
    extends AutoDisposeProviderElement<AppConfig>
    with TestCustomConfigRef {
  _TestCustomConfigProviderElement(super.provider);

  @override
  AppConfig get config => (origin as TestCustomConfigProvider).config;
}

String _$testInitializeConfigHash() =>
    r'b8da649d9fb233c4b8244c0bd99db549735b151e';

/// Mock configuration initialization provider
///
/// Copied from [testInitializeConfig].
@ProviderFor(testInitializeConfig)
final testInitializeConfigProvider = AutoDisposeFutureProvider<void>.internal(
  testInitializeConfig,
  name: r'testInitializeConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testInitializeConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestInitializeConfigRef = AutoDisposeFutureProviderRef<void>;
String _$testRefreshedConfigHash() =>
    r'f10283e622950af2132fcb18e05074089e05a422';

/// Mock configuration refresh provider
///
/// Copied from [testRefreshedConfig].
@ProviderFor(testRefreshedConfig)
final testRefreshedConfigProvider =
    AutoDisposeFutureProvider<AppConfig>.internal(
      testRefreshedConfig,
      name: r'testRefreshedConfigProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$testRefreshedConfigHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestRefreshedConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
String _$testApiConfigHash() => r'f8001f7d709cc593163bd1ce8cdad8cc0662be6c';

/// Mock API config provider
///
/// Copied from [testApiConfig].
@ProviderFor(testApiConfig)
final testApiConfigProvider = AutoDisposeProvider<ApiConfig>.internal(
  testApiConfig,
  name: r'testApiConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testApiConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestApiConfigRef = AutoDisposeProviderRef<ApiConfig>;
String _$testAuthConfigHash() => r'5d476d9691ac6ee0fbbbba0e0b5f81e2962ff7e5';

/// Mock Auth config provider
///
/// Copied from [testAuthConfig].
@ProviderFor(testAuthConfig)
final testAuthConfigProvider = AutoDisposeProvider<AuthConfig>.internal(
  testAuthConfig,
  name: r'testAuthConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testAuthConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestAuthConfigRef = AutoDisposeProviderRef<AuthConfig>;
String _$testDebugConfigHash() => r'4a5d785cf90d225047001565110fe846d2527821';

/// Mock Debug config provider
///
/// Copied from [testDebugConfig].
@ProviderFor(testDebugConfig)
final testDebugConfigProvider = AutoDisposeProvider<DebugConfig>.internal(
  testDebugConfig,
  name: r'testDebugConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testDebugConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestDebugConfigRef = AutoDisposeProviderRef<DebugConfig>;
String _$testFeatureFlagsHash() => r'5882fd45902412dfcefcf1d7cb98c8c3a74dcabf';

/// Mock Feature flags provider
///
/// Copied from [testFeatureFlags].
@ProviderFor(testFeatureFlags)
final testFeatureFlagsProvider = AutoDisposeProvider<FeatureFlags>.internal(
  testFeatureFlags,
  name: r'testFeatureFlagsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testFeatureFlagsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestFeatureFlagsRef = AutoDisposeProviderRef<FeatureFlags>;
String _$testAdminConfigHash() => r'baede9cef35448c986b787d243b49d77e94fb27e';

/// Mock Admin config provider
///
/// Copied from [testAdminConfig].
@ProviderFor(testAdminConfig)
final testAdminConfigProvider = AutoDisposeProvider<AdminConfig>.internal(
  testAdminConfig,
  name: r'testAdminConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testAdminConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestAdminConfigRef = AutoDisposeProviderRef<AdminConfig>;
String _$testConfigMergerHash() => r'3be25f831abccf17f956da889a10c42c2618da64';

/// Mock config merger provider
///
/// Copied from [testConfigMerger].
@ProviderFor(testConfigMerger)
final testConfigMergerProvider = AutoDisposeProvider<ConfigMerger>.internal(
  testConfigMerger,
  name: r'testConfigMergerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testConfigMergerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestConfigMergerRef = AutoDisposeProviderRef<ConfigMerger>;
String _$testConfigCacheHash() => r'b23a959d1224ebc45344a62d681504a3cec974df';

/// Mock config cache provider
///
/// Copied from [testConfigCache].
@ProviderFor(testConfigCache)
final testConfigCacheProvider = AutoDisposeProvider<ConfigCache>.internal(
  testConfigCache,
  name: r'testConfigCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$testConfigCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestConfigCacheRef = AutoDisposeProviderRef<ConfigCache>;
String _$testConfigUpdateMonitorHash() =>
    r'7a00dbeff275a4455496039efd6170408dd30d63';

/// Mock config update monitor provider
///
/// Copied from [testConfigUpdateMonitor].
@ProviderFor(testConfigUpdateMonitor)
final testConfigUpdateMonitorProvider =
    AutoDisposeProvider<ConfigUpdateMonitor>.internal(
      testConfigUpdateMonitor,
      name: r'testConfigUpdateMonitorProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$testConfigUpdateMonitorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestConfigUpdateMonitorRef =
    AutoDisposeProviderRef<ConfigUpdateMonitor>;
String _$testEnvConfigSourceHash() =>
    r'85729701d27e27da3b6728f6c5d85da38e5f97c1';

/// Mock env config source provider
///
/// Copied from [testEnvConfigSource].
@ProviderFor(testEnvConfigSource)
final testEnvConfigSourceProvider =
    AutoDisposeProvider<EnvConfigSource>.internal(
      testEnvConfigSource,
      name: r'testEnvConfigSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$testEnvConfigSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestEnvConfigSourceRef = AutoDisposeProviderRef<EnvConfigSource>;
String _$testRemoteConfigSourceHash() =>
    r'c85ffb23edfa31a37be14003298aea8286c37d7f';

/// Mock remote config source provider
///
/// Copied from [testRemoteConfigSource].
@ProviderFor(testRemoteConfigSource)
final testRemoteConfigSourceProvider =
    AutoDisposeProvider<RemoteConfigSource>.internal(
      testRemoteConfigSource,
      name: r'testRemoteConfigSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$testRemoteConfigSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TestRemoteConfigSourceRef = AutoDisposeProviderRef<RemoteConfigSource>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
