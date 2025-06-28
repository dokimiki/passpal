import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_config.freezed.dart';
part 'auth_config.g.dart';

/// 認証設定
@freezed
abstract class AuthConfig with _$AuthConfig {
  const factory AuthConfig({
    // 許可されたメールドメイン
    required String allowedMailDomain,
  }) = _AuthConfig;

  factory AuthConfig.fromJson(Map<String, dynamic> json) =>
      _$AuthConfigFromJson(json);

  /// デフォルトの認証設定
  static const AuthConfig defaultConfig = AuthConfig(
    allowedMailDomain: '@m.chukyo-u.ac.jp',
  );
}
