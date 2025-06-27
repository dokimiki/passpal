import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Navigation observer for analytics and debugging
class NavigationObserver extends NavigatorObserver {
  NavigationObserver(this._ref);

  // ignore: unused_field
  final Ref _ref;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logNavigation('push', route, previousRoute);
    // TODO: Implement analytics tracking with _ref.read(analyticsProvider)
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logNavigation('pop', route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logNavigation('replace', newRoute, oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logNavigation('remove', route, previousRoute);
  }

  void _logNavigation(
    String action,
    Route<dynamic>? route,
    Route<dynamic>? previousRoute,
  ) {
    final routeName = route?.settings.name ?? 'unknown';
    final previousRouteName = previousRoute?.settings.name ?? 'none';

    // Debug logging
    debugPrint('Navigation: $action from $previousRouteName to $routeName');

    // TODO: Send to GA4 analytics
    // final analytics = _ref.read(analyticsProvider);
    // analytics.logScreenView(screenName: routeName);

    // TODO: Send navigation events to Crashlytics breadcrumbs
    // final crashlytics = _ref.read(crashlyticsReporterProvider);
    // crashlytics.addBreadcrumb(
    //   message: 'Navigation: $action to $routeName',
    //   category: 'navigation',
    // );
  }
}
