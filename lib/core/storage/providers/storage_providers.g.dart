// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$secureStorageHash() => r'91ff96d70ea48be516d64f8854e0effd9a7f5b1f';

/// Provider for SecureStorage implementation
///
/// Provides secure storage for sensitive data using platform-specific
/// secure storage mechanisms (iOS Keychain, Android Keystore).
///
/// Copied from [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider = Provider<SecureStorageInterface>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageRef = ProviderRef<SecureStorageInterface>;
String _$sharedPreferencesHash() => r'50d46e3f8d9f32715d0f3efabdce724e4b2593b4';

/// Provider for SharedPreferences instance
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = FutureProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = FutureProviderRef<SharedPreferences>;
String _$cacheStorageHash() => r'352741a79cf5abaa4d3ae0e2ac745d4b7e9b2220';

/// Provider for CacheStorage implementation
///
/// Provides cache storage with TTL, capacity management, and reactive updates.
///
/// Copied from [cacheStorage].
@ProviderFor(cacheStorage)
final cacheStorageProvider = FutureProvider<CacheStorageInterface>.internal(
  cacheStorage,
  name: r'cacheStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cacheStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheStorageRef = FutureProviderRef<CacheStorageInterface>;
String _$preferenceStorageHash() => r'494e1ed0554a1bc4b2462e3a27a6e4975a0d96c1';

/// Provider for PreferenceStorage implementation
///
/// Provides app preferences storage with typed access and reactive updates.
///
/// Copied from [preferenceStorage].
@ProviderFor(preferenceStorage)
final preferenceStorageProvider =
    FutureProvider<PreferenceStorageInterface>.internal(
      preferenceStorage,
      name: r'preferenceStorageProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$preferenceStorageHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PreferenceStorageRef = FutureProviderRef<PreferenceStorageInterface>;
String _$cacheManagerHash() => r'eead6a750f85ea37d1b9894cd8bc6a1b52bba8bc';

/// Provider for CacheManager
///
/// Provides advanced cache management with capacity limits, LRU cleanup,
/// and SWR (Stale-While-Revalidate) strategies.
///
/// Copied from [cacheManager].
@ProviderFor(cacheManager)
final cacheManagerProvider = FutureProvider<CacheManager>.internal(
  cacheManager,
  name: r'cacheManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cacheManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheManagerRef = FutureProviderRef<CacheManager>;
String _$credentialManagerHash() => r'0e290c0faa70fca48634fe9d6ea4d3664dbd71ec';

/// Provider for CredentialManager
///
/// Provides specialized credential handling with auto-invalidation
/// and integration with authentication systems.
///
/// Copied from [credentialManager].
@ProviderFor(credentialManager)
final credentialManagerProvider = Provider<CredentialManager>.internal(
  credentialManager,
  name: r'credentialManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$credentialManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CredentialManagerRef = ProviderRef<CredentialManager>;
String _$migrationManagerHash() => r'5d3e53f44908e9d4b0648f44dcd947dbd01d9f6d';

/// Provider for MigrationManager
///
/// Provides storage schema migration and version tracking.
///
/// Copied from [migrationManager].
@ProviderFor(migrationManager)
final migrationManagerProvider = FutureProvider<MigrationManager>.internal(
  migrationManager,
  name: r'migrationManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$migrationManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MigrationManagerRef = FutureProviderRef<MigrationManager>;
String _$initializeStorageHash() => r'0f4b559c93222946c81e2bcc7f0ea19595b08b9b';

/// Initialize storage system
///
/// This provider handles the initialization of the storage system
/// and should be called during app startup.
///
/// Copied from [initializeStorage].
@ProviderFor(initializeStorage)
final initializeStorageProvider = AutoDisposeFutureProvider<void>.internal(
  initializeStorage,
  name: r'initializeStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$initializeStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InitializeStorageRef = AutoDisposeFutureProviderRef<void>;
String _$cachedDataHash() => r'348ae9bc3b8032864802e01b71ba9678fc618338';

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

/// Typed cache access providers
/// These provide type-safe access to specific cache entries
/// Provider for getting cached data with type safety
///
/// Copied from [cachedData].
@ProviderFor(cachedData)
const cachedDataProvider = CachedDataFamily();

/// Typed cache access providers
/// These provide type-safe access to specific cache entries
/// Provider for getting cached data with type safety
///
/// Copied from [cachedData].
class CachedDataFamily extends Family<AsyncValue<Object?>> {
  /// Typed cache access providers
  /// These provide type-safe access to specific cache entries
  /// Provider for getting cached data with type safety
  ///
  /// Copied from [cachedData].
  const CachedDataFamily();

  /// Typed cache access providers
  /// These provide type-safe access to specific cache entries
  /// Provider for getting cached data with type safety
  ///
  /// Copied from [cachedData].
  CachedDataProvider call(String key) {
    return CachedDataProvider(key);
  }

  @override
  CachedDataProvider getProviderOverride(
    covariant CachedDataProvider provider,
  ) {
    return call(provider.key);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cachedDataProvider';
}

/// Typed cache access providers
/// These provide type-safe access to specific cache entries
/// Provider for getting cached data with type safety
///
/// Copied from [cachedData].
class CachedDataProvider extends AutoDisposeFutureProvider<Object?> {
  /// Typed cache access providers
  /// These provide type-safe access to specific cache entries
  /// Provider for getting cached data with type safety
  ///
  /// Copied from [cachedData].
  CachedDataProvider(String key)
    : this._internal(
        (ref) => cachedData(ref as CachedDataRef, key),
        from: cachedDataProvider,
        name: r'cachedDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$cachedDataHash,
        dependencies: CachedDataFamily._dependencies,
        allTransitiveDependencies: CachedDataFamily._allTransitiveDependencies,
        key: key,
      );

  CachedDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final String key;

  @override
  Override overrideWith(
    FutureOr<Object?> Function(CachedDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CachedDataProvider._internal(
        (ref) => create(ref as CachedDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Object?> createElement() {
    return _CachedDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CachedDataProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CachedDataRef on AutoDisposeFutureProviderRef<Object?> {
  /// The parameter `key` of this provider.
  String get key;
}

class _CachedDataProviderElement
    extends AutoDisposeFutureProviderElement<Object?>
    with CachedDataRef {
  _CachedDataProviderElement(super.provider);

  @override
  String get key => (origin as CachedDataProvider).key;
}

String _$hasCachedDataHash() => r'595fddec0700da3ee4e2578d15b0be3cc0878b18';

/// Provider for checking if cache has valid data
///
/// Copied from [hasCachedData].
@ProviderFor(hasCachedData)
const hasCachedDataProvider = HasCachedDataFamily();

/// Provider for checking if cache has valid data
///
/// Copied from [hasCachedData].
class HasCachedDataFamily extends Family<AsyncValue<bool>> {
  /// Provider for checking if cache has valid data
  ///
  /// Copied from [hasCachedData].
  const HasCachedDataFamily();

  /// Provider for checking if cache has valid data
  ///
  /// Copied from [hasCachedData].
  HasCachedDataProvider call(String key) {
    return HasCachedDataProvider(key);
  }

  @override
  HasCachedDataProvider getProviderOverride(
    covariant HasCachedDataProvider provider,
  ) {
    return call(provider.key);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hasCachedDataProvider';
}

/// Provider for checking if cache has valid data
///
/// Copied from [hasCachedData].
class HasCachedDataProvider extends AutoDisposeFutureProvider<bool> {
  /// Provider for checking if cache has valid data
  ///
  /// Copied from [hasCachedData].
  HasCachedDataProvider(String key)
    : this._internal(
        (ref) => hasCachedData(ref as HasCachedDataRef, key),
        from: hasCachedDataProvider,
        name: r'hasCachedDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$hasCachedDataHash,
        dependencies: HasCachedDataFamily._dependencies,
        allTransitiveDependencies:
            HasCachedDataFamily._allTransitiveDependencies,
        key: key,
      );

  HasCachedDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final String key;

  @override
  Override overrideWith(
    FutureOr<bool> Function(HasCachedDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HasCachedDataProvider._internal(
        (ref) => create(ref as HasCachedDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _HasCachedDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasCachedDataProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HasCachedDataRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `key` of this provider.
  String get key;
}

class _HasCachedDataProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with HasCachedDataRef {
  _HasCachedDataProviderElement(super.provider);

  @override
  String get key => (origin as HasCachedDataProvider).key;
}

String _$invalidateCacheHash() => r'9592abae8ebbe1e77524b5a9b11982330b00f73e';

/// Provider for cache invalidation
///
/// Copied from [invalidateCache].
@ProviderFor(invalidateCache)
const invalidateCacheProvider = InvalidateCacheFamily();

/// Provider for cache invalidation
///
/// Copied from [invalidateCache].
class InvalidateCacheFamily extends Family<AsyncValue<void>> {
  /// Provider for cache invalidation
  ///
  /// Copied from [invalidateCache].
  const InvalidateCacheFamily();

  /// Provider for cache invalidation
  ///
  /// Copied from [invalidateCache].
  InvalidateCacheProvider call(String key) {
    return InvalidateCacheProvider(key);
  }

  @override
  InvalidateCacheProvider getProviderOverride(
    covariant InvalidateCacheProvider provider,
  ) {
    return call(provider.key);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'invalidateCacheProvider';
}

/// Provider for cache invalidation
///
/// Copied from [invalidateCache].
class InvalidateCacheProvider extends AutoDisposeFutureProvider<void> {
  /// Provider for cache invalidation
  ///
  /// Copied from [invalidateCache].
  InvalidateCacheProvider(String key)
    : this._internal(
        (ref) => invalidateCache(ref as InvalidateCacheRef, key),
        from: invalidateCacheProvider,
        name: r'invalidateCacheProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$invalidateCacheHash,
        dependencies: InvalidateCacheFamily._dependencies,
        allTransitiveDependencies:
            InvalidateCacheFamily._allTransitiveDependencies,
        key: key,
      );

  InvalidateCacheProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final String key;

  @override
  Override overrideWith(
    FutureOr<void> Function(InvalidateCacheRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvalidateCacheProvider._internal(
        (ref) => create(ref as InvalidateCacheRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _InvalidateCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvalidateCacheProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InvalidateCacheRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `key` of this provider.
  String get key;
}

class _InvalidateCacheProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with InvalidateCacheRef {
  _InvalidateCacheProviderElement(super.provider);

  @override
  String get key => (origin as InvalidateCacheProvider).key;
}

String _$clearAllCacheHash() => r'6202c4b0831bf9d1f86ec219a00333f51df4a72c';

/// Provider for clearing all cache
///
/// Copied from [clearAllCache].
@ProviderFor(clearAllCache)
final clearAllCacheProvider = AutoDisposeFutureProvider<void>.internal(
  clearAllCache,
  name: r'clearAllCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearAllCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClearAllCacheRef = AutoDisposeFutureProviderRef<void>;
String _$themeModeHash() => r'93ed7da78857fd02453741becc7a83f2bf40de63';

/// Preference access providers
/// These provide reactive access to app preferences
/// Provider for theme mode preference
///
/// Copied from [themeMode].
@ProviderFor(themeMode)
final themeModeProvider = AutoDisposeFutureProvider<ThemeMode>.internal(
  themeMode,
  name: r'themeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeModeRef = AutoDisposeFutureProviderRef<ThemeMode>;
String _$selectedCampusHash() => r'cf1ae328bb2584ef3866d9f2ca352f8a89d865a2';

/// Provider for campus preference
///
/// Copied from [selectedCampus].
@ProviderFor(selectedCampus)
final selectedCampusProvider = AutoDisposeFutureProvider<Campus>.internal(
  selectedCampus,
  name: r'selectedCampusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCampusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedCampusRef = AutoDisposeFutureProviderRef<Campus>;
String _$assignmentNotificationsHash() =>
    r'736aa0d6eb855c07f2c82926721041860459a4c0';

/// Provider for assignment notifications preference
///
/// Copied from [assignmentNotifications].
@ProviderFor(assignmentNotifications)
final assignmentNotificationsProvider =
    AutoDisposeFutureProvider<bool>.internal(
      assignmentNotifications,
      name: r'assignmentNotificationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$assignmentNotificationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AssignmentNotificationsRef = AutoDisposeFutureProviderRef<bool>;
String _$notificationFrequencyHash() =>
    r'512572b9b04ce013ed435082c795b9621a63d071';

/// Provider for notification frequency preference
///
/// Copied from [notificationFrequency].
@ProviderFor(notificationFrequency)
final notificationFrequencyProvider =
    AutoDisposeFutureProvider<NotificationFrequency>.internal(
      notificationFrequency,
      name: r'notificationFrequencyProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationFrequencyHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationFrequencyRef =
    AutoDisposeFutureProviderRef<NotificationFrequency>;
String _$updateThemeModeHash() => r'55c4d4867f3b37d8b817089d5a4b9c62c40fdb0f';

/// Provider for updating theme preference
///
/// Copied from [updateThemeMode].
@ProviderFor(updateThemeMode)
const updateThemeModeProvider = UpdateThemeModeFamily();

/// Provider for updating theme preference
///
/// Copied from [updateThemeMode].
class UpdateThemeModeFamily extends Family<AsyncValue<void>> {
  /// Provider for updating theme preference
  ///
  /// Copied from [updateThemeMode].
  const UpdateThemeModeFamily();

  /// Provider for updating theme preference
  ///
  /// Copied from [updateThemeMode].
  UpdateThemeModeProvider call(ThemeMode theme) {
    return UpdateThemeModeProvider(theme);
  }

  @override
  UpdateThemeModeProvider getProviderOverride(
    covariant UpdateThemeModeProvider provider,
  ) {
    return call(provider.theme);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateThemeModeProvider';
}

/// Provider for updating theme preference
///
/// Copied from [updateThemeMode].
class UpdateThemeModeProvider extends AutoDisposeFutureProvider<void> {
  /// Provider for updating theme preference
  ///
  /// Copied from [updateThemeMode].
  UpdateThemeModeProvider(ThemeMode theme)
    : this._internal(
        (ref) => updateThemeMode(ref as UpdateThemeModeRef, theme),
        from: updateThemeModeProvider,
        name: r'updateThemeModeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateThemeModeHash,
        dependencies: UpdateThemeModeFamily._dependencies,
        allTransitiveDependencies:
            UpdateThemeModeFamily._allTransitiveDependencies,
        theme: theme,
      );

  UpdateThemeModeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.theme,
  }) : super.internal();

  final ThemeMode theme;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateThemeModeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateThemeModeProvider._internal(
        (ref) => create(ref as UpdateThemeModeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        theme: theme,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateThemeModeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateThemeModeProvider && other.theme == theme;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, theme.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateThemeModeRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `theme` of this provider.
  ThemeMode get theme;
}

class _UpdateThemeModeProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateThemeModeRef {
  _UpdateThemeModeProviderElement(super.provider);

  @override
  ThemeMode get theme => (origin as UpdateThemeModeProvider).theme;
}

String _$updateSelectedCampusHash() =>
    r'b2c1ffbd2e5e06a324949990041d0a188c961fa3';

/// Provider for updating campus preference
///
/// Copied from [updateSelectedCampus].
@ProviderFor(updateSelectedCampus)
const updateSelectedCampusProvider = UpdateSelectedCampusFamily();

/// Provider for updating campus preference
///
/// Copied from [updateSelectedCampus].
class UpdateSelectedCampusFamily extends Family<AsyncValue<void>> {
  /// Provider for updating campus preference
  ///
  /// Copied from [updateSelectedCampus].
  const UpdateSelectedCampusFamily();

  /// Provider for updating campus preference
  ///
  /// Copied from [updateSelectedCampus].
  UpdateSelectedCampusProvider call(Campus campus) {
    return UpdateSelectedCampusProvider(campus);
  }

  @override
  UpdateSelectedCampusProvider getProviderOverride(
    covariant UpdateSelectedCampusProvider provider,
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
  String? get name => r'updateSelectedCampusProvider';
}

/// Provider for updating campus preference
///
/// Copied from [updateSelectedCampus].
class UpdateSelectedCampusProvider extends AutoDisposeFutureProvider<void> {
  /// Provider for updating campus preference
  ///
  /// Copied from [updateSelectedCampus].
  UpdateSelectedCampusProvider(Campus campus)
    : this._internal(
        (ref) => updateSelectedCampus(ref as UpdateSelectedCampusRef, campus),
        from: updateSelectedCampusProvider,
        name: r'updateSelectedCampusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateSelectedCampusHash,
        dependencies: UpdateSelectedCampusFamily._dependencies,
        allTransitiveDependencies:
            UpdateSelectedCampusFamily._allTransitiveDependencies,
        campus: campus,
      );

  UpdateSelectedCampusProvider._internal(
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
    FutureOr<void> Function(UpdateSelectedCampusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateSelectedCampusProvider._internal(
        (ref) => create(ref as UpdateSelectedCampusRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateSelectedCampusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateSelectedCampusProvider && other.campus == campus;
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
mixin UpdateSelectedCampusRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `campus` of this provider.
  Campus get campus;
}

class _UpdateSelectedCampusProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateSelectedCampusRef {
  _UpdateSelectedCampusProviderElement(super.provider);

  @override
  Campus get campus => (origin as UpdateSelectedCampusProvider).campus;
}

String _$updateAssignmentNotificationsHash() =>
    r'76b4b8d3184aeb64352099027d0faefb73da20a2';

/// Provider for updating assignment notifications
///
/// Copied from [updateAssignmentNotifications].
@ProviderFor(updateAssignmentNotifications)
const updateAssignmentNotificationsProvider =
    UpdateAssignmentNotificationsFamily();

/// Provider for updating assignment notifications
///
/// Copied from [updateAssignmentNotifications].
class UpdateAssignmentNotificationsFamily extends Family<AsyncValue<void>> {
  /// Provider for updating assignment notifications
  ///
  /// Copied from [updateAssignmentNotifications].
  const UpdateAssignmentNotificationsFamily();

  /// Provider for updating assignment notifications
  ///
  /// Copied from [updateAssignmentNotifications].
  UpdateAssignmentNotificationsProvider call(bool enabled) {
    return UpdateAssignmentNotificationsProvider(enabled);
  }

  @override
  UpdateAssignmentNotificationsProvider getProviderOverride(
    covariant UpdateAssignmentNotificationsProvider provider,
  ) {
    return call(provider.enabled);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateAssignmentNotificationsProvider';
}

/// Provider for updating assignment notifications
///
/// Copied from [updateAssignmentNotifications].
class UpdateAssignmentNotificationsProvider
    extends AutoDisposeFutureProvider<void> {
  /// Provider for updating assignment notifications
  ///
  /// Copied from [updateAssignmentNotifications].
  UpdateAssignmentNotificationsProvider(bool enabled)
    : this._internal(
        (ref) => updateAssignmentNotifications(
          ref as UpdateAssignmentNotificationsRef,
          enabled,
        ),
        from: updateAssignmentNotificationsProvider,
        name: r'updateAssignmentNotificationsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateAssignmentNotificationsHash,
        dependencies: UpdateAssignmentNotificationsFamily._dependencies,
        allTransitiveDependencies:
            UpdateAssignmentNotificationsFamily._allTransitiveDependencies,
        enabled: enabled,
      );

  UpdateAssignmentNotificationsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.enabled,
  }) : super.internal();

  final bool enabled;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateAssignmentNotificationsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateAssignmentNotificationsProvider._internal(
        (ref) => create(ref as UpdateAssignmentNotificationsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        enabled: enabled,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateAssignmentNotificationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateAssignmentNotificationsProvider &&
        other.enabled == enabled;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, enabled.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateAssignmentNotificationsRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `enabled` of this provider.
  bool get enabled;
}

class _UpdateAssignmentNotificationsProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateAssignmentNotificationsRef {
  _UpdateAssignmentNotificationsProviderElement(super.provider);

  @override
  bool get enabled => (origin as UpdateAssignmentNotificationsProvider).enabled;
}

String _$updateNotificationFrequencyHash() =>
    r'54318ccd90775109501378013f427446fa4031e9';

/// Provider for updating notification frequency
///
/// Copied from [updateNotificationFrequency].
@ProviderFor(updateNotificationFrequency)
const updateNotificationFrequencyProvider = UpdateNotificationFrequencyFamily();

/// Provider for updating notification frequency
///
/// Copied from [updateNotificationFrequency].
class UpdateNotificationFrequencyFamily extends Family<AsyncValue<void>> {
  /// Provider for updating notification frequency
  ///
  /// Copied from [updateNotificationFrequency].
  const UpdateNotificationFrequencyFamily();

  /// Provider for updating notification frequency
  ///
  /// Copied from [updateNotificationFrequency].
  UpdateNotificationFrequencyProvider call(NotificationFrequency frequency) {
    return UpdateNotificationFrequencyProvider(frequency);
  }

  @override
  UpdateNotificationFrequencyProvider getProviderOverride(
    covariant UpdateNotificationFrequencyProvider provider,
  ) {
    return call(provider.frequency);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateNotificationFrequencyProvider';
}

/// Provider for updating notification frequency
///
/// Copied from [updateNotificationFrequency].
class UpdateNotificationFrequencyProvider
    extends AutoDisposeFutureProvider<void> {
  /// Provider for updating notification frequency
  ///
  /// Copied from [updateNotificationFrequency].
  UpdateNotificationFrequencyProvider(NotificationFrequency frequency)
    : this._internal(
        (ref) => updateNotificationFrequency(
          ref as UpdateNotificationFrequencyRef,
          frequency,
        ),
        from: updateNotificationFrequencyProvider,
        name: r'updateNotificationFrequencyProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateNotificationFrequencyHash,
        dependencies: UpdateNotificationFrequencyFamily._dependencies,
        allTransitiveDependencies:
            UpdateNotificationFrequencyFamily._allTransitiveDependencies,
        frequency: frequency,
      );

  UpdateNotificationFrequencyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.frequency,
  }) : super.internal();

  final NotificationFrequency frequency;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateNotificationFrequencyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateNotificationFrequencyProvider._internal(
        (ref) => create(ref as UpdateNotificationFrequencyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        frequency: frequency,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateNotificationFrequencyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateNotificationFrequencyProvider &&
        other.frequency == frequency;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, frequency.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateNotificationFrequencyRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `frequency` of this provider.
  NotificationFrequency get frequency;
}

class _UpdateNotificationFrequencyProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateNotificationFrequencyRef {
  _UpdateNotificationFrequencyProviderElement(super.provider);

  @override
  NotificationFrequency get frequency =>
      (origin as UpdateNotificationFrequencyProvider).frequency;
}

String _$storageHealthCheckHash() =>
    r'8f6aff413db5aa06c52b453d1e4838c77b868f84';

/// Storage health check provider
///
/// Copied from [storageHealthCheck].
@ProviderFor(storageHealthCheck)
final storageHealthCheckProvider =
    AutoDisposeFutureProvider<StorageHealthStatus>.internal(
      storageHealthCheck,
      name: r'storageHealthCheckProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$storageHealthCheckHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StorageHealthCheckRef =
    AutoDisposeFutureProviderRef<StorageHealthStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
