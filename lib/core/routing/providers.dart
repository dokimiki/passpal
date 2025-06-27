import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/deep_link_handler.dart';
import 'package:passpal/core/routing/observers/navigation_observer.dart';
import 'package:passpal/core/routing/app_router.dart';

/// GoRouter provider
final goRouterProvider = Provider<GoRouter>((ref) {
  return createAppRouter(ref);
});

/// Deep link handler provider
final deepLinkHandlerProvider = Provider<DeepLinkHandler>((ref) {
  final router = ref.read(goRouterProvider);
  return DeepLinkHandler(router);
});

/// Navigation observer provider
final navigationObserverProvider = Provider<NavigationObserver>((ref) {
  return NavigationObserver(ref);
});

/// Setup completion status provider (placeholder)
/// TODO: Implement actual setup completion logic
final setupCompletedProvider = Provider<bool>((ref) {
  // Placeholder - replace with actual setup state
  return false;
});

/// Maintenance flag provider (placeholder)
/// TODO: Connect to actual maintenance status from remote config
final maintenanceFlagProvider = Provider<bool>((ref) {
  // Placeholder - replace with actual maintenance check
  return false;
});

/// Remote config provider (placeholder)
/// TODO: Connect to actual remote config service
final remoteConfigProvider = Provider<RemoteConfigService>((ref) {
  return const RemoteConfigService();
});

/// Placeholder remote config service
class RemoteConfigService {
  const RemoteConfigService();

  /// Check if force update is required
  bool requiresForceUpdate({String? currentVersion}) {
    // Placeholder implementation
    return false;
  }

  /// Get minimum required version
  String? get minimumVersion => null;
}
