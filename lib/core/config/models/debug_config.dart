import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_config.freezed.dart';
part 'debug_config.g.dart';

@freezed
abstract class DebugConfig with _$DebugConfig {
  const factory DebugConfig({
    @Default('info') String logLevel,
    @Default(false) bool enableConsoleLogging,
    @Default(false) bool enableFileLogging,
    @Default(true) bool enableNetworkLogging,
    @Default(true) bool enableCrashlytics,
  }) = _DebugConfig;

  factory DebugConfig.fromJson(Map<String, Object?> json) =>
      _$DebugConfigFromJson(json);

  const DebugConfig._();

  factory DebugConfig.forTesting() => const DebugConfig(
    logLevel: 'debug',
    enableConsoleLogging: true,
    enableFileLogging: false,
    enableNetworkLogging: true,
    enableCrashlytics: false,
  );

  bool get isDebugLevel => logLevel == 'debug';
  bool get isInfoLevel => logLevel == 'info';
  bool get isWarningLevel => logLevel == 'warning';
  bool get isErrorLevel => logLevel == 'error';
}
