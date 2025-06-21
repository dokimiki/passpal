import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/network_provider.dart';
import '../../../../core/network/portal.dart';
import 'auth_api.dart';

/// Provider for AuthApi instances configured for specific portals
final authApiProvider = Provider.family<AuthApi, Portal>((ref, portal) {
  final dio = ref.watch(dioProvider(portal));
  return AuthApi(dio);
});

/// Provider for the default AuthApi instance (using SSO portal)
final defaultAuthApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider(Portal.sso));
  return AuthApi(dio);
});
