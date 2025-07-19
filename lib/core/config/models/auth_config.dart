import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_config.freezed.dart';
part 'auth_config.g.dart';

/// Default values for authentication configuration
class AuthConfigDefaults {
  static const String allowedEmailDomain = '@m.chukyo-u.ac.jp';
}

@freezed
abstract class AuthConfig with _$AuthConfig {
  const factory AuthConfig({
    @Default(AuthConfigDefaults.allowedEmailDomain) String allowedEmailDomain,
  }) = _AuthConfig;

  factory AuthConfig.fromJson(Map<String, Object?> json) =>
      _$AuthConfigFromJson(json);

  const AuthConfig._();

  factory AuthConfig.forTesting() =>
      const AuthConfig(allowedEmailDomain: '@test.chukyo-u.ac.jp');

  /// Factory method that creates AuthConfig with all default values
  factory AuthConfig.withDefaults() => const AuthConfig(
    allowedEmailDomain: AuthConfigDefaults.allowedEmailDomain,
  );
}
