// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_interceptor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mockAuthProviderHash() => r'b5750f5b774867a0360f9ea789179017fce3b708';

/// Provider for mock auth provider (temporary until Auth Core is ready)
///
/// Copied from [mockAuthProvider].
@ProviderFor(mockAuthProvider)
final mockAuthProviderProvider = AutoDisposeProvider<AuthProvider>.internal(
  mockAuthProvider,
  name: r'mockAuthProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mockAuthProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MockAuthProviderRef = AutoDisposeProviderRef<AuthProvider>;
String _$authInterceptorHash() => r'2917bd5744fbb9685bffbc46f72804d15c0f40ca';

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

/// Provider for auth interceptor
///
/// Copied from [authInterceptor].
@ProviderFor(authInterceptor)
const authInterceptorProvider = AuthInterceptorFamily();

/// Provider for auth interceptor
///
/// Copied from [authInterceptor].
class AuthInterceptorFamily extends Family<AuthInterceptor> {
  /// Provider for auth interceptor
  ///
  /// Copied from [authInterceptor].
  const AuthInterceptorFamily();

  /// Provider for auth interceptor
  ///
  /// Copied from [authInterceptor].
  AuthInterceptorProvider call(ServiceConfig serviceConfig) {
    return AuthInterceptorProvider(serviceConfig);
  }

  @override
  AuthInterceptorProvider getProviderOverride(
    covariant AuthInterceptorProvider provider,
  ) {
    return call(provider.serviceConfig);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'authInterceptorProvider';
}

/// Provider for auth interceptor
///
/// Copied from [authInterceptor].
class AuthInterceptorProvider extends AutoDisposeProvider<AuthInterceptor> {
  /// Provider for auth interceptor
  ///
  /// Copied from [authInterceptor].
  AuthInterceptorProvider(ServiceConfig serviceConfig)
    : this._internal(
        (ref) => authInterceptor(ref as AuthInterceptorRef, serviceConfig),
        from: authInterceptorProvider,
        name: r'authInterceptorProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$authInterceptorHash,
        dependencies: AuthInterceptorFamily._dependencies,
        allTransitiveDependencies:
            AuthInterceptorFamily._allTransitiveDependencies,
        serviceConfig: serviceConfig,
      );

  AuthInterceptorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serviceConfig,
  }) : super.internal();

  final ServiceConfig serviceConfig;

  @override
  Override overrideWith(
    AuthInterceptor Function(AuthInterceptorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthInterceptorProvider._internal(
        (ref) => create(ref as AuthInterceptorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serviceConfig: serviceConfig,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AuthInterceptor> createElement() {
    return _AuthInterceptorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthInterceptorProvider &&
        other.serviceConfig == serviceConfig;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceConfig.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AuthInterceptorRef on AutoDisposeProviderRef<AuthInterceptor> {
  /// The parameter `serviceConfig` of this provider.
  ServiceConfig get serviceConfig;
}

class _AuthInterceptorProviderElement
    extends AutoDisposeProviderElement<AuthInterceptor>
    with AuthInterceptorRef {
  _AuthInterceptorProviderElement(super.provider);

  @override
  ServiceConfig get serviceConfig =>
      (origin as AuthInterceptorProvider).serviceConfig;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
