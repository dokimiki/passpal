import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_config.freezed.dart';
part 'debug_config.g.dart';

/// Default values for debug configuration
class DebugConfigDefaults {
  static const String logLevel = 'info';
  static const bool enableConsoleLogging = false;
  static const bool enableFileLogging = false;
  static const bool enableNetworkLogging = true;
  static const bool enableCrashlytics = true;
}

@freezed
abstract class DebugConfig with _$DebugConfig {
  const factory DebugConfig({
    @Default(DebugConfigDefaults.logLevel) String logLevel,
    @Default(DebugConfigDefaults.enableConsoleLogging)
    bool enableConsoleLogging,
    @Default(DebugConfigDefaults.enableFileLogging) bool enableFileLogging,
    @Default(DebugConfigDefaults.enableNetworkLogging)
    bool enableNetworkLogging,
    @Default(DebugConfigDefaults.enableCrashlytics) bool enableCrashlytics,
  }) = _DebugConfig;

  factory DebugConfig.fromJson(Map<String, Object?> json) =>
      _$DebugConfigFromJson(json);

  const DebugConfig._();

  factory DebugConfig.forTesting() => const DebugConfig(
    logLevel: 'debug',
    enableConsoleLogging: true,
    enableFileLogging: DebugConfigDefaults.enableFileLogging,
    enableNetworkLogging: DebugConfigDefaults.enableNetworkLogging,
    enableCrashlytics: false,
  );

  /// Factory method that creates DebugConfig with all default values
  factory DebugConfig.withDefaults() => const DebugConfig(
    logLevel: DebugConfigDefaults.logLevel,
    enableConsoleLogging: DebugConfigDefaults.enableConsoleLogging,
    enableFileLogging: DebugConfigDefaults.enableFileLogging,
    enableNetworkLogging: DebugConfigDefaults.enableNetworkLogging,
    enableCrashlytics: DebugConfigDefaults.enableCrashlytics,
  );

  bool get isDebugLevel => logLevel == 'debug';
  bool get isInfoLevel => logLevel == 'info';
  bool get isWarningLevel => logLevel == 'warning';
  bool get isErrorLevel => logLevel == 'error';
}
