// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$effectiveThemeModeHash() =>
    r'45c73f79e00031fa64fe9917b9a6f061f3acdce9';

/// Provider for effective theme mode (resolves system to light/dark)
///
/// This provider takes the theme mode preference and resolves ThemeMode.system
/// to either ThemeMode.light or ThemeMode.dark based on system brightness.
///
/// Copied from [effectiveThemeMode].
@ProviderFor(effectiveThemeMode)
final effectiveThemeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  effectiveThemeMode,
  name: r'effectiveThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$effectiveThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EffectiveThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$systemBrightnessHash() => r'b4a251528b4f4c4ffdfbc5fda4b723027221fabe';

/// Provider for current system brightness
///
/// This provider provides access to the current system brightness setting.
///
/// Copied from [systemBrightness].
@ProviderFor(systemBrightness)
final systemBrightnessProvider = AutoDisposeProvider<Brightness>.internal(
  systemBrightness,
  name: r'systemBrightnessProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$systemBrightnessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SystemBrightnessRef = AutoDisposeProviderRef<Brightness>;
String _$themeModeDisplayNameHash() =>
    r'f59c8124cc085565b94f6e3dd23030c5ec9c4371';

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

/// Provider for theme mode display name
///
/// This provider converts ThemeMode enum values to user-friendly display names.
///
/// Copied from [themeModeDisplayName].
@ProviderFor(themeModeDisplayName)
const themeModeDisplayNameProvider = ThemeModeDisplayNameFamily();

/// Provider for theme mode display name
///
/// This provider converts ThemeMode enum values to user-friendly display names.
///
/// Copied from [themeModeDisplayName].
class ThemeModeDisplayNameFamily extends Family<String> {
  /// Provider for theme mode display name
  ///
  /// This provider converts ThemeMode enum values to user-friendly display names.
  ///
  /// Copied from [themeModeDisplayName].
  const ThemeModeDisplayNameFamily();

  /// Provider for theme mode display name
  ///
  /// This provider converts ThemeMode enum values to user-friendly display names.
  ///
  /// Copied from [themeModeDisplayName].
  ThemeModeDisplayNameProvider call(ThemeMode mode) {
    return ThemeModeDisplayNameProvider(mode);
  }

  @override
  ThemeModeDisplayNameProvider getProviderOverride(
    covariant ThemeModeDisplayNameProvider provider,
  ) {
    return call(provider.mode);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'themeModeDisplayNameProvider';
}

/// Provider for theme mode display name
///
/// This provider converts ThemeMode enum values to user-friendly display names.
///
/// Copied from [themeModeDisplayName].
class ThemeModeDisplayNameProvider extends AutoDisposeProvider<String> {
  /// Provider for theme mode display name
  ///
  /// This provider converts ThemeMode enum values to user-friendly display names.
  ///
  /// Copied from [themeModeDisplayName].
  ThemeModeDisplayNameProvider(ThemeMode mode)
    : this._internal(
        (ref) => themeModeDisplayName(ref as ThemeModeDisplayNameRef, mode),
        from: themeModeDisplayNameProvider,
        name: r'themeModeDisplayNameProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$themeModeDisplayNameHash,
        dependencies: ThemeModeDisplayNameFamily._dependencies,
        allTransitiveDependencies:
            ThemeModeDisplayNameFamily._allTransitiveDependencies,
        mode: mode,
      );

  ThemeModeDisplayNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mode,
  }) : super.internal();

  final ThemeMode mode;

  @override
  Override overrideWith(
    String Function(ThemeModeDisplayNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThemeModeDisplayNameProvider._internal(
        (ref) => create(ref as ThemeModeDisplayNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mode: mode,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _ThemeModeDisplayNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeModeDisplayNameProvider && other.mode == mode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ThemeModeDisplayNameRef on AutoDisposeProviderRef<String> {
  /// The parameter `mode` of this provider.
  ThemeMode get mode;
}

class _ThemeModeDisplayNameProviderElement
    extends AutoDisposeProviderElement<String>
    with ThemeModeDisplayNameRef {
  _ThemeModeDisplayNameProviderElement(super.provider);

  @override
  ThemeMode get mode => (origin as ThemeModeDisplayNameProvider).mode;
}

String _$isDarkModeHash() => r'75574c5c5179c3b80dccfc1688e2e9e9c710d682';

/// Provider for checking if dark mode is active
///
/// This provider returns true if the effective theme mode is dark.
///
/// Copied from [isDarkMode].
@ProviderFor(isDarkMode)
final isDarkModeProvider = AutoDisposeProvider<bool>.internal(
  isDarkMode,
  name: r'isDarkModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isDarkModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsDarkModeRef = AutoDisposeProviderRef<bool>;
String _$availableThemeModesHash() =>
    r'4163dc7fdfbb80dd44dfac2f09f373672ebd5064';

/// Provider for available theme modes with display names
///
/// This provider returns a map of all available theme modes with their
/// user-friendly display names for use in settings UI.
///
/// Copied from [availableThemeModes].
@ProviderFor(availableThemeModes)
final availableThemeModesProvider =
    AutoDisposeProvider<Map<ThemeMode, String>>.internal(
      availableThemeModes,
      name: r'availableThemeModesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$availableThemeModesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AvailableThemeModesRef = AutoDisposeProviderRef<Map<ThemeMode, String>>;
String _$themeModeNotifierHash() => r'027ed66d32ff4e528c85263fd91e758b729df65f';

/// Provider for theme mode with system brightness detection
///
/// This provider integrates with the storage core to persist theme mode
/// preferences and provides system brightness detection for automatic
/// theme switching when ThemeMode.system is selected.
///
/// Copied from [ThemeModeNotifier].
@ProviderFor(ThemeModeNotifier)
final themeModeNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ThemeModeNotifier, ThemeMode>.internal(
      ThemeModeNotifier.new,
      name: r'themeModeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeModeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeModeNotifier = AutoDisposeAsyncNotifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
