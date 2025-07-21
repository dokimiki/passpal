import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:passpal/core/theme/builders/theme_builder.dart';
import 'package:passpal/core/theme/extensions/status_colors.dart';
import 'package:passpal/core/theme/extensions/spacing_tokens.dart';
import 'package:passpal/core/theme/extensions/radius_tokens.dart';
import 'package:passpal/core/theme/extensions/elevation_tokens.dart';

/// Golden test utilities for theme validation and snapshot testing
class GoldenTestUtilities {
  /// Test widget wrapper with theme and basic structure
  static Widget buildThemeTestWidget({
    required Brightness brightness,
    Widget? child,
  }) {
    final theme = ThemeBuilder.buildTheme(brightness);
    return ProviderScope(
      child: MaterialApp(
        theme: theme,
        home: Scaffold(body: child ?? const ThemeTestContent()),
      ),
    );
  }

  /// Test widget with theme extensions showcase
  static Widget buildExtensionsTestWidget(Brightness brightness) {
    return buildThemeTestWidget(
      brightness: brightness,
      child: const ExtensionsShowcase(),
    );
  }

  /// Test widget showing Material 3 components with theme
  static Widget buildComponentsTestWidget(Brightness brightness) {
    return buildThemeTestWidget(
      brightness: brightness,
      child: const ComponentsShowcase(),
    );
  }

  /// Test widget for accessibility validation
  static Widget buildAccessibilityTestWidget(Brightness brightness) {
    return buildThemeTestWidget(
      brightness: brightness,
      child: const AccessibilityShowcase(),
    );
  }

  /// Test widget that demonstrates all color schemes
  static Widget buildColorSchemeTestWidget(Brightness brightness) {
    return buildThemeTestWidget(
      brightness: brightness,
      child: const ColorSchemeShowcase(),
    );
  }

  /// Test widget for typography samples
  static Widget buildTypographyTestWidget(Brightness brightness) {
    return buildThemeTestWidget(
      brightness: brightness,
      child: const TypographyShowcase(),
    );
  }
}

/// Main test content widget
class ThemeTestContent extends StatelessWidget {
  const ThemeTestContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 16),
        Text('Theme Test Widget'),
        SizedBox(height: 16),
        ExtensionsShowcase(),
        SizedBox(height: 16),
        ComponentsShowcase(),
      ],
    );
  }
}

/// Widget showcasing theme extensions
class ExtensionsShowcase extends StatelessWidget {
  const ExtensionsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final statusColors = Theme.of(context).extension<StatusColors>();
    final spacing = Theme.of(context).extension<SpacingTokensExtension>();
    final radius = Theme.of(context).extension<RadiusTokensExtension>();
    final elevation = Theme.of(context).extension<ElevationTokensExtension>();

    return Column(
      children: [
        // Status Colors
        if (statusColors != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColors.success,
                  borderRadius: BorderRadius.circular(radius?.md ?? 0),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColors.warning,
                  borderRadius: BorderRadius.circular(radius?.md ?? 0),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColors.error,
                  borderRadius: BorderRadius.circular(radius?.md ?? 0),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColors.info,
                  borderRadius: BorderRadius.circular(radius?.md ?? 0),
                ),
              ),
            ],
          ),

        // Spacing
        if (spacing != null) ...[
          SizedBox(height: spacing.md),
          Row(
            children: [
              SizedBox(width: spacing.sm),
              const Text('Spacing: '),
              SizedBox(width: spacing.xs),
              const Text('XS'),
              SizedBox(width: spacing.sm),
              const Text('SM'),
              SizedBox(width: spacing.md),
              const Text('MD'),
            ],
          ),
        ],

        // Elevation
        if (elevation != null) ...[
          const SizedBox(height: 16),
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: elevation.shadow2,
              borderRadius: BorderRadius.circular(radius?.md ?? 0),
            ),
            child: const Center(child: Text('Elevation')),
          ),
        ],
      ],
    );
  }
}

/// Widget showcasing Material 3 components
class ComponentsShowcase extends StatelessWidget {
  const ComponentsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Buttons
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
            FilledButton(onPressed: () {}, child: const Text('Filled')),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
            TextButton(onPressed: () {}, child: const Text('Text')),
          ],
        ),

        const SizedBox(height: 16),

        // Cards
        const Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Card Example'),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Chips
        const Wrap(
          spacing: 8,
          children: [
            Chip(label: Text('Chip 1')),
            Chip(label: Text('Chip 2')),
            Chip(label: Text('Chip 3')),
          ],
        ),
      ],
    );
  }
}

/// Widget showcasing accessibility features
class AccessibilityShowcase extends StatelessWidget {
  const AccessibilityShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // High contrast examples
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Text(
            'Accessibility Test Content',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Touch targets
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
            ),
            SizedBox(
              width: 48,
              height: 48,
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
            ),
            SizedBox(
              width: 48,
              height: 48,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget showcasing color schemes
class ColorSchemeShowcase extends StatelessWidget {
  const ColorSchemeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Primary colors
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                color: colorScheme.primary,
                child: Center(
                  child: Text(
                    'Primary',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                color: colorScheme.secondary,
                child: Center(
                  child: Text(
                    'Secondary',
                    style: TextStyle(color: colorScheme.onSecondary),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Surface colors
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                color: colorScheme.surface,
                child: Center(
                  child: Text(
                    'Surface',
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                color: colorScheme.surfaceContainerHighest,
                child: Center(
                  child: Text(
                    'Surface Container',
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget showcasing typography
class TypographyShowcase extends StatelessWidget {
  const TypographyShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (textTheme.displayLarge != null)
            Text('Display Large', style: textTheme.displayLarge),
          if (textTheme.displayMedium != null)
            Text('Display Medium', style: textTheme.displayMedium),
          if (textTheme.displaySmall != null)
            Text('Display Small', style: textTheme.displaySmall),
          if (textTheme.headlineLarge != null)
            Text('Headline Large', style: textTheme.headlineLarge),
          if (textTheme.headlineMedium != null)
            Text('Headline Medium', style: textTheme.headlineMedium),
          if (textTheme.headlineSmall != null)
            Text('Headline Small', style: textTheme.headlineSmall),
          if (textTheme.titleLarge != null)
            Text('Title Large', style: textTheme.titleLarge),
          if (textTheme.titleMedium != null)
            Text('Title Medium', style: textTheme.titleMedium),
          if (textTheme.titleSmall != null)
            Text('Title Small', style: textTheme.titleSmall),
          if (textTheme.bodyLarge != null)
            Text('Body Large', style: textTheme.bodyLarge),
          if (textTheme.bodyMedium != null)
            Text('Body Medium', style: textTheme.bodyMedium),
          if (textTheme.bodySmall != null)
            Text('Body Small', style: textTheme.bodySmall),
          if (textTheme.labelLarge != null)
            Text('Label Large', style: textTheme.labelLarge),
          if (textTheme.labelMedium != null)
            Text('Label Medium', style: textTheme.labelMedium),
          if (textTheme.labelSmall != null)
            Text('Label Small', style: textTheme.labelSmall),
        ],
      ),
    );
  }
}
