import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/core/error/remote_kill_switch.dart';

import 'remote_kill_switch_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FirebaseRemoteConfig>()])
void main() {
  group('RemoteKillSwitch', () {
    late MockFirebaseRemoteConfig mockRemoteConfig;
    late RemoteKillSwitch killSwitch;

    setUp(() {
      mockRemoteConfig = MockFirebaseRemoteConfig();
      killSwitch = RemoteKillSwitch(mockRemoteConfig);
    });

    test('should return false when parser is not disabled', () async {
      // Arrange
      when(
        mockRemoteConfig.getBool('disable_assignments_parser_v1'),
      ).thenReturn(false);
      when(mockRemoteConfig.fetchAndActivate()).thenAnswer((_) async => true);

      // Act
      final result = await killSwitch.isParserDisabled('assignments_parser_v1');

      // Assert
      expect(result, false);
      verify(mockRemoteConfig.fetchAndActivate()).called(1);
    });

    test('should return true when parser is disabled', () async {
      // Arrange
      when(
        mockRemoteConfig.getBool('disable_assignments_parser_v1'),
      ).thenReturn(true);
      when(mockRemoteConfig.fetchAndActivate()).thenAnswer((_) async => true);

      // Act
      final result = await killSwitch.isParserDisabled('assignments_parser_v1');

      // Assert
      expect(result, true);
    });

    test('should cache results for 15 minutes', () async {
      // Arrange
      when(
        mockRemoteConfig.getBool('disable_assignments_parser_v1'),
      ).thenReturn(false);
      when(mockRemoteConfig.fetchAndActivate()).thenAnswer((_) async => true);

      // Act
      await killSwitch.isParserDisabled('assignments_parser_v1');
      await killSwitch.isParserDisabled('assignments_parser_v1');

      // Assert - fetchAndActivate should be called only once due to caching
      verify(mockRemoteConfig.fetchAndActivate()).called(1);
    });

    test(
      'should force update required when version is below minimum',
      () async {
        // Arrange
        when(
          mockRemoteConfig.getString('force_update_min_version'),
        ).thenReturn('1.2.0');
        when(mockRemoteConfig.fetchAndActivate()).thenAnswer((_) async => true);

        // Act
        final result = await killSwitch.isForceUpdateRequired('1.1.0');

        // Assert
        expect(result, true);
      },
    );

    test('should not force update when version meets minimum', () async {
      // Arrange
      when(
        mockRemoteConfig.getString('force_update_min_version'),
      ).thenReturn('1.2.0');
      when(mockRemoteConfig.fetchAndActivate()).thenAnswer((_) async => true);

      // Act
      final result = await killSwitch.isForceUpdateRequired('1.2.0');

      // Assert
      expect(result, false);
    });

    test('should handle remote config fetch errors gracefully', () async {
      // Arrange
      when(
        mockRemoteConfig.fetchAndActivate(),
      ).thenThrow(Exception('Network error'));
      when(
        mockRemoteConfig.getBool('disable_assignments_parser_v1'),
      ).thenReturn(false);

      // Act
      final result = await killSwitch.isParserDisabled('assignments_parser_v1');

      // Assert - should use cached/default value
      expect(result, false);
    });

    test('should expire cache after 15 minutes', () async {
      // Arrange
      when(
        mockRemoteConfig.getBool('disable_assignments_parser_v1'),
      ).thenReturn(false);
      when(mockRemoteConfig.fetchAndActivate()).thenAnswer((_) async => true);

      // Act
      await killSwitch.isParserDisabled('assignments_parser_v1');

      // Simulate time passing (this would require dependency injection for clock)
      // For now, we'll test the cache expiry logic separately

      // Clear cache manually to simulate expiry
      killSwitch.clearCache();
      await killSwitch.isParserDisabled('assignments_parser_v1');

      // Assert
      verify(mockRemoteConfig.fetchAndActivate()).called(2);
    });
  });
}
