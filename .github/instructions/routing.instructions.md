---
applyTo: "lib/core/routing/**"
---

# Routing & Navigation – Instruction

## Summary

-   Expose a **single GoRouter instance**.
-   Implement 4-step guards: **Auth**, **Maintenance**, **Force-Update**, **Onboarding**.
-   Enforce evaluation order and exclusive overlays (ErrorOverlay).
-   Integrate `DeepLinkHandler` for deep links, push, and background navigation – always reach consistent screen state.
-   All error and navigation flows must align with the custom error hierarchy in `core/error`.

---

## 1. Scope

| Area               | Includes                                       | Excludes               |
| ------------------ | ---------------------------------------------- | ---------------------- |
| Routing Definition | GoRouter instance, AppRoute enum, typed params | Screen implementation  |
| Guard/Redirect     | Auth, Force-Update, Maintenance, Onboarding    | Auth logic (core/auth) |
| Deep Link          | URI/FCM/App Widget → navigation                | OS URL-scheme setup    |
| Navigation Logging | NavigationObserver → GA4                       | Analytics dashboard    |
| Transitions        | Fade/Platform-default/NoAnimationPage()        | Per-screen Hero        |

---

## 2. Routing Tree

```
/
├─ login/                    # (Guard 1: unauth only)
│   ├─ student-id
│   ├─ google
│   └─ cu-id
├─ setup/                    # (Guard 2: auth & setup not done)
│   ├─ campus
│   ├─ notification
│   └─ start
├─ main/                     # (ShellRoute: 4 tabs, Guard 3: setup done & no maintenance)
│   ├─ home
│   ├─ timetable
│   │   └─ :courseId/
│   │       ├─ detail
│   │       └─ materials
│   ├─ bus
│   └─ assignments
├─ settings
├─ maintenance
├─ force-update
└─ error
```

-   Each feature adds subroutes via `ExtraRoutes` mixin.
-   Path strings are private in `routes.dart`; only `AppRoute` enum is public.

---

## 3. Guard & Redirect Policy

Order: **Force-Update → Maintenance → Auth → Setup** (do not reorder).

```dart
String? redirect(BuildContext ctx, GoRouterState state) {
  final ref        = ProviderScope.containerOf(ctx);
  final auth       = ref.read(authStateProvider);
  final rc         = ref.read(remoteConfigProvider);
  final isMaint    = ref.read(maintenanceFlagProvider);
  final setupDone  = ref.read(setupCompletedProvider);

  if (rc.forceUpdate(state.buildVersion) && state.subloc != '/force-update')
    return '/force-update';
  if (isMaint && state.subloc != '/maintenance')
    return '/maintenance';
  if (!auth.isAuthenticated && !state.subloc.startsWith('/login'))
    return '/login/student-id';
  if (auth.isAuthenticated && !setupDone && !state.subloc.startsWith('/setup'))
    return '/setup/campus';

  return null;
}
```

-   Guard must not cause double navigation (see MaintenanceException handling).
-   _core/error_ exceptions bubble to `errorBuilder` for overlay/minimum block.

---

## 4. Deep Link & Notification

-   All navigation sources (URI, FCM `"deeplink"`, widget taps) route through:

```dart
class DeepLinkHandler {
  Future<void> handle(Uri uri, {Object? pushPayload}) async {
    final extras = _parseExtras(uri, pushPayload);
    return goRouter.go(uri.path, extra: extras);
  }
}
```

-   `DeepLinkHandler` is called from background isolate if needed.
-   All route arguments must use `Freezed` RouteData classes. If parsing fails, throw `RouteParsingException` and navigate to `/error`.

---

## 5. Error Handling & Maintenance

| Source           | Exception               | Guard?   | View              |
| ---------------- | ----------------------- | -------- | ----------------- |
| Auth 401 (retry) | AuthenticationException | ✓ (Auth) | /login            |
| RemoteConfig min | ForceUpdateException    | ✓        | /force-update     |
| Maintenance flag | MaintenanceException    | ✓        | /maintenance      |
| Unhandled        | UnknownException        | –        | /error (+overlay) |

-   All errors report to Crashlytics. Only fatal errors block UX.

---

## 6. Navigation Analytics

-   Use `NavigationObserver` to send screen names to GA4.
-   Inject into GoRouter as `observers:[gaObserver]` to avoid duplicate events.

---

## 7. Transitions

-   Default: Material 3/Cupertino.
-   Fast flows (e.g. widget→detail): use `NoAnimationPage()`.
-   Modals: `fullscreenDialog:true`, no swipe-back for Android.

---

## 8. Typical Usage

Push example:

```dart
extension RouterX on WidgetRef {
  Future<void> pushAssignment(String courseId, String assignmentId) =>
    read(goRouterProvider).pushNamed(
      AppRoute.assignmentDetail.name,
      extra: AssignmentDetailArgs(courseId: courseId, assignmentId: assignmentId),
    );
}
```

In tests:

```dart
ProviderContainer(overrides:[
  goRouterProvider.overrideWithValue(MockGoRouter()),
]).read(routerX).pushAssignment(...);
```

---

## 9. Testing

| Type        | What to test                                              |
| ----------- | --------------------------------------------------------- |
| Unit        | Guard: flag combos → correct redirect                     |
| Widget      | DeepLinkHandler routes to correct page, overlay only once |
| Integration | Push/DeepLink → reflected on UI, 401 retry path           |
| Golden      | `/maintenance` screen, no BottomNav                       |

---

## 10. Folder Structure

```
lib/core/routing/
 ├─ app_router.dart          # Provider + GoRouter
 ├─ routes.dart              # AppRoute enum & path const
 ├─ guards/                  # auth_guard.dart, maintenance_guard.dart, ...
 ├─ deep_link_handler.dart
 ├─ observers/ga_observer.dart
 └─ pages/                   # MaintenancePage, ForceUpdatePage, ...
```

---

## 11. Cross-Core Interaction

-   `network → routing`: MaintenanceException triggers `/maintenance` navigation.
-   `background → routing`: DeepLinkHandler opens correct screen after background tasks.
-   `error → routing`: Use both ErrorOverlay and errorBuilder, minimize UI block.
-   `theme → routing`: Inject `ThemeData` via `MaterialApp.router(theme: ...)`.

---

**Result:**
This ensures stable, type-safe navigation and error handling even in complex states (network down, maintenance, logout, deep link).
**Order, overlays, and arguments are strictly controlled.**
