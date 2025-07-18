import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_config.freezed.dart';
part 'auth_config.g.dart';

@freezed
abstract class AuthConfig with _$AuthConfig {
  const factory AuthConfig({
    @Default('@m.chukyo-u.ac.jp') String allowedEmailDomain,
  }) = _AuthConfig;

  factory AuthConfig.fromJson(Map<String, Object?> json) =>
      _$AuthConfigFromJson(json);

  const AuthConfig._();

  factory AuthConfig.forTesting() =>
      const AuthConfig(allowedEmailDomain: '@test.chukyo-u.ac.jp');
}
