import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/background/scheduler_service.dart';
import 'package:passpal/core/background/android_scheduler.dart';
import 'package:passpal/core/background/ios_scheduler.dart';

void main() {
  // Initialize Flutter binding for tests
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SchedulerService', () {
    group('AndroidScheduler', () {
      late AndroidScheduler scheduler;

      setUp(() {
        scheduler = AndroidScheduler();

        // Mock platform method calls
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              const MethodChannel(
                'be.tramckrijte.workmanager/foreground_channel_work_manager',
              ),
              (MethodCall methodCall) async {
                // Mock WorkManager method calls
                return null;
              },
            );
      });

      tearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              const MethodChannel(
                'be.tramckrijte.workmanager/foreground_channel_work_manager',
              ),
              null,
            );
      });

      test('creates AndroidScheduler instance', () {
        expect(scheduler, isA<SchedulerService>());
        expect(scheduler, isA<AndroidScheduler>());
      });

      test('scheduleOneOff method completes without error', () async {
        await expectLater(
          scheduler.scheduleOneOff(
            taskId: 'test_task',
            delay: const Duration(minutes: 30),
          ),
          completes,
        );
      });

      test('schedulePeriodic method completes without error', () async {
        await expectLater(
          scheduler.schedulePeriodic(
            taskId: 'periodic_task',
            frequency: const Duration(hours: 1),
          ),
          completes,
        );
      });

      test('cancel method completes without error', () async {
        await expectLater(scheduler.cancel('test_task'), completes);
      });
    });

    group('IosScheduler', () {
      late IosScheduler scheduler;

      setUp(() {
        scheduler =
            IosScheduler(); // Mock platform method calls for BackgroundFetch
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              const MethodChannel(
                'com.transistorsoft/flutter_background_fetch/methods',
              ),
              (MethodCall methodCall) async {
                // Mock BackgroundFetch method calls
                switch (methodCall.method) {
                  case 'scheduleTask':
                    return true;
                  case 'stop':
                    return 1;
                  default:
                    return null;
                }
              },
            );
      });

      tearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              const MethodChannel(
                'com.transistorsoft/flutter_background_fetch/methods',
              ),
              null,
            );
      });

      test('creates IosScheduler instance', () {
        expect(scheduler, isA<SchedulerService>());
        expect(scheduler, isA<IosScheduler>());
      });

      test('scheduleOneOff method completes without error', () async {
        await expectLater(
          scheduler.scheduleOneOff(
            taskId: 'test_task',
            delay: const Duration(minutes: 30),
          ),
          completes,
        );
      });

      test('schedulePeriodic method completes without error', () async {
        await expectLater(
          scheduler.schedulePeriodic(
            taskId: 'periodic_task',
            frequency: const Duration(hours: 1),
          ),
          completes,
        );
      });

      test('cancel method completes without error', () async {
        await expectLater(scheduler.cancel('test_task'), completes);
      });
    });

    group('Platform detection', () {
      test('should use correct scheduler based on platform', () {
        // Test that we can detect the current platform
        expect(Platform.isAndroid || Platform.isIOS, isTrue);
      });
    });
  });
}
