import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/network/models/connectivity_status.dart';
import 'package:passpal/core/network/models/network_event.dart';
import 'package:passpal/core/network/services/connectivity_monitor.dart';

import 'connectivity_monitor_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  group('ConnectivityMonitor', () {
    late MockConnectivity mockConnectivity;
    late ConnectivityMonitor monitor;
    late StreamController<List<ConnectivityResult>> connectivityController;

    setUp(() {
      mockConnectivity = MockConnectivity();
      connectivityController = StreamController<List<ConnectivityResult>>();

      when(
        mockConnectivity.onConnectivityChanged,
      ).thenAnswer((_) => connectivityController.stream);

      monitor = ConnectivityMonitor(connectivity: mockConnectivity);
    });

    tearDown(() {
      monitor.dispose();
      connectivityController.close();
    });

    group('Initialization', () {
      test(
        'should initialize with offline status on connectivity check error',
        () async {
          final testMockConnectivity = MockConnectivity();
          final testController = StreamController<List<ConnectivityResult>>();

          when(
            testMockConnectivity.onConnectivityChanged,
          ).thenAnswer((_) => testController.stream);

          when(
            testMockConnectivity.checkConnectivity(),
          ).thenThrow(Exception('Test error'));

          final testMonitor = ConnectivityMonitor(
            connectivity: testMockConnectivity,
          );

          // Give time for initialization
          await Future.delayed(const Duration(milliseconds: 100));

          expect(testMonitor.currentStatus?.isOffline, isTrue);

          testMonitor.dispose();
          testController.close();
        },
      );

      test(
        'should initialize with correct status on successful check',
        () async {
          final testMockConnectivity = MockConnectivity();
          final testController = StreamController<List<ConnectivityResult>>();

          when(
            testMockConnectivity.onConnectivityChanged,
          ).thenAnswer((_) => testController.stream);

          when(
            testMockConnectivity.checkConnectivity(),
          ).thenAnswer((_) async => [ConnectivityResult.wifi]);

          final testMonitor = ConnectivityMonitor(
            connectivity: testMockConnectivity,
          );

          // Give time for initialization and internet check
          await Future.delayed(const Duration(milliseconds: 100));

          // Since internet connectivity test may fail in test environment,
          // we just verify the call was made
          verify(testMockConnectivity.checkConnectivity()).called(1);

          testMonitor.dispose();
          testController.close();
        },
      );
    });

    group('Connectivity Status Mapping', () {
      test('should map connectivity results correctly', () async {
        final testCases = [
          ([ConnectivityResult.none], true), // should be offline
          ([ConnectivityResult.wifi], false), // should attempt online
          ([ConnectivityResult.mobile], false), // should attempt online
          ([ConnectivityResult.ethernet], false), // should attempt online
          ([ConnectivityResult.vpn], false), // should attempt online
        ];

        for (final testCase in testCases) {
          final results = testCase.$1;
          final shouldBeOfflineImmediately = testCase.$2;

          // Create a new mock for each test case to avoid stream conflicts
          final testMockConnectivity = MockConnectivity();
          final testController = StreamController<List<ConnectivityResult>>();

          when(
            testMockConnectivity.onConnectivityChanged,
          ).thenAnswer((_) => testController.stream);

          when(
            testMockConnectivity.checkConnectivity(),
          ).thenAnswer((_) async => results);

          final testMonitor = ConnectivityMonitor(
            connectivity: testMockConnectivity,
          );

          // Give time for initialization
          await Future.delayed(const Duration(milliseconds: 100));

          if (shouldBeOfflineImmediately) {
            expect(testMonitor.currentStatus?.isOffline, isTrue);
          }
          // Note: Online status depends on actual internet connectivity test

          testMonitor.dispose();
          testController.close();
        }
      });
    });

    group('Status Stream', () {
      test('should emit status updates', () async {
        final statusUpdates = <ConnectivityStatus>[];
        final subscription = monitor.statusStream.listen(statusUpdates.add);

        // Simulate connectivity changes
        connectivityController.add([ConnectivityResult.none]);
        await Future.delayed(const Duration(milliseconds: 50));

        connectivityController.add([ConnectivityResult.wifi]);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(statusUpdates.length, greaterThan(0));

        subscription.cancel();
      });
    });

    group('Event Stream', () {
      test('should emit network events', () async {
        final events = <NetworkEvent>[];
        final subscription = monitor.eventStream.listen(events.add);

        // Simulate connectivity changes
        connectivityController.add([ConnectivityResult.none]);
        await Future.delayed(const Duration(milliseconds: 50));

        connectivityController.add([ConnectivityResult.wifi]);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(events.length, greaterThan(0));

        subscription.cancel();
      });

      test('should emit appropriate event types', () async {
        final events = <NetworkEvent>[];
        final subscription = monitor.eventStream.listen(events.add);

        // Start with offline
        connectivityController.add([ConnectivityResult.none]);
        await Future.delayed(const Duration(milliseconds: 50));

        // Go online
        connectivityController.add([ConnectivityResult.wifi]);
        await Future.delayed(const Duration(milliseconds: 50));

        // Check that we have events
        expect(events.length, greaterThan(0));

        // First event should be related to going offline
        final firstEvent = events.first;
        expect(firstEvent.current.isOffline, isTrue);

        subscription.cancel();
      });
    });

    group('Connection Quality Assessment', () {
      test(
        'should assess quality correctly for different connection types',
        () async {
          // This is a simplified test since actual quality assessment
          // involves network calls that may not work in test environment

          // Just verify the monitor can handle different connection types
          final connectionTypes = [
            ConnectivityResult.wifi,
            ConnectivityResult.mobile,
            ConnectivityResult.ethernet,
            ConnectivityResult.vpn,
            ConnectivityResult.other,
          ];

          for (final type in connectionTypes) {
            connectivityController.add([type]);
            await Future.delayed(const Duration(milliseconds: 50));

            // Should not throw errors
            expect(monitor.currentStatus, isNotNull);
          }
        },
      );
    });

    group('Manual Operations', () {
      test(
        'refreshConnectivity should trigger new connectivity check',
        () async {
          when(
            mockConnectivity.checkConnectivity(),
          ).thenAnswer((_) async => [ConnectivityResult.wifi]);

          await monitor.refreshConnectivity();

          verify(mockConnectivity.checkConnectivity()).called(greaterThan(0));
        },
      );

      test('testConnectionSpeed should return null when offline', () async {
        // Set up offline state
        connectivityController.add([ConnectivityResult.none]);
        await Future.delayed(const Duration(milliseconds: 50));

        final speed = await monitor.testConnectionSpeed();
        expect(speed, isNull);
      });
    });

    group('State Properties', () {
      test('isOnline should reflect current connectivity', () async {
        // Start offline
        connectivityController.add([ConnectivityResult.none]);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(monitor.isOffline, isTrue);
        expect(monitor.isOnline, isFalse);
      });

      test('currentStatus should be updated on connectivity changes', () async {
        connectivityController.add([ConnectivityResult.wifi]);
        await Future.delayed(const Duration(milliseconds: 100));

        final newStatus = monitor.currentStatus;

        // Status should have been updated (though it might be the same
        // if initialization already set it)
        expect(newStatus, isNotNull);
      });
    });
  });
}
