import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_config.freezed.dart';
part 'debug_config.g.dart';

/// デバッグ関連の設定
@freezed
abstract class DebugConfig with _$DebugConfig {
  const factory DebugConfig({
    required bool showLogs,
    required bool useMockData,
    required bool enableNetworkLogging,
    required bool enablePerformanceMonitoring,
  }) = _DebugConfig;

  factory DebugConfig.fromJson(Map<String, dynamic> json) =>
      _$DebugConfigFromJson(json);

  /// デフォルトのデバッグ設定
  static const DebugConfig defaultConfig = DebugConfig(
    showLogs: false,
    useMockData: false,
    enableNetworkLogging: false,
    enablePerformanceMonitoring: false,
  );
}
