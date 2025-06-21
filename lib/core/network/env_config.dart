import 'package:envied/envied.dart';

part 'env_config.g.dart';

/// Environment configuration using envied for compile-time environment variables
@Envied(path: '.env')
abstract class EnvConfig {
  @EnviedField(varName: 'API_BASE_URL', defaultValue: 'https://api.example.com')
  static const String apiBaseUrl = _EnvConfig.apiBaseUrl;
  @EnviedField(varName: 'ENABLE_LOGGING', defaultValue: false)
  static const bool enableLogging = _EnvConfig.enableLogging;

  @EnviedField(
    varName: 'BASE_URL_MANABO',
    defaultValue: 'https://manabo.cnc.chukyo-u.ac.jp',
  )
  static const String manaboBaseUrl = _EnvConfig.manaboBaseUrl;

  @EnviedField(
    varName: 'BASE_URL_ALBO',
    defaultValue: 'https://cubics-pt-out.mng.chukyo-u.ac.jp',
  )
  static const String alboBaseUrl = _EnvConfig.alboBaseUrl;

  @EnviedField(
    varName: 'BASE_URL_CUBICS',
    defaultValue: 'https://cubics-as-out.mng.chukyo-u.ac.jp',
  )
  static const String cubicsBaseUrl = _EnvConfig.cubicsBaseUrl;

  @EnviedField(
    varName: 'SSO_BASE_URL',
    defaultValue: 'https://shib.chukyo-u.ac.jp',
  )
  static const String ssoBaseUrl = _EnvConfig.ssoBaseUrl;

  @EnviedField(varName: 'API_TIMEOUT_SECONDS', defaultValue: 30)
  static const int apiTimeoutSeconds = _EnvConfig.apiTimeoutSeconds;
  @EnviedField(varName: 'MAX_RETRY_ATTEMPTS', defaultValue: 3)
  static const int maxRetryAttempts = _EnvConfig.maxRetryAttempts;
}
