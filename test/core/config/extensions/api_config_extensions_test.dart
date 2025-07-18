import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/config/extensions/api_config_extensions.dart';
import 'package:passpal/core/config/models/api_config.dart';

void main() {
  group('ApiConfigExtensions', () {
    late ApiConfig config;

    setUp(() {
      config = const ApiConfig(
        manaboBaseUrl: 'https://manabo.cnc.chukyo-u.ac.jp',
        alboBaseUrl: 'https://albo.cnc.chukyo-u.ac.jp',
        cubicsBaseUrl: 'https://cubics.cnc.chukyo-u.ac.jp',
        ssoUrl: 'https://shib.chukyo-u.ac.jp',
        palApiBaseUrl: 'https://api.chukyo-passpal.app/v1',
        connectionTimeoutSeconds: 30,
        receiveTimeoutSeconds: 60,
      );
    });

    group('getBaseUrl', () {
      test('returns correct URL for each service type', () {
        expect(
          config.getBaseUrl(ServiceType.manabo),
          'https://manabo.cnc.chukyo-u.ac.jp',
        );
        expect(
          config.getBaseUrl(ServiceType.albo),
          'https://albo.cnc.chukyo-u.ac.jp',
        );
        expect(
          config.getBaseUrl(ServiceType.cubics),
          'https://cubics.cnc.chukyo-u.ac.jp',
        );
        expect(
          config.getBaseUrl(ServiceType.sso),
          'https://shib.chukyo-u.ac.jp',
        );
        expect(
          config.getBaseUrl(ServiceType.palApi),
          'https://api.chukyo-passpal.app/v1',
        );
      });
    });

    group('getFullUrl', () {
      test('creates correct full URL with endpoint', () {
        expect(
          config.getFullUrl(ServiceType.manabo, 'login'),
          'https://manabo.cnc.chukyo-u.ac.jp/login',
        );
        expect(
          config.getFullUrl(ServiceType.palApi, '/api/assignments'),
          'https://api.chukyo-passpal.app/v1/api/assignments',
        );
      });

      test('handles endpoints with and without leading slash', () {
        expect(
          config.getFullUrl(ServiceType.manabo, 'login'),
          'https://manabo.cnc.chukyo-u.ac.jp/login',
        );
        expect(
          config.getFullUrl(ServiceType.manabo, '/login'),
          'https://manabo.cnc.chukyo-u.ac.jp/login',
        );
      });
    });

    group('getServiceTypeFromUrl', () {
      test('returns correct service type for known URLs', () {
        expect(
          config.getServiceTypeFromUrl(
            'https://manabo.cnc.chukyo-u.ac.jp/login',
          ),
          ServiceType.manabo,
        );
        expect(
          config.getServiceTypeFromUrl(
            'https://albo.cnc.chukyo-u.ac.jp/dashboard',
          ),
          ServiceType.albo,
        );
        expect(
          config.getServiceTypeFromUrl(
            'https://cubics.cnc.chukyo-u.ac.jp/courses',
          ),
          ServiceType.cubics,
        );
        expect(
          config.getServiceTypeFromUrl('https://shib.chukyo-u.ac.jp/auth'),
          ServiceType.sso,
        );
        expect(
          config.getServiceTypeFromUrl(
            'https://api.chukyo-passpal.app/v1/assignments',
          ),
          ServiceType.palApi,
        );
      });

      test('returns null for unknown URLs', () {
        expect(
          config.getServiceTypeFromUrl('https://unknown.example.com'),
          null,
        );
      });
    });

    group('service type checks', () {
      test('isPortalService returns true for portal services', () {
        expect(
          config.isPortalService('https://manabo.cnc.chukyo-u.ac.jp/login'),
          true,
        );
        expect(
          config.isPortalService('https://albo.cnc.chukyo-u.ac.jp/dashboard'),
          true,
        );
        expect(
          config.isPortalService('https://cubics.cnc.chukyo-u.ac.jp/courses'),
          true,
        );
        expect(
          config.isPortalService('https://shib.chukyo-u.ac.jp/auth'),
          false,
        );
        expect(
          config.isPortalService(
            'https://api.chukyo-passpal.app/v1/assignments',
          ),
          false,
        );
      });

      test('isPalApiService returns true for PassPal API', () {
        expect(
          config.isPalApiService(
            'https://api.chukyo-passpal.app/v1/assignments',
          ),
          true,
        );
        expect(
          config.isPalApiService('https://manabo.cnc.chukyo-u.ac.jp/login'),
          false,
        );
      });

      test('isSsoService returns true for SSO service', () {
        expect(config.isSsoService('https://shib.chukyo-u.ac.jp/auth'), true);
        expect(
          config.isSsoService('https://manabo.cnc.chukyo-u.ac.jp/login'),
          false,
        );
      });
    });

    group('URL collections', () {
      test('allPortalUrls returns all portal URLs', () {
        expect(config.allPortalUrls, [
          'https://manabo.cnc.chukyo-u.ac.jp',
          'https://albo.cnc.chukyo-u.ac.jp',
          'https://cubics.cnc.chukyo-u.ac.jp',
        ]);
      });

      test('allExternalUrls returns all external URLs', () {
        expect(config.allExternalUrls, [
          'https://manabo.cnc.chukyo-u.ac.jp',
          'https://albo.cnc.chukyo-u.ac.jp',
          'https://cubics.cnc.chukyo-u.ac.jp',
          'https://shib.chukyo-u.ac.jp',
        ]);
      });

      test('allServiceUrls returns all service URLs', () {
        expect(config.allServiceUrls, [
          'https://manabo.cnc.chukyo-u.ac.jp',
          'https://albo.cnc.chukyo-u.ac.jp',
          'https://cubics.cnc.chukyo-u.ac.jp',
          'https://shib.chukyo-u.ac.jp',
          'https://api.chukyo-passpal.app/v1',
        ]);
      });
    });

    group('getServiceDisplayName', () {
      test('returns correct display names', () {
        expect(config.getServiceDisplayName(ServiceType.manabo), 'MaNaBo');
        expect(config.getServiceDisplayName(ServiceType.albo), 'ALBO');
        expect(config.getServiceDisplayName(ServiceType.cubics), 'CUBICS');
        expect(config.getServiceDisplayName(ServiceType.sso), 'SSO');
        expect(config.getServiceDisplayName(ServiceType.palApi), 'PassPal API');
      });
    });

    group('security checks', () {
      test('allUrlsSecure returns true when all URLs use HTTPS', () {
        expect(config.allUrlsSecure, true);
      });

      test('allUrlsSecure returns false when any URL uses HTTP', () {
        final insecureConfig = config.copyWith(
          manaboBaseUrl: 'http://manabo.cnc.chukyo-u.ac.jp',
        );
        expect(insecureConfig.allUrlsSecure, false);
      });
    });

    group('testing mode checks', () {
      test('isTestingUrl identifies testing URLs', () {
        expect(config.isTestingUrl('https://test.manabo.jp'), true);
        expect(config.isTestingUrl('http://localhost:3000'), true);
        expect(config.isTestingUrl('http://127.0.0.1:8080'), true);
        expect(config.isTestingUrl('https://manabo.cnc.chukyo-u.ac.jp'), false);
      });

      test(
        'hasTestingServices identifies if any service is in testing mode',
        () {
          expect(config.hasTestingServices, false);

          final testingConfig = config.copyWith(
            manaboBaseUrl: 'https://test.manabo.jp',
          );
          expect(testingConfig.hasTestingServices, true);
        },
      );
    });

    group('getTimeoutForService', () {
      test('returns extended timeout for portal services', () {
        expect(
          config.getTimeoutForService(ServiceType.manabo),
          const Duration(seconds: 120), // 60 * 2
        );
        expect(
          config.getTimeoutForService(ServiceType.albo),
          const Duration(seconds: 120),
        );
        expect(
          config.getTimeoutForService(ServiceType.cubics),
          const Duration(seconds: 120),
        );
      });

      test('returns normal timeout for non-portal services', () {
        expect(
          config.getTimeoutForService(ServiceType.sso),
          const Duration(seconds: 60),
        );
        expect(
          config.getTimeoutForService(ServiceType.palApi),
          const Duration(seconds: 60),
        );
      });
    });

    group('withUpdatedUrl', () {
      test('creates new config with updated URL for each service', () {
        final updatedConfig = config.withUpdatedUrl(
          ServiceType.manabo,
          'https://new.manabo.jp',
        );
        expect(updatedConfig.manaboBaseUrl, 'https://new.manabo.jp');
        expect(updatedConfig.alboBaseUrl, config.alboBaseUrl);
      });

      test('updates correct URL for each service type', () {
        expect(
          config
              .withUpdatedUrl(ServiceType.manabo, 'https://new.manabo.jp')
              .manaboBaseUrl,
          'https://new.manabo.jp',
        );
        expect(
          config
              .withUpdatedUrl(ServiceType.albo, 'https://new.albo.jp')
              .alboBaseUrl,
          'https://new.albo.jp',
        );
        expect(
          config
              .withUpdatedUrl(ServiceType.cubics, 'https://new.cubics.jp')
              .cubicsBaseUrl,
          'https://new.cubics.jp',
        );
        expect(
          config.withUpdatedUrl(ServiceType.sso, 'https://new.sso.jp').ssoUrl,
          'https://new.sso.jp',
        );
        expect(
          config
              .withUpdatedUrl(ServiceType.palApi, 'https://new.api.jp')
              .palApiBaseUrl,
          'https://new.api.jp',
        );
      });
    });
  });
}
