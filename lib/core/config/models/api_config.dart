import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_config.freezed.dart';
part 'api_config.g.dart';

@freezed
abstract class ApiConfig with _$ApiConfig {
  const factory ApiConfig({
    @Default('https://manabo.cnc.chukyo-u.ac.jp') String manaboBaseUrl,
    @Default('https://cubics-pt-out.mng.chukyo-u.ac.jp') String alboBaseUrl,
    @Default('https://cubics-as-out.mng.chukyo-u.ac.jp') String cubicsBaseUrl,
    @Default('https://shib.chukyo-u.ac.jp') String ssoUrl,
    @Default('https://api.chukyo-passpal.app/v1') String palApiBaseUrl,
    @Default(30) int connectionTimeoutSeconds,
    @Default(60) int receiveTimeoutSeconds,
    @Default(3) int maxRetries,
  }) = _ApiConfig;

  factory ApiConfig.fromJson(Map<String, Object?> json) =>
      _$ApiConfigFromJson(json);

  const ApiConfig._();

  factory ApiConfig.forTesting() => const ApiConfig(
    manaboBaseUrl: 'https://test.manabo.jp',
    alboBaseUrl: 'https://test.albo.jp',
    cubicsBaseUrl: 'https://test.cubics.jp',
    connectionTimeoutSeconds: 30,
    receiveTimeoutSeconds: 30,
  );

  Duration get connectionTimeout => Duration(seconds: connectionTimeoutSeconds);
  Duration get receiveTimeout => Duration(seconds: receiveTimeoutSeconds);
}
