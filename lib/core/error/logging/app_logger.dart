import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../models/app_error.dart';
import 'log_level.dart';
import 'log_formatter.dart';

class AppLogger {
  final String _tag;
  final LogLevel _minimumLevel;
  static bool _devMenuLoggingEnabled = false;
  static String? _logFilePath;

  AppLogger({required String tag, LogLevel minimumLevel = LogLevel.info})
    : _tag = tag,
      _minimumLevel = minimumLevel;

  static Future<void> enableDevMenuLogging() async {
    _devMenuLoggingEnabled = true;
    await _initializeLogFile();
  }

  static void disableDevMenuLogging() {
    _devMenuLoggingEnabled = false;
    _logFilePath = null;
  }

  static Future<void> _initializeLogFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logFile = File('${directory.path}/passpal_logs.txt');
      _logFilePath = logFile.path;

      // Create file if it doesn't exist
      if (!await logFile.exists()) {
        await logFile.create(recursive: true);
      }
    } catch (e) {
      // Log file creation failed, continue without file logging
      _logFilePath = null;
    }
  }

  void debug(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.debug,
      message,
      attributes: attributes,
      stackTrace: stackTrace,
    );
  }

  void info(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.info,
      message,
      attributes: attributes,
      stackTrace: stackTrace,
    );
  }

  void warning(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.warning,
      message,
      attributes: attributes,
      stackTrace: stackTrace,
    );
  }

  void error(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      attributes: attributes,
      stackTrace: stackTrace,
    );
  }

  void fatal(
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.fatal,
      message,
      attributes: attributes,
      stackTrace: stackTrace,
    );
  }

  void logError(AppError error, {Map<String, dynamic>? additionalAttributes}) {
    final level = _getLogLevelForError(error);
    final attributes = <String, dynamic>{
      'errorCode': error.errorCode,
      'isRecoverable': error.isRecoverable,
      'timestamp': error.timestamp.toIso8601String(),
      if (error.retryDelay != null) 'retryDelay': error.retryDelay.toString(),
      if (error.context != null) ...error.context!,
      if (additionalAttributes != null) ...additionalAttributes,
    };

    _log(
      level,
      error.message,
      attributes: attributes,
      stackTrace: error.stackTrace,
    );
  }

  LogLevel _getLogLevelForError(AppError error) {
    if (error.isRecoverable) {
      return LogLevel.warning;
    }
    return LogLevel.error;
  }

  void _log(
    LogLevel level,
    String message, {
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    if (level < _minimumLevel) return;

    final timestamp = DateTime.now();
    final formattedMessage = LogFormatter.format(
      level: level,
      message: message,
      timestamp: timestamp,
      tag: _tag,
      attributes: attributes,
      stackTrace: stackTrace,
    );

    _outputToConsole(level, formattedMessage);
    _outputToCrashlytics(level, message, attributes, stackTrace);
    _outputToFile(level, formattedMessage);
  }

  void _outputToConsole(LogLevel level, String formattedMessage) {
    if (kDebugMode) {
      developer.log(formattedMessage, name: _tag, level: level.value);
    }
  }

  void _outputToCrashlytics(
    LogLevel level,
    String message,
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  ) {
    if (kReleaseMode && level >= LogLevel.warning) {
      // TODO: Implement Crashlytics logging in Issue #5
      // FirebaseCrashlytics.instance.log(message);
      // if (attributes != null) {
      //   for (final entry in attributes.entries) {
      //     FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
      //   }
      // }
    }
  }

  void _outputToFile(LogLevel level, String formattedMessage) {
    if (_devMenuLoggingEnabled &&
        _logFilePath != null &&
        level >= LogLevel.info) {
      _writeToFile(formattedMessage);
    }
  }

  void _writeToFile(String message) {
    if (_logFilePath == null) return;

    try {
      final file = File(_logFilePath!);
      file.writeAsStringSync('$message\n', mode: FileMode.append);
    } catch (e) {
      // File writing failed, continue without file logging
    }
  }

  static Future<String?> getLogFileContent() async {
    if (_logFilePath == null) return null;

    try {
      final file = File(_logFilePath!);
      if (await file.exists()) {
        return await file.readAsString();
      }
    } catch (e) {
      // File reading failed
    }
    return null;
  }

  static Future<void> clearLogFile() async {
    if (_logFilePath == null) return;

    try {
      final file = File(_logFilePath!);
      if (await file.exists()) {
        await file.delete();
        await file.create();
      }
    } catch (e) {
      // File clearing failed
    }
  }
}
