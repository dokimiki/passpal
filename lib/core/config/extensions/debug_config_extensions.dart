import '../models/debug_config.dart';

/// Log level enumeration for type safety
enum LogLevel {
  /// Debug level (most verbose)
  debug,

  /// Info level (default)
  info,

  /// Warning level
  warning,

  /// Error level (least verbose)
  error,
}

/// Extended functionality for DebugConfig
extension DebugConfigExtensions on DebugConfig {
  /// Parse log level string to LogLevel enum
  LogLevel get logLevelEnum {
    switch (logLevel.toLowerCase()) {
      case 'debug':
        return LogLevel.debug;
      case 'info':
        return LogLevel.info;
      case 'warning':
      case 'warn':
        return LogLevel.warning;
      case 'error':
        return LogLevel.error;
      default:
        return LogLevel.info; // Default fallback
    }
  }

  /// Check if current log level allows debug messages
  bool get allowsDebug => logLevelEnum == LogLevel.debug;

  /// Check if current log level allows info messages
  bool get allowsInfo => logLevelEnum.index <= LogLevel.info.index;

  /// Check if current log level allows warning messages
  bool get allowsWarning => logLevelEnum.index <= LogLevel.warning.index;

  /// Check if current log level allows error messages
  bool get allowsError => logLevelEnum.index <= LogLevel.error.index;

  /// Check if a specific log level is allowed
  bool allowsLevel(LogLevel level) => logLevelEnum.index <= level.index;

  /// Get numeric priority for log level (lower = higher priority)
  int get logLevelPriority => logLevelEnum.index;

  /// Check if development mode is enabled (debug level + console logging)
  bool get isDevelopmentMode => isDebugLevel && enableConsoleLogging;

  /// Check if production mode is enabled (no debug level + crashlytics)
  bool get isProductionMode => !isDebugLevel && enableCrashlytics;

  /// Check if any logging is enabled
  bool get hasLoggingEnabled =>
      enableConsoleLogging || enableFileLogging || enableNetworkLogging;

  /// Check if only essential logging is enabled (warnings and errors)
  bool get hasEssentialLoggingOnly =>
      (logLevelEnum == LogLevel.warning || logLevelEnum == LogLevel.error);

  /// Check if verbose logging is enabled (debug level + file logging)
  bool get hasVerboseLogging => isDebugLevel && enableFileLogging;

  /// Check if Crashlytics should be enabled based on conditions
  bool get shouldEnableCrashlytics {
    // Enable Crashlytics if explicitly enabled and not in debug mode
    return enableCrashlytics && !isDevelopmentMode;
  }

  /// Check if network logging should be enabled
  bool get shouldEnableNetworkLogging {
    // Enable network logging if explicitly enabled and appropriate log level
    return enableNetworkLogging && (allowsDebug || allowsInfo);
  }

  /// Check if console logging should be enabled
  bool get shouldEnableConsoleLogging {
    // Enable console logging if explicitly enabled
    return enableConsoleLogging;
  }

  /// Check if file logging should be enabled
  bool get shouldEnableFileLogging {
    // Enable file logging if explicitly enabled and appropriate log level
    return enableFileLogging && (allowsDebug || allowsInfo);
  }

  /// Get log level display name
  String get logLevelDisplayName {
    switch (logLevelEnum) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.error:
        return 'ERROR';
    }
  }

  /// Get log level color for console output
  String get logLevelColor {
    switch (logLevelEnum) {
      case LogLevel.debug:
        return '\x1B[36m'; // Cyan
      case LogLevel.info:
        return '\x1B[32m'; // Green
      case LogLevel.warning:
        return '\x1B[33m'; // Yellow
      case LogLevel.error:
        return '\x1B[31m'; // Red
    }
  }

  /// Create a copy with updated log level
  DebugConfig withLogLevel(LogLevel level) {
    final levelString = switch (level) {
      LogLevel.debug => 'debug',
      LogLevel.info => 'info',
      LogLevel.warning => 'warning',
      LogLevel.error => 'error',
    };
    return copyWith(logLevel: levelString);
  }

  /// Create a copy optimized for development
  DebugConfig forDevelopment() => copyWith(
    logLevel: 'debug',
    enableConsoleLogging: true,
    enableFileLogging: true,
    enableNetworkLogging: true,
    enableCrashlytics: false,
  );

  /// Create a copy optimized for production
  DebugConfig forProduction() => copyWith(
    logLevel: 'info',
    enableConsoleLogging: false,
    enableFileLogging: false,
    enableNetworkLogging: false,
    enableCrashlytics: true,
  );

  /// Create a copy optimized for testing
  DebugConfig forTesting() => copyWith(
    logLevel: 'debug',
    enableConsoleLogging: true,
    enableFileLogging: false,
    enableNetworkLogging: true,
    enableCrashlytics: false,
  );
}
