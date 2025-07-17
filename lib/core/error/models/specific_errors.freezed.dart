// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'specific_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkErrorType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkErrorType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkErrorType()';
}


}

/// @nodoc
class $NetworkErrorTypeCopyWith<$Res>  {
$NetworkErrorTypeCopyWith(NetworkErrorType _, $Res Function(NetworkErrorType) __);
}


/// Adds pattern-matching-related methods to [NetworkErrorType].
extension NetworkErrorTypePatterns on NetworkErrorType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConnectionError value)?  connection,TResult Function( TimeoutError value)?  timeout,TResult Function( ServerError value)?  server,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConnectionError() when connection != null:
return connection(_that);case TimeoutError() when timeout != null:
return timeout(_that);case ServerError() when server != null:
return server(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConnectionError value)  connection,required TResult Function( TimeoutError value)  timeout,required TResult Function( ServerError value)  server,}){
final _that = this;
switch (_that) {
case ConnectionError():
return connection(_that);case TimeoutError():
return timeout(_that);case ServerError():
return server(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConnectionError value)?  connection,TResult? Function( TimeoutError value)?  timeout,TResult? Function( ServerError value)?  server,}){
final _that = this;
switch (_that) {
case ConnectionError() when connection != null:
return connection(_that);case TimeoutError() when timeout != null:
return timeout(_that);case ServerError() when server != null:
return server(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  connection,TResult Function()?  timeout,TResult Function()?  server,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConnectionError() when connection != null:
return connection();case TimeoutError() when timeout != null:
return timeout();case ServerError() when server != null:
return server();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  connection,required TResult Function()  timeout,required TResult Function()  server,}) {final _that = this;
switch (_that) {
case ConnectionError():
return connection();case TimeoutError():
return timeout();case ServerError():
return server();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  connection,TResult? Function()?  timeout,TResult? Function()?  server,}) {final _that = this;
switch (_that) {
case ConnectionError() when connection != null:
return connection();case TimeoutError() when timeout != null:
return timeout();case ServerError() when server != null:
return server();case _:
  return null;

}
}

}

/// @nodoc


class ConnectionError implements NetworkErrorType {
  const ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkErrorType.connection()';
}


}




/// @nodoc


class TimeoutError implements NetworkErrorType {
  const TimeoutError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkErrorType.timeout()';
}


}




/// @nodoc


class ServerError implements NetworkErrorType {
  const ServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkErrorType.server()';
}


}




/// @nodoc
mixin _$ParseErrorType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseErrorType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParseErrorType()';
}


}

/// @nodoc
class $ParseErrorTypeCopyWith<$Res>  {
$ParseErrorTypeCopyWith(ParseErrorType _, $Res Function(ParseErrorType) __);
}


/// Adds pattern-matching-related methods to [ParseErrorType].
extension ParseErrorTypePatterns on ParseErrorType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MalformedDataError value)?  malformedData,TResult Function( SchemaChangedError value)?  schemaChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MalformedDataError() when malformedData != null:
return malformedData(_that);case SchemaChangedError() when schemaChanged != null:
return schemaChanged(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MalformedDataError value)  malformedData,required TResult Function( SchemaChangedError value)  schemaChanged,}){
final _that = this;
switch (_that) {
case MalformedDataError():
return malformedData(_that);case SchemaChangedError():
return schemaChanged(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MalformedDataError value)?  malformedData,TResult? Function( SchemaChangedError value)?  schemaChanged,}){
final _that = this;
switch (_that) {
case MalformedDataError() when malformedData != null:
return malformedData(_that);case SchemaChangedError() when schemaChanged != null:
return schemaChanged(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  malformedData,TResult Function()?  schemaChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MalformedDataError() when malformedData != null:
return malformedData();case SchemaChangedError() when schemaChanged != null:
return schemaChanged();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  malformedData,required TResult Function()  schemaChanged,}) {final _that = this;
switch (_that) {
case MalformedDataError():
return malformedData();case SchemaChangedError():
return schemaChanged();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  malformedData,TResult? Function()?  schemaChanged,}) {final _that = this;
switch (_that) {
case MalformedDataError() when malformedData != null:
return malformedData();case SchemaChangedError() when schemaChanged != null:
return schemaChanged();case _:
  return null;

}
}

}

/// @nodoc


class MalformedDataError implements ParseErrorType {
  const MalformedDataError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MalformedDataError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParseErrorType.malformedData()';
}


}




/// @nodoc


class SchemaChangedError implements ParseErrorType {
  const SchemaChangedError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchemaChangedError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParseErrorType.schemaChanged()';
}


}




/// @nodoc
mixin _$AuthenticationErrorType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationErrorType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationErrorType()';
}


}

/// @nodoc
class $AuthenticationErrorTypeCopyWith<$Res>  {
$AuthenticationErrorTypeCopyWith(AuthenticationErrorType _, $Res Function(AuthenticationErrorType) __);
}


/// Adds pattern-matching-related methods to [AuthenticationErrorType].
extension AuthenticationErrorTypePatterns on AuthenticationErrorType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InvalidCredentialsError value)?  invalidCredentials,TResult Function( SessionExpiredError value)?  sessionExpired,TResult Function( CredentialsNotFoundError value)?  credentialsNotFound,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InvalidCredentialsError() when invalidCredentials != null:
return invalidCredentials(_that);case SessionExpiredError() when sessionExpired != null:
return sessionExpired(_that);case CredentialsNotFoundError() when credentialsNotFound != null:
return credentialsNotFound(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InvalidCredentialsError value)  invalidCredentials,required TResult Function( SessionExpiredError value)  sessionExpired,required TResult Function( CredentialsNotFoundError value)  credentialsNotFound,}){
final _that = this;
switch (_that) {
case InvalidCredentialsError():
return invalidCredentials(_that);case SessionExpiredError():
return sessionExpired(_that);case CredentialsNotFoundError():
return credentialsNotFound(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InvalidCredentialsError value)?  invalidCredentials,TResult? Function( SessionExpiredError value)?  sessionExpired,TResult? Function( CredentialsNotFoundError value)?  credentialsNotFound,}){
final _that = this;
switch (_that) {
case InvalidCredentialsError() when invalidCredentials != null:
return invalidCredentials(_that);case SessionExpiredError() when sessionExpired != null:
return sessionExpired(_that);case CredentialsNotFoundError() when credentialsNotFound != null:
return credentialsNotFound(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  invalidCredentials,TResult Function()?  sessionExpired,TResult Function()?  credentialsNotFound,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InvalidCredentialsError() when invalidCredentials != null:
return invalidCredentials();case SessionExpiredError() when sessionExpired != null:
return sessionExpired();case CredentialsNotFoundError() when credentialsNotFound != null:
return credentialsNotFound();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  invalidCredentials,required TResult Function()  sessionExpired,required TResult Function()  credentialsNotFound,}) {final _that = this;
switch (_that) {
case InvalidCredentialsError():
return invalidCredentials();case SessionExpiredError():
return sessionExpired();case CredentialsNotFoundError():
return credentialsNotFound();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  invalidCredentials,TResult? Function()?  sessionExpired,TResult? Function()?  credentialsNotFound,}) {final _that = this;
switch (_that) {
case InvalidCredentialsError() when invalidCredentials != null:
return invalidCredentials();case SessionExpiredError() when sessionExpired != null:
return sessionExpired();case CredentialsNotFoundError() when credentialsNotFound != null:
return credentialsNotFound();case _:
  return null;

}
}

}

/// @nodoc


class InvalidCredentialsError implements AuthenticationErrorType {
  const InvalidCredentialsError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidCredentialsError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationErrorType.invalidCredentials()';
}


}




/// @nodoc


class SessionExpiredError implements AuthenticationErrorType {
  const SessionExpiredError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionExpiredError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationErrorType.sessionExpired()';
}


}




/// @nodoc


class CredentialsNotFoundError implements AuthenticationErrorType {
  const CredentialsNotFoundError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CredentialsNotFoundError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationErrorType.credentialsNotFound()';
}


}




/// @nodoc
mixin _$MaintenanceErrorType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceErrorType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MaintenanceErrorType()';
}


}

/// @nodoc
class $MaintenanceErrorTypeCopyWith<$Res>  {
$MaintenanceErrorTypeCopyWith(MaintenanceErrorType _, $Res Function(MaintenanceErrorType) __);
}


/// Adds pattern-matching-related methods to [MaintenanceErrorType].
extension MaintenanceErrorTypePatterns on MaintenanceErrorType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ScheduledMaintenanceError value)?  scheduled,TResult Function( EmergencyMaintenanceError value)?  emergency,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScheduledMaintenanceError() when scheduled != null:
return scheduled(_that);case EmergencyMaintenanceError() when emergency != null:
return emergency(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ScheduledMaintenanceError value)  scheduled,required TResult Function( EmergencyMaintenanceError value)  emergency,}){
final _that = this;
switch (_that) {
case ScheduledMaintenanceError():
return scheduled(_that);case EmergencyMaintenanceError():
return emergency(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ScheduledMaintenanceError value)?  scheduled,TResult? Function( EmergencyMaintenanceError value)?  emergency,}){
final _that = this;
switch (_that) {
case ScheduledMaintenanceError() when scheduled != null:
return scheduled(_that);case EmergencyMaintenanceError() when emergency != null:
return emergency(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  scheduled,TResult Function()?  emergency,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScheduledMaintenanceError() when scheduled != null:
return scheduled();case EmergencyMaintenanceError() when emergency != null:
return emergency();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  scheduled,required TResult Function()  emergency,}) {final _that = this;
switch (_that) {
case ScheduledMaintenanceError():
return scheduled();case EmergencyMaintenanceError():
return emergency();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  scheduled,TResult? Function()?  emergency,}) {final _that = this;
switch (_that) {
case ScheduledMaintenanceError() when scheduled != null:
return scheduled();case EmergencyMaintenanceError() when emergency != null:
return emergency();case _:
  return null;

}
}

}

/// @nodoc


class ScheduledMaintenanceError implements MaintenanceErrorType {
  const ScheduledMaintenanceError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledMaintenanceError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MaintenanceErrorType.scheduled()';
}


}




/// @nodoc


class EmergencyMaintenanceError implements MaintenanceErrorType {
  const EmergencyMaintenanceError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyMaintenanceError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MaintenanceErrorType.emergency()';
}


}




/// @nodoc
mixin _$StorageErrorType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageErrorType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StorageErrorType()';
}


}

/// @nodoc
class $StorageErrorTypeCopyWith<$Res>  {
$StorageErrorTypeCopyWith(StorageErrorType _, $Res Function(StorageErrorType) __);
}


/// Adds pattern-matching-related methods to [StorageErrorType].
extension StorageErrorTypePatterns on StorageErrorType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReadFailureError value)?  readFailure,TResult Function( WriteFailureError value)?  writeFailure,TResult Function( CapacityExceededError value)?  capacityExceeded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReadFailureError() when readFailure != null:
return readFailure(_that);case WriteFailureError() when writeFailure != null:
return writeFailure(_that);case CapacityExceededError() when capacityExceeded != null:
return capacityExceeded(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReadFailureError value)  readFailure,required TResult Function( WriteFailureError value)  writeFailure,required TResult Function( CapacityExceededError value)  capacityExceeded,}){
final _that = this;
switch (_that) {
case ReadFailureError():
return readFailure(_that);case WriteFailureError():
return writeFailure(_that);case CapacityExceededError():
return capacityExceeded(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReadFailureError value)?  readFailure,TResult? Function( WriteFailureError value)?  writeFailure,TResult? Function( CapacityExceededError value)?  capacityExceeded,}){
final _that = this;
switch (_that) {
case ReadFailureError() when readFailure != null:
return readFailure(_that);case WriteFailureError() when writeFailure != null:
return writeFailure(_that);case CapacityExceededError() when capacityExceeded != null:
return capacityExceeded(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  readFailure,TResult Function()?  writeFailure,TResult Function()?  capacityExceeded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReadFailureError() when readFailure != null:
return readFailure();case WriteFailureError() when writeFailure != null:
return writeFailure();case CapacityExceededError() when capacityExceeded != null:
return capacityExceeded();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  readFailure,required TResult Function()  writeFailure,required TResult Function()  capacityExceeded,}) {final _that = this;
switch (_that) {
case ReadFailureError():
return readFailure();case WriteFailureError():
return writeFailure();case CapacityExceededError():
return capacityExceeded();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  readFailure,TResult? Function()?  writeFailure,TResult? Function()?  capacityExceeded,}) {final _that = this;
switch (_that) {
case ReadFailureError() when readFailure != null:
return readFailure();case WriteFailureError() when writeFailure != null:
return writeFailure();case CapacityExceededError() when capacityExceeded != null:
return capacityExceeded();case _:
  return null;

}
}

}

/// @nodoc


class ReadFailureError implements StorageErrorType {
  const ReadFailureError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadFailureError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StorageErrorType.readFailure()';
}


}




/// @nodoc


class WriteFailureError implements StorageErrorType {
  const WriteFailureError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WriteFailureError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StorageErrorType.writeFailure()';
}


}




/// @nodoc


class CapacityExceededError implements StorageErrorType {
  const CapacityExceededError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapacityExceededError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StorageErrorType.capacityExceeded()';
}


}




// dart format on
