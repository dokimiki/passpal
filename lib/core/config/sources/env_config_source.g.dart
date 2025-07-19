// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_config_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$envConfigSourceHash() => r'094b505678f5d2a549078d2cd15c6b6aad94423e';

/// Riverpod provider for EnvConfigSource with keepAlive
///
/// Copied from [envConfigSource].
@ProviderFor(envConfigSource)
final envConfigSourceProvider = Provider<EnvConfigSource>.internal(
  envConfigSource,
  name: r'envConfigSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$envConfigSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EnvConfigSourceRef = ProviderRef<EnvConfigSource>;
String _$envConfigHash() => r'946ec739aa2705a785c3d67563c9313c47443b84';

/// Riverpod provider for loading environment configuration
///
/// Copied from [envConfig].
@ProviderFor(envConfig)
final envConfigProvider = AutoDisposeFutureProvider<AppConfig>.internal(
  envConfig,
  name: r'envConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$envConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EnvConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
