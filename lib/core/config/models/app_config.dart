import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    @Default('1.0.0') String version,
    @Default(true) bool enableAnalytics,
    @Default(true) bool enableCrashReporting,
    @Default(false) bool enableDebugMode,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, Object?> json) =>
      _$AppConfigFromJson(json);

  const AppConfig._();
}
