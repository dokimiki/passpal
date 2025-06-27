import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_exception.dart';

/// Provider for CrashlyticsReporter
final crashlyticsReporterProvider = Provider<CrashlyticsReporter>((ref) {
  return CrashlyticsReporter(FirebaseCrashlytics.instance);
});

/// Handles reporting errors to Firebase Crashlytics
class CrashlyticsReporter {
  const CrashlyticsReporter(this._crashlytics);

  final FirebaseCrashlytics _crashlytics;

  /// Record an error to Crashlytics with appropriate metadata
  Future<void> recordError(AppException exception) async {
    try {
      final information = _buildErrorInformation(exception);

      // Set custom keys for additional context
      for (final entry in information.entries) {
        await _crashlytics.setCustomKey(entry.key, entry.value);
      }

      await _crashlytics.recordError(
        exception,
        exception.stack,
        fatal: exception.isFatal,
      );
    } catch (e) {
      // Gracefully handle Crashlytics errors to prevent infinite loops
      // In debug mode, we might want to print this
      if (kDebugMode) {
        print('Failed to record error to Crashlytics: $e');
      }
    }
  }

  /// Set user context for better error tracking
  Future<void> setUserContext({
    String? userId,
    String? email,
    Map<String, String>? customKeys,
  }) async {
    try {
      if (userId != null) {
        await _crashlytics.setUserIdentifier(userId);
      }

      if (customKeys != null) {
        for (final entry in customKeys.entries) {
          await _crashlytics.setCustomKey(entry.key, entry.value);
        }
      }
    } catch (e) {
      // Gracefully handle Crashlytics errors to prevent infinite loops
      if (kDebugMode) {
        print('Failed to set user context: $e');
      }
    }
  }

  /// Build error information based on exception type
  Map<String, String> _buildErrorInformation(AppException exception) {
    final information = <String, String>{
      'exception_type': exception.runtimeType.toString(),
      'message': exception.message,
      'is_fatal': exception.isFatal.toString(),
    };

    // Add type-specific information
    switch (exception) {
      case NetworkFailure failure:
        information.addAll({
          'network_kind': failure.kind.name,
          'can_retry': failure.canRetry.toString(),
          if (failure.statusCode != null)
            'status_code': failure.statusCode.toString(),
        });
        break;

      case ParseFailure failure:
        information.addAll({
          if (failure.source != null)
            'source_length': failure.source!.length.toString(),
        });
        break;

      case MaintenanceException maintenance:
        information.addAll({
          if (maintenance.estimatedEndTime != null)
            'estimated_end': maintenance.estimatedEndTime.toString(),
        });
        break;

      case UnknownException unknown:
        information.addAll({
          if (unknown.originalException != null)
            'original_type': unknown.originalException.runtimeType.toString(),
        });
        break;

      case ForceUpdateException update:
        information.addAll({
          'current_version': update.currentVersion,
          'minimum_version': update.minimumVersion,
        });
        break;
    }

    return information;
  }
}
