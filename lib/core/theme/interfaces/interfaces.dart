/// Theme extension interfaces for PassPal design system.
/// 
/// This file exports all theme extension interfaces that define the contracts
/// for implementing consistent design tokens throughout the application.
/// 
/// These interfaces ensure type safety and consistency across:
/// - Status colors (success, warning, error, info)
/// - Spacing tokens (xs, sm, md, lg, xl, xxl)
/// - Radius tokens (none, xs, sm, md, lg, xl, full)
/// - Elevation tokens (level0-level5 with shadows)
/// - Motion tokens (durations and curves)
/// 
/// Each interface extends [ThemeExtension] to integrate with Flutter's
/// theme system and support smooth transitions between theme modes.
library;

export 'elevation_extension.dart';
export 'motion_extension.dart';
export 'radius_extension.dart';
export 'spacing_extension.dart';
export 'status_colors_extension.dart';