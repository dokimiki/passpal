import 'package:freezed_annotation/freezed_annotation.dart';

part 'retry_config.freezed.dart';

/// Configuration for retry policy
@freezed
class RetryConfig with _$RetryConfig {
  const factory RetryConfig({
    @Default(5) int maxAttempts,
    @Default(Duration(minutes: 1)) Duration baseDelay,
    @Default(2.0) double multiplier,
    @Default(Duration(hours: 1)) Duration maxDelay,
    @Default(0.3) double jitterFactor,
  }) = _RetryConfig;
}
