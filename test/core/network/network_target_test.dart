import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/network/network_target.dart';
import 'package:passpal/core/config/models/api_config.dart';

void main() {
  group('NetworkTarget', () {
    late ApiConfig testConfig;

    setUp(() {
      testConfig = const ApiConfig(
        palapiBaseUrl: 'https://api.chukyo-passpal.app/v1',
        alboBaseUrl: 'https://albo.chukyonet.jp',
        manaboBaseUrl: 'https://manabo.chukyonet.jp',
        cubicsBaseUrl: 'https://cubics.chukyonet.jp',
        ssoBaseUrl: 'https://sso.chukyonet.jp',
      );
    });

    test('should have correct base URLs from config', () {
      expect(
        NetworkTarget.albo.getBaseUrl(testConfig),
        'https://albo.chukyonet.jp',
      );
      expect(
        NetworkTarget.manabo.getBaseUrl(testConfig),
        'https://manabo.chukyonet.jp',
      );
      expect(
        NetworkTarget.cubics.getBaseUrl(testConfig),
        'https://cubics.chukyonet.jp',
      );
      expect(
        NetworkTarget.sso.getBaseUrl(testConfig),
        'https://sso.chukyonet.jp',
      );
      expect(
        NetworkTarget.palapi.getBaseUrl(testConfig),
        'https://api.chukyo-passpal.app/v1',
      );
    });

    test('should support custom URLs from config', () {
      final customConfig = const ApiConfig(
        palapiBaseUrl: 'https://test-api.example.com',
        alboBaseUrl: 'https://test-albo.example.com',
        manaboBaseUrl: 'https://test-manabo.example.com',
        cubicsBaseUrl: 'https://test-cubics.example.com',
        ssoBaseUrl: 'https://test-sso.example.com',
      );

      expect(
        NetworkTarget.albo.getBaseUrl(customConfig),
        'https://test-albo.example.com',
      );
      expect(
        NetworkTarget.manabo.getBaseUrl(customConfig),
        'https://test-manabo.example.com',
      );
      expect(
        NetworkTarget.cubics.getBaseUrl(customConfig),
        'https://test-cubics.example.com',
      );
      expect(
        NetworkTarget.sso.getBaseUrl(customConfig),
        'https://test-sso.example.com',
      );
      expect(
        NetworkTarget.palapi.getBaseUrl(customConfig),
        'https://test-api.example.com',
      );
    });

    test('should have correct display names', () {
      expect(NetworkTarget.albo.displayName, 'ALBO');
      expect(NetworkTarget.manabo.displayName, 'MaNaBo');
      expect(NetworkTarget.cubics.displayName, 'Cubics');
      expect(NetworkTarget.sso.displayName, 'SSO');
      expect(NetworkTarget.palapi.displayName, 'PalAPI');
    });

    test('should correctly identify auth requirements', () {
      expect(NetworkTarget.albo.requiresAuth, true);
      expect(NetworkTarget.manabo.requiresAuth, true);
      expect(NetworkTarget.cubics.requiresAuth, true);
      expect(NetworkTarget.sso.requiresAuth, false);
      expect(NetworkTarget.palapi.requiresAuth, true);
    });

    test('should correctly identify SSO cookie usage', () {
      expect(NetworkTarget.albo.usesSsoCookies, true);
      expect(NetworkTarget.manabo.usesSsoCookies, true);
      expect(NetworkTarget.cubics.usesSsoCookies, true);
      expect(NetworkTarget.sso.usesSsoCookies, false);
      expect(NetworkTarget.palapi.usesSsoCookies, false);
    });

    test('should correctly identify Bearer token usage', () {
      expect(NetworkTarget.albo.usesBearerToken, false);
      expect(NetworkTarget.manabo.usesBearerToken, false);
      expect(NetworkTarget.cubics.usesBearerToken, false);
      expect(NetworkTarget.sso.usesBearerToken, false);
      expect(NetworkTarget.palapi.usesBearerToken, true);
    });
  });
}
