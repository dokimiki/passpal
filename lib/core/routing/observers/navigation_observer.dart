import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Navigation observer for analytics and debugging
class NavigationObserver extends NavigatorObserver {
  NavigationObserver(this._ref);

  // ignore: unused_field
  final Ref _ref;

  // Firebase Analytics instance for tracking navigation events
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Firebase Crashlytics instance for breadcrumb tracking
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logNavigation('push', route, previousRoute);
    _trackScreenView(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logNavigation('pop', route, previousRoute);
    if (previousRoute != null) {
      _trackScreenView(previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logNavigation('replace', newRoute, oldRoute);
    if (newRoute != null) {
      _trackScreenView(newRoute);
    }
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

    // Send navigation events to Firebase Analytics
    _analytics.logEvent(
      name: 'navigation',
      parameters: {
        'action': action,
        'from_screen': previousRouteName,
        'to_screen': routeName,
      },
    );

    // Send navigation events to Crashlytics breadcrumbs
    _crashlytics.log(
      'Navigation: $action from $previousRouteName to $routeName',
    );
  }

  /// Track screen view events for Firebase Analytics
  void _trackScreenView(Route<dynamic> route) {
    final routeName = route.settings.name;
    if (routeName != null && routeName.isNotEmpty) {
      _analytics.logScreenView(
        screenName: routeName,
        screenClass: route.runtimeType.toString(),
      );
    }
  }
}
