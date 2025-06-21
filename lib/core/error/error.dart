/// Core error handling utilities for PassPal application.
///
/// This library provides a comprehensive error handling system that includes:
/// - [OverlayErrorWidget]: A non-blocking error banner widget
/// - [ErrorHandler]: Service for managing application-wide error handling
/// - Extension methods for easy integration with Riverpod
///
/// Example usage:
/// ```dart
/// // In your main app
/// final navigatorKey = GlobalKey<NavigatorState>();
///
/// ProviderScope(
///   overrides: [
///     errorHandlerProvider.overrideWithValue(ErrorHandler(navigatorKey)),
///   ],
///   child: MaterialApp(navigatorKey: navigatorKey, ...),
/// )
///
/// // In your widgets
/// class MyWidget extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     // Handle network errors
///     ref.handleNetworkError(
///       error,
///       onRetry: () => performNetworkRequest(),
///     );
///   }
/// }
/// ```

export 'error_handler.dart';
export 'overlay_error_widget.dart';
