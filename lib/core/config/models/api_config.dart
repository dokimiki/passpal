import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_config.freezed.dart';
part 'api_config.g.dart';

/// Default values for API configuration
class ApiConfigDefaults {
  static const String manaboBaseUrl = 'https://manabo.cnc.chukyo-u.ac.jp';
  static const String alboBaseUrl = 'https://cubics-pt-out.mng.chukyo-u.ac.jp';
  static const String cubicsBaseUrl =
      'https://cubics-as-out.mng.chukyo-u.ac.jp';
  static const String ssoUrl = 'https://shib.chukyo-u.ac.jp';
  static const String palApiBaseUrl = 'https://api.chukyo-passpal.app/v1';
  static const int connectionTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 60;
  static const int maxRetries = 3;
}

@freezed
abstract class ApiConfig with _$ApiConfig {
  const factory ApiConfig({
    @Default(ApiConfigDefaults.manaboBaseUrl) String manaboBaseUrl,
    @Default(ApiConfigDefaults.alboBaseUrl) String alboBaseUrl,
    @Default(ApiConfigDefaults.cubicsBaseUrl) String cubicsBaseUrl,
    @Default(ApiConfigDefaults.ssoUrl) String ssoUrl,
    @Default(ApiConfigDefaults.palApiBaseUrl) String palApiBaseUrl,
    @Default(ApiConfigDefaults.connectionTimeoutSeconds)
    int connectionTimeoutSeconds,
    @Default(ApiConfigDefaults.receiveTimeoutSeconds) int receiveTimeoutSeconds,
    @Default(ApiConfigDefaults.maxRetries) int maxRetries,
  }) = _ApiConfig;

  factory ApiConfig.fromJson(Map<String, Object?> json) =>
      _$ApiConfigFromJson(json);

  const ApiConfig._();

  factory ApiConfig.forTesting() => const ApiConfig(
    manaboBaseUrl: 'https://test.manabo.jp',
    alboBaseUrl: 'https://test.albo.jp',
    cubicsBaseUrl: 'https://test.cubics.jp',
    connectionTimeoutSeconds: ApiConfigDefaults.connectionTimeoutSeconds,
    receiveTimeoutSeconds: ApiConfigDefaults.receiveTimeoutSeconds,
  );

  /// Factory method that creates ApiConfig with all default values
  factory ApiConfig.withDefaults() => const ApiConfig(
    manaboBaseUrl: ApiConfigDefaults.manaboBaseUrl,
    alboBaseUrl: ApiConfigDefaults.alboBaseUrl,
    cubicsBaseUrl: ApiConfigDefaults.cubicsBaseUrl,
    ssoUrl: ApiConfigDefaults.ssoUrl,
    palApiBaseUrl: ApiConfigDefaults.palApiBaseUrl,
    connectionTimeoutSeconds: ApiConfigDefaults.connectionTimeoutSeconds,
    receiveTimeoutSeconds: ApiConfigDefaults.receiveTimeoutSeconds,
    maxRetries: ApiConfigDefaults.maxRetries,
  );

  Duration get connectionTimeout => Duration(seconds: connectionTimeoutSeconds);
  Duration get receiveTimeout => Duration(seconds: receiveTimeoutSeconds);
}
