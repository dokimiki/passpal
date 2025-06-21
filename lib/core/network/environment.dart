import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'env_config.dart';
import 'portal.dart';

/// Environment configuration for the application
class Environment {
  final String apiBase;
  final bool enableLogging;
  final bool enablePinning;
  final int timeoutSeconds;
  final int maxRetryAttempts;
  final List<String> certificatePins;

  const Environment({
    required this.apiBase,
    required this.enableLogging,
    required this.enablePinning,
    required this.timeoutSeconds,
    required this.maxRetryAttempts,
    required this.certificatePins,
  });

  /// Creates an environment configuration for a specific portal
  factory Environment.forPortal(Portal portal) {
    final baseUrl = switch (portal) {
      Portal.manabo => EnvConfig.manaboBaseUrl,
      Portal.albo => EnvConfig.alboBaseUrl,
      Portal.cubics => EnvConfig.cubicsBaseUrl,
      Portal.sso => EnvConfig.ssoBaseUrl,
    };

    final pins = <String>[];
    if (EnvConfig.certPinMain.isNotEmpty) {
      pins.add(EnvConfig.certPinMain);
    }
    if (EnvConfig.certPinBackup.isNotEmpty) {
      pins.add(EnvConfig.certPinBackup);
    }

    return Environment(
      apiBase: baseUrl,
      enableLogging: EnvConfig.enableLogging,
      enablePinning: EnvConfig.enablePinning,
      timeoutSeconds: EnvConfig.apiTimeoutSeconds,
      maxRetryAttempts: EnvConfig.maxRetryAttempts,
      certificatePins: pins,
    );
  }

  /// Duration representation of the timeout
  Duration get timeout => Duration(seconds: timeoutSeconds);
}

/// Provider for environment configuration based on portal
final envProvider = Provider.family<Environment, Portal>((ref, portal) {
  return Environment.forPortal(portal);
});

/// Provider for the default environment configuration
final defaultEnvProvider = Provider<Environment>((ref) {
  return Environment(
    apiBase: EnvConfig.apiBaseUrl,
    enableLogging: EnvConfig.enableLogging,
    enablePinning: EnvConfig.enablePinning,
    timeoutSeconds: EnvConfig.apiTimeoutSeconds,
    maxRetryAttempts: EnvConfig.maxRetryAttempts,
    certificatePins: [
      if (EnvConfig.certPinMain.isNotEmpty) EnvConfig.certPinMain,
      if (EnvConfig.certPinBackup.isNotEmpty) EnvConfig.certPinBackup,
    ],
  );
});
