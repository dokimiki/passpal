// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessibility_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$systemHighContrastHash() =>
    r'cff0e2620716bd7eb271de844e7a63c022fea3f3';

/// Provider for system high contrast detection.
///
/// Detects if the system has high contrast enabled and provides
/// reactive updates when the setting changes.
///
/// Copied from [systemHighContrast].
@ProviderFor(systemHighContrast)
final systemHighContrastProvider = AutoDisposeProvider<bool>.internal(
  systemHighContrast,
  name: r'systemHighContrastProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$systemHighContrastHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SystemHighContrastRef = AutoDisposeProviderRef<bool>;
String _$systemReducedMotionHash() =>
    r'a514367a7048babe3db2558e82b290b9eea09f6d';

/// Provider for system reduced motion detection.
///
/// Detects if the system has reduced motion enabled and provides
/// reactive updates when the setting changes.
///
/// Copied from [systemReducedMotion].
@ProviderFor(systemReducedMotion)
final systemReducedMotionProvider = AutoDisposeProvider<bool>.internal(
  systemReducedMotion,
  name: r'systemReducedMotionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$systemReducedMotionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SystemReducedMotionRef = AutoDisposeProviderRef<bool>;
String _$highContrastLightThemeHash() =>
    r'd9009da083af503c8c6c6bae1485c10fbd505970';

/// Provider for high contrast light theme.
///
/// Generates a high contrast variant of the light theme with
/// enhanced color contrast ratios for accessibility.
///
/// Copied from [highContrastLightTheme].
@ProviderFor(highContrastLightTheme)
final highContrastLightThemeProvider = AutoDisposeProvider<ThemeData>.internal(
  highContrastLightTheme,
  name: r'highContrastLightThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$highContrastLightThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HighContrastLightThemeRef = AutoDisposeProviderRef<ThemeData>;
String _$highContrastDarkThemeHash() =>
    r'9786dda19841772628b87bbb5e041d8c3f80bc22';

/// Provider for high contrast dark theme.
///
/// Generates a high contrast variant of the dark theme with
/// enhanced color contrast ratios for accessibility.
///
/// Copied from [highContrastDarkTheme].
@ProviderFor(highContrastDarkTheme)
final highContrastDarkThemeProvider = AutoDisposeProvider<ThemeData>.internal(
  highContrastDarkTheme,
  name: r'highContrastDarkThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$highContrastDarkThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HighContrastDarkThemeRef = AutoDisposeProviderRef<ThemeData>;
String _$accessibilityThemeDataHash() =>
    r'93c4a1c64a88bdb0423369d2cc392f375d0b07dd';

/// Provider for accessibility-aware theme data.
///
/// Returns appropriate theme based on current accessibility settings,
/// automatically switching to high contrast themes when needed.
///
/// Copied from [accessibilityThemeData].
@ProviderFor(accessibilityThemeData)
final accessibilityThemeDataProvider = AutoDisposeProvider<ThemeData>.internal(
  accessibilityThemeData,
  name: r'accessibilityThemeDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accessibilityThemeDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccessibilityThemeDataRef = AutoDisposeProviderRef<ThemeData>;
String _$isHighContrastActiveHash() =>
    r'700683ce88dda0a4821fbdc287480f39c05adfcc';

/// Provider for checking if high contrast mode is active.
///
/// Combines user preference and system settings to determine
/// if high contrast mode should be used.
///
/// Copied from [isHighContrastActive].
@ProviderFor(isHighContrastActive)
final isHighContrastActiveProvider = AutoDisposeProvider<bool>.internal(
  isHighContrastActive,
  name: r'isHighContrastActiveProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isHighContrastActiveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsHighContrastActiveRef = AutoDisposeProviderRef<bool>;
String _$isReducedMotionActiveHash() =>
    r'2a151927bd5edf7c3c9a67187d2e05052a8355aa';

/// Provider for checking if reduced motion is active.
///
/// Combines user preference and system settings to determine
/// if motion should be reduced.
///
/// Copied from [isReducedMotionActive].
@ProviderFor(isReducedMotionActive)
final isReducedMotionActiveProvider = AutoDisposeProvider<bool>.internal(
  isReducedMotionActive,
  name: r'isReducedMotionActiveProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isReducedMotionActiveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsReducedMotionActiveRef = AutoDisposeProviderRef<bool>;
String _$effectiveMotionTokensHash() =>
    r'4cba56efbdd30eb1478ebe2a024ff596d423631a';

/// Provider for effective motion tokens.
///
/// Returns appropriate motion tokens based on accessibility settings,
/// automatically switching to reduced motion variants when needed.
///
/// Copied from [effectiveMotionTokens].
@ProviderFor(effectiveMotionTokens)
final effectiveMotionTokensProvider =
    AutoDisposeProvider<MotionTokensExtension>.internal(
      effectiveMotionTokens,
      name: r'effectiveMotionTokensProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$effectiveMotionTokensHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EffectiveMotionTokensRef =
    AutoDisposeProviderRef<MotionTokensExtension>;
String _$effectiveSpacingTokensHash() =>
    r'2070b6904a59b6f0817d6e92f106aef6917ea488';

/// Provider for effective spacing tokens.
///
/// Returns appropriate spacing tokens based on accessibility settings,
/// automatically switching to expanded spacing for better touch targets.
///
/// Copied from [effectiveSpacingTokens].
@ProviderFor(effectiveSpacingTokens)
final effectiveSpacingTokensProvider =
    AutoDisposeProvider<SpacingTokensExtension>.internal(
      effectiveSpacingTokens,
      name: r'effectiveSpacingTokensProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$effectiveSpacingTokensHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EffectiveSpacingTokensRef =
    AutoDisposeProviderRef<SpacingTokensExtension>;
String _$accessibilityRecommendationsHash() =>
    r'7c0b2f32a1561d1282d3726002aabe336e9b6053';

/// Provider for accessibility theme recommendations.
///
/// Provides recommendations for theme adjustments based on
/// current accessibility needs and settings.
///
/// Copied from [accessibilityRecommendations].
@ProviderFor(accessibilityRecommendations)
final accessibilityRecommendationsProvider =
    AutoDisposeProvider<List<String>>.internal(
      accessibilityRecommendations,
      name: r'accessibilityRecommendationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accessibilityRecommendationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccessibilityRecommendationsRef = AutoDisposeProviderRef<List<String>>;
String _$colorBlindFriendlyThemeHash() =>
    r'e0098bad3fdc537decbf5330f3272440cdfdc0e1';

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

/// Provider for colorblind-friendly theme variants.
///
/// Returns a theme adapted for the specified color blind type
/// with improved color distinguishability.
///
/// Copied from [colorBlindFriendlyTheme].
@ProviderFor(colorBlindFriendlyTheme)
const colorBlindFriendlyThemeProvider = ColorBlindFriendlyThemeFamily();

/// Provider for colorblind-friendly theme variants.
///
/// Returns a theme adapted for the specified color blind type
/// with improved color distinguishability.
///
/// Copied from [colorBlindFriendlyTheme].
class ColorBlindFriendlyThemeFamily extends Family<ThemeData> {
  /// Provider for colorblind-friendly theme variants.
  ///
  /// Returns a theme adapted for the specified color blind type
  /// with improved color distinguishability.
  ///
  /// Copied from [colorBlindFriendlyTheme].
  const ColorBlindFriendlyThemeFamily();

  /// Provider for colorblind-friendly theme variants.
  ///
  /// Returns a theme adapted for the specified color blind type
  /// with improved color distinguishability.
  ///
  /// Copied from [colorBlindFriendlyTheme].
  ColorBlindFriendlyThemeProvider call(
    Brightness brightness,
    ColorBlindType colorBlindType,
  ) {
    return ColorBlindFriendlyThemeProvider(brightness, colorBlindType);
  }

  @override
  ColorBlindFriendlyThemeProvider getProviderOverride(
    covariant ColorBlindFriendlyThemeProvider provider,
  ) {
    return call(provider.brightness, provider.colorBlindType);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'colorBlindFriendlyThemeProvider';
}

/// Provider for colorblind-friendly theme variants.
///
/// Returns a theme adapted for the specified color blind type
/// with improved color distinguishability.
///
/// Copied from [colorBlindFriendlyTheme].
class ColorBlindFriendlyThemeProvider extends AutoDisposeProvider<ThemeData> {
  /// Provider for colorblind-friendly theme variants.
  ///
  /// Returns a theme adapted for the specified color blind type
  /// with improved color distinguishability.
  ///
  /// Copied from [colorBlindFriendlyTheme].
  ColorBlindFriendlyThemeProvider(
    Brightness brightness,
    ColorBlindType colorBlindType,
  ) : this._internal(
        (ref) => colorBlindFriendlyTheme(
          ref as ColorBlindFriendlyThemeRef,
          brightness,
          colorBlindType,
        ),
        from: colorBlindFriendlyThemeProvider,
        name: r'colorBlindFriendlyThemeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$colorBlindFriendlyThemeHash,
        dependencies: ColorBlindFriendlyThemeFamily._dependencies,
        allTransitiveDependencies:
            ColorBlindFriendlyThemeFamily._allTransitiveDependencies,
        brightness: brightness,
        colorBlindType: colorBlindType,
      );

  ColorBlindFriendlyThemeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brightness,
    required this.colorBlindType,
  }) : super.internal();

  final Brightness brightness;
  final ColorBlindType colorBlindType;

  @override
  Override overrideWith(
    ThemeData Function(ColorBlindFriendlyThemeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ColorBlindFriendlyThemeProvider._internal(
        (ref) => create(ref as ColorBlindFriendlyThemeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brightness: brightness,
        colorBlindType: colorBlindType,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ThemeData> createElement() {
    return _ColorBlindFriendlyThemeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ColorBlindFriendlyThemeProvider &&
        other.brightness == brightness &&
        other.colorBlindType == colorBlindType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);
    hash = _SystemHash.combine(hash, colorBlindType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ColorBlindFriendlyThemeRef on AutoDisposeProviderRef<ThemeData> {
  /// The parameter `brightness` of this provider.
  Brightness get brightness;

  /// The parameter `colorBlindType` of this provider.
  ColorBlindType get colorBlindType;
}

class _ColorBlindFriendlyThemeProviderElement
    extends AutoDisposeProviderElement<ThemeData>
    with ColorBlindFriendlyThemeRef {
  _ColorBlindFriendlyThemeProviderElement(super.provider);

  @override
  Brightness get brightness =>
      (origin as ColorBlindFriendlyThemeProvider).brightness;
  @override
  ColorBlindType get colorBlindType =>
      (origin as ColorBlindFriendlyThemeProvider).colorBlindType;
}

String _$accessibilitySettingsNotifierHash() =>
    r'fec1727b670c46c7f54d264c40190f85ed96ff2c';

/// Provider for current accessibility settings.
///
/// Combines system-detected accessibility preferences with user
/// settings to provide comprehensive accessibility configuration.
///
/// Copied from [AccessibilitySettingsNotifier].
@ProviderFor(AccessibilitySettingsNotifier)
final accessibilitySettingsNotifierProvider =
    AutoDisposeNotifierProvider<
      AccessibilitySettingsNotifier,
      AccessibilitySettings
    >.internal(
      AccessibilitySettingsNotifier.new,
      name: r'accessibilitySettingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accessibilitySettingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AccessibilitySettingsNotifier =
    AutoDisposeNotifier<AccessibilitySettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
