// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remoteConfigSourceHash() =>
    r'b11c66959b4116e313cc9bb1e52c50fc69edec45';

/// Riverpod provider for RemoteConfigSource with keepAlive
///
/// Copied from [remoteConfigSource].
@ProviderFor(remoteConfigSource)
final remoteConfigSourceProvider = Provider<RemoteConfigSource>.internal(
  remoteConfigSource,
  name: r'remoteConfigSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteConfigSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteConfigSourceRef = ProviderRef<RemoteConfigSource>;
String _$remoteConfigHash() => r'1fa508900dd4d4d5533f43f604f27af998aa5982';

/// Riverpod provider for loading remote configuration
///
/// Copied from [remoteConfig].
@ProviderFor(remoteConfig)
final remoteConfigProvider = AutoDisposeFutureProvider<AppConfig>.internal(
  remoteConfig,
  name: r'remoteConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteConfigRef = AutoDisposeFutureProviderRef<AppConfig>;
String _$remoteConfigWithTimeoutHash() =>
    r'aecb69fffeeda35c8033fdbdfa8d63cccccd6dbe';

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

/// Riverpod provider for remote configuration with custom timeout
///
/// Copied from [remoteConfigWithTimeout].
@ProviderFor(remoteConfigWithTimeout)
const remoteConfigWithTimeoutProvider = RemoteConfigWithTimeoutFamily();

/// Riverpod provider for remote configuration with custom timeout
///
/// Copied from [remoteConfigWithTimeout].
class RemoteConfigWithTimeoutFamily extends Family<AsyncValue<AppConfig>> {
  /// Riverpod provider for remote configuration with custom timeout
  ///
  /// Copied from [remoteConfigWithTimeout].
  const RemoteConfigWithTimeoutFamily();

  /// Riverpod provider for remote configuration with custom timeout
  ///
  /// Copied from [remoteConfigWithTimeout].
  RemoteConfigWithTimeoutProvider call(Duration timeout) {
    return RemoteConfigWithTimeoutProvider(timeout);
  }

  @override
  RemoteConfigWithTimeoutProvider getProviderOverride(
    covariant RemoteConfigWithTimeoutProvider provider,
  ) {
    return call(provider.timeout);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'remoteConfigWithTimeoutProvider';
}

/// Riverpod provider for remote configuration with custom timeout
///
/// Copied from [remoteConfigWithTimeout].
class RemoteConfigWithTimeoutProvider
    extends AutoDisposeFutureProvider<AppConfig> {
  /// Riverpod provider for remote configuration with custom timeout
  ///
  /// Copied from [remoteConfigWithTimeout].
  RemoteConfigWithTimeoutProvider(Duration timeout)
    : this._internal(
        (ref) =>
            remoteConfigWithTimeout(ref as RemoteConfigWithTimeoutRef, timeout),
        from: remoteConfigWithTimeoutProvider,
        name: r'remoteConfigWithTimeoutProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$remoteConfigWithTimeoutHash,
        dependencies: RemoteConfigWithTimeoutFamily._dependencies,
        allTransitiveDependencies:
            RemoteConfigWithTimeoutFamily._allTransitiveDependencies,
        timeout: timeout,
      );

  RemoteConfigWithTimeoutProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.timeout,
  }) : super.internal();

  final Duration timeout;

  @override
  Override overrideWith(
    FutureOr<AppConfig> Function(RemoteConfigWithTimeoutRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoteConfigWithTimeoutProvider._internal(
        (ref) => create(ref as RemoteConfigWithTimeoutRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        timeout: timeout,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AppConfig> createElement() {
    return _RemoteConfigWithTimeoutProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoteConfigWithTimeoutProvider && other.timeout == timeout;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, timeout.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RemoteConfigWithTimeoutRef on AutoDisposeFutureProviderRef<AppConfig> {
  /// The parameter `timeout` of this provider.
  Duration get timeout;
}

class _RemoteConfigWithTimeoutProviderElement
    extends AutoDisposeFutureProviderElement<AppConfig>
    with RemoteConfigWithTimeoutRef {
  _RemoteConfigWithTimeoutProviderElement(super.provider);

  @override
  Duration get timeout => (origin as RemoteConfigWithTimeoutProvider).timeout;
}

String _$remoteConfigUpdatesHash() =>
    r'cc1400774b6a76952955c3771fd7bbf0b4858140';

/// Riverpod provider for monitoring remote config updates
///
/// Copied from [remoteConfigUpdates].
@ProviderFor(remoteConfigUpdates)
final remoteConfigUpdatesProvider =
    AutoDisposeStreamProvider<RemoteConfigUpdate>.internal(
      remoteConfigUpdates,
      name: r'remoteConfigUpdatesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remoteConfigUpdatesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteConfigUpdatesRef =
    AutoDisposeStreamProviderRef<RemoteConfigUpdate>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
