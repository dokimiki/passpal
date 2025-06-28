import 'package:passpal/core/error/app_exception.dart';

/// 設定関連の例外の基底クラス
abstract class ConfigException extends AppException {
  const ConfigException({
    required super.message,
    super.stack,
    super.isFatal = false,
  });
}

/// 設定値のパースエラー
class ConfigParseException extends ConfigException {
  const ConfigParseException({
    required super.message,
    required this.key,
    required this.value,
    super.stack,
  });

  final String key;
  final String value;

  @override
  String toString() =>
      'ConfigParseException: Failed to parse config "$key" with value "$value": $message';
}

/// 設定ソースからの読み込みエラー
class ConfigSourceException extends ConfigException {
  const ConfigSourceException({
    required super.message,
    required this.source,
    super.stack,
  });

  final String source;

  @override
  String toString() =>
      'ConfigSourceException: Error from source "$source": $message';
}

/// 必須設定が見つからない場合のエラー
class RequiredConfigMissingException extends ConfigException {
  const RequiredConfigMissingException({required this.key, super.stack})
    : super(
        message:
            'Required configuration key "$key" is missing from all sources',
        isFatal: true,
      );

  final String key;

  @override
  String toString() => 'RequiredConfigMissingException: $message';
}
