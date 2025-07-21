// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lightThemeHash() => r'4bc5571c692fe545ea838771fc13cd91e8ff5fdc';

/// Provider for light theme data.
///
/// Generates a complete ThemeData with Material 3 configuration,
/// all theme extensions, and light mode color scheme.
///
/// Copied from [lightTheme].
@ProviderFor(lightTheme)
final lightThemeProvider = AutoDisposeProvider<ThemeData>.internal(
  lightTheme,
  name: r'lightThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lightThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LightThemeRef = AutoDisposeProviderRef<ThemeData>;
String _$darkThemeHash() => r'f0f87b23c4d3ea6db0e580f7184c4aea2f2f00c7';

/// Provider for dark theme data.
///
/// Generates a complete ThemeData with Material 3 configuration,
/// all theme extensions, and dark mode color scheme.
///
/// Copied from [darkTheme].
@ProviderFor(darkTheme)
final darkThemeProvider = AutoDisposeProvider<ThemeData>.internal(
  darkTheme,
  name: r'darkThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$darkThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DarkThemeRef = AutoDisposeProviderRef<ThemeData>;
String _$currentThemeDataHash() => r'd84c3c557d074af4b4d2d811d8bd7df7971e5f37';

/// Provider for current theme data based on effective theme mode.
///
/// Automatically switches between light and dark themes based on
/// the current effective theme mode (resolving system mode).
///
/// Copied from [currentThemeData].
@ProviderFor(currentThemeData)
final currentThemeDataProvider = AutoDisposeProvider<ThemeData>.internal(
  currentThemeData,
  name: r'currentThemeDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentThemeDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentThemeDataRef = AutoDisposeProviderRef<ThemeData>;
String _$statusColorsHash() => r'c031683d4363f8e11bb32dae6f54648cc04170ab';

/// Provider for StatusColors extension from current theme.
///
/// Provides easy access to status colors (success, warning, error, info)
/// without needing to manually extract from theme extensions.
///
/// Copied from [statusColors].
@ProviderFor(statusColors)
final statusColorsProvider = AutoDisposeProvider<StatusColors>.internal(
  statusColors,
  name: r'statusColorsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statusColorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatusColorsRef = AutoDisposeProviderRef<StatusColors>;
String _$spacingHash() => r'e839243ef7c0274be87e043ffc89caaa0f03f91c';

/// Provider for SpacingTokensExtension from current theme.
///
/// Provides easy access to spacing tokens and utilities
/// without needing to manually extract from theme extensions.
///
/// Copied from [spacing].
@ProviderFor(spacing)
final spacingProvider = AutoDisposeProvider<SpacingTokensExtension>.internal(
  spacing,
  name: r'spacingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$spacingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SpacingRef = AutoDisposeProviderRef<SpacingTokensExtension>;
String _$radiusHash() => r'de2c0dc85d7ebf77839a226caaed47ede04034b8';

/// Provider for RadiusTokensExtension from current theme.
///
/// Provides easy access to border radius tokens and utilities
/// without needing to manually extract from theme extensions.
///
/// Copied from [radius].
@ProviderFor(radius)
final radiusProvider = AutoDisposeProvider<RadiusTokensExtension>.internal(
  radius,
  name: r'radiusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$radiusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RadiusRef = AutoDisposeProviderRef<RadiusTokensExtension>;
String _$elevationHash() => r'5bb8d936faf6f807df73e553cad8af20cd277fd5';

/// Provider for ElevationTokensExtension from current theme.
///
/// Provides easy access to elevation tokens and utilities
/// without needing to manually extract from theme extensions.
///
/// Copied from [elevation].
@ProviderFor(elevation)
final elevationProvider =
    AutoDisposeProvider<ElevationTokensExtension>.internal(
      elevation,
      name: r'elevationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$elevationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ElevationRef = AutoDisposeProviderRef<ElevationTokensExtension>;
String _$motionHash() => r'c4ee3d45bc7dfa00c7afd69f9e8ccab309a16de6';

/// Provider for MotionTokensExtension from current theme.
///
/// Provides easy access to motion tokens and utilities
/// without needing to manually extract from theme extensions.
///
/// Copied from [motion].
@ProviderFor(motion)
final motionProvider = AutoDisposeProvider<MotionTokensExtension>.internal(
  motion,
  name: r'motionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$motionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MotionRef = AutoDisposeProviderRef<MotionTokensExtension>;
String _$isThemeInitializedHash() =>
    r'f1a653f34a57ea582df70bd94a4938614f02c5ad';

/// Provider for theme initialization status.
///
/// Tracks whether the theme system has been properly initialized
/// and is ready for use. Useful for splash screens or loading states.
///
/// Copied from [isThemeInitialized].
@ProviderFor(isThemeInitialized)
final isThemeInitializedProvider = AutoDisposeProvider<bool>.internal(
  isThemeInitialized,
  name: r'isThemeInitializedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isThemeInitializedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsThemeInitializedRef = AutoDisposeProviderRef<bool>;
String _$themeBrightnessHash() => r'94afa12fc44660a7673da051695be25569f19859';

/// Provider for theme brightness information.
///
/// Returns the current brightness of the active theme,
/// useful for conditional UI elements or icons.
///
/// Copied from [themeBrightness].
@ProviderFor(themeBrightness)
final themeBrightnessProvider = AutoDisposeProvider<Brightness>.internal(
  themeBrightness,
  name: r'themeBrightnessProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeBrightnessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeBrightnessRef = AutoDisposeProviderRef<Brightness>;
String _$themeColorSchemeHash() => r'633ff35aa63c739e5f8062ab94cbe3c11253476e';

/// Provider for theme color scheme.
///
/// Provides direct access to the current color scheme
/// for advanced color operations or custom components.
///
/// Copied from [themeColorScheme].
@ProviderFor(themeColorScheme)
final themeColorSchemeProvider = AutoDisposeProvider<ColorScheme>.internal(
  themeColorScheme,
  name: r'themeColorSchemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeColorSchemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeColorSchemeRef = AutoDisposeProviderRef<ColorScheme>;
String _$themeTextThemeHash() => r'25fa06577675fa5f91f5f7524e78c98db90cce04';

/// Provider for theme text theme.
///
/// Provides direct access to the current text theme
/// for typography operations or custom text widgets.
///
/// Copied from [themeTextTheme].
@ProviderFor(themeTextTheme)
final themeTextThemeProvider = AutoDisposeProvider<TextTheme>.internal(
  themeTextTheme,
  name: r'themeTextThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeTextThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeTextThemeRef = AutoDisposeProviderRef<TextTheme>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
