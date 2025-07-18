import 'package:flutter_test/flutter_test.dart';
import 'package:passpal/core/config/extensions/debug_config_extensions.dart';
import 'package:passpal/core/config/models/debug_config.dart';

void main() {
  group('DebugConfigExtensions', () {
    group('logLevelEnum', () {
      test('parses log level strings correctly', () {
        expect(
          const DebugConfig(logLevel: 'debug').logLevelEnum,
          LogLevel.debug,
        );
        expect(const DebugConfig(logLevel: 'info').logLevelEnum, LogLevel.info);
        expect(
          const DebugConfig(logLevel: 'warning').logLevelEnum,
          LogLevel.warning,
        );
        expect(
          const DebugConfig(logLevel: 'warn').logLevelEnum,
          LogLevel.warning,
        );
        expect(
          const DebugConfig(logLevel: 'error').logLevelEnum,
          LogLevel.error,
        );
      });

      test('handles case insensitive log levels', () {
        expect(
          const DebugConfig(logLevel: 'DEBUG').logLevelEnum,
          LogLevel.debug,
        );
        expect(const DebugConfig(logLevel: 'Info').logLevelEnum, LogLevel.info);
        expect(
          const DebugConfig(logLevel: 'WARNING').logLevelEnum,
          LogLevel.warning,
        );
      });

      test('returns info as default for unknown log level', () {
        expect(
          const DebugConfig(logLevel: 'unknown').logLevelEnum,
          LogLevel.info,
        );
      });
    });

    group('log level permission checks', () {
      test('allowsDebug returns true only for debug level', () {
        expect(const DebugConfig(logLevel: 'debug').allowsDebug, true);
        expect(const DebugConfig(logLevel: 'info').allowsDebug, false);
        expect(const DebugConfig(logLevel: 'warning').allowsDebug, false);
        expect(const DebugConfig(logLevel: 'error').allowsDebug, false);
      });

      test('allowsInfo returns true for debug and info levels', () {
        expect(const DebugConfig(logLevel: 'debug').allowsInfo, true);
        expect(const DebugConfig(logLevel: 'info').allowsInfo, true);
        expect(const DebugConfig(logLevel: 'warning').allowsInfo, false);
        expect(const DebugConfig(logLevel: 'error').allowsInfo, false);
      });

      test(
        'allowsWarning returns true for debug, info, and warning levels',
        () {
          expect(const DebugConfig(logLevel: 'debug').allowsWarning, true);
          expect(const DebugConfig(logLevel: 'info').allowsWarning, true);
          expect(const DebugConfig(logLevel: 'warning').allowsWarning, true);
          expect(const DebugConfig(logLevel: 'error').allowsWarning, false);
        },
      );

      test('allowsError returns true for all levels', () {
        expect(const DebugConfig(logLevel: 'debug').allowsError, true);
        expect(const DebugConfig(logLevel: 'info').allowsError, true);
        expect(const DebugConfig(logLevel: 'warning').allowsError, true);
        expect(const DebugConfig(logLevel: 'error').allowsError, true);
      });

      test('allowsLevel works for specific log levels', () {
        final config = const DebugConfig(logLevel: 'info');
        expect(config.allowsLevel(LogLevel.debug), false);
        expect(config.allowsLevel(LogLevel.info), true);
        expect(config.allowsLevel(LogLevel.warning), true);
        expect(config.allowsLevel(LogLevel.error), true);
      });
    });

    group('mode detection', () {
      test('isDevelopmentMode detects development configuration', () {
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableConsoleLogging: true,
          ).isDevelopmentMode,
          true,
        );
        expect(
          const DebugConfig(
            logLevel: 'info',
            enableConsoleLogging: true,
          ).isDevelopmentMode,
          false,
        );
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableConsoleLogging: false,
          ).isDevelopmentMode,
          false,
        );
      });

      test('isProductionMode detects production configuration', () {
        expect(
          const DebugConfig(
            logLevel: 'info',
            enableCrashlytics: true,
          ).isProductionMode,
          true,
        );
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableCrashlytics: true,
          ).isProductionMode,
          false,
        );
        expect(
          const DebugConfig(
            logLevel: 'info',
            enableCrashlytics: false,
          ).isProductionMode,
          false,
        );
      });

      test('hasLoggingEnabled detects any logging configuration', () {
        expect(
          const DebugConfig(enableConsoleLogging: true).hasLoggingEnabled,
          true,
        );
        expect(
          const DebugConfig(enableFileLogging: true).hasLoggingEnabled,
          true,
        );
        expect(
          const DebugConfig(enableNetworkLogging: true).hasLoggingEnabled,
          true,
        );
        expect(
          const DebugConfig(
            enableConsoleLogging: false,
            enableFileLogging: false,
            enableNetworkLogging: false,
          ).hasLoggingEnabled,
          false,
        );
      });

      test('hasEssentialLoggingOnly detects minimal logging configuration', () {
        expect(
          const DebugConfig(logLevel: 'warning').hasEssentialLoggingOnly,
          true,
        );
        expect(
          const DebugConfig(logLevel: 'error').hasEssentialLoggingOnly,
          true,
        );
        expect(
          const DebugConfig(logLevel: 'info').hasEssentialLoggingOnly,
          false,
        );
        expect(
          const DebugConfig(logLevel: 'debug').hasEssentialLoggingOnly,
          false,
        );
      });

      test('hasVerboseLogging detects verbose logging configuration', () {
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableFileLogging: true,
          ).hasVerboseLogging,
          true,
        );
        expect(
          const DebugConfig(
            logLevel: 'info',
            enableFileLogging: true,
          ).hasVerboseLogging,
          false,
        );
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableFileLogging: false,
          ).hasVerboseLogging,
          false,
        );
      });
    });

    group('should enable checks', () {
      test('shouldEnableCrashlytics respects development mode', () {
        expect(
          const DebugConfig(
            logLevel: 'info',
            enableCrashlytics: true,
          ).shouldEnableCrashlytics,
          true,
        );
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableConsoleLogging: true,
            enableCrashlytics: true,
          ).shouldEnableCrashlytics,
          false,
        );
        expect(
          const DebugConfig(
            logLevel: 'info',
            enableCrashlytics: false,
          ).shouldEnableCrashlytics,
          false,
        );
      });

      test('shouldEnableNetworkLogging respects log level', () {
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableNetworkLogging: true,
          ).shouldEnableNetworkLogging,
          true,
        );
        expect(
          const DebugConfig(
            logLevel: 'info',
            enableNetworkLogging: true,
          ).shouldEnableNetworkLogging,
          true,
        );
        expect(
          const DebugConfig(
            logLevel: 'warning',
            enableNetworkLogging: true,
          ).shouldEnableNetworkLogging,
          false,
        );
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableNetworkLogging: false,
          ).shouldEnableNetworkLogging,
          false,
        );
      });

      test('shouldEnableConsoleLogging respects flag', () {
        expect(
          const DebugConfig(
            enableConsoleLogging: true,
          ).shouldEnableConsoleLogging,
          true,
        );
        expect(
          const DebugConfig(
            enableConsoleLogging: false,
          ).shouldEnableConsoleLogging,
          false,
        );
      });

      test('shouldEnableFileLogging respects log level and flag', () {
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableFileLogging: true,
          ).shouldEnableFileLogging,
          true,
        );
        expect(
          const DebugConfig(
            logLevel: 'info',
            enableFileLogging: true,
          ).shouldEnableFileLogging,
          true,
        );
        expect(
          const DebugConfig(
            logLevel: 'warning',
            enableFileLogging: true,
          ).shouldEnableFileLogging,
          false,
        );
        expect(
          const DebugConfig(
            logLevel: 'debug',
            enableFileLogging: false,
          ).shouldEnableFileLogging,
          false,
        );
      });
    });

    group('display helpers', () {
      test('logLevelDisplayName returns correct display names', () {
        expect(
          const DebugConfig(logLevel: 'debug').logLevelDisplayName,
          'DEBUG',
        );
        expect(const DebugConfig(logLevel: 'info').logLevelDisplayName, 'INFO');
        expect(
          const DebugConfig(logLevel: 'warning').logLevelDisplayName,
          'WARNING',
        );
        expect(
          const DebugConfig(logLevel: 'error').logLevelDisplayName,
          'ERROR',
        );
      });

      test('logLevelColor returns ANSI color codes', () {
        expect(const DebugConfig(logLevel: 'debug').logLevelColor, '\x1B[36m');
        expect(const DebugConfig(logLevel: 'info').logLevelColor, '\x1B[32m');
        expect(
          const DebugConfig(logLevel: 'warning').logLevelColor,
          '\x1B[33m',
        );
        expect(const DebugConfig(logLevel: 'error').logLevelColor, '\x1B[31m');
      });

      test('logLevelPriority returns correct priority values', () {
        expect(const DebugConfig(logLevel: 'debug').logLevelPriority, 0);
        expect(const DebugConfig(logLevel: 'info').logLevelPriority, 1);
        expect(const DebugConfig(logLevel: 'warning').logLevelPriority, 2);
        expect(const DebugConfig(logLevel: 'error').logLevelPriority, 3);
      });
    });

    group('configuration builders', () {
      test('withLogLevel creates config with updated log level', () {
        const config = DebugConfig(logLevel: 'info');
        final updated = config.withLogLevel(LogLevel.debug);
        expect(updated.logLevel, 'debug');
        expect(updated.enableConsoleLogging, config.enableConsoleLogging);
      });

      test('forDevelopment creates development-optimized config', () {
        const config = DebugConfig();
        final dev = config.forDevelopment();
        expect(dev.logLevel, 'debug');
        expect(dev.enableConsoleLogging, true);
        expect(dev.enableFileLogging, true);
        expect(dev.enableNetworkLogging, true);
        expect(dev.enableCrashlytics, false);
      });

      test('forProduction creates production-optimized config', () {
        const config = DebugConfig();
        final prod = config.forProduction();
        expect(prod.logLevel, 'info');
        expect(prod.enableConsoleLogging, false);
        expect(prod.enableFileLogging, false);
        expect(prod.enableNetworkLogging, false);
        expect(prod.enableCrashlytics, true);
      });

      test('forTesting creates testing-optimized config', () {
        const config = DebugConfig();
        final test = config.forTesting();
        expect(test.logLevel, 'debug');
        expect(test.enableConsoleLogging, true);
        expect(test.enableFileLogging, false);
        expect(test.enableNetworkLogging, true);
        expect(test.enableCrashlytics, false);
      });
    });
  });
}
