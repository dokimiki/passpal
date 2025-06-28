import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_config.freezed.dart';
part 'api_config.g.dart';

/// API関連の設定
@freezed
abstract class ApiConfig with _$ApiConfig {
  const factory ApiConfig({
    /// PalAPI のベースURL
    required String palapiBaseUrl,

    /// ALBO ポータルのベースURL
    required String alboBaseUrl,

    /// MaNaBo ポータルのベースURL
    required String manaboBaseUrl,

    /// Cubics ポータルのベースURL
    required String cubicsBaseUrl,

    /// SSO のベースURL
    required String ssoBaseUrl,
  }) = _ApiConfig;

  factory ApiConfig.fromJson(Map<String, dynamic> json) =>
      _$ApiConfigFromJson(json);

  /// デフォルトのAPI設定
  static const ApiConfig defaultConfig = ApiConfig(
    palapiBaseUrl: 'https://api.chukyo-passpal.app/v1',
    alboBaseUrl: 'https://cubics-pt-out.mng.chukyo-u.ac.jp',
    manaboBaseUrl: 'https://manabo.cnc.chukyo-u.ac.jp',
    cubicsBaseUrl: 'https://cubics-as-out.mng.chukyo-u.ac.jp',
    ssoBaseUrl: 'https://shib.chukyo-u.ac.jp',
  );
}
