import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'scheduler_service.dart';
import 'android_scheduler.dart';
import 'ios_scheduler.dart';

/// Provider for the platform-specific [SchedulerService] implementation.
///
/// Returns [AndroidScheduler] on Android devices and [IosScheduler] on iOS devices.
final schedulerProvider = Provider<SchedulerService>((ref) {
  if (Platform.isAndroid) {
    return AndroidScheduler();
  } else if (Platform.isIOS) {
    return IosScheduler();
  } else {
    throw UnsupportedError('Platform not supported for background scheduling');
  }
});
