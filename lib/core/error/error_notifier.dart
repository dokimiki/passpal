import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_exception.dart';
import 'crashlytics_reporter.dart';

/// Provider for ErrorNotifier
final errorNotifierProvider = NotifierProvider<ErrorNotifier, AppErrorState>(
  ErrorNotifier.new,
);

/// UI error state
sealed class AppErrorState {
  const AppErrorState();
}

final class AppErrorState$Idle extends AppErrorState {
  const AppErrorState$Idle();
}

final class AppErrorState$Showing extends AppErrorState {
  const AppErrorState$Showing({required this.exception, this.showTime});

  final AppException exception;
  final DateTime? showTime;
}

/// Notifier for managing UI error states
class ErrorNotifier extends Notifier<AppErrorState> {
  @override
  AppErrorState build() {
    return const AppErrorState$Idle();
  }

  /// Show an error to the user
  Future<void> show(
    AppException exception, {
    bool recordToCrashlytics = true,
    bool autoDismiss = false,
  }) async {
    // Record to Crashlytics if requested
    if (recordToCrashlytics) {
      try {
        await ref.read(crashlyticsReporterProvider).recordError(exception);
      } catch (e) {
        // If Crashlytics fails, don't let it prevent showing the error to the user
        // We already have graceful error handling in CrashlyticsReporter, but this is extra safety
        if (kDebugMode) {
          print('Failed to record error to Crashlytics: $e');
        }
      }
    }

    // Update UI state
    state = AppErrorState$Showing(
      exception: exception,
      showTime: DateTime.now(),
    );

    // Auto-dismiss for certain error types
    if (autoDismiss) {
      _scheduleAutoDismiss(exception);
    }
  }

  /// Dismiss the current error
  void dismiss() {
    state = const AppErrorState$Idle();
  }

  /// Check if an error is currently being shown
  bool get isShowing => state is AppErrorState$Showing;

  /// Get the current exception if showing
  AppException? get currentException {
    return switch (state) {
      AppErrorState$Showing(exception: final exception) => exception,
      AppErrorState$Idle() => null,
    };
  }

  /// Schedule auto-dismiss for certain error types
  void _scheduleAutoDismiss(AppException exception) {
    Duration dismissDelay;

    switch (exception) {
      case NetworkFailure failure
          when failure.kind == NetworkFailureKind.offline:
        dismissDelay = const Duration(seconds: 5);
        break;
      case ParseFailure _:
        dismissDelay = const Duration(seconds: 3);
        break;
      default:
        return; // Don't auto-dismiss other types
    }

    Future.delayed(dismissDelay, () {
      if (state is AppErrorState$Showing) {
        final current = state as AppErrorState$Showing;
        if (current.exception == exception) {
          dismiss();
        }
      }
    });
  }
}
