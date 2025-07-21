import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import '../models/elevation_tokens.dart';

/// ElevationTokens theme extension implementation.
///
/// Provides concrete implementation of consistent elevation and shadow values
/// with responsive behavior and Material 3 integration.
///
/// This extension integrates with ElevationTokens from the model layer
/// and provides utilities for consistent depth and shadows throughout the app.
class ElevationTokensExtension
    extends ThemeExtension<ElevationTokensExtension> {
  /// Creates an ElevationTokens theme extension.
  ElevationTokensExtension({
    required this.level0,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
    required this.elevationTokens,
    required this.componentElevationTokens,
    required this.shadowTokens,
    required this.brightness,
  });

  /// Standard elevation extension using Material 3 specifications.
  static final standardLight = ElevationTokensExtension(
    level0: 0.0,
    level1: 1.0,
    level2: 3.0,
    level3: 6.0,
    level4: 8.0,
    level5: 12.0,
    elevationTokens: ElevationTokens.standard,
    componentElevationTokens: ComponentElevationTokens.standard,
    shadowTokens: ShadowTokens.light,
    brightness: Brightness.light,
  );

  /// Standard elevation extension for dark theme.
  static final standardDark = ElevationTokensExtension(
    level0: 0.0,
    level1: 1.0,
    level2: 3.0,
    level3: 6.0,
    level4: 8.0,
    level5: 12.0,
    elevationTokens: ElevationTokens.standard,
    componentElevationTokens: ComponentElevationTokens.standard,
    shadowTokens: ShadowTokens.dark,
    brightness: Brightness.dark,
  );

  /// Enhanced elevation extension with stronger shadows.
  static final enhancedLight = ElevationTokensExtension(
    level0: 0.0,
    level1: 2.0,
    level2: 4.0,
    level3: 8.0,
    level4: 12.0,
    level5: 16.0,
    elevationTokens: ElevationTokens.standard,
    componentElevationTokens: ComponentElevationTokens.enhanced,
    shadowTokens: ShadowTokens.light,
    brightness: Brightness.light,
  );

  /// Enhanced elevation extension for dark theme.
  static final enhancedDark = ElevationTokensExtension(
    level0: 0.0,
    level1: 2.0,
    level2: 4.0,
    level3: 8.0,
    level4: 12.0,
    level5: 16.0,
    elevationTokens: ElevationTokens.standard,
    componentElevationTokens: ComponentElevationTokens.enhanced,
    shadowTokens: ShadowTokens.dark,
    brightness: Brightness.dark,
  );

  /// Flat elevation extension with minimal shadows.
  static final flatLight = ElevationTokensExtension(
    level0: 0.0,
    level1: 0.0,
    level2: 1.0,
    level3: 2.0,
    level4: 3.0,
    level5: 6.0,
    elevationTokens: ElevationTokens.standard,
    componentElevationTokens: ComponentElevationTokens.flat,
    shadowTokens: ShadowTokens.light,
    brightness: Brightness.light,
  );

  /// Flat elevation extension for dark theme.
  static final flatDark = ElevationTokensExtension(
    level0: 0.0,
    level1: 0.0,
    level2: 1.0,
    level3: 2.0,
    level4: 3.0,
    level5: 6.0,
    elevationTokens: ElevationTokens.standard,
    componentElevationTokens: ComponentElevationTokens.flat,
    shadowTokens: ShadowTokens.dark,
    brightness: Brightness.dark,
  );

  final double level0;

  final double level1;

  final double level2;

  final double level3;

  final double level4;

  final double level5;

  /// Underlying elevation tokens model.
  final ElevationTokens elevationTokens;

  /// Component-specific elevation tokens.
  final ComponentElevationTokens componentElevationTokens;

  /// Shadow color tokens.
  final ShadowTokens shadowTokens;

  /// Theme brightness for shadow calculation.
  final Brightness brightness;

  // Convenience getters for common shadow configurations
  List<BoxShadow> get shadow0 => shadowForLevel(level0);
  List<BoxShadow> get shadow1 => shadowForLevel(level1);
  List<BoxShadow> get shadow2 => shadowForLevel(level2);
  List<BoxShadow> get shadow3 => shadowForLevel(level3);
  List<BoxShadow> get shadow4 => shadowForLevel(level4);
  List<BoxShadow> get shadow5 => shadowForLevel(level5);

  List<BoxShadow> shadowForLevel(double elevation) {
    if (elevation <= 0) return [];

    return ElevationUtils.getBoxShadow(
      elevation: elevation,
      shadowColor: shadowTokens.shadow,
      ambientOpacity: brightness == Brightness.light ? 0.12 : 0.24,
      keyOpacity: brightness == Brightness.light ? 0.14 : 0.32,
    );
  }

  BoxDecoration decorationWithElevation(
    double elevation, {
    Color? color,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      border: border,
      boxShadow: shadowForLevel(elevation),
    );
  }

  Widget materialWithElevation(
    double elevation, {
    required Widget child,
    Color? color,
    BorderRadius? borderRadius,
    Clip clipBehavior = Clip.none,
  }) {
    return Material(
      elevation: elevation,
      color: color,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      child: child,
    );
  }

  Widget animatedElevation({
    required double elevation,
    required Widget child,
    Duration duration = const Duration(milliseconds: 150),
    Curve curve = Curves.easeInOut,
    Color? color,
    BorderRadius? borderRadius,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: elevation, end: elevation),
      duration: duration,
      curve: curve,
      builder: (context, animatedElevation, _) {
        return materialWithElevation(
          animatedElevation,
          color: color,
          borderRadius: borderRadius,
          child: child,
        );
      },
    );
  }

  // Component-specific elevation getters

  /// Surface elevation for background elements.
  double get surface => componentElevationTokens.surface;

  /// Card elevation for container components.
  double get card => componentElevationTokens.card;

  /// Button elevation for elevated buttons.
  double get button => componentElevationTokens.button;

  /// FAB elevation for floating action buttons.
  double get fab => componentElevationTokens.fab;

  /// Navigation bar elevation.
  double get navigationBar => componentElevationTokens.navigationBar;

  /// App bar elevation.
  double get appBar => componentElevationTokens.appBar;

  /// Drawer elevation for navigation drawers.
  double get drawer => componentElevationTokens.drawer;

  /// Modal elevation for dialogs and overlays.
  double get modal => componentElevationTokens.modal;

  /// Menu elevation for dropdowns and context menus.
  double get menu => componentElevationTokens.menu;

  /// Snackbar elevation for temporary messages.
  double get snackbar => componentElevationTokens.snackbar;

  /// Tooltip elevation for help text.
  double get tooltip => componentElevationTokens.tooltip;

  /// Bottom sheet elevation for sliding panels.
  double get bottomSheet => componentElevationTokens.bottomSheet;

  /// Tab bar elevation for tab navigation.
  double get tabBar => componentElevationTokens.tabBar;

  /// Chip elevation for tag-like elements.
  double get chip => componentElevationTokens.chip;

  // Utility methods

  /// Creates responsive elevation based on screen width.
  double getResponsiveElevation({
    required double baseElevation,
    required double screenWidth,
    double minScale = 0.7,
    double maxScale = 1.3,
  }) {
    return ElevationUtils.getResponsiveElevation(
      baseElevation: baseElevation,
      screenWidth: screenWidth,
      minScale: minScale,
      maxScale: maxScale,
    );
  }

  /// Gets elevation for interactive states.
  double getElevationForState({
    required double baseElevation,
    bool isHovered = false,
    bool isFocused = false,
    bool isPressed = false,
    bool isDisabled = false,
  }) {
    return ElevationUtils.getElevationForState(
      baseElevation: baseElevation,
      isHovered: isHovered,
      isFocused: isFocused,
      isPressed: isPressed,
      isDisabled: isDisabled,
    );
  }

  /// Gets surface tint color for Material 3 elevation.
  Color getSurfaceTint({
    required Color baseColor,
    required Color tintColor,
    required double elevation,
    double maxOpacity = 0.15,
  }) {
    return ElevationUtils.getSurfaceTint(
      baseColor: baseColor,
      tintColor: tintColor,
      elevation: elevation,
      maxOpacity: maxOpacity,
    );
  }

  @override
  ElevationTokensExtension copyWith({
    double? level0,
    double? level1,
    double? level2,
    double? level3,
    double? level4,
    double? level5,
    ElevationTokens? elevationTokens,
    ComponentElevationTokens? componentElevationTokens,
    ShadowTokens? shadowTokens,
    Brightness? brightness,
  }) {
    return ElevationTokensExtension(
      level0: level0 ?? this.level0,
      level1: level1 ?? this.level1,
      level2: level2 ?? this.level2,
      level3: level3 ?? this.level3,
      level4: level4 ?? this.level4,
      level5: level5 ?? this.level5,
      elevationTokens: elevationTokens ?? this.elevationTokens,
      componentElevationTokens:
          componentElevationTokens ?? this.componentElevationTokens,
      shadowTokens: shadowTokens ?? this.shadowTokens,
      brightness: brightness ?? this.brightness,
    );
  }

  @override
  ElevationTokensExtension lerp(
    ThemeExtension<ElevationTokensExtension>? other,
    double t,
  ) {
    if (other is! ElevationTokensExtension) {
      return this;
    }

    return ElevationTokensExtension(
      level0: lerpDouble(level0, other.level0, t) ?? level0,
      level1: lerpDouble(level1, other.level1, t) ?? level1,
      level2: lerpDouble(level2, other.level2, t) ?? level2,
      level3: lerpDouble(level3, other.level3, t) ?? level3,
      level4: lerpDouble(level4, other.level4, t) ?? level4,
      level5: lerpDouble(level5, other.level5, t) ?? level5,
      elevationTokens: elevationTokens, // Don't interpolate complex objects
      componentElevationTokens: componentElevationTokens,
      shadowTokens: shadowTokens,
      brightness: brightness,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ElevationTokensExtension &&
        other.level0 == level0 &&
        other.level1 == level1 &&
        other.level2 == level2 &&
        other.level3 == level3 &&
        other.level4 == level4 &&
        other.level5 == level5 &&
        other.elevationTokens == elevationTokens &&
        other.componentElevationTokens == componentElevationTokens &&
        other.shadowTokens == shadowTokens &&
        other.brightness == brightness;
  }

  @override
  int get hashCode {
    return Object.hash(
      level0,
      level1,
      level2,
      level3,
      level4,
      level5,
      elevationTokens,
      componentElevationTokens,
      shadowTokens,
      brightness,
    );
  }

  @override
  String toString() {
    return 'ElevationTokensExtension('
        'level0: $level0, '
        'level1: $level1, '
        'level2: $level2, '
        'level3: $level3, '
        'level4: $level4, '
        'level5: $level5, '
        'brightness: $brightness)';
  }
}

/// Extension on [BuildContext] for easy access to elevation tokens.
extension ElevationTokensContext on BuildContext {
  /// Gets the current [ElevationTokensExtension] from the theme.
  ElevationTokensExtension? get elevation {
    return Theme.of(this).extension<ElevationTokensExtension>();
  }
}

/// Extension on [ThemeData] for adding elevation tokens.
extension ElevationTokensTheme on ThemeData {
  /// Gets the [ElevationTokensExtension] from this theme.
  ElevationTokensExtension? get elevation {
    return extension<ElevationTokensExtension>();
  }

  /// Creates a copy of this theme with the given [ElevationTokensExtension].
  ThemeData withElevationTokens(ElevationTokensExtension elevationTokens) {
    return copyWith(
      extensions: [
        ...extensions.values.where((ext) => ext is! ElevationTokensExtension),
        elevationTokens,
      ],
    );
  }
}
