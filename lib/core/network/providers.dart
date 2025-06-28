import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passpal/core/config/config_providers.dart';

import 'network_client_factory.dart';
import 'network_target.dart';

/// Provider for the network client factory
final networkClientFactoryProvider = Provider.autoDispose<NetworkClientFactory>(
  (ref) {
    final connectivity = ref.watch(connectivityProvider);
    final cookieJar = ref.watch(cookieJarProvider);
    final appConfigAsync = ref.watch(appConfigProvider);

    return appConfigAsync.when(
      data: (appConfig) => NetworkClientFactory(
        apiConfig: appConfig.api,
        connectivity: connectivity,
        cookieJar: cookieJar,
        ref: ref,
      ),
      loading: () => throw StateError('Config not loaded yet'),
      error: (error, stack) =>
          throw StateError('Failed to load config: $error'),
    );
  },
);

/// Provider for network clients by target
final networkClientProvider = Provider.family.autoDispose<Dio, NetworkTarget>((
  ref,
  target,
) {
  final factory = ref.watch(networkClientFactoryProvider);
  return factory.create(target);
});

/// Provider for connectivity service
final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

/// Provider for cookie jar (for SSO authentication)
final cookieJarProvider = Provider<CookieJar>((ref) {
  // In production, you might want to use PersistCookieJar for persistence
  // For now, return memory-only cookie jar
  return CookieJar();

  // Future implementation for persistent cookies:
  // return PersistCookieJar(
  //   storage: FileStorage(
  //     await getApplicationDocumentsDirectory().then((dir) =>
  //       '${dir.path}/.cookies/'),
  //   ),
  // );
});

/// Provider for checking current connectivity status
final connectivityStatusProvider = StreamProvider<List<ConnectivityResult>>((
  ref,
) {
  final connectivity = ref.watch(connectivityProvider);
  return connectivity.onConnectivityChanged;
});

/// Provider for checking if device is online
final isOnlineProvider = Provider<bool>((ref) {
  final connectivityAsync = ref.watch(connectivityStatusProvider);

  return connectivityAsync.when(
    data: (results) => !results.contains(ConnectivityResult.none),
    loading: () => true, // Assume online while loading
    error: (_, __) => true, // Assume online on error
  );
});
