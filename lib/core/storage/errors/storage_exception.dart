/// ストレージ層で発生する例外の基底クラス
abstract class StorageException implements Exception {
  const StorageException({required this.message, this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => 'StorageException: $message';
}

/// JSON デシリアライゼーション失敗
class DeserializeException extends StorageException {
  const DeserializeException({
    required this.key,
    required super.message,
    super.cause,
  });

  final String key;

  @override
  String toString() => 'DeserializeException(key: $key): $message';
}

/// SecureStorage I/O エラー
class SecureIoException extends StorageException {
  const SecureIoException({
    required this.operation,
    required super.message,
    super.cause,
  });

  final String operation;

  @override
  String toString() => 'SecureIoException(operation: $operation): $message';
}

/// Key-Value ストレージ I/O エラー
class KvIoException extends StorageException {
  const KvIoException({
    required this.operation,
    required super.message,
    super.cause,
  });

  final String operation;

  @override
  String toString() => 'KvIoException(operation: $operation): $message';
}
