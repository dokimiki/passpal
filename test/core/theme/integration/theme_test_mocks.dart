/// Mock providers for theme integration tests
///
/// This file provides lightweight mock implementations to prevent
/// infinite loops and timer leaks in integration tests.
library;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:passpal/core/theme/extensions/status_colors.dart';
import 'package:passpal/core/theme/extensions/spacing_tokens.dart';
import 'package:passpal/core/theme/extensions/radius_tokens.dart';
import 'package:passpal/core/theme/providers/theme_providers.dart';
import 'package:passpal/core/theme/providers/theme_mode_provider.dart';

/// Simple mock provider for theme mode
final mockThemeModeProvider = StateProvider<ThemeMode>(
  (ref) => ThemeMode.system,
);

/// Mock providers for integration testing
final mockThemeModeNotifierProvider = StateProvider<AsyncValue<ThemeMode>>((
  ref,
) {
  return AsyncValue.data(ref.watch(mockThemeModeProvider));
});

final mockSystemBrightnessProvider = Provider<Brightness>((ref) {
  return Brightness.light;
});

final mockEffectiveThemeModeProvider = Provider<ThemeMode>((ref) {
  final asyncThemeMode = ref.watch(mockThemeModeNotifierProvider);
  return asyncThemeMode.when(
    data: (mode) {
      if (mode == ThemeMode.system) {
        final brightness = ref.watch(mockSystemBrightnessProvider);
        return brightness == Brightness.light
            ? ThemeMode.light
            : ThemeMode.dark;
      }
      return mode;
    },
    loading: () => ThemeMode.system,
    error: (_, _) => ThemeMode.system,
  );
});

final mockLightThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    extensions: [
      StatusColors.light,
      SpacingTokensExtension.standard,
      RadiusTokensExtension.standard,
    ],
  );
});

final mockDarkThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    extensions: [
      StatusColors.dark,
      SpacingTokensExtension.standard,
      RadiusTokensExtension.standard,
    ],
  );
});

final mockCurrentThemeDataProvider = Provider<ThemeData>((ref) {
  final effectiveMode = ref.watch(mockEffectiveThemeModeProvider);

  switch (effectiveMode) {
    case ThemeMode.light:
      return ref.watch(mockLightThemeProvider);
    case ThemeMode.dark:
      return ref.watch(mockDarkThemeProvider);
    case ThemeMode.system:
      final brightness = ref.watch(mockSystemBrightnessProvider);
      return brightness == Brightness.light
          ? ref.watch(mockLightThemeProvider)
          : ref.watch(mockDarkThemeProvider);
  }
});

final mockStatusColorsProvider = Provider<StatusColors>((ref) {
  final theme = ref.watch(mockCurrentThemeDataProvider);
  return theme.extension<StatusColors>() ?? StatusColors.light;
});

final mockSpacingProvider = Provider<SpacingTokensExtension>((ref) {
  final theme = ref.watch(mockCurrentThemeDataProvider);
  return theme.extension<SpacingTokensExtension>() ??
      SpacingTokensExtension.standard;
});

final mockRadiusProvider = Provider<RadiusTokensExtension>((ref) {
  final theme = ref.watch(mockCurrentThemeDataProvider);
  return theme.extension<RadiusTokensExtension>() ??
      RadiusTokensExtension.standard;
});

/// Integration test overrides
final List<Override> integrationTestOverrides = [
  // Skip theme mode notifier override - use simple values instead
  systemBrightnessProvider.overrideWith((ref) => Brightness.light),
  effectiveThemeModeProvider.overrideWith((ref) => ThemeMode.light),
  lightThemeProvider.overrideWith(
    (ref) => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      extensions: [
        StatusColors.light,
        SpacingTokensExtension.standard,
        RadiusTokensExtension.standard,
      ],
    ),
  ),
  darkThemeProvider.overrideWith(
    (ref) => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      extensions: [
        StatusColors.dark,
        SpacingTokensExtension.standard,
        RadiusTokensExtension.standard,
      ],
    ),
  ),
  currentThemeDataProvider.overrideWith(
    (ref) => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      extensions: [
        StatusColors.light,
        SpacingTokensExtension.standard,
        RadiusTokensExtension.standard,
      ],
    ),
  ),
  statusColorsProvider.overrideWith((ref) => StatusColors.light),
  spacingProvider.overrideWith((ref) => SpacingTokensExtension.standard),
  radiusProvider.overrideWith((ref) => RadiusTokensExtension.standard),
];
