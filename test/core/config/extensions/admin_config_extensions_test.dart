import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/config/extensions/admin_config_extensions.dart';
import 'package:passpal/core/config/models/admin_config.dart';

void main() {
  group('AdminConfigExtensions', () {
    group('compareVersions', () {
      test('should return 0 for equal versions', () {
        expect(AdminConfigExtensions.compareVersions('1.0.0', '1.0.0'), 0);
        expect(AdminConfigExtensions.compareVersions('2.5.3', '2.5.3'), 0);
      });

      test('should return positive value when first version is greater', () {
        expect(
          AdminConfigExtensions.compareVersions('1.1.0', '1.0.0'),
          greaterThan(0),
        );
        expect(
          AdminConfigExtensions.compareVersions('2.0.0', '1.9.9'),
          greaterThan(0),
        );
        expect(
          AdminConfigExtensions.compareVersions('1.0.1', '1.0.0'),
          greaterThan(0),
        );
      });

      test('should return negative value when first version is less', () {
        expect(
          AdminConfigExtensions.compareVersions('1.0.0', '1.1.0'),
          lessThan(0),
        );
        expect(
          AdminConfigExtensions.compareVersions('1.9.9', '2.0.0'),
          lessThan(0),
        );
        expect(
          AdminConfigExtensions.compareVersions('1.0.0', '1.0.1'),
          lessThan(0),
        );
      });

      test('should handle versions with different number of parts', () {
        expect(AdminConfigExtensions.compareVersions('1.0', '1.0.0'), 0);
        expect(AdminConfigExtensions.compareVersions('1.0.0', '1.0'), 0);
        expect(
          AdminConfigExtensions.compareVersions('1.1', '1.0.1'),
          greaterThan(0),
        );
      });
    });

    group('isValidVersion', () {
      test('should return true for valid semantic versions', () {
        expect(AdminConfigExtensions.isValidVersion('1.0.0'), true);
        expect(AdminConfigExtensions.isValidVersion('10.25.99'), true);
        expect(AdminConfigExtensions.isValidVersion('0.0.1'), true);
      });

      test('should return false for invalid versions', () {
        expect(AdminConfigExtensions.isValidVersion('1.0'), false);
        expect(AdminConfigExtensions.isValidVersion('1.0.0.0'), false);
        expect(AdminConfigExtensions.isValidVersion('v1.0.0'), false);
        expect(AdminConfigExtensions.isValidVersion('1.0.0-beta'), false);
        expect(AdminConfigExtensions.isValidVersion('abc'), false);
        expect(AdminConfigExtensions.isValidVersion(''), false);
      });
    });

    group('getUpdateRequirement', () {
      late AdminConfig config;

      setUp(() {
        config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );
      });

      test('should return required when current version is below minimum', () {
        expect(
          config.getUpdateRequirement('1.4.0'),
          UpdateRequirement.required,
        );
        expect(
          config.getUpdateRequirement('1.0.0'),
          UpdateRequirement.required,
        );
      });

      test(
        'should return optional when current version is between min and latest',
        () {
          expect(
            config.getUpdateRequirement('1.5.0'),
            UpdateRequirement.optional,
          );
          expect(
            config.getUpdateRequirement('1.9.0'),
            UpdateRequirement.optional,
          );
        },
      );

      test('should return none when current version is latest or newer', () {
        expect(config.getUpdateRequirement('2.0.0'), UpdateRequirement.none);
        expect(config.getUpdateRequirement('2.1.0'), UpdateRequirement.none);
      });

      test('should return none for invalid versions', () {
        expect(config.getUpdateRequirement('invalid'), UpdateRequirement.none);
        expect(config.getUpdateRequirement('1.0'), UpdateRequirement.none);
      });
    });

    group('isForceUpdateRequired', () {
      late AdminConfig config;

      setUp(() {
        config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );
      });

      test('should return true when version is below minimum', () {
        expect(config.isForceUpdateRequired('1.4.0'), true);
        expect(config.isForceUpdateRequired('1.0.0'), true);
      });

      test('should return false when version is supported', () {
        expect(config.isForceUpdateRequired('1.5.0'), false);
        expect(config.isForceUpdateRequired('2.0.0'), false);
        expect(config.isForceUpdateRequired('2.1.0'), false);
      });
    });

    group('isOptionalUpdateAvailable', () {
      late AdminConfig config;

      setUp(() {
        config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );
      });

      test('should return true when newer version is available', () {
        expect(config.isOptionalUpdateAvailable('1.5.0'), true);
        expect(config.isOptionalUpdateAvailable('1.9.0'), true);
      });

      test('should return false when version is latest or unsupported', () {
        expect(config.isOptionalUpdateAvailable('2.0.0'), false);
        expect(config.isOptionalUpdateAvailable('2.1.0'), false);
        expect(config.isOptionalUpdateAvailable('1.4.0'), false);
      });
    });

    group('isVersionSupported', () {
      late AdminConfig config;

      setUp(() {
        config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );
      });

      test('should return true for supported versions', () {
        expect(config.isVersionSupported('1.5.0'), true);
        expect(config.isVersionSupported('2.0.0'), true);
        expect(config.isVersionSupported('2.1.0'), true);
      });

      test('should return false for unsupported versions', () {
        expect(config.isVersionSupported('1.4.0'), false);
        expect(config.isVersionSupported('1.0.0'), false);
      });

      test('should return false for invalid versions', () {
        expect(config.isVersionSupported('invalid'), false);
        expect(config.isVersionSupported('1.0'), false);
      });
    });

    group('shouldBlockApp', () {
      test('should return true when maintenance mode is enabled', () {
        final config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: true,
          maintenanceMessage: 'Under maintenance',
        );

        expect(config.shouldBlockApp('2.0.0'), true);
        expect(config.shouldBlockApp('1.5.0'), true);
      });

      test('should return true when version is unsupported', () {
        final config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );

        expect(config.shouldBlockApp('1.4.0'), true);
        expect(config.shouldBlockApp('1.0.0'), true);
      });

      test(
        'should return false when version is supported and not in maintenance',
        () {
          final config = const AdminConfig(
            appVersion: '2.0.0',
            minSupportedVersion: '1.5.0',
            isMaintenanceMode: false,
            maintenanceMessage: '',
          );

          expect(config.shouldBlockApp('1.5.0'), false);
          expect(config.shouldBlockApp('2.0.0'), false);
          expect(config.shouldBlockApp('2.1.0'), false);
        },
      );
    });

    group('getAppMessage', () {
      test('should return maintenance message when in maintenance mode', () {
        final config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: true,
          maintenanceMessage: 'システムメンテナンス中です',
        );

        expect(config.getAppMessage('2.0.0'), 'システムメンテナンス中です');
        expect(config.getAppMessage('1.0.0'), 'システムメンテナンス中です');
      });

      test(
        'should return forced update message when maintenance mode but no message',
        () {
          final config = const AdminConfig(
            appVersion: '2.0.0',
            minSupportedVersion: '1.5.0',
            isMaintenanceMode: true,
            maintenanceMessage: '',
          );

          expect(
            config.getAppMessage('1.4.0'),
            'アプリの更新が必要です。最新バージョンをインストールしてください。',
          );
        },
      );

      test(
        'should return forced update message when version is unsupported',
        () {
          final config = const AdminConfig(
            appVersion: '2.0.0',
            minSupportedVersion: '1.5.0',
            isMaintenanceMode: false,
            maintenanceMessage: '',
          );

          expect(
            config.getAppMessage('1.4.0'),
            'アプリの更新が必要です。最新バージョンをインストールしてください。',
          );
        },
      );

      test(
        'should return optional update message when newer version available',
        () {
          final config = const AdminConfig(
            appVersion: '2.0.0',
            minSupportedVersion: '1.5.0',
            isMaintenanceMode: false,
            maintenanceMessage: '',
          );

          expect(
            config.getAppMessage('1.9.0'),
            'アプリの新しいバージョンが利用可能です。更新をお勧めします。',
          );
        },
      );

      test('should return empty string when no message needed', () {
        final config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );

        expect(config.getAppMessage('2.0.0'), '');
        expect(config.getAppMessage('2.1.0'), '');
      });
    });

    group('canUseApp', () {
      test('should return false when app is blocked', () {
        final config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: true,
          maintenanceMessage: '',
        );

        expect(config.canUseApp('2.0.0'), false);
      });

      test('should return true when app is not blocked', () {
        final config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );

        expect(config.canUseApp('2.0.0'), true);
      });
    });

    group('getVersionDifference', () {
      late AdminConfig config;

      setUp(() {
        config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );
      });

      test('should return update arrow when current is older', () {
        expect(config.getVersionDifference('1.9.0'), '1.9.0 → 2.0.0');
        expect(config.getVersionDifference('1.5.0'), '1.5.0 → 2.0.0');
      });

      test('should return beta indicator when current is newer', () {
        expect(config.getVersionDifference('2.1.0'), '2.1.0 (beta)');
        expect(config.getVersionDifference('3.0.0'), '3.0.0 (beta)');
      });

      test('should return latest indicator when current is same', () {
        expect(config.getVersionDifference('2.0.0'), '2.0.0 (latest)');
      });

      test('should return empty string for invalid versions', () {
        expect(config.getVersionDifference('invalid'), '');
        expect(config.getVersionDifference('1.0'), '');
      });
    });

    group('copyWithVersion', () {
      test('should create copy with updated version info', () {
        final config = const AdminConfig(
          appVersion: '1.0.0',
          minSupportedVersion: '1.0.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );

        final updated = config.copyWithVersion(
          newAppVersion: '2.0.0',
          newMinSupportedVersion: '1.5.0',
        );

        expect(updated.appVersion, '2.0.0');
        expect(updated.minSupportedVersion, '1.5.0');
        expect(updated.isMaintenanceMode, false);
        expect(updated.maintenanceMessage, '');
      });

      test('should preserve existing values when not specified', () {
        final config = const AdminConfig(
          appVersion: '1.0.0',
          minSupportedVersion: '1.0.0',
          isMaintenanceMode: true,
          maintenanceMessage: 'test',
        );

        final updated = config.copyWithVersion(newAppVersion: '2.0.0');

        expect(updated.appVersion, '2.0.0');
        expect(updated.minSupportedVersion, '1.0.0'); // preserved
        expect(updated.isMaintenanceMode, true); // preserved
        expect(updated.maintenanceMessage, 'test'); // preserved
      });
    });

    group('copyWithMaintenance', () {
      test('should create copy with updated maintenance info', () {
        final config = const AdminConfig(
          appVersion: '1.0.0',
          minSupportedVersion: '1.0.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );

        final updated = config.copyWithMaintenance(
          maintenance: true,
          message: 'メンテナンス中',
        );

        expect(updated.isMaintenanceMode, true);
        expect(updated.maintenanceMessage, 'メンテナンス中');
        expect(updated.appVersion, '1.0.0');
        expect(updated.minSupportedVersion, '1.0.0');
      });

      test('should preserve existing values when not specified', () {
        final config = const AdminConfig(
          appVersion: '2.0.0',
          minSupportedVersion: '1.5.0',
          isMaintenanceMode: false,
          maintenanceMessage: '',
        );

        final updated = config.copyWithMaintenance(maintenance: true);

        expect(updated.isMaintenanceMode, true);
        expect(updated.maintenanceMessage, ''); // preserved
        expect(updated.appVersion, '2.0.0'); // preserved
        expect(updated.minSupportedVersion, '1.5.0'); // preserved
      });
    });

    group('UpdateRequirement enum', () {
      test('should have correct values', () {
        expect(UpdateRequirement.values.length, 3);
        expect(UpdateRequirement.values, contains(UpdateRequirement.none));
        expect(UpdateRequirement.values, contains(UpdateRequirement.optional));
        expect(UpdateRequirement.values, contains(UpdateRequirement.required));
      });
    });
  });
}
