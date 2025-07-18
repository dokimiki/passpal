import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_config.freezed.dart';
part 'admin_config.g.dart';

@freezed
abstract class AdminConfig with _$AdminConfig {
  const factory AdminConfig({
    @Default('1.0.0') String appVersion,
    @Default('1.0.0') String minSupportedVersion,
    @Default(false) bool isMaintenanceMode,
    @Default('') String maintenanceMessage,
  }) = _AdminConfig;

  factory AdminConfig.fromJson(Map<String, Object?> json) =>
      _$AdminConfigFromJson(json);

  const AdminConfig._();

  bool get isAppBlocked => isMaintenanceMode;
  bool get shouldShowMaintenanceMessage =>
      isMaintenanceMode && maintenanceMessage.isNotEmpty;
}
