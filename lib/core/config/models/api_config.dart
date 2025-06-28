import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_config.freezed.dart';
part 'api_config.g.dart';

/// API関連の設定
@freezed
abstract class ApiConfig with _$ApiConfig {
  const factory ApiConfig({required String baseUrl}) = _ApiConfig;

  factory ApiConfig.fromJson(Map<String, dynamic> json) =>
      _$ApiConfigFromJson(json);

  /// デフォルトのAPI設定
  static const ApiConfig defaultConfig = ApiConfig(
    baseUrl: 'https://api.chukyo-passpal.app/v1',
  );
}
