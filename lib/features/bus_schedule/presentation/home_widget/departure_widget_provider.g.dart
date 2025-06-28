// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure_widget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nearestDepartureHash() => r'ad77b6b0dda6bc1c9016ea68a33a0041099aec2f';

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

/// Provider for home widget departure data
///
/// Copied from [nearestDeparture].
@ProviderFor(nearestDeparture)
const nearestDepartureProvider = NearestDepartureFamily();

/// Provider for home widget departure data
///
/// Copied from [nearestDeparture].
class NearestDepartureFamily extends Family<AsyncValue<DepartureDTO?>> {
  /// Provider for home widget departure data
  ///
  /// Copied from [nearestDeparture].
  const NearestDepartureFamily();

  /// Provider for home widget departure data
  ///
  /// Copied from [nearestDeparture].
  NearestDepartureProvider call(Campus campus) {
    return NearestDepartureProvider(campus);
  }

  @override
  NearestDepartureProvider getProviderOverride(
    covariant NearestDepartureProvider provider,
  ) {
    return call(provider.campus);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nearestDepartureProvider';
}

/// Provider for home widget departure data
///
/// Copied from [nearestDeparture].
class NearestDepartureProvider
    extends AutoDisposeFutureProvider<DepartureDTO?> {
  /// Provider for home widget departure data
  ///
  /// Copied from [nearestDeparture].
  NearestDepartureProvider(Campus campus)
    : this._internal(
        (ref) => nearestDeparture(ref as NearestDepartureRef, campus),
        from: nearestDepartureProvider,
        name: r'nearestDepartureProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$nearestDepartureHash,
        dependencies: NearestDepartureFamily._dependencies,
        allTransitiveDependencies:
            NearestDepartureFamily._allTransitiveDependencies,
        campus: campus,
      );

  NearestDepartureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.campus,
  }) : super.internal();

  final Campus campus;

  @override
  Override overrideWith(
    FutureOr<DepartureDTO?> Function(NearestDepartureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NearestDepartureProvider._internal(
        (ref) => create(ref as NearestDepartureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        campus: campus,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DepartureDTO?> createElement() {
    return _NearestDepartureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NearestDepartureProvider && other.campus == campus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, campus.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NearestDepartureRef on AutoDisposeFutureProviderRef<DepartureDTO?> {
  /// The parameter `campus` of this provider.
  Campus get campus;
}

class _NearestDepartureProviderElement
    extends AutoDisposeFutureProviderElement<DepartureDTO?>
    with NearestDepartureRef {
  _NearestDepartureProviderElement(super.provider);

  @override
  Campus get campus => (origin as NearestDepartureProvider).campus;
}

String _$nearestDepartureStreamHash() =>
    r'430734f5966580736c98d9c3f606c9f814a276dc';

/// Provider that refreshes every minute for the home widget
///
/// Copied from [nearestDepartureStream].
@ProviderFor(nearestDepartureStream)
const nearestDepartureStreamProvider = NearestDepartureStreamFamily();

/// Provider that refreshes every minute for the home widget
///
/// Copied from [nearestDepartureStream].
class NearestDepartureStreamFamily extends Family<AsyncValue<DepartureDTO?>> {
  /// Provider that refreshes every minute for the home widget
  ///
  /// Copied from [nearestDepartureStream].
  const NearestDepartureStreamFamily();

  /// Provider that refreshes every minute for the home widget
  ///
  /// Copied from [nearestDepartureStream].
  NearestDepartureStreamProvider call(Campus campus) {
    return NearestDepartureStreamProvider(campus);
  }

  @override
  NearestDepartureStreamProvider getProviderOverride(
    covariant NearestDepartureStreamProvider provider,
  ) {
    return call(provider.campus);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nearestDepartureStreamProvider';
}

/// Provider that refreshes every minute for the home widget
///
/// Copied from [nearestDepartureStream].
class NearestDepartureStreamProvider
    extends AutoDisposeStreamProvider<DepartureDTO?> {
  /// Provider that refreshes every minute for the home widget
  ///
  /// Copied from [nearestDepartureStream].
  NearestDepartureStreamProvider(Campus campus)
    : this._internal(
        (ref) =>
            nearestDepartureStream(ref as NearestDepartureStreamRef, campus),
        from: nearestDepartureStreamProvider,
        name: r'nearestDepartureStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$nearestDepartureStreamHash,
        dependencies: NearestDepartureStreamFamily._dependencies,
        allTransitiveDependencies:
            NearestDepartureStreamFamily._allTransitiveDependencies,
        campus: campus,
      );

  NearestDepartureStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.campus,
  }) : super.internal();

  final Campus campus;

  @override
  Override overrideWith(
    Stream<DepartureDTO?> Function(NearestDepartureStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NearestDepartureStreamProvider._internal(
        (ref) => create(ref as NearestDepartureStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        campus: campus,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<DepartureDTO?> createElement() {
    return _NearestDepartureStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NearestDepartureStreamProvider && other.campus == campus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, campus.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NearestDepartureStreamRef on AutoDisposeStreamProviderRef<DepartureDTO?> {
  /// The parameter `campus` of this provider.
  Campus get campus;
}

class _NearestDepartureStreamProviderElement
    extends AutoDisposeStreamProviderElement<DepartureDTO?>
    with NearestDepartureStreamRef {
  _NearestDepartureStreamProviderElement(super.provider);

  @override
  Campus get campus => (origin as NearestDepartureStreamProvider).campus;
}

String _$widgetConfigHash() => r'547c4abe5c05ce31d24e3a2b0af820dfff02fbe1';

/// Widget configuration for home screen integration
///
/// Copied from [widgetConfig].
@ProviderFor(widgetConfig)
final widgetConfigProvider = AutoDisposeProvider<Map<String, dynamic>>.internal(
  widgetConfig,
  name: r'widgetConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$widgetConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WidgetConfigRef = AutoDisposeProviderRef<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
