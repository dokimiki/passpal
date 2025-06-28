import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_config.freezed.dart';
part 'admin_config.g.dart';

/// 管理者設定
@freezed
abstract class AdminConfig with _$AdminConfig {
  const factory AdminConfig({
    // メンテナンスモード
    required bool maintenanceMode,
    // 最小バージョン
    required String minimumVersion,
  }) = _AdminConfig;

  factory AdminConfig.fromJson(Map<String, dynamic> json) =>
      _$AdminConfigFromJson(json);

  /// デフォルトの管理者設定
  static const AdminConfig defaultConfig = AdminConfig(
    maintenanceMode: false,
    minimumVersion: '0.0.0',
  );
}
