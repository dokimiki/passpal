import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flags.freezed.dart';
part 'feature_flags.g.dart';

@freezed
abstract class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    @Default(true) bool enableOfflineMode,
    @Default(true) bool enablePushNotifications,
    @Default(false) bool enableMaintenanceMode,
  }) = _FeatureFlags;

  factory FeatureFlags.fromJson(Map<String, Object?> json) =>
      _$FeatureFlagsFromJson(json);

  const FeatureFlags._();
}
