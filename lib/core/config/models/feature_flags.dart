import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flags.freezed.dart';
part 'feature_flags.g.dart';

/// Default values for feature flags
class FeatureFlagsDefaults {
  static const bool enableOfflineMode = true;
  static const bool enablePushNotifications = true;
  static const bool enableMaintenanceMode = false;
}

@freezed
abstract class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    @Default(FeatureFlagsDefaults.enableOfflineMode) bool enableOfflineMode,
    @Default(FeatureFlagsDefaults.enablePushNotifications)
    bool enablePushNotifications,
    @Default(FeatureFlagsDefaults.enableMaintenanceMode)
    bool enableMaintenanceMode,
  }) = _FeatureFlags;

  factory FeatureFlags.fromJson(Map<String, Object?> json) =>
      _$FeatureFlagsFromJson(json);

  const FeatureFlags._();

  factory FeatureFlags.forTesting() => const FeatureFlags(
    enableOfflineMode: FeatureFlagsDefaults.enableOfflineMode,
    enablePushNotifications: FeatureFlagsDefaults.enablePushNotifications,
    enableMaintenanceMode: FeatureFlagsDefaults.enableMaintenanceMode,
  );

  /// Factory method that creates FeatureFlags with all default values
  factory FeatureFlags.withDefaults() => const FeatureFlags(
    enableOfflineMode: FeatureFlagsDefaults.enableOfflineMode,
    enablePushNotifications: FeatureFlagsDefaults.enablePushNotifications,
    enableMaintenanceMode: FeatureFlagsDefaults.enableMaintenanceMode,
  );
}
