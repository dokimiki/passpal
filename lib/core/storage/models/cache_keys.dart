/// Predefined cache keys for consistent caching across the app
///
/// Provides type-safe cache key definitions with consistent naming
/// conventions and TTL configurations for different types of data.
abstract class CacheKeys {
  // User authentication cache
  static const String userSession = 'user_session';
  static const String userProfile = 'user_profile';
  static const String authTokens = 'auth_tokens';

  // Academic data cache
  static const String timetable = 'timetable';
  static const String assignments = 'assignments';
  static const String grades = 'grades';
  static const String attendance = 'attendance';

  // Portal data cache (MaNaBo, ALBO, CUBICS)
  static const String manaboData = 'manabo_data';
  static const String alboNews = 'albo_news';
  static const String cubicsSchedule = 'cubics_schedule';

  // Transport and campus information
  static const String busSchedule = 'bus_schedule';
  static const String trainSchedule = 'train_schedule';
  static const String campusMap = 'campus_map';

  // App configuration cache
  static const String appConfig = 'app_config';
  static const String featureFlags = 'feature_flags';
  static const String remoteConfig = 'remote_config';

  // Notification cache
  static const String pendingNotifications = 'pending_notifications';
  static const String notificationHistory = 'notification_history';

  // Offline content cache
  static const String courseMaterials = 'course_materials';
  static const String downloadedFiles = 'downloaded_files';

  // Analytics and usage data
  static const String usageMetrics = 'usage_metrics';
  static const String errorLogs = 'error_logs';
}

/// Cache key utilities for generating dynamic keys
abstract class CacheKeyUtils {
  /// Generate a user-specific cache key
  static String userKey(String baseKey, String userId) => '${baseKey}_$userId';

  /// Generate a course-specific cache key
  static String courseKey(String baseKey, String courseId) =>
      '${baseKey}_course_$courseId';

  /// Generate a date-specific cache key
  static String dateKey(String baseKey, DateTime date) =>
      '${baseKey}_${date.toIso8601String().split('T')[0]}';

  /// Generate a campus-specific cache key
  static String campusKey(String baseKey, String campusId) =>
      '${baseKey}_$campusId';

  /// Generate a versioned cache key
  static String versionedKey(String baseKey, String version) =>
      '${baseKey}_v$version';
}

/// Default TTL configurations for different types of cached data
abstract class CacheTTL {
  // Short-lived cache (5 minutes)
  static const Duration realtime = Duration(minutes: 5);

  // Medium-lived cache (1 hour)
  static const Duration session = Duration(hours: 1);

  // Long-lived cache (1 day)
  static const Duration daily = Duration(days: 1);

  // Very long-lived cache (1 week)
  static const Duration weekly = Duration(days: 7);

  // Static content cache (1 month)
  static const Duration monthly = Duration(days: 30);

  // Specific TTL for different data types
  static const Duration userSession = session;
  static const Duration timetable = daily;
  static const Duration assignments = realtime;
  static const Duration news = session;
  static const Duration transportSchedule = daily;
  static const Duration appConfig = weekly;
  static const Duration courseMaterials = monthly;
}
