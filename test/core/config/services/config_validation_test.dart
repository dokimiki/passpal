import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:passpal/core/config/services/config_validation.dart';
import 'package:passpal/core/config/models/admin_config.dart';
import 'package:passpal/core/config/models/api_config.dart';
import 'package:passpal/core/config/models/app_config.dart';
import 'package:passpal/core/config/models/auth_config.dart';
import 'package:passpal/core/config/models/debug_config.dart';
import 'package:passpal/core/config/models/feature_flags.dart';
import 'package:passpal/core/error/models/app_error.dart';

void main() {
  group('ConfigValidation', () {
    late ConfigValidation validation;

    setUp(() {
      validation = const ConfigValidation();
    });

    group('validateAppConfig', () {
      test('should return Right when all configs are valid', () {
        final config = AppConfig(
          apiConfig: const ApiConfig(),
          authConfig: const AuthConfig(),
          debugConfig: const DebugConfig(),
          featureFlags: const FeatureFlags(),
          adminConfig: const AdminConfig(),
        );

        final result = validation.validateAppConfig(config);

        expect(result, isA<Right<AppError, AppConfig>>());
      });

      test('should return Left when API config is invalid', () {
        final config = AppConfig(
          apiConfig: const ApiConfig(manaboBaseUrl: 'invalid-url'),
          authConfig: const AuthConfig(),
          debugConfig: const DebugConfig(),
          featureFlags: const FeatureFlags(),
          adminConfig: const AdminConfig(),
        );

        final result = validation.validateAppConfig(config);

        expect(result, isA<Left<AppError, AppConfig>>());
      });

      test('should return Left when auth config is invalid', () {
        final config = AppConfig(
          apiConfig: const ApiConfig(),
          authConfig: const AuthConfig(allowedEmailDomain: 'invalid-domain'),
          debugConfig: const DebugConfig(),
          featureFlags: const FeatureFlags(),
          adminConfig: const AdminConfig(),
        );

        final result = validation.validateAppConfig(config);

        expect(result, isA<Left<AppError, AppConfig>>());
      });

      test('should return Left when admin config is invalid', () {
        final config = AppConfig(
          apiConfig: const ApiConfig(),
          authConfig: const AuthConfig(),
          debugConfig: const DebugConfig(),
          featureFlags: const FeatureFlags(),
          adminConfig: const AdminConfig(appVersion: 'invalid-version'),
        );

        final result = validation.validateAppConfig(config);

        expect(result, isA<Left<AppError, AppConfig>>());
      });
    });

    group('validateApiConfig', () {
      test('should return Right when all URLs are valid', () {
        const config = ApiConfig(
          manaboBaseUrl: 'https://manabo.example.com',
          alboBaseUrl: 'https://albo.example.com',
          cubicsBaseUrl: 'https://cubics.example.com',
          ssoUrl: 'https://sso.example.com',
          palApiBaseUrl: 'https://api.example.com/v1',
        );

        final result = validation.validateApiConfig(config);

        expect(result, isA<Right<AppError, ApiConfig>>());
      });

      test('should return Left when URL is empty', () {
        const config = ApiConfig(manaboBaseUrl: '');

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'EMPTY_URL'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when URL has no scheme', () {
        const config = ApiConfig(manaboBaseUrl: 'example.com');

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_URL_SCHEME'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when URL has invalid scheme', () {
        const config = ApiConfig(manaboBaseUrl: 'ftp://example.com');

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_URL_SCHEME'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when URL has no host', () {
        const config = ApiConfig(manaboBaseUrl: 'https://');

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_URL_HOST'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when connection timeout is zero', () {
        const config = ApiConfig(connectionTimeoutSeconds: 0);

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_TIMEOUT'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when connection timeout is negative', () {
        const config = ApiConfig(connectionTimeoutSeconds: -1);

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_TIMEOUT'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when receive timeout is zero', () {
        const config = ApiConfig(receiveTimeoutSeconds: 0);

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_TIMEOUT'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when receive timeout is negative', () {
        const config = ApiConfig(receiveTimeoutSeconds: -1);

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_TIMEOUT'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when max retries is negative', () {
        const config = ApiConfig(maxRetries: -1);

        final result = validation.validateApiConfig(config);

        expect(result, isA<Left<AppError, ApiConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_RETRIES'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should accept zero max retries', () {
        const config = ApiConfig(maxRetries: 0);

        final result = validation.validateApiConfig(config);

        expect(result, isA<Right<AppError, ApiConfig>>());
      });

      test('should accept IP address in URL', () {
        const config = ApiConfig(manaboBaseUrl: 'https://192.168.1.1');

        final result = validation.validateApiConfig(config);

        expect(result, isA<Right<AppError, ApiConfig>>());
      });

      test('should accept localhost in URL', () {
        const config = ApiConfig(manaboBaseUrl: 'https://localhost:8080');

        final result = validation.validateApiConfig(config);

        expect(result, isA<Right<AppError, ApiConfig>>());
      });

      test('should accept URL with path', () {
        const config = ApiConfig(manaboBaseUrl: 'https://example.com/api/v1');

        final result = validation.validateApiConfig(config);

        expect(result, isA<Right<AppError, ApiConfig>>());
      });

      test('should accept URL with query parameters', () {
        const config = ApiConfig(
          manaboBaseUrl: 'https://example.com?param=value',
        );

        final result = validation.validateApiConfig(config);

        expect(result, isA<Right<AppError, ApiConfig>>());
      });
    });

    group('validateAuthConfig', () {
      test('should return Right when email domain is valid', () {
        const config = AuthConfig(allowedEmailDomain: '@example.com');

        final result = validation.validateAuthConfig(config);

        expect(result, isA<Right<AppError, AuthConfig>>());
      });

      test('should return Left when email domain is empty', () {
        const config = AuthConfig(allowedEmailDomain: '');

        final result = validation.validateAuthConfig(config);

        expect(result, isA<Left<AppError, AuthConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_EMAIL_DOMAIN'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when email domain does not start with @', () {
        const config = AuthConfig(allowedEmailDomain: 'example.com');

        final result = validation.validateAuthConfig(config);

        expect(result, isA<Left<AppError, AuthConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_EMAIL_DOMAIN'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when email domain is just @', () {
        const config = AuthConfig(allowedEmailDomain: '@');

        final result = validation.validateAuthConfig(config);

        expect(result, isA<Left<AppError, AuthConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_EMAIL_DOMAIN'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when email domain has no TLD', () {
        const config = AuthConfig(allowedEmailDomain: '@example');

        final result = validation.validateAuthConfig(config);

        expect(result, isA<Left<AppError, AuthConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_EMAIL_DOMAIN'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when email domain has invalid characters', () {
        const config = AuthConfig(allowedEmailDomain: '@example..com');

        final result = validation.validateAuthConfig(config);

        expect(result, isA<Left<AppError, AuthConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_EMAIL_DOMAIN'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should accept subdomain in email domain', () {
        const config = AuthConfig(allowedEmailDomain: '@mail.example.com');

        final result = validation.validateAuthConfig(config);

        expect(result, isA<Right<AppError, AuthConfig>>());
      });

      test('should accept multiple subdomains in email domain', () {
        const config = AuthConfig(allowedEmailDomain: '@mail.dept.example.com');

        final result = validation.validateAuthConfig(config);

        expect(result, isA<Right<AppError, AuthConfig>>());
      });
    });

    group('validateDebugConfig', () {
      test('should always return Right for debug config', () {
        const config = DebugConfig(
          logLevel: 'debug',
          enableConsoleLogging: true,
          enableFileLogging: false,
          enableNetworkLogging: true,
          enableCrashlytics: false,
        );

        final result = validation.validateDebugConfig(config);

        expect(result, isA<Right<AppError, DebugConfig>>());
      });
    });

    group('validateFeatureFlags', () {
      test('should always return Right for feature flags', () {
        const flags = FeatureFlags(
          enableOfflineMode: true,
          enablePushNotifications: false,
          enableMaintenanceMode: true,
        );

        final result = validation.validateFeatureFlags(flags);

        expect(result, isA<Right<AppError, FeatureFlags>>());
      });
    });

    group('validateAdminConfig', () {
      test('should return Right when versions are valid', () {
        const config = AdminConfig(
          appVersion: '1.0.0',
          minSupportedVersion: '1.0.0',
        );

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Right<AppError, AdminConfig>>());
      });

      test('should return Left when app version is invalid', () {
        const config = AdminConfig(appVersion: 'invalid-version');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Left<AppError, AdminConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_VERSION'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when min supported version is invalid', () {
        const config = AdminConfig(minSupportedVersion: 'invalid-version');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Left<AppError, AdminConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_VERSION'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should return Left when app version is empty', () {
        const config = AdminConfig(appVersion: '');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Left<AppError, AdminConfig>>());
        result.fold(
          (error) => expect(error.errorCode, 'INVALID_VERSION'),
          (_) => fail('Expected Left but got Right'),
        );
      });

      test('should accept semantic version with pre-release', () {
        const config = AdminConfig(appVersion: '1.0.0-alpha.1');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Right<AppError, AdminConfig>>());
      });

      test('should accept semantic version with build metadata', () {
        const config = AdminConfig(appVersion: '1.0.0+build.123');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Right<AppError, AdminConfig>>());
      });

      test(
        'should accept semantic version with both pre-release and build metadata',
        () {
          const config = AdminConfig(appVersion: '1.0.0-alpha.1+build.123');

          final result = validation.validateAdminConfig(config);

          expect(result, isA<Right<AppError, AdminConfig>>());
        },
      );

      test('should reject version with leading zeros', () {
        const config = AdminConfig(appVersion: '01.0.0');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Left<AppError, AdminConfig>>());
      });

      test('should reject version with missing parts', () {
        const config = AdminConfig(appVersion: '1.0');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Left<AppError, AdminConfig>>());
      });

      test('should reject version with too many parts', () {
        const config = AdminConfig(appVersion: '1.0.0.0');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Left<AppError, AdminConfig>>());
      });

      test('should reject version with non-numeric parts', () {
        const config = AdminConfig(appVersion: '1.0.x');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Left<AppError, AdminConfig>>());
      });

      test('should reject version with negative numbers', () {
        const config = AdminConfig(appVersion: '-1.0.0');

        final result = validation.validateAdminConfig(config);

        expect(result, isA<Left<AppError, AdminConfig>>());
      });
    });
  });
}
