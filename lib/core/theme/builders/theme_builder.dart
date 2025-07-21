import 'package:flutter/material.dart';
import '../generators/color_scheme_generator.dart';
import '../generators/typography_generator.dart';
import '../extensions/status_colors.dart';
import '../extensions/spacing_tokens.dart';
import '../extensions/radius_tokens.dart';
import '../extensions/elevation_tokens.dart';
import '../extensions/motion_tokens.dart';

/// Central theme builder for PassPal application.
///
/// Provides a unified buildTheme function that generates complete Material 3
/// themes with all custom extensions and component configurations.
///
/// Key features:
/// - Material 3 enabled with custom design tokens
/// - All theme extensions registered and configured
/// - Component-specific theme overrides
/// - Accessibility and responsive design support
class ThemeBuilder {
  const ThemeBuilder._();

  /// Builds a complete Material 3 theme for the specified brightness.
  ///
  /// Generates a ThemeData with:
  /// - Material 3 ColorScheme from design tokens
  /// - Inter font-based typography
  /// - Custom theme extensions (StatusColors, SpacingTokens, etc.)
  /// - Component theme configurations
  /// - Accessibility and responsive support
  ///
  /// Example:
  /// ```dart
  /// final lightTheme = ThemeBuilder.buildTheme(Brightness.light);
  /// final darkTheme = ThemeBuilder.buildTheme(Brightness.dark);
  /// ```
  static ThemeData buildTheme(Brightness brightness) {
    // Generate base color scheme from design tokens
    final colorScheme = brightness == Brightness.light
        ? ColorSchemeGenerator.generateLightScheme()
        : ColorSchemeGenerator.generateDarkScheme();

    // Generate typography theme
    final textTheme = TypographyGenerator.generateTextTheme(
      brightness: brightness,
      textColor: colorScheme.onSurface,
    );

    return ThemeData(
      // Material 3 configuration
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,

      // Visual density and platform adjustments
      visualDensity: VisualDensity.adaptivePlatformDensity,
      platform: TargetPlatform.android, // Primary target platform

      // Theme extensions
      extensions: <ThemeExtension<dynamic>>[
        brightness == Brightness.light ? StatusColors.light : StatusColors.dark,
        SpacingTokensExtension.standard,
        RadiusTokensExtension.standard,
        brightness == Brightness.light
            ? ElevationTokensExtension.standardLight
            : ElevationTokensExtension.standardDark,
        MotionTokensExtension.standard,
      ],

      // Component themes
      appBarTheme: _buildAppBarTheme(colorScheme, textTheme),
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),
      textButtonTheme: _buildTextButtonTheme(colorScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme),
      filledButtonTheme: _buildFilledButtonTheme(colorScheme),
      cardTheme: _buildCardTheme(colorScheme),
      snackBarTheme: _buildSnackBarTheme(colorScheme, textTheme),
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme, textTheme),
      navigationBarTheme: _buildNavigationBarTheme(colorScheme),
      navigationRailTheme: _buildNavigationRailTheme(colorScheme),
      tabBarTheme: _buildTabBarTheme(colorScheme, textTheme),
      dialogTheme: _buildDialogTheme(colorScheme, textTheme),
      bottomSheetTheme: _buildBottomSheetTheme(colorScheme),
      listTileTheme: _buildListTileTheme(colorScheme),
      chipTheme: _buildChipTheme(colorScheme, textTheme),
      dividerTheme: _buildDividerTheme(colorScheme),
      expansionTileTheme: _buildExpansionTileTheme(colorScheme),
    );
  }

  // Private helper methods for component themes
  
  static AppBarTheme _buildAppBarTheme(ColorScheme colorScheme, TextTheme textTheme) {
    return AppBarTheme(
      elevation: 0,
      surfaceTintColor: colorScheme.surfaceTint,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
        side: BorderSide(color: colorScheme.outline),
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static FilledButtonThemeData _buildFilledButtonTheme(ColorScheme colorScheme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static CardThemeData _buildCardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      elevation: 1,
      surfaceTintColor: colorScheme.surfaceTint,
      color: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
    );
  }

  static SnackBarThemeData _buildSnackBarTheme(ColorScheme colorScheme, TextTheme textTheme) {
    return SnackBarThemeData(
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onInverseSurface,
      ),
      actionTextColor: colorScheme.inversePrimary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      hintStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      labelStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.primary,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.error),
      ),
    );
  }

  static NavigationBarThemeData _buildNavigationBarTheme(ColorScheme colorScheme) {
    return NavigationBarThemeData(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      indicatorColor: colorScheme.secondaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(color: colorScheme.onSurface, fontSize: 12);
        }
        return TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12);
      }),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: colorScheme.onSecondaryContainer);
        }
        return IconThemeData(color: colorScheme.onSurfaceVariant);
      }),
    );
  }

  static NavigationRailThemeData _buildNavigationRailTheme(ColorScheme colorScheme) {
    return NavigationRailThemeData(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      indicatorColor: colorScheme.secondaryContainer,
      selectedIconTheme: IconThemeData(color: colorScheme.onSecondaryContainer),
      selectedLabelTextStyle: TextStyle(color: colorScheme.onSurface),
      unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      unselectedLabelTextStyle: TextStyle(color: colorScheme.onSurfaceVariant),
    );
  }

  static TabBarThemeData _buildTabBarTheme(ColorScheme colorScheme, TextTheme textTheme) {
    return TabBarThemeData(
      dividerColor: Colors.transparent,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      labelStyle: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle: textTheme.titleSmall,
    );
  }

  static DialogThemeData _buildDialogTheme(ColorScheme colorScheme, TextTheme textTheme) {
    return DialogThemeData(
      elevation: 6,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      titleTextStyle: textTheme.headlineSmall?.copyWith(
        color: colorScheme.onSurface,
      ),
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  static BottomSheetThemeData _buildBottomSheetTheme(ColorScheme colorScheme) {
    return BottomSheetThemeData(
      elevation: 1,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shadowColor: colorScheme.shadow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    );
  }

  static ListTileThemeData _buildListTileTheme(ColorScheme colorScheme) {
    return ListTileThemeData(
      iconColor: colorScheme.onSurfaceVariant,
      textColor: colorScheme.onSurface,
      tileColor: colorScheme.surface,
      selectedColor: colorScheme.primary,
      selectedTileColor: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static ChipThemeData _buildChipTheme(ColorScheme colorScheme, TextTheme textTheme) {
    return ChipThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      selectedColor: colorScheme.secondaryContainer,
      disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
      labelStyle: textTheme.labelLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      secondaryLabelStyle: textTheme.labelLarge?.copyWith(
        color: colorScheme.onSecondaryContainer,
      ),
      side: BorderSide(color: colorScheme.outline),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static DividerThemeData _buildDividerTheme(ColorScheme colorScheme) {
    return DividerThemeData(
      color: colorScheme.outlineVariant,
      thickness: 1,
      space: 16,
    );
  }

  static ExpansionTileThemeData _buildExpansionTileTheme(ColorScheme colorScheme) {
    return ExpansionTileThemeData(
      backgroundColor: colorScheme.surface,
      collapsedBackgroundColor: colorScheme.surface,
      iconColor: colorScheme.onSurfaceVariant,
      collapsedIconColor: colorScheme.onSurfaceVariant,
      textColor: colorScheme.onSurface,
      collapsedTextColor: colorScheme.onSurface,
    );
  }
}