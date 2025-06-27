import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../platform/background_scheduler.dart';
import '../platform/android_scheduler.dart';
import '../platform/ios_scheduler.dart';

/// Provider for platform-specific background scheduler
final backgroundSchedulerProvider = Provider<BackgroundScheduler>((ref) {
  if (Platform.isAndroid) {
    return const AndroidScheduler();
  } else if (Platform.isIOS) {
    return IosScheduler();
  } else {
    throw UnsupportedError(
      'Background scheduling not supported on this platform',
    );
  }
});

/// Provider for background scheduler (testable)
final backgroundSchedulerFamilyProvider =
    Provider.family<BackgroundScheduler, String>((ref, platform) {
      switch (platform) {
        case 'android':
          return const AndroidScheduler();
        case 'ios':
          return IosScheduler();
        default:
          throw ArgumentError('Unsupported platform: $platform');
      }
    });
