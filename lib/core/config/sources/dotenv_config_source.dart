import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:passpal/core/config/sources/config_source.dart';
import 'package:passpal/core/config/exceptions/config_exception.dart';

/// .envファイルからの設定を提供するソース
class DotEnvConfigSource implements ConfigSource {
  DotEnvConfigSource();

  final StreamController<String> _configChangeController =
      StreamController<String>.broadcast();

  @override
  String get sourceName => 'DotEnv';

  @override
  Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      // .envファイルが存在しない場合は無視
      // 開発環境でのみ使用され、本番では使用しない
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      return dotenv.env[key];
    } catch (e) {
      throw ConfigSourceException(
        message: 'Failed to read string value for key: $key',
        source: sourceName,
        stack: StackTrace.current,
      );
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    final value = await getString(key);
    if (value == null) return null;

    switch (value.toLowerCase()) {
      case 'true':
      case '1':
      case 'yes':
        return true;
      case 'false':
      case '0':
      case 'no':
        return false;
      default:
        throw ConfigParseException(
          message: 'Invalid boolean value',
          key: key,
          value: value,
          stack: StackTrace.current,
        );
    }
  }

  @override
  Future<int?> getInt(String key) async {
    final value = await getString(key);
    if (value == null) return null;

    try {
      return int.parse(value);
    } catch (e) {
      throw ConfigParseException(
        message: 'Invalid integer value',
        key: key,
        value: value,
        stack: StackTrace.current,
      );
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    final value = await getString(key);
    if (value == null) return null;

    try {
      return double.parse(value);
    } catch (e) {
      throw ConfigParseException(
        message: 'Invalid double value',
        key: key,
        value: value,
        stack: StackTrace.current,
      );
    }
  }

  @override
  Stream<String> get onConfigChanged => _configChangeController.stream;

  @override
  Future<void> dispose() async {
    await _configChangeController.close();
  }
}
