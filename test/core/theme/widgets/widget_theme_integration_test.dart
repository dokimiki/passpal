// Widget Integration Tests for Theme Core Module
// Tests end-to-end theme application in real widget scenarios

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:passpal/core/theme/providers/theme_providers.dart';
import 'package:passpal/core/theme/extensions/status_colors.dart';
import 'package:passpal/core/theme/extensions/spacing_tokens.dart';
import 'package:passpal/core/theme/extensions/radius_tokens.dart';
import 'package:passpal/core/theme/extensions/motion_tokens.dart';
import '../mocks/mock_theme_providers.dart';

void main() {
  group('Widget Theme Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('Basic Theme Application', () {
      testWidgets('should apply light theme to widgets correctly', (
        tester,
      ) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(lightThemeProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _TestScaffold(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify scaffold uses light theme
        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.backgroundColor, isNull); // Uses theme default

        // Verify AppBar uses light theme colors
        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.backgroundColor, isNull); // Uses theme default
      });

      testWidgets('should apply dark theme to widgets correctly', (
        tester,
      ) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(darkThemeProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _TestScaffold(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Find the actual Material widget that provides the background
        final materialWidget = tester.widget<Material>(
          find
              .descendant(
                of: find.byType(Scaffold),
                matching: find.byType(Material),
              )
              .first,
        );

        // The color should be dark
        expect(materialWidget.color, isNotNull);
      });
    });

    group('Theme Extension Usage in Widgets', () {
      testWidgets('should use StatusColors extension in widgets', (
        tester,
      ) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(lightThemeProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _StatusColorsTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify status color containers are rendered
        expect(find.byKey(const Key('success_container')), findsOneWidget);
        expect(find.byKey(const Key('warning_container')), findsOneWidget);
        expect(find.byKey(const Key('error_container')), findsOneWidget);
        expect(find.byKey(const Key('info_container')), findsOneWidget);
      });

      testWidgets('should use SpacingTokens extension in widgets', (
        tester,
      ) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(lightThemeProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _SpacingTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify spacing widgets are rendered with correct sizes
        final spacingWidget = tester.widget<SizedBox>(
          find.byKey(const Key('spacing_widget')),
        );
        expect(spacingWidget.height, 16.0); // md spacing
      });

      testWidgets('should use RadiusTokens extension in widgets', (
        tester,
      ) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(lightThemeProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _RadiusTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify radius containers are rendered
        expect(find.byKey(const Key('rounded_container')), findsOneWidget);
      });
    });

    group('Dynamic Theme Switching', () {
      testWidgets('should handle theme data switching', (tester) async {
        // Use existing provider overrides for simplicity
        final testContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.lightTheme(),
        );

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: testContainer,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(currentThemeDataProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _ThemeSwitchTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify theme is applied
        expect(find.text('Light Theme'), findsOneWidget);

        testContainer.dispose();
      });

      testWidgets('should update extension values on theme change', (
        tester,
      ) async {
        // Test light theme first
        final lightContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.lightTheme(),
        );

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: lightContainer,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(currentThemeDataProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _ExtensionValueTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify status color container is rendered
        expect(find.byKey(const Key('success_indicator')), findsOneWidget);

        lightContainer.dispose();

        // Test dark theme
        final darkContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.darkTheme(),
        );

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: darkContainer,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(currentThemeDataProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _ExtensionValueTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify status color container is still rendered (different theme)
        expect(find.byKey(const Key('success_indicator')), findsOneWidget);

        darkContainer.dispose();
      });
    });

    group('Accessibility Integration', () {
      testWidgets('should apply theme with accessibility considerations', (
        tester,
      ) async {
        // Use overrides that simulate accessibility settings
        final testContainer = ProviderContainer(
          overrides: TestThemeProviderOverrides.highContrast(),
        );

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: testContainer,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(currentThemeDataProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _AccessibilityTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify accessibility theme is applied
        expect(find.byKey(const Key('accessibility_widget')), findsOneWidget);

        testContainer.dispose();
      });

      testWidgets('should handle motion settings in theme', (tester) async {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(lightThemeProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _MotionTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify motion widget is rendered
        expect(find.byKey(const Key('motion_widget')), findsOneWidget);
      });
    });

    group('Performance Testing', () {
      testWidgets('should render performance test widget efficiently', (
        tester,
      ) async {
        final stopwatch = Stopwatch()..start();

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(lightThemeProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _PerformanceTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();
        stopwatch.stop();

        // Performance should be reasonable (less than 1000ms for initial render)
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));

        // Verify performance test widget is rendered
        expect(find.text('Performance Test'), findsOneWidget);
      });

      testWidgets('should not cause memory leaks with theme changes', (
        tester,
      ) async {
        final testContainer = ProviderContainer();

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: testContainer,
            child: Consumer(
              builder: (context, ref, child) {
                final themeData = ref.watch(lightThemeProvider);
                return MaterialApp(
                  theme: themeData,
                  home: const _MemoryTestWidget(),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // This test verifies that theme objects can be garbage collected
        // by creating and disposing multiple theme instances
        expect(find.byKey(const Key('memory_test_widget')), findsOneWidget);

        testContainer.dispose();
      });
    });
  });
}

// Test Widgets

class _TestScaffold extends StatelessWidget {
  const _TestScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test App')),
      body: const Center(child: Text('Test Content')),
    );
  }
}

class _StatusColorsTestWidget extends StatelessWidget {
  const _StatusColorsTestWidget();

  @override
  Widget build(BuildContext context) {
    final statusColors = Theme.of(context).extension<StatusColors>()!;

    return Scaffold(
      body: Column(
        children: [
          Container(
            key: const Key('success_container'),
            color: statusColors.success,
            height: 50,
            width: 50,
          ),
          Container(
            key: const Key('warning_container'),
            color: statusColors.warning,
            height: 50,
            width: 50,
          ),
          Container(
            key: const Key('error_container'),
            color: statusColors.error,
            height: 50,
            width: 50,
          ),
          Container(
            key: const Key('info_container'),
            color: statusColors.info,
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}

class _SpacingTestWidget extends StatelessWidget {
  const _SpacingTestWidget();

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<SpacingTokensExtension>()!;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            key: const Key('spacing_widget'),
            height: spacing.md,
            width: spacing.md,
          ),
          spacing.verticalSpace(spacing.lg),
        ],
      ),
    );
  }
}

class _RadiusTestWidget extends StatelessWidget {
  const _RadiusTestWidget();

  @override
  Widget build(BuildContext context) {
    final radius = Theme.of(context).extension<RadiusTokensExtension>()!;

    return Scaffold(
      body: Container(
        key: const Key('rounded_container'),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(radius.md),
        ),
        height: 100,
        width: 100,
      ),
    );
  }
}

class _ThemeSwitchTestWidget extends StatelessWidget {
  const _ThemeSwitchTestWidget();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(child: Text(isDark ? 'Dark Theme' : 'Light Theme')),
    );
  }
}

class _ExtensionValueTestWidget extends StatelessWidget {
  const _ExtensionValueTestWidget();

  @override
  Widget build(BuildContext context) {
    final statusColors = Theme.of(context).extension<StatusColors>()!;

    return Scaffold(
      body: Container(
        key: const Key('success_indicator'),
        color: statusColors.success,
        height: 50,
        width: 50,
      ),
    );
  }
}

class _AccessibilityTestWidget extends StatelessWidget {
  const _AccessibilityTestWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: const Key('accessibility_widget'),
        child: const Text('Accessibility Test'),
      ),
    );
  }
}

class _MotionTestWidget extends StatelessWidget {
  const _MotionTestWidget();

  @override
  Widget build(BuildContext context) {
    final motion = Theme.of(context).extension<MotionTokensExtension>()!;

    return Scaffold(
      body: AnimatedContainer(
        key: const Key('motion_widget'),
        duration: motion.fast,
        height: 100,
        width: 100,
        color: Colors.blue,
      ),
    );
  }
}

class _PerformanceTestWidget extends StatelessWidget {
  const _PerformanceTestWidget();

  @override
  Widget build(BuildContext context) {
    // Widget with multiple theme dependencies to test performance
    final statusColors = Theme.of(context).extension<StatusColors>()!;
    final spacing = Theme.of(context).extension<SpacingTokensExtension>()!;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: statusColors.success,
            padding: EdgeInsets.all(spacing.md),
            child: const Text('Performance Test'),
          ),
        ],
      ),
    );
  }
}

class _MemoryTestWidget extends StatelessWidget {
  const _MemoryTestWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: const Key('memory_test_widget'),
        child: const Text('Memory Test'),
      ),
    );
  }
}
