import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flags.freezed.dart';
part 'feature_flags.g.dart';

/// 機能フラグの設定
@freezed
abstract class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    required bool enableNewAssignmentParser,
    required bool enableBiometricAuth,
    required bool enableOfflineMode,
    required bool enableExperimentalFeatures,
  }) = _FeatureFlags;

  factory FeatureFlags.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsFromJson(json);

  /// デフォルトの機能フラグ
  static const FeatureFlags defaultConfig = FeatureFlags(
    enableNewAssignmentParser: false,
    enableBiometricAuth: false,
    enableOfflineMode: false,
    enableExperimentalFeatures: false,
  );
}
