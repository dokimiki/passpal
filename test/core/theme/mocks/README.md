# Theme Mock Providers

This directory contains mock implementations for testing theme functionality in PassPal.

## Overview

The mock providers allow for comprehensive testing of theme-related functionality without requiring the full theme system initialization or external dependencies.

## Files

- `mock_theme_providers.dart` - Main mock implementation file with providers and utilities
- `mock_theme_providers_test.dart` - Comprehensive tests for all mock implementations

## Key Components

### Mock Theme Notifiers

#### `MockLightThemeModeNotifier`
Always returns `ThemeMode.light` for light theme testing scenarios.

#### `MockDarkThemeModeNotifier`
Always returns `ThemeMode.dark` for dark theme testing scenarios.

#### `MockSystemThemeModeNotifier`
Always returns `ThemeMode.system` for system theme testing scenarios.

#### `MockLoadingThemeModeNotifier`
Simulates loading state with long delay for testing loading UI.

#### `MockErrorThemeModeNotifier`
Throws exceptions for testing error handling.

### Provider Override Utilities

#### `TestThemeProviderOverrides`

Static methods for creating provider overrides:

- `lightTheme()` - Override providers for light theme testing
- `darkTheme()` - Override providers for dark theme testing
- `systemTheme()` - Override providers for system theme testing
- `loading()` - Override providers for loading state testing
- `error()` - Override providers for error state testing
- `custom()` - Override providers with custom theme data
- `extensions()` - Override providers with theme extension testing
- `integration()` - Override providers for integration testing

### Test Scenarios

#### `TestThemeScenarios`

Pre-configured theme scenarios for common testing needs:

- `light()` - Light theme configuration
- `dark()` - Dark theme configuration
- `systemLight()` - System theme with light brightness
- `systemDark()` - System theme with dark brightness
- `highContrast()` - High contrast theme configuration
- `custom()` - Custom theme configuration with parameters

### Theme Factory Methods

- `getTestLightTheme()` - Creates valid light theme with all extensions
- `getTestDarkTheme()` - Creates valid dark theme with all extensions
- `getTestCustomTheme()` - Creates theme with custom properties

### Testing Utilities

#### `MockThemeTestUtils`

Utility methods for theme testing:

- `createTestContainer()` - Creates ProviderContainer with theme overrides
- `wrapWithTheme()` - Wraps widgets with theme providers
- `simulateThemeChange()` - Simulates theme mode changes
- `getAllExtensions()` - Gets all theme extensions from ThemeData
- `validateTheme()` - Validates theme completeness

## Usage Examples

### Basic Light Theme Testing

```dart
testWidgets('widget with light theme', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: TestThemeProviderOverrides.lightTheme(),
      child: MaterialApp(
        home: YourWidget(),
      ),
    ),
  );
  
  // Your test assertions here
});
```

### Custom Theme Testing

```dart
testWidgets('widget with custom theme', (tester) async {
  final customTheme = getTestCustomTheme(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  );
  
  await tester.pumpWidget(
    ProviderScope(
      overrides: TestThemeProviderOverrides.custom(
        customTheme,
        getTestDarkTheme(),
        mode: ThemeMode.dark,
      ),
      child: MaterialApp(
        home: YourWidget(),
      ),
    ),
  );
});
```

### Using Test Scenarios

```dart
test('theme config properties', () {
  final config = TestThemeScenarios.dark();
  
  expect(config.brightness, equals(Brightness.dark));
  expect(config.themeMode, equals(ThemeMode.dark));
  expect(config.isDarkMode, isTrue);
  
  // Use config.overrides for provider overrides
  final container = ProviderContainer(overrides: config.overrides);
});
```

### Widget Testing with Theme Wrapper

```dart
testWidgets('widget with theme wrapper', (tester) async {
  final themedWidget = MockThemeTestUtils.wrapWithTheme(
    YourWidget(),
    config: TestThemeScenarios.light(),
  );
  
  await tester.pumpWidget(MaterialApp(home: themedWidget));
  
  // Verify theme is applied
  final theme = Theme.of(tester.element(find.byType(YourWidget)));
  expect(theme.brightness, equals(Brightness.light));
});
```

### Theme Extension Testing

```dart
testWidgets('theme extensions are available', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: TestThemeProviderOverrides.extensions(),
      child: Consumer(
        builder: (context, ref, _) {
          final statusColors = ref.watch(statusColorsProvider);
          final spacing = ref.watch(spacingProvider);
          
          return MaterialApp(
            home: Container(
              color: statusColors.success,
              padding: EdgeInsets.all(spacing.md),
              child: Text('Test'),
            ),
          );
        },
      ),
    ),
  );
  
  expect(find.text('Test'), findsOneWidget);
});
```

### Error State Testing

```dart
testWidgets('handles theme loading errors', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: TestThemeProviderOverrides.error(),
      child: Consumer(
        builder: (context, ref, _) {
          final themeAsync = ref.watch(themeModeNotifierProvider);
          
          return MaterialApp(
            home: themeAsync.when(
              data: (mode) => Text('Theme: $mode'),
              loading: () => CircularProgressIndicator(),
              error: (err, _) => Text('Error: $err'),
            ),
          );
        },
      ),
    ),
  );
  
  expect(find.textContaining('Error'), findsOneWidget);
});
```

### Advanced Testing with MockThemeNotifier

```dart
test('theme mode switching simulation', () {
  final notifier = MockThemeNotifier(initialMode: ThemeMode.light);
  
  expect(notifier.state.value, equals(ThemeMode.light));
  
  notifier.setThemeMode(ThemeMode.dark);
  expect(notifier.state.value, equals(ThemeMode.dark));
  
  notifier.setLoading();
  expect(notifier.state.isLoading, isTrue);
  
  notifier.setError(Exception('Test error'));
  expect(notifier.state.error, isNotNull);
});
```

## Testing Strategy

### Theme Completeness
Always validate that themes have all required extensions:

```dart
test('theme validation', () {
  final theme = getTestLightTheme();
  MockThemeTestUtils.validateTheme(theme); // Throws if incomplete
});
```

### Cross-Platform Consistency
Test themes on different screen densities and text scaling:

```dart
testWidgets('theme adapts to text scaling', (tester) async {
  tester.binding.window.textScaleFactorTestValue = 1.5;
  
  await tester.pumpWidget(/* your themed widget */);
  
  // Verify text scales appropriately
});
```

### Accessibility Testing
Use high contrast themes for accessibility validation:

```dart
testWidgets('high contrast theme', (tester) async {
  final config = TestThemeScenarios.highContrast();
  
  await tester.pumpWidget(
    ProviderScope(
      overrides: config.overrides,
      child: YourWidget(),
    ),
  );
  
  // Verify accessibility compliance
});
```

## Integration with Other Core Modules

The mock providers are designed to work with other core module test utilities:

```dart
testWidgets('theme with storage integration', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        ...TestThemeProviderOverrides.lightTheme(),
        ...TestStorageProviderOverrides.basic(), // From storage core mocks
      ],
      child: YourApp(),
    ),
  );
});
```

## Performance Considerations

- Mock providers avoid network calls and use cached theme data
- Theme generation is optimized for test performance
- Extensions are pre-initialized to avoid lazy loading delays
- Use `createTestContainer()` for isolated testing without widget overhead

## Troubleshooting

### Common Issues

1. **Theme extensions not found**: Ensure you're using `extensions()` overrides
2. **Timer pending errors**: Use simplified test scenarios without complex async operations
3. **Provider not found**: Check that all required providers are overridden
4. **Memory leaks**: Dispose test containers properly in `tearDown()`

### Debug Tips

- Use `MockThemeTestUtils.getAllExtensions()` to inspect theme extensions
- Check `isThemeInitializedProvider` for theme loading status
- Validate themes with `MockThemeTestUtils.validateTheme()`

## Contributing

When adding new theme functionality:

1. Add corresponding mock implementations
2. Update provider overrides in `TestThemeProviderOverrides`
3. Add test scenarios in `TestThemeScenarios`
4. Write comprehensive tests
5. Update this README with usage examples

## See Also

- `/lib/core/theme/` - Main theme implementation
- `/test/core/theme/golden/` - Golden test utilities for theme validation
- `/test/core/config/mocks/` - Similar mock structure for config testing
- `/test/core/storage/mocks/` - Storage mock implementations