import 'package:freezed_annotation/freezed_annotation.dart';
import 'failure.dart';
import 'app_exception.dart';

part 'specific_errors.freezed.dart';

@freezed
sealed class NetworkErrorType with _$NetworkErrorType {
  const factory NetworkErrorType.connection() = ConnectionError;
  const factory NetworkErrorType.timeout() = TimeoutError;
  const factory NetworkErrorType.server() = ServerError;
}

@freezed
sealed class ParseErrorType with _$ParseErrorType {
  const factory ParseErrorType.malformedData() = MalformedDataError;
  const factory ParseErrorType.schemaChanged() = SchemaChangedError;
}

@freezed
sealed class AuthenticationErrorType with _$AuthenticationErrorType {
  const factory AuthenticationErrorType.invalidCredentials() =
      InvalidCredentialsError;
  const factory AuthenticationErrorType.sessionExpired() = SessionExpiredError;
  const factory AuthenticationErrorType.credentialsNotFound() =
      CredentialsNotFoundError;
}

@freezed
sealed class MaintenanceErrorType with _$MaintenanceErrorType {
  const factory MaintenanceErrorType.scheduled() = ScheduledMaintenanceError;
  const factory MaintenanceErrorType.emergency() = EmergencyMaintenanceError;
}

@freezed
sealed class StorageErrorType with _$StorageErrorType {
  const factory StorageErrorType.readFailure() = ReadFailureError;
  const factory StorageErrorType.writeFailure() = WriteFailureError;
  const factory StorageErrorType.capacityExceeded() = CapacityExceededError;
}

extension NetworkFailureExtension on NetworkFailure {
  NetworkErrorType get type {
    switch (errorCode) {
      case 'NETWORK_CONNECTION':
        return const NetworkErrorType.connection();
      case 'NETWORK_TIMEOUT':
        return const NetworkErrorType.timeout();
      case 'NETWORK_SERVER':
        return const NetworkErrorType.server();
      default:
        return const NetworkErrorType.connection();
    }
  }
}

extension ParseFailureExtension on ParseFailure {
  ParseErrorType get type {
    switch (errorCode) {
      case 'PARSE_MALFORMED_DATA':
        return const ParseErrorType.malformedData();
      case 'PARSE_SCHEMA_CHANGED':
        return const ParseErrorType.schemaChanged();
      default:
        return const ParseErrorType.malformedData();
    }
  }
}

extension AuthenticationExceptionExtension on AuthenticationException {
  AuthenticationErrorType get type {
    switch (errorCode) {
      case 'AUTH_INVALID_CREDENTIALS':
        return const AuthenticationErrorType.invalidCredentials();
      case 'AUTH_SESSION_EXPIRED':
        return const AuthenticationErrorType.sessionExpired();
      case 'AUTH_CREDENTIALS_NOT_FOUND':
        return const AuthenticationErrorType.credentialsNotFound();
      default:
        return const AuthenticationErrorType.invalidCredentials();
    }
  }
}

extension MaintenanceExceptionExtension on MaintenanceException {
  MaintenanceErrorType get type {
    switch (errorCode) {
      case 'MAINTENANCE_SCHEDULED':
        return const MaintenanceErrorType.scheduled();
      case 'MAINTENANCE_EMERGENCY':
        return const MaintenanceErrorType.emergency();
      default:
        return const MaintenanceErrorType.scheduled();
    }
  }
}

extension StorageExceptionExtension on StorageException {
  StorageErrorType get type {
    switch (errorCode) {
      case 'STORAGE_READ_FAILURE':
        return const StorageErrorType.readFailure();
      case 'STORAGE_WRITE_FAILURE':
        return const StorageErrorType.writeFailure();
      case 'STORAGE_CAPACITY_EXCEEDED':
        return const StorageErrorType.capacityExceeded();
      default:
        return const StorageErrorType.readFailure();
    }
  }
}

class ErrorCodes {
  static const String networkConnection = 'NETWORK_CONNECTION';
  static const String networkTimeout = 'NETWORK_TIMEOUT';
  static const String networkServer = 'NETWORK_SERVER';

  static const String parseMalformedData = 'PARSE_MALFORMED_DATA';
  static const String parseSchemaChanged = 'PARSE_SCHEMA_CHANGED';

  static const String authInvalidCredentials = 'AUTH_INVALID_CREDENTIALS';
  static const String authSessionExpired = 'AUTH_SESSION_EXPIRED';
  static const String authCredentialsNotFound = 'AUTH_CREDENTIALS_NOT_FOUND';

  static const String maintenanceScheduled = 'MAINTENANCE_SCHEDULED';
  static const String maintenanceEmergency = 'MAINTENANCE_EMERGENCY';

  static const String updateRequired = 'UPDATE_REQUIRED';

  static const String storageReadFailure = 'STORAGE_READ_FAILURE';
  static const String storageWriteFailure = 'STORAGE_WRITE_FAILURE';
  static const String storageCapacityExceeded = 'STORAGE_CAPACITY_EXCEEDED';
}
