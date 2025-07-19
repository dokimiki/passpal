import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_config.freezed.dart';
part 'admin_config.g.dart';

/// Default values for admin configuration
class AdminConfigDefaults {
  static const String appVersion = '1.0.0';
  static const String minSupportedVersion = '1.0.0';
  static const bool isMaintenanceMode = false;
  static const String maintenanceMessage = '';
}

@freezed
abstract class AdminConfig with _$AdminConfig {
  const factory AdminConfig({
    @Default(AdminConfigDefaults.appVersion) String appVersion,
    @Default(AdminConfigDefaults.minSupportedVersion)
    String minSupportedVersion,
    @Default(AdminConfigDefaults.isMaintenanceMode) bool isMaintenanceMode,
    @Default(AdminConfigDefaults.maintenanceMessage) String maintenanceMessage,
  }) = _AdminConfig;

  factory AdminConfig.fromJson(Map<String, Object?> json) =>
      _$AdminConfigFromJson(json);

  const AdminConfig._();

  factory AdminConfig.forTesting() => const AdminConfig(
    appVersion: AdminConfigDefaults.appVersion,
    minSupportedVersion: AdminConfigDefaults.minSupportedVersion,
    isMaintenanceMode: AdminConfigDefaults.isMaintenanceMode,
    maintenanceMessage: AdminConfigDefaults.maintenanceMessage,
  );

  /// Factory method that creates AdminConfig with all default values
  factory AdminConfig.withDefaults() => const AdminConfig(
    appVersion: AdminConfigDefaults.appVersion,
    minSupportedVersion: AdminConfigDefaults.minSupportedVersion,
    isMaintenanceMode: AdminConfigDefaults.isMaintenanceMode,
    maintenanceMessage: AdminConfigDefaults.maintenanceMessage,
  );

  bool get isAppBlocked => isMaintenanceMode;
  bool get shouldShowMaintenanceMessage =>
      isMaintenanceMode && maintenanceMessage.isNotEmpty;
}
