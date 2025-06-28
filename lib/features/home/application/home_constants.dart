/// TTL (Time To Live) constants for home feature data caching
class HomeTtl {
  const HomeTtl._();

  /// System news cache TTL: 5 minutes
  static const Duration systemNews = Duration(minutes: 5);

  /// Received mail cache TTL: 2 minutes
  static const Duration receivedMail = Duration(minutes: 2);

  /// Mail body cache TTL: 0 minutes (no caching for full mail content)
  static const Duration mailBody = Duration.zero;

  /// ALBO news cache TTL: 10 minutes
  static const Duration alboNews = Duration(minutes: 10);
}

/// Background task intervals for home feature
class HomeTaskIntervals {
  const HomeTaskIntervals._();

  /// System news background refresh: every 2 hours
  static const Duration systemNewsRefresh = Duration(hours: 2);

  /// Mail background refresh: every 30 minutes
  static const Duration mailRefresh = Duration(minutes: 30);

  /// ALBO news background refresh: every hour
  static const Duration alboNewsRefresh = Duration(hours: 1);
}
