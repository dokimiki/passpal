// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppException {

 String get message; String get errorCode; StackTrace? get stackTrace; DateTime get timestamp; Map<String, dynamic>? get context;
/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppExceptionCopyWith<AppException> get copyWith => _$AppExceptionCopyWithImpl<AppException>(this as AppException, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppException&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.context, context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,const DeepCollectionEquality().hash(context));

@override
String toString() {
  return 'AppException(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, context: $context)';
}


}

/// @nodoc
abstract mixin class $AppExceptionCopyWith<$Res>  {
  factory $AppExceptionCopyWith(AppException value, $Res Function(AppException) _then) = _$AppExceptionCopyWithImpl;
@useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Map<String, dynamic>? context
});




}
/// @nodoc
class _$AppExceptionCopyWithImpl<$Res>
    implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._self, this._then);

  final AppException _self;
  final $Res Function(AppException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? context = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppException].
extension AppExceptionPatterns on AppException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthenticationException value)?  authentication,TResult Function( MaintenanceException value)?  maintenance,TResult Function( UpdateRequiredException value)?  updateRequired,TResult Function( StorageException value)?  storage,TResult Function( ConfigException value)?  config,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthenticationException() when authentication != null:
return authentication(_that);case MaintenanceException() when maintenance != null:
return maintenance(_that);case UpdateRequiredException() when updateRequired != null:
return updateRequired(_that);case StorageException() when storage != null:
return storage(_that);case ConfigException() when config != null:
return config(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthenticationException value)  authentication,required TResult Function( MaintenanceException value)  maintenance,required TResult Function( UpdateRequiredException value)  updateRequired,required TResult Function( StorageException value)  storage,required TResult Function( ConfigException value)  config,}){
final _that = this;
switch (_that) {
case AuthenticationException():
return authentication(_that);case MaintenanceException():
return maintenance(_that);case UpdateRequiredException():
return updateRequired(_that);case StorageException():
return storage(_that);case ConfigException():
return config(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthenticationException value)?  authentication,TResult? Function( MaintenanceException value)?  maintenance,TResult? Function( UpdateRequiredException value)?  updateRequired,TResult? Function( StorageException value)?  storage,TResult? Function( ConfigException value)?  config,}){
final _that = this;
switch (_that) {
case AuthenticationException() when authentication != null:
return authentication(_that);case MaintenanceException() when maintenance != null:
return maintenance(_that);case UpdateRequiredException() when updateRequired != null:
return updateRequired(_that);case StorageException() when storage != null:
return storage(_that);case ConfigException() when config != null:
return config(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  authentication,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  maintenance,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  updateRequired,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  storage,TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  config,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthenticationException() when authentication != null:
return authentication(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case MaintenanceException() when maintenance != null:
return maintenance(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case UpdateRequiredException() when updateRequired != null:
return updateRequired(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case StorageException() when storage != null:
return storage(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case ConfigException() when config != null:
return config(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)  authentication,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)  maintenance,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)  updateRequired,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)  storage,required TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)  config,}) {final _that = this;
switch (_that) {
case AuthenticationException():
return authentication(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case MaintenanceException():
return maintenance(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case UpdateRequiredException():
return updateRequired(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case StorageException():
return storage(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case ConfigException():
return config(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  authentication,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  maintenance,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  updateRequired,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  storage,TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  Map<String, dynamic>? context)?  config,}) {final _that = this;
switch (_that) {
case AuthenticationException() when authentication != null:
return authentication(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case MaintenanceException() when maintenance != null:
return maintenance(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case UpdateRequiredException() when updateRequired != null:
return updateRequired(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case StorageException() when storage != null:
return storage(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case ConfigException() when config != null:
return config(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.context);case _:
  return null;

}
}

}

/// @nodoc


class AuthenticationException extends AppException {
  const AuthenticationException({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationExceptionCopyWith<AuthenticationException> get copyWith => _$AuthenticationExceptionCopyWithImpl<AuthenticationException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationException&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'AppException.authentication(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, context: $context)';
}


}

/// @nodoc
abstract mixin class $AuthenticationExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $AuthenticationExceptionCopyWith(AuthenticationException value, $Res Function(AuthenticationException) _then) = _$AuthenticationExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Map<String, dynamic>? context
});




}
/// @nodoc
class _$AuthenticationExceptionCopyWithImpl<$Res>
    implements $AuthenticationExceptionCopyWith<$Res> {
  _$AuthenticationExceptionCopyWithImpl(this._self, this._then);

  final AuthenticationException _self;
  final $Res Function(AuthenticationException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? context = freezed,}) {
  return _then(AuthenticationException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class MaintenanceException extends AppException {
  const MaintenanceException({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceExceptionCopyWith<MaintenanceException> get copyWith => _$MaintenanceExceptionCopyWithImpl<MaintenanceException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceException&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'AppException.maintenance(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, context: $context)';
}


}

/// @nodoc
abstract mixin class $MaintenanceExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $MaintenanceExceptionCopyWith(MaintenanceException value, $Res Function(MaintenanceException) _then) = _$MaintenanceExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Map<String, dynamic>? context
});




}
/// @nodoc
class _$MaintenanceExceptionCopyWithImpl<$Res>
    implements $MaintenanceExceptionCopyWith<$Res> {
  _$MaintenanceExceptionCopyWithImpl(this._self, this._then);

  final MaintenanceException _self;
  final $Res Function(MaintenanceException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? context = freezed,}) {
  return _then(MaintenanceException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class UpdateRequiredException extends AppException {
  const UpdateRequiredException({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateRequiredExceptionCopyWith<UpdateRequiredException> get copyWith => _$UpdateRequiredExceptionCopyWithImpl<UpdateRequiredException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateRequiredException&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'AppException.updateRequired(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, context: $context)';
}


}

/// @nodoc
abstract mixin class $UpdateRequiredExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $UpdateRequiredExceptionCopyWith(UpdateRequiredException value, $Res Function(UpdateRequiredException) _then) = _$UpdateRequiredExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Map<String, dynamic>? context
});




}
/// @nodoc
class _$UpdateRequiredExceptionCopyWithImpl<$Res>
    implements $UpdateRequiredExceptionCopyWith<$Res> {
  _$UpdateRequiredExceptionCopyWithImpl(this._self, this._then);

  final UpdateRequiredException _self;
  final $Res Function(UpdateRequiredException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? context = freezed,}) {
  return _then(UpdateRequiredException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class StorageException extends AppException {
  const StorageException({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageExceptionCopyWith<StorageException> get copyWith => _$StorageExceptionCopyWithImpl<StorageException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageException&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'AppException.storage(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, context: $context)';
}


}

/// @nodoc
abstract mixin class $StorageExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $StorageExceptionCopyWith(StorageException value, $Res Function(StorageException) _then) = _$StorageExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Map<String, dynamic>? context
});




}
/// @nodoc
class _$StorageExceptionCopyWithImpl<$Res>
    implements $StorageExceptionCopyWith<$Res> {
  _$StorageExceptionCopyWithImpl(this._self, this._then);

  final StorageException _self;
  final $Res Function(StorageException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? context = freezed,}) {
  return _then(StorageException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc


class ConfigException extends AppException {
  const ConfigException({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigExceptionCopyWith<ConfigException> get copyWith => _$ConfigExceptionCopyWithImpl<ConfigException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigException&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'AppException.config(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, context: $context)';
}


}

/// @nodoc
abstract mixin class $ConfigExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $ConfigExceptionCopyWith(ConfigException value, $Res Function(ConfigException) _then) = _$ConfigExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, Map<String, dynamic>? context
});




}
/// @nodoc
class _$ConfigExceptionCopyWithImpl<$Res>
    implements $ConfigExceptionCopyWith<$Res> {
  _$ConfigExceptionCopyWithImpl(this._self, this._then);

  final ConfigException _self;
  final $Res Function(ConfigException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? context = freezed,}) {
  return _then(ConfigException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
