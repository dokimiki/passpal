import '../../error/models/app_exception.dart';
import '../../error/models/failure.dart';
import 'config_error_types.dart';

/// 設定関連の例外を作成するためのファクトリークラス
/// core/errorのAppExceptionとFailureと統合
class ConfigExceptionFactory {
  ConfigExceptionFactory._();

  // Critical config exceptions (non-recoverable)

  /// 設定ファイルが見つからない場合の例外
  static AppException configNotFound({
    String? detail,
    String? source,
    StackTrace? stackTrace,
  }) => AppException.configNow(
    message: detail != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.configNotFound,
            detail,
          )
        : ConfigErrorMessages.configNotFound,
    errorCode: ConfigErrorCodes.configNotFound,
    stackTrace: stackTrace,
    context: source != null ? {'source': source} : null,
  );

  /// 設定の検証に失敗した場合の例外
  static AppException configValidationFailed({
    String? detail,
    String? key,
    StackTrace? stackTrace,
  }) => AppException.configNow(
    message: detail != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.configValidationFailed,
            detail,
          )
        : ConfigErrorMessages.configValidationFailed,
    errorCode: ConfigErrorCodes.configValidationFailed,
    stackTrace: stackTrace,
    context: key != null ? {'key': key} : null,
  );

  /// 設定の初期化に失敗した場合の例外
  static AppException configInitializationFailed({
    String? detail,
    Object? cause,
    StackTrace? stackTrace,
  }) => AppException.configNow(
    message: detail != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.configInitializationFailed,
            detail,
          )
        : ConfigErrorMessages.configInitializationFailed,
    errorCode: ConfigErrorCodes.configInitializationFailed,
    stackTrace: stackTrace,
    context: cause != null ? {'cause': cause.toString()} : null,
  );

  // Config source failures (recoverable)

  /// リモート設定の取得に失敗した場合の失敗
  static Failure remoteConfigFetchFailed({
    String? detail,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) => Failure.configSourceNow(
    message: detail != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.remoteConfigFetchFailed,
            detail,
          )
        : ConfigErrorMessages.remoteConfigFetchFailed,
    errorCode: ConfigErrorCodes.remoteConfigFetchFailed,
    stackTrace: stackTrace,
    retryDelay: canRetry ? ConfigRetryDelays.remoteConfigFetch : null,
  );

  /// リモート設定の取得がタイムアウトした場合の失敗
  static Failure remoteConfigTimeout({
    Duration? timeout,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) => Failure.configSourceNow(
    message: timeout != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.remoteConfigTimeout,
            '${timeout.inSeconds}秒',
          )
        : ConfigErrorMessages.remoteConfigTimeout,
    errorCode: ConfigErrorCodes.remoteConfigTimeout,
    stackTrace: stackTrace,
    retryDelay: canRetry ? ConfigRetryDelays.remoteConfigFetch : null,
    context: timeout != null ? {'timeout_seconds': timeout.inSeconds} : null,
  );

  /// 環境設定ファイルが見つからない場合の失敗
  static Failure envFileNotFound({
    String? filePath,
    StackTrace? stackTrace,
    bool canRetry = false,
  }) => Failure.configSourceNow(
    message: filePath != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.envFileNotFound,
            filePath,
          )
        : ConfigErrorMessages.envFileNotFound,
    errorCode: ConfigErrorCodes.envFileNotFound,
    stackTrace: stackTrace,
    retryDelay: canRetry ? ConfigRetryDelays.envFileRead : null,
    context: filePath != null ? {'file_path': filePath} : null,
  );

  /// 設定ソースが利用できない場合の失敗
  static Failure configSourceUnavailable({
    String? source,
    String? reason,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) => Failure.configSourceNow(
    message: reason != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.configSourceUnavailable,
            reason,
          )
        : ConfigErrorMessages.configSourceUnavailable,
    errorCode: ConfigErrorCodes.configSourceUnavailable,
    stackTrace: stackTrace,
    retryDelay: canRetry ? ConfigRetryDelays.remoteConfigFetch : null,
    context: source != null ? {'source': source} : null,
  );

  // Config parse failures (recoverable)

  /// 環境設定ファイルの解析に失敗した場合の失敗
  static Failure envParseError({
    String? detail,
    String? key,
    StackTrace? stackTrace,
    bool canRetry = false,
  }) => Failure.configParseNow(
    message: detail != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.envParseError,
            detail,
          )
        : ConfigErrorMessages.envParseError,
    errorCode: ConfigErrorCodes.envParseError,
    stackTrace: stackTrace,
    retryDelay: canRetry ? ConfigRetryDelays.configParse : null,
    context: key != null ? {'key': key} : null,
  );

  /// リモート設定の解析に失敗した場合の失敗
  static Failure remoteConfigParseError({
    String? detail,
    String? key,
    StackTrace? stackTrace,
    bool canRetry = true,
  }) => Failure.configParseNow(
    message: detail != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.remoteConfigParseError,
            detail,
          )
        : ConfigErrorMessages.remoteConfigParseError,
    errorCode: ConfigErrorCodes.remoteConfigParseError,
    stackTrace: stackTrace,
    retryDelay: canRetry ? ConfigRetryDelays.configParse : null,
    context: key != null ? {'key': key} : null,
  );

  /// 設定フォーマットが不正な場合の失敗
  static Failure configFormatInvalid({
    String? format,
    String? detail,
    StackTrace? stackTrace,
    bool canRetry = false,
  }) => Failure.configParseNow(
    message: detail != null
        ? ConfigErrorMessages.withDetail(
            ConfigErrorMessages.configFormatInvalid,
            detail,
          )
        : ConfigErrorMessages.configFormatInvalid,
    errorCode: ConfigErrorCodes.configFormatInvalid,
    stackTrace: stackTrace,
    retryDelay: canRetry ? ConfigRetryDelays.configParse : null,
    context: format != null ? {'format': format} : null,
  );

  /// 設定値が不正な場合の失敗
  static Failure configValueInvalid({
    String? key,
    String? value,
    String? expectedType,
    StackTrace? stackTrace,
    bool canRetry = false,
  }) => Failure.configParseNow(
    message: key != null
        ? ConfigErrorMessages.withKey(
            ConfigErrorMessages.configValueInvalid,
            key,
          )
        : ConfigErrorMessages.configValueInvalid,
    errorCode: ConfigErrorCodes.configValueInvalid,
    stackTrace: stackTrace,
    retryDelay: canRetry ? ConfigRetryDelays.configValidation : null,
    context: {
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (expectedType != null) 'expected_type': expectedType,
    },
  );
}
