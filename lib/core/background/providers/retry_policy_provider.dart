import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../retry/retry_config.dart';
import '../retry/retry_policy.dart';

/// Provider for default retry configuration
final retryConfigProvider = Provider<RetryConfig>((ref) {
  return const RetryConfig(
    maxAttempts: 5,
    baseDelay: Duration(minutes: 1),
    multiplier: 2.0,
    maxDelay: Duration(hours: 1),
    jitterFactor: 0.3,
  );
});

/// Provider for retry policy
final retryPolicyProvider = Provider<RetryPolicy>((ref) {
  final config = ref.watch(retryConfigProvider);
  return RetryPolicy(config);
});

/// Provider family for custom retry policies
final retryPolicyFamilyProvider = Provider.family<RetryPolicy, RetryConfig>((
  ref,
  config,
) {
  return RetryPolicy(config);
});
