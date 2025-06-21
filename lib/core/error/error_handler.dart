import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'overlay_error_widget.dart';

/// Error handler service for managing application-wide error handling.
///
/// This service provides methods to handle different types of errors,
/// particularly network-related errors that should be displayed as
/// overlay banners to the user.
class ErrorHandler {
  ErrorHandler(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  /// Shows an overlay error widget for network-related errors.
  ///
  /// This method displays a non-blocking error banner at the top of the screen
  /// for DioError or SocketException types. The banner includes retry and FAQ options.
  ///   /// Returns true if the error was handled and overlay was shown, false otherwise.
  bool handleNetworkError(Object error, {required VoidCallback onRetry}) {
    if (!_isNetworkError(error)) {
      return false;
    }

    final navigator = _navigatorKey.currentState;
    if (navigator == null) {
      return false;
    }

    // Get the overlay from the navigator's context
    try {
      final overlay = navigator.overlay;
      if (overlay != null) {
        _showOverlayError(overlay, error, onRetry);
        return true;
      }
      return false;
    } catch (e) {
      // Overlay not available, return false
      debugPrint('Failed to show overlay error: $e');
      return false;
    }
  }

  /// Checks if the given error is a network-related error that should be handled.
  bool _isNetworkError(Object error) {
    return error is DioException || error is SocketException;
  }

  /// Shows the overlay error widget with the given parameters.
  void _showOverlayError(
    OverlayState overlay,
    Object error,
    VoidCallback onRetry,
  ) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: OverlayErrorWidget(
          error: error,
          onRetry: () {
            overlayEntry.remove();
            onRetry();
          },
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  /// Handles general errors that are not network-related.
  ///
  /// This method can be extended to handle other types of errors
  /// such as validation errors, authentication errors, etc.
  void handleGeneralError(Object error, {StackTrace? stackTrace}) {
    // Log the error for debugging purposes
    debugPrint('General error: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }

    // TODO: Implement handling for other error types
    // For example, show SnackBar for validation errors,
    // redirect to login for authentication errors, etc.
  }
}

/// Provider for the error handler service.
///
/// This provider creates and provides access to the ErrorHandler instance
/// throughout the application using Riverpod dependency injection.
final errorHandlerProvider = Provider<ErrorHandler>((ref) {
  // Get the navigator key from the main app
  // This should be injected from the main application
  throw UnimplementedError(
    'errorHandlerProvider must be overridden with a proper NavigatorKey',
  );
});

/// Extension on WidgetRef to provide easy access to error handling.
extension ErrorHandlingExtension on WidgetRef {
  /// Handles network errors using the error handler service.
  ///
  /// Returns true if the error was handled, false otherwise.
  bool handleNetworkError(Object error, {required VoidCallback onRetry}) {
    return read(
      errorHandlerProvider,
    ).handleNetworkError(error, onRetry: onRetry);
  }

  /// Handles general errors using the error handler service.
  void handleGeneralError(Object error, {StackTrace? stackTrace}) {
    read(
      errorHandlerProvider,
    ).handleGeneralError(error, stackTrace: stackTrace);
  }
}
