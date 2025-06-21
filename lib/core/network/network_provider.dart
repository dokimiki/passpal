import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_dio_wrapper.dart';
import 'environment.dart';
import 'portal.dart';

/// Provider for BaseDioWrapper instances configured for specific portals
final dioWrapperProvider = Provider.family<BaseDioWrapper, Portal>((
  ref,
  portal,
) {
  final env = ref.watch(envProvider(portal));

  return BaseDioWrapper(
    baseUrl: env.apiBase,
    timeout: env.timeout,
    maxRetry: env.maxRetryAttempts,
  );
});

/// Provider for the default BaseDioWrapper instance
final defaultDioWrapperProvider = Provider<BaseDioWrapper>((ref) {
  final env = ref.watch(defaultEnvProvider);

  return BaseDioWrapper(
    baseUrl: env.apiBase,
    timeout: env.timeout,
    maxRetry: env.maxRetryAttempts,
  );
});

/// Provider for configured Dio instance for specific portals
final dioProvider = Provider.family<Dio, Portal>((ref, portal) {
  final wrapper = ref.watch(dioWrapperProvider(portal));
  return wrapper.dio;
});

/// Provider for the default configured Dio instance
final defaultDioProvider = Provider<Dio>((ref) {
  final wrapper = ref.watch(defaultDioWrapperProvider);
  return wrapper.dio;
});
