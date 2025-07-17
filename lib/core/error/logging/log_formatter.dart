import 'package:flutter/foundation.dart';
import 'log_level.dart';

class LogFormatter {
  static const String _ansiReset = '\x1B[0m';
  static const String _ansiRed = '\x1B[31m';
  static const String _ansiYellow = '\x1B[33m';
  static const String _ansiBlue = '\x1B[34m';
  static const String _ansiGreen = '\x1B[32m';
  static const String _ansiPurple = '\x1B[35m';

  static String format({
    required LogLevel level,
    required String message,
    required DateTime timestamp,
    String? tag,
    Map<String, dynamic>? attributes,
    StackTrace? stackTrace,
  }) {
    final buffer = StringBuffer();

    final timeStr = timestamp.toIso8601String();
    final levelStr = level.name.padRight(7);
    final tagStr = tag != null ? '[$tag]' : '';

    if (kDebugMode) {
      final color = _getColorForLevel(level);
      buffer.write('$color$timeStr $levelStr$tagStr $message$_ansiReset');
    } else {
      buffer.write('$timeStr $levelStr$tagStr $message');
    }

    if (attributes != null && attributes.isNotEmpty) {
      buffer.write(' | ');
      buffer.write(
        attributes.entries.map((e) => '${e.key}=${e.value}').join(', '),
      );
    }

    if (stackTrace != null) {
      buffer.write('\n');
      buffer.write(stackTrace.toString());
    }

    return buffer.toString();
  }

  static String _getColorForLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return _ansiBlue;
      case LogLevel.info:
        return _ansiGreen;
      case LogLevel.warning:
        return _ansiYellow;
      case LogLevel.error:
        return _ansiRed;
      case LogLevel.fatal:
        return _ansiPurple;
    }
  }
}
