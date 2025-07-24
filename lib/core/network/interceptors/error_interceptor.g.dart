// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_interceptor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$errorInterceptorHash() => r'2aa652a557fdac21aede87345aff4e8a57cc7d35';

/// Provider for the error interceptor
///
/// Copied from [errorInterceptor].
@ProviderFor(errorInterceptor)
final errorInterceptorProvider = AutoDisposeProvider<ErrorInterceptor>.internal(
  errorInterceptor,
  name: r'errorInterceptorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$errorInterceptorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ErrorInterceptorRef = AutoDisposeProviderRef<ErrorInterceptor>;
String _$errorInterceptorForServiceHash() =>
    r'e889dee8d5c0595bd703a96ddb6a5f4d4ac423e0';

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

/// Provider family for creating error interceptors with custom tags
///
/// Copied from [errorInterceptorForService].
@ProviderFor(errorInterceptorForService)
const errorInterceptorForServiceProvider = ErrorInterceptorForServiceFamily();

/// Provider family for creating error interceptors with custom tags
///
/// Copied from [errorInterceptorForService].
class ErrorInterceptorForServiceFamily extends Family<ErrorInterceptor> {
  /// Provider family for creating error interceptors with custom tags
  ///
  /// Copied from [errorInterceptorForService].
  const ErrorInterceptorForServiceFamily();

  /// Provider family for creating error interceptors with custom tags
  ///
  /// Copied from [errorInterceptorForService].
  ErrorInterceptorForServiceProvider call(String serviceName) {
    return ErrorInterceptorForServiceProvider(serviceName);
  }

  @override
  ErrorInterceptorForServiceProvider getProviderOverride(
    covariant ErrorInterceptorForServiceProvider provider,
  ) {
    return call(provider.serviceName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'errorInterceptorForServiceProvider';
}

/// Provider family for creating error interceptors with custom tags
///
/// Copied from [errorInterceptorForService].
class ErrorInterceptorForServiceProvider
    extends AutoDisposeProvider<ErrorInterceptor> {
  /// Provider family for creating error interceptors with custom tags
  ///
  /// Copied from [errorInterceptorForService].
  ErrorInterceptorForServiceProvider(String serviceName)
    : this._internal(
        (ref) => errorInterceptorForService(
          ref as ErrorInterceptorForServiceRef,
          serviceName,
        ),
        from: errorInterceptorForServiceProvider,
        name: r'errorInterceptorForServiceProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$errorInterceptorForServiceHash,
        dependencies: ErrorInterceptorForServiceFamily._dependencies,
        allTransitiveDependencies:
            ErrorInterceptorForServiceFamily._allTransitiveDependencies,
        serviceName: serviceName,
      );

  ErrorInterceptorForServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serviceName,
  }) : super.internal();

  final String serviceName;

  @override
  Override overrideWith(
    ErrorInterceptor Function(ErrorInterceptorForServiceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ErrorInterceptorForServiceProvider._internal(
        (ref) => create(ref as ErrorInterceptorForServiceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serviceName: serviceName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ErrorInterceptor> createElement() {
    return _ErrorInterceptorForServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ErrorInterceptorForServiceProvider &&
        other.serviceName == serviceName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ErrorInterceptorForServiceRef
    on AutoDisposeProviderRef<ErrorInterceptor> {
  /// The parameter `serviceName` of this provider.
  String get serviceName;
}

class _ErrorInterceptorForServiceProviderElement
    extends AutoDisposeProviderElement<ErrorInterceptor>
    with ErrorInterceptorForServiceRef {
  _ErrorInterceptorForServiceProviderElement(super.provider);

  @override
  String get serviceName =>
      (origin as ErrorInterceptorForServiceProvider).serviceName;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
