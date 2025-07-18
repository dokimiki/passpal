import 'package:dartz/dartz.dart';

import '../../error/models/app_error.dart';
import '../models/admin_config.dart';
import '../models/api_config.dart';
import '../models/app_config.dart';
import '../models/auth_config.dart';
import '../models/debug_config.dart';
import '../models/feature_flags.dart';

/// Validation service for configuration objects
class ConfigValidation {
  const ConfigValidation();

  /// Validates a complete app configuration
  Either<AppError, AppConfig> validateAppConfig(AppConfig config) {
    // Validate each section
    final apiValidation = validateApiConfig(config.apiConfig);
    if (apiValidation.isLeft()) {
      return apiValidation.fold((error) => Left(error), (_) => Right(config));
    }

    final authValidation = validateAuthConfig(config.authConfig);
    if (authValidation.isLeft()) {
      return authValidation.fold((error) => Left(error), (_) => Right(config));
    }

    final debugValidation = validateDebugConfig(config.debugConfig);
    if (debugValidation.isLeft()) {
      return debugValidation.fold((error) => Left(error), (_) => Right(config));
    }

    final featureFlagsValidation = validateFeatureFlags(config.featureFlags);
    if (featureFlagsValidation.isLeft()) {
      return featureFlagsValidation.fold(
        (error) => Left(error),
        (_) => Right(config),
      );
    }

    final adminValidation = validateAdminConfig(config.adminConfig);
    if (adminValidation.isLeft()) {
      return adminValidation.fold((error) => Left(error), (_) => Right(config));
    }

    return Right(config);
  }

  /// Validates API configuration
  Either<AppError, ApiConfig> validateApiConfig(ApiConfig config) {
    // Validate URLs
    final urlValidations = [
      _validateUrl(config.manaboBaseUrl, 'manaboBaseUrl'),
      _validateUrl(config.alboBaseUrl, 'alboBaseUrl'),
      _validateUrl(config.cubicsBaseUrl, 'cubicsBaseUrl'),
      _validateUrl(config.ssoUrl, 'ssoUrl'),
      _validateUrl(config.palApiBaseUrl, 'palApiBaseUrl'),
    ];

    for (final validation in urlValidations) {
      if (validation.isLeft()) {
        return validation.fold((error) => Left(error), (_) => Right(config));
      }
    }

    // Validate timeout values
    if (config.connectionTimeoutSeconds <= 0) {
      return Left(
        AppError.now(
          message: 'connectionTimeoutSeconds must be positive',
          errorCode: 'INVALID_TIMEOUT',
          isRecoverable: false,
        ),
      );
    }

    if (config.receiveTimeoutSeconds <= 0) {
      return Left(
        AppError.now(
          message: 'receiveTimeoutSeconds must be positive',
          errorCode: 'INVALID_TIMEOUT',
          isRecoverable: false,
        ),
      );
    }

    if (config.maxRetries < 0) {
      return Left(
        AppError.now(
          message: 'maxRetries must be non-negative',
          errorCode: 'INVALID_RETRIES',
          isRecoverable: false,
        ),
      );
    }

    return Right(config);
  }

  /// Validates auth configuration
  Either<AppError, AuthConfig> validateAuthConfig(AuthConfig config) {
    // Validate email domain format
    if (!_isValidEmailDomain(config.allowedEmailDomain)) {
      return Left(
        AppError.now(
          message:
              'allowedEmailDomain must be a valid email domain (e.g., @example.com)',
          errorCode: 'INVALID_EMAIL_DOMAIN',
          isRecoverable: false,
        ),
      );
    }

    return Right(config);
  }

  /// Validates debug configuration
  Either<AppError, DebugConfig> validateDebugConfig(DebugConfig config) {
    // All debug config fields are booleans or strings, so basic validation is sufficient
    return Right(config);
  }

  /// Validates feature flags
  Either<AppError, FeatureFlags> validateFeatureFlags(FeatureFlags flags) {
    // All feature flags are booleans, so basic validation is sufficient
    return Right(flags);
  }

  /// Validates admin configuration
  Either<AppError, AdminConfig> validateAdminConfig(AdminConfig config) {
    // Validate version format
    if (!_isValidVersion(config.appVersion)) {
      return Left(
        AppError.now(
          message: 'appVersion must be a valid semantic version (e.g., 1.0.0)',
          errorCode: 'INVALID_VERSION',
          isRecoverable: false,
        ),
      );
    }

    if (!_isValidVersion(config.minSupportedVersion)) {
      return Left(
        AppError.now(
          message:
              'minSupportedVersion must be a valid semantic version (e.g., 1.0.0)',
          errorCode: 'INVALID_VERSION',
          isRecoverable: false,
        ),
      );
    }

    return Right(config);
  }

  /// Validates a URL string
  Either<AppError, String> _validateUrl(String url, String fieldName) {
    if (url.isEmpty) {
      return Left(
        AppError.now(
          message: '$fieldName cannot be empty',
          errorCode: 'EMPTY_URL',
          isRecoverable: false,
        ),
      );
    }

    try {
      final uri = Uri.parse(url);

      // Must have scheme
      if (uri.scheme.isEmpty) {
        return Left(
          AppError.now(
            message: '$fieldName must have a scheme (http or https)',
            errorCode: 'INVALID_URL_SCHEME',
            isRecoverable: false,
          ),
        );
      }

      // Must be http or https
      if (!['http', 'https'].contains(uri.scheme.toLowerCase())) {
        return Left(
          AppError.now(
            message: '$fieldName must use http or https scheme',
            errorCode: 'INVALID_URL_SCHEME',
            isRecoverable: false,
          ),
        );
      }

      // Must have host
      if (uri.host.isEmpty) {
        return Left(
          AppError.now(
            message: '$fieldName must have a valid host',
            errorCode: 'INVALID_URL_HOST',
            isRecoverable: false,
          ),
        );
      }

      // Validate host format
      if (!_isValidHost(uri.host)) {
        return Left(
          AppError.now(
            message: '$fieldName must have a valid host format',
            errorCode: 'INVALID_URL_HOST',
            isRecoverable: false,
          ),
        );
      }

      return Right(url);
    } catch (e) {
      return Left(
        AppError.now(
          message: '$fieldName is not a valid URL: $e',
          errorCode: 'INVALID_URL',
          isRecoverable: false,
        ),
      );
    }
  }

  /// Validates if a string is a valid email domain
  bool _isValidEmailDomain(String domain) {
    if (domain.isEmpty) return false;

    // Must start with @
    if (!domain.startsWith('@')) return false;

    // Remove @ and validate the domain part
    final domainPart = domain.substring(1);
    if (domainPart.isEmpty) return false;

    // Check for consecutive dots which are invalid
    if (domainPart.contains('..')) return false;

    // Basic domain validation - must have at least one dot and valid characters
    final domainRegex = RegExp(r'^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return domainRegex.hasMatch(domainPart);
  }

  /// Validates if a string is a valid semantic version
  bool _isValidVersion(String version) {
    if (version.isEmpty) return false;

    // Semantic version pattern: MAJOR.MINOR.PATCH with optional pre-release/build metadata
    final versionRegex = RegExp(
      r'^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$',
    );

    return versionRegex.hasMatch(version);
  }

  /// Validates if a string is a valid host
  bool _isValidHost(String host) {
    if (host.isEmpty) return false;

    // Check for IP address (basic validation)
    if (RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$').hasMatch(host)) {
      // Basic IP validation - each octet should be 0-255
      final octets = host.split('.');
      for (final octet in octets) {
        final value = int.tryParse(octet);
        if (value == null || value < 0 || value > 255) {
          return false;
        }
      }
      return true;
    }

    // Check for domain name
    if (host.contains('..')) return false; // No consecutive dots
    if (host.startsWith('.') || host.endsWith('.')) {
      return false; // No leading/trailing dots
    }

    // Domain name validation
    final domainRegex = RegExp(r'^[a-zA-Z0-9.-]+$');
    if (!domainRegex.hasMatch(host)) return false;

    // Each label should be valid
    final labels = host.split('.');
    for (final label in labels) {
      if (label.isEmpty) return false;
      if (label.length > 63) return false; // DNS label limit
      if (label.startsWith('-') || label.endsWith('-')) return false;
    }

    return true;
  }
}
