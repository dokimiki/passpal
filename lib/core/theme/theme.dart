/// Core theme system for Passpal app
///
/// This library provides a comprehensive theme system built on Material Design 3
/// with support for light/dark modes, accessibility, and custom styling.
///
/// ## Usage
///
/// ### Basic Theme Setup
/// ```dart
/// import 'package:passpal/core/theme/theme.dart';
///
/// Widget build(BuildContext context) {
///   return MaterialApp(
///     theme: AppTheme.light(ColorTokens.brand.primary),
///     darkTheme: AppTheme.dark(ColorTokens.brand.primary),
///     home: MyApp(),
///   );
/// }
/// ```
///
/// ### Using Theme Provider
/// ```dart
/// class MyApp extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final themeMode = ref.watch(themeModeProvider);
///
///     return MaterialApp(
///       themeMode: themeMode,
///       theme: AppTheme.light(ColorTokens.brand.primary),
///       darkTheme: AppTheme.dark(ColorTokens.brand.primary),
///       home: HomeScreen(),
///     );
///   }
/// }
/// ```
///
/// ### Accessing Custom Colors
/// ```dart
/// Widget build(BuildContext context) {
///   final customTheme = Theme.of(context).extension<PasspalThemeExt>()!;
///
///   return Container(
///     color: customTheme.errorBg,
///     child: Text('Error message'),
///   );
/// }
/// ```
library;

// Design tokens
export 'tokens/colors.dart';
export 'tokens/spacing.dart';
export 'tokens/radii.dart';
export 'tokens/durations.dart';

// Theme builders
export 'builders/app_theme.dart';

// Theme extensions
export 'extensions/passpal_theme_ext.dart';

// Theme providers
export 'providers/theme_mode_provider.dart';
