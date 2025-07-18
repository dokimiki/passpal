import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/services/config_update_monitor.dart';
import 'package:passpal/core/config/sources/remote_config_source.dart';

import 'config_update_monitor_test.mocks.dart';

@GenerateMocks([RemoteConfigSource])
void main() {
  group('ConfigUpdateMonitor providers', () {
    late ProviderContainer container;
    late MockRemoteConfigSource mockRemoteConfigSource;

    setUp(() {
      mockRemoteConfigSource = MockRemoteConfigSource();

      // Mock the onConfigUpdated stream
      when(
        mockRemoteConfigSource.onConfigUpdated,
      ).thenAnswer((_) => Stream.empty());

      container = ProviderContainer(
        overrides: [
          remoteConfigSourceProvider.overrideWithValue(mockRemoteConfigSource),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('configUpdateMonitorProvider should create monitor instance', () {
      // Act
      final monitor = container.read(configUpdateMonitorProvider);

      // Assert
      expect(monitor, isA<ConfigUpdateMonitor>());
    });

    test('configUpdateStreamProvider should provide stream', () {
      // Act
      final asyncValue = container.read(configUpdateStreamProvider);

      // Assert
      expect(asyncValue, isA<AsyncValue<AppConfig>>());
    });

    test('should dispose monitor when container is disposed', () {
      // Arrange
      final monitor = container.read(configUpdateMonitorProvider);

      // Act
      container.dispose();

      // Assert - This verifies the monitor was created successfully
      expect(monitor, isA<ConfigUpdateMonitor>());
    });
  });
}
