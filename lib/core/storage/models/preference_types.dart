/// Type-safe preference key with serialization support
///
/// Represents a strongly-typed preference key that ensures
/// type safety when reading and writing preference values.
class PreferenceKey<T> {
  const PreferenceKey({
    required this.key,
    required this.defaultValue,
    required this.serializer,
    required this.deserializer,
  });

  /// The string key used for storage
  final String key;

  /// Default value if preference doesn't exist
  final T defaultValue;

  /// Serializer function to convert value to string
  final String Function(T value) serializer;

  /// Deserializer function to convert string back to value
  final T Function(String value) deserializer;
}

/// Common campus types for Chukyo University
enum Campus {
  nagoya('nagoya', '名古屋キャンパス'),
  toyota('toyota', '豊田キャンパス');

  const Campus(this.id, this.displayName);
  final String id;
  final String displayName;
}

/// Theme preference options
enum ThemeMode {
  system('system', 'システム'),
  light('light', 'ライト'),
  dark('dark', 'ダーク');

  const ThemeMode(this.id, this.displayName);
  final String id;
  final String displayName;
}

/// Notification frequency options
enum NotificationFrequency {
  never('never', '通知しない'),
  immediate('immediate', 'すぐに'),
  daily('daily', '1日1回'),
  weekly('weekly', '週1回');

  const NotificationFrequency(this.id, this.displayName);
  final String id;
  final String displayName;
}

/// Predefined preference keys for common app settings
abstract class PreferenceKeys {
  // Theme preferences
  static final themeMode = PreferenceKey<ThemeMode>(
    key: 'theme_mode',
    defaultValue: ThemeMode.system,
    serializer: (value) => value.id,
    deserializer: (value) => ThemeMode.values.firstWhere(
      (mode) => mode.id == value,
      orElse: () => ThemeMode.system,
    ),
  );

  // Campus preferences
  static final selectedCampus = PreferenceKey<Campus>(
    key: 'selected_campus',
    defaultValue: Campus.nagoya,
    serializer: (value) => value.id,
    deserializer: (value) => Campus.values.firstWhere(
      (campus) => campus.id == value,
      orElse: () => Campus.nagoya,
    ),
  );

  // Notification preferences
  static final assignmentNotifications = PreferenceKey<bool>(
    key: 'assignment_notifications',
    defaultValue: true,
    serializer: (value) => value.toString(),
    deserializer: (value) => value.toLowerCase() == 'true',
  );

  static final notificationFrequency = PreferenceKey<NotificationFrequency>(
    key: 'notification_frequency',
    defaultValue: NotificationFrequency.immediate,
    serializer: (value) => value.id,
    deserializer: (value) => NotificationFrequency.values.firstWhere(
      (freq) => freq.id == value,
      orElse: () => NotificationFrequency.immediate,
    ),
  );

  // App behavior preferences
  static final enableAnalytics = PreferenceKey<bool>(
    key: 'enable_analytics',
    defaultValue: true,
    serializer: (value) => value.toString(),
    deserializer: (value) => value.toLowerCase() == 'true',
  );

  static final enableCrashReporting = PreferenceKey<bool>(
    key: 'enable_crash_reporting',
    defaultValue: true,
    serializer: (value) => value.toString(),
    deserializer: (value) => value.toLowerCase() == 'true',
  );

  // Onboarding and first-time setup
  static final isFirstLaunch = PreferenceKey<bool>(
    key: 'is_first_launch',
    defaultValue: true,
    serializer: (value) => value.toString(),
    deserializer: (value) => value.toLowerCase() == 'true',
  );

  static final onboardingCompleted = PreferenceKey<bool>(
    key: 'onboarding_completed',
    defaultValue: false,
    serializer: (value) => value.toString(),
    deserializer: (value) => value.toLowerCase() == 'true',
  );

  // Language and localization
  static final languageCode = PreferenceKey<String>(
    key: 'language_code',
    defaultValue: 'ja',
    serializer: (value) => value,
    deserializer: (value) => value,
  );

  // Data sync preferences
  static final lastSyncTimestamp = PreferenceKey<DateTime?>(
    key: 'last_sync_timestamp',
    defaultValue: null,
    serializer: (value) => value?.toIso8601String() ?? '',
    deserializer: (value) => value.isEmpty ? null : DateTime.parse(value),
  );
}
