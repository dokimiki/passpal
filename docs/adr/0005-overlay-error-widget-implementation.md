# ADR-0005: Overlay Error Widget Implementation

* Status: accepted
* Date: 2025-06-22
* Deciders: Development Team

## Context and Problem Statement

The PassPal application needs a non-blocking way to display network errors to users when API calls fail due to DioException or SocketException. The current approach of showing modal dialogs interrupts the user's workflow and blocks the entire UI. Users need immediate feedback about network issues with options to retry or get help, without losing their current context.

## Decision Drivers

* Non-blocking error display requirement
* Material Design 3 compliance
* Smooth animations for better UX
* Easy integration with existing Riverpod architecture
* Testability and maintainability
* Support for retry functionality and FAQ access

## Considered Options

1. **Modal Dialog Approach** - Traditional error dialogs that block the UI
2. **SnackBar Approach** - Bottom-positioned temporary messages
3. **Overlay Banner Approach** - Top-positioned overlay cards with rich content
4. **Toast Approach** - System-level notifications

## Decision Outcome

Chosen option: **Overlay Banner Approach**, because it provides the best balance of visibility, functionality, and user experience without blocking the UI workflow.

### Positive Consequences

* Non-blocking error display maintains user workflow
* Rich content area allows for retry buttons and FAQ links
* Smooth slide-in animations provide polished UX
* Easy dismissal options (manual close or auto-dismiss on retry)
* Centralized error handling through Riverpod providers
* High test coverage ensures reliability

### Negative Consequences

* Additional complexity in overlay management
* Requires careful positioning to avoid UI conflicts
* Memory management considerations for overlay entries

## Implementation Details

### Core Components

1. **OverlayErrorWidget**: StatefulWidget with animations
   * SlideTransition for smooth entry (200ms)
   * FadeTransition for smooth exit
   * Material Design 3 error container styling
   * WiFi-off icon for network error indication

2. **ErrorHandler**: Service class for centralized error management
   * Network error detection (DioException, SocketException)
   * Navigator-based overlay insertion
   * Try-catch error handling for robustness

3. **Riverpod Integration**: Provider and extension methods
   * errorHandlerProvider for dependency injection
   * ErrorHandlingExtension for easy WidgetRef access

### Error Message Strategy

```dart
// Status code specific messages
'通信に失敗しました (503)。再試行しますか？'

// Generic network messages
'通信に失敗しました。再試行しますか？'
'ネットワークエラーが発生しました。再試行しますか？'
```

### Animation Specifications

* **Entry**: SlideTransition from top, 200ms duration with easeOut curve
* **Exit**: FadeTransition, 200ms duration with easeOut curve
* **Positioning**: SafeArea-aware, 16px margins

### Integration Pattern

```dart
// In main app setup
final navigatorKey = GlobalKey<NavigatorState>();
ProviderScope(
  overrides: [
    errorHandlerProvider.overrideWithValue(ErrorHandler(navigatorKey)),
  ],
  child: MaterialApp(navigatorKey: navigatorKey, ...),
)

// In feature code
ref.handleNetworkError(error, onRetry: () => retryOperation());
```

## Validation

### Test Coverage

* **OverlayErrorWidget Tests**: Widget behavior, animations, error messages
* **ErrorHandler Tests**: Network error detection, overlay management
* **Integration Tests**: Riverpod provider integration

### Performance Considerations

* Efficient overlay entry management (proper cleanup)
* Animation controller disposal
* Memory-conscious implementation

## Links

* Related ADRs: ADR-0001 (Base Dio Wrapper), ADR-0003 (Secure Credential Storage)
* Material Design 3 Error Handling Guidelines
* Flutter Overlay Documentation
* Riverpod Error Handling Best Practices
