import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'env_config.dart';
import 'portal.dart';

/// Environment configuration for the application
class Environment {
  final String apiBase;
  final bool enableLogging;
  final int timeoutSeconds;
  final int maxRetryAttempts;

  const Environment({
    required this.apiBase,
    required this.enableLogging,
    required this.timeoutSeconds,
    required this.maxRetryAttempts,
  });

  /// Creates an environment configuration for a specific portal
  factory Environment.forPortal(Portal portal) {
    final baseUrl = switch (portal) {
      Portal.manabo => EnvConfig.manaboBaseUrl,
      Portal.albo => EnvConfig.alboBaseUrl,
      Portal.cubics => EnvConfig.cubicsBaseUrl,
      Portal.sso => EnvConfig.ssoBaseUrl,
    };

    return Environment(
      apiBase: baseUrl,
      enableLogging: EnvConfig.enableLogging,
      timeoutSeconds: EnvConfig.apiTimeoutSeconds,
      maxRetryAttempts: EnvConfig.maxRetryAttempts,
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
    timeoutSeconds: EnvConfig.apiTimeoutSeconds,
    maxRetryAttempts: EnvConfig.maxRetryAttempts,
  );
});
