/// 設定関連のエラーコードとメッセージの定数定義
/// core/errorのAppExceptionとFailureと統合して使用
library;

/// 設定ファイル関連のエラーコード
class ConfigErrorCodes {
  ConfigErrorCodes._();

  // Critical errors (AppException.config)
  static const String configNotFound = 'CONFIG_NOT_FOUND';
  static const String configValidationFailed = 'CONFIG_VALIDATION_FAILED';
  static const String configInitializationFailed = 'CONFIG_INIT_FAILED';

  // Recoverable failures (Failure.configSource)
  static const String remoteConfigFetchFailed = 'REMOTE_CONFIG_FETCH_FAILED';
  static const String remoteConfigTimeout = 'REMOTE_CONFIG_TIMEOUT';
  static const String envFileNotFound = 'ENV_FILE_NOT_FOUND';
  static const String configSourceUnavailable = 'CONFIG_SOURCE_UNAVAILABLE';

  // Parse failures (Failure.configParse)
  static const String envParseError = 'ENV_PARSE_ERROR';
  static const String remoteConfigParseError = 'REMOTE_CONFIG_PARSE_ERROR';
  static const String configFormatInvalid = 'CONFIG_FORMAT_INVALID';
  static const String configValueInvalid = 'CONFIG_VALUE_INVALID';
}

/// 設定関連のエラーメッセージテンプレート
class ConfigErrorMessages {
  ConfigErrorMessages._();

  // Critical errors
  static const String configNotFound = '設定ファイルが見つかりません';
  static const String configValidationFailed = '設定の検証に失敗しました';
  static const String configInitializationFailed = '設定の初期化に失敗しました';

  // Recoverable failures
  static const String remoteConfigFetchFailed = 'リモート設定の取得に失敗しました';
  static const String remoteConfigTimeout = 'リモート設定の取得がタイムアウトしました';
  static const String envFileNotFound = '環境設定ファイルが見つかりません';
  static const String configSourceUnavailable = '設定ソースが利用できません';

  // Parse failures
  static const String envParseError = '環境設定ファイルの解析に失敗しました';
  static const String remoteConfigParseError = 'リモート設定の解析に失敗しました';
  static const String configFormatInvalid = '設定フォーマットが不正です';
  static const String configValueInvalid = '設定値が不正です';

  /// カスタムメッセージを生成するヘルパー
  static String withDetail(String baseMessage, String detail) =>
      '$baseMessage: $detail';

  static String withKey(String baseMessage, String key) =>
      '$baseMessage (key: $key)';

  static String withSource(String baseMessage, String source) =>
      '$baseMessage (source: $source)';
}

/// 設定例外のリトライ遅延設定
class ConfigRetryDelays {
  ConfigRetryDelays._();

  static const Duration remoteConfigFetch = Duration(seconds: 3);
  static const Duration envFileRead = Duration(seconds: 1);
  static const Duration configParse = Duration(seconds: 2);
  static const Duration configValidation = Duration(seconds: 1);
}
