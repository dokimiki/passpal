import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:passpal/core/theme/builders/theme_builder.dart';
import 'package:passpal/core/theme/extensions/elevation_tokens.dart';
import 'package:passpal/core/theme/extensions/motion_tokens.dart';
import 'package:passpal/core/theme/extensions/radius_tokens.dart';
import 'package:passpal/core/theme/extensions/spacing_tokens.dart';
import 'package:passpal/core/theme/extensions/status_colors.dart';
import 'package:passpal/core/theme/providers/theme_mode_provider.dart';
import 'package:passpal/core/theme/providers/theme_providers.dart';

/// Mock theme mode notifier that returns light mode
class MockLightThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    return ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncValue.data(mode);
  }
}

/// Mock theme mode notifier that returns dark mode
class MockDarkThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    return ThemeMode.dark;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncValue.data(mode);
  }
}

/// Mock theme mode notifier that returns system mode
class MockSystemThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncValue.data(mode);
  }
}

/// Mock theme mode notifier with loading state
class MockLoadingThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    // Never complete to simulate loading state
    await Future.delayed(const Duration(seconds: 10));
    return ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 100));
    state = AsyncValue.data(mode);
  }
}

/// Mock theme mode notifier that throws an error
class MockErrorThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    throw Exception('Test theme mode error');
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    throw Exception('Test theme mode update error');
  }
}

/// Test theme factory methods
ThemeData getTestLightTheme() {
  return ThemeBuilder.buildTheme(Brightness.light);
}

ThemeData getTestDarkTheme() {
  return ThemeBuilder.buildTheme(Brightness.dark);
}

/// Custom test theme with specific properties
ThemeData getTestCustomTheme({
  Brightness? brightness,
  ColorScheme? colorScheme,
  TextTheme? textTheme,
}) {
  final baseBrightness = brightness ?? Brightness.light;
  final baseTheme = ThemeBuilder.buildTheme(baseBrightness);

  return baseTheme.copyWith(
    brightness: baseBrightness,
    colorScheme: colorScheme ?? baseTheme.colorScheme,
    textTheme: textTheme ?? baseTheme.textTheme,
  );
}

/// Provider container override utilities for testing
class TestThemeProviderOverrides {
  /// Create overrides for basic theme testing with light theme
  static List<Override> lightTheme() {
    return [
      lightThemeProvider.overrideWith((ref) => getTestLightTheme()),
      darkThemeProvider.overrideWith((ref) => getTestDarkTheme()),
      currentThemeDataProvider.overrideWith((ref) => getTestLightTheme()),
      // Note: Skip theme mode notifier override as it requires complex async notifier mocking
      effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.light),
      systemBrightnessProvider.overrideWith((ref) => Brightness.light),
      isDarkModeProvider.overrideWith((ref) => false),
      isThemeInitializedProvider.overrideWith((ref) => true),
    ];
  }

  /// Create overrides for basic theme testing with dark theme
  static List<Override> darkTheme() {
    return [
      lightThemeProvider.overrideWith((ref) => getTestLightTheme()),
      darkThemeProvider.overrideWith((ref) => getTestDarkTheme()),
      currentThemeDataProvider.overrideWith((ref) => getTestDarkTheme()),
      // Note: Skip theme mode notifier override as it requires complex async notifier mocking
      effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.dark),
      systemBrightnessProvider.overrideWith((ref) => Brightness.dark),
      isDarkModeProvider.overrideWith((ref) => true),
      isThemeInitializedProvider.overrideWith((ref) => true),
    ];
  }

  /// Create overrides for system theme mode testing
  static List<Override> systemTheme({
    Brightness systemBrightness = Brightness.light,
  }) {
    return [
      lightThemeProvider.overrideWith((ref) => getTestLightTheme()),
      darkThemeProvider.overrideWith((ref) => getTestDarkTheme()),
      currentThemeDataProvider.overrideWith(
        (ref) => systemBrightness == Brightness.dark
            ? getTestDarkTheme()
            : getTestLightTheme(),
      ),
      // Note: Skip theme mode notifier override as it requires complex async notifier mocking
      effectiveThemeModeProvider.overrideWith(
        (ref) => systemBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
      ),
      systemBrightnessProvider.overrideWith((ref) => systemBrightness),
      isDarkModeProvider.overrideWith(
        (ref) => systemBrightness == Brightness.dark,
      ),
      isThemeInitializedProvider.overrideWith((ref) => true),
    ];
  }

  /// Create overrides for loading state testing
  static List<Override> loading() {
    return [
      lightThemeProvider.overrideWith((ref) => getTestLightTheme()),
      darkThemeProvider.overrideWith((ref) => getTestDarkTheme()),
      currentThemeDataProvider.overrideWith((ref) => getTestLightTheme()),
      // Note: Skip theme mode notifier override as it requires complex async notifier mocking
      effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.light),
      systemBrightnessProvider.overrideWith((ref) => Brightness.light),
      isDarkModeProvider.overrideWith((ref) => false),
      isThemeInitializedProvider.overrideWith((ref) => false),
    ];
  }

  /// Create overrides for error state testing
  static List<Override> error() {
    return [
      lightThemeProvider.overrideWith((ref) => getTestLightTheme()),
      darkThemeProvider.overrideWith((ref) => getTestDarkTheme()),
      currentThemeDataProvider.overrideWith((ref) => getTestLightTheme()),
      // Note: Skip theme mode notifier override as it requires complex async notifier mocking
      effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.light),
      systemBrightnessProvider.overrideWith((ref) => Brightness.light),
      isDarkModeProvider.overrideWith((ref) => false),
      isThemeInitializedProvider.overrideWith((ref) => false),
    ];
  }

  /// Create overrides with custom theme data
  static List<Override> custom(
    ThemeData lightTheme,
    ThemeData darkTheme, {
    ThemeMode mode = ThemeMode.light,
  }) {
    return [
      lightThemeProvider.overrideWith((ref) => lightTheme),
      darkThemeProvider.overrideWith((ref) => darkTheme),
      currentThemeDataProvider.overrideWith(
        (ref) => mode == ThemeMode.dark ? darkTheme : lightTheme,
      ),
      effectiveThemeModeProvider.overrideWith((ref) => mode),
      systemBrightnessProvider.overrideWith(
        (ref) => mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      ),
      isDarkModeProvider.overrideWith((ref) => mode == ThemeMode.dark),
      isThemeInitializedProvider.overrideWith((ref) => true),
    ];
  }

  /// Create overrides for extension testing
  static List<Override> extensions() {
    final lightTheme = getTestLightTheme();
    return [
      ...TestThemeProviderOverrides.lightTheme(),
      statusColorsProvider.overrideWith(
        (ref) => lightTheme.extension<StatusColors>()!,
      ),
      spacingProvider.overrideWith(
        (ref) => lightTheme.extension<SpacingTokensExtension>()!,
      ),
      radiusProvider.overrideWith(
        (ref) => lightTheme.extension<RadiusTokensExtension>()!,
      ),
      elevationProvider.overrideWith(
        (ref) => lightTheme.extension<ElevationTokensExtension>()!,
      ),
      motionProvider.overrideWith(
        (ref) => lightTheme.extension<MotionTokensExtension>()!,
      ),
    ];
  }

  /// Create overrides for integration testing
  static List<Override> integration() {
    return [...TestThemeProviderOverrides.lightTheme(), ...extensions()];
  }
}

/// Test theme scenarios for different testing needs
class TestThemeScenarios {
  /// Light theme configuration for testing
  static TestThemeConfig light() {
    return TestThemeConfig(
      brightness: Brightness.light,
      themeMode: ThemeMode.light,
      theme: getTestLightTheme(),
      isDarkMode: false,
    );
  }

  /// Dark theme configuration for testing
  static TestThemeConfig dark() {
    return TestThemeConfig(
      brightness: Brightness.dark,
      themeMode: ThemeMode.dark,
      theme: getTestDarkTheme(),
      isDarkMode: true,
    );
  }

  /// System theme configuration with light system brightness
  static TestThemeConfig systemLight() {
    return TestThemeConfig(
      brightness: Brightness.light,
      themeMode: ThemeMode.system,
      theme: getTestLightTheme(),
      isDarkMode: false,
    );
  }

  /// System theme configuration with dark system brightness
  static TestThemeConfig systemDark() {
    return TestThemeConfig(
      brightness: Brightness.dark,
      themeMode: ThemeMode.system,
      theme: getTestDarkTheme(),
      isDarkMode: true,
    );
  }

  /// High contrast theme configuration
  static TestThemeConfig highContrast() {
    return TestThemeConfig(
      brightness: Brightness.light,
      themeMode: ThemeMode.light,
      theme: getTestCustomTheme(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB1BCD9),
          brightness: Brightness.light,
          contrastLevel: 1.0, // Maximum contrast
        ),
      ),
      isDarkMode: false,
    );
  }

  /// Custom theme configuration
  static TestThemeConfig custom({
    required Brightness brightness,
    required ThemeMode themeMode,
    ColorScheme? colorScheme,
    TextTheme? textTheme,
  }) {
    return TestThemeConfig(
      brightness: brightness,
      themeMode: themeMode,
      theme: getTestCustomTheme(
        brightness: brightness,
        colorScheme: colorScheme,
        textTheme: textTheme,
      ),
      isDarkMode: brightness == Brightness.dark,
    );
  }
}

/// Test theme configuration model
class TestThemeConfig {
  const TestThemeConfig({
    required this.brightness,
    required this.themeMode,
    required this.theme,
    required this.isDarkMode,
  });

  final Brightness brightness;
  final ThemeMode themeMode;
  final ThemeData theme;
  final bool isDarkMode;

  /// Get provider overrides for this theme configuration
  List<Override> get overrides {
    return TestThemeProviderOverrides.custom(
      brightness == Brightness.light ? getTestLightTheme() : getTestDarkTheme(),
      brightness == Brightness.dark ? getTestDarkTheme() : getTestLightTheme(),
      mode: themeMode == ThemeMode.system
          ? (brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light)
          : themeMode,
    );
  }
}

/// Mock theme notifier for advanced testing scenarios
class MockThemeNotifier extends StateNotifier<AsyncValue<ThemeMode>> {
  MockThemeNotifier({ThemeMode initialMode = ThemeMode.light})
    : super(AsyncValue.data(initialMode));

  void setThemeMode(ThemeMode mode) {
    state = AsyncValue.data(mode);
  }

  void setLoading() {
    state = const AsyncValue.loading();
  }

  void setError(Object error, [StackTrace? stackTrace]) {
    state = AsyncValue.error(error, stackTrace ?? StackTrace.current);
  }

  Future<void> simulateThemeSwitch() async {
    final currentMode = state.value ?? ThemeMode.light;
    setLoading();
    await Future.delayed(const Duration(milliseconds: 100));

    final newMode = currentMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    setThemeMode(newMode);
  }
}

/// Mock accessibility settings notifier for testing accessibility-aware themes
class MockAccessibilitySettingsNotifier extends StateNotifier<bool> {
  MockAccessibilitySettingsNotifier({bool highContrast = false})
    : super(highContrast);

  void toggleHighContrast() {
    state = !state;
  }

  void setHighContrast(bool value) {
    state = value;
  }
}

/// Mock theme testing utilities
class MockThemeTestUtils {
  /// Creates a test ProviderContainer with basic theme overrides
  static ProviderContainer createTestContainer({
    TestThemeConfig? config,
    List<Override>? additionalOverrides,
  }) {
    final themeConfig = config ?? TestThemeScenarios.light();
    final overrides = [
      ...themeConfig.overrides,
      if (additionalOverrides != null) ...additionalOverrides,
    ];

    return ProviderContainer(overrides: overrides);
  }

  /// Creates a test widget with theme providers
  static Widget wrapWithTheme(
    Widget child, {
    TestThemeConfig? config,
    List<Override>? additionalOverrides,
  }) {
    return UncontrolledProviderScope(
      container: createTestContainer(
        config: config,
        additionalOverrides: additionalOverrides,
      ),
      child: Builder(
        builder: (context) {
          return Consumer(
            builder: (context, ref, _) {
              final theme = ref.watch(currentThemeDataProvider);
              return Theme(data: theme, child: child);
            },
          );
        },
      ),
    );
  }

  /// Simulate theme mode change in tests
  static Future<void> simulateThemeChange(
    ProviderContainer container,
    ThemeMode newMode,
  ) async {
    final notifier = container.read(themeModeNotifierProvider.notifier);
    await notifier.setThemeMode(newMode);
  }

  /// Get all theme extensions for testing
  static Map<Type, ThemeExtension> getAllExtensions(ThemeData theme) {
    return {
      StatusColors: theme.extension<StatusColors>()!,
      SpacingTokensExtension: theme.extension<SpacingTokensExtension>()!,
      RadiusTokensExtension: theme.extension<RadiusTokensExtension>()!,
      ElevationTokensExtension: theme.extension<ElevationTokensExtension>()!,
      MotionTokensExtension: theme.extension<MotionTokensExtension>()!,
    };
  }

  /// Validate theme completeness
  static void validateTheme(ThemeData theme) {
    // Check that all required extensions are present
    final extensions = getAllExtensions(theme);
    assert(extensions.length == 5, 'Missing theme extensions');

    // Check basic theme properties
    assert(theme.colorScheme.runtimeType != Null, 'ColorScheme is null');
    assert(theme.textTheme.runtimeType != Null, 'TextTheme is null');
    assert(theme.useMaterial3 == true, 'Material 3 not enabled');
  }
}
