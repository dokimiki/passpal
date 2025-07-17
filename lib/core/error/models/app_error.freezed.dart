// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppError {

 String get message; String get errorCode; StackTrace? get stackTrace; DateTime get timestamp; bool get isRecoverable; Duration? get retryDelay; Map<String, dynamic>? get context;
/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppErrorCopyWith<AppError> get copyWith => _$AppErrorCopyWithImpl<AppError>(this as AppError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppError&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRecoverable, isRecoverable) || other.isRecoverable == isRecoverable)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other.context, context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,isRecoverable,retryDelay,const DeepCollectionEquality().hash(context));

@override
String toString() {
  return 'AppError(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, isRecoverable: $isRecoverable, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class $AppErrorCopyWith<$Res>  {
  factory $AppErrorCopyWith(AppError value, $Res Function(AppError) _then) = _$AppErrorCopyWithImpl;
@useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, bool isRecoverable, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class _$AppErrorCopyWithImpl<$Res>
    implements $AppErrorCopyWith<$Res> {
  _$AppErrorCopyWithImpl(this._self, this._then);

  final AppError _self;
  final $Res Function(AppError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? isRecoverable = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRecoverable: null == isRecoverable ? _self.isRecoverable : isRecoverable // ignore: cast_nullable_to_non_nullable
as bool,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppError].
extension AppErrorPatterns on AppError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppError() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppError value)  $default,){
final _that = this;
switch (_that) {
case _AppError():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppError value)?  $default,){
final _that = this;
switch (_that) {
case _AppError() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  bool isRecoverable,  Duration? retryDelay,  Map<String, dynamic>? context)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppError() when $default != null:
return $default(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.isRecoverable,_that.retryDelay,_that.context);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  bool isRecoverable,  Duration? retryDelay,  Map<String, dynamic>? context)  $default,) {final _that = this;
switch (_that) {
case _AppError():
return $default(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.isRecoverable,_that.retryDelay,_that.context);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String errorCode,  StackTrace? stackTrace,  DateTime timestamp,  bool isRecoverable,  Duration? retryDelay,  Map<String, dynamic>? context)?  $default,) {final _that = this;
switch (_that) {
case _AppError() when $default != null:
return $default(_that.message,_that.errorCode,_that.stackTrace,_that.timestamp,_that.isRecoverable,_that.retryDelay,_that.context);case _:
  return null;

}
}

}

/// @nodoc


class _AppError extends AppError {
  const _AppError({required this.message, required this.errorCode, this.stackTrace, required this.timestamp, required this.isRecoverable, this.retryDelay, final  Map<String, dynamic>? context}): _context = context,super._();
  

@override final  String message;
@override final  String errorCode;
@override final  StackTrace? stackTrace;
@override final  DateTime timestamp;
@override final  bool isRecoverable;
@override final  Duration? retryDelay;
 final  Map<String, dynamic>? _context;
@override Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppErrorCopyWith<_AppError> get copyWith => __$AppErrorCopyWithImpl<_AppError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppError&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRecoverable, isRecoverable) || other.isRecoverable == isRecoverable)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&const DeepCollectionEquality().equals(other._context, _context));
}


@override
int get hashCode => Object.hash(runtimeType,message,errorCode,stackTrace,timestamp,isRecoverable,retryDelay,const DeepCollectionEquality().hash(_context));

@override
String toString() {
  return 'AppError(message: $message, errorCode: $errorCode, stackTrace: $stackTrace, timestamp: $timestamp, isRecoverable: $isRecoverable, retryDelay: $retryDelay, context: $context)';
}


}

/// @nodoc
abstract mixin class _$AppErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory _$AppErrorCopyWith(_AppError value, $Res Function(_AppError) _then) = __$AppErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, String errorCode, StackTrace? stackTrace, DateTime timestamp, bool isRecoverable, Duration? retryDelay, Map<String, dynamic>? context
});




}
/// @nodoc
class __$AppErrorCopyWithImpl<$Res>
    implements _$AppErrorCopyWith<$Res> {
  __$AppErrorCopyWithImpl(this._self, this._then);

  final _AppError _self;
  final $Res Function(_AppError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? errorCode = null,Object? stackTrace = freezed,Object? timestamp = null,Object? isRecoverable = null,Object? retryDelay = freezed,Object? context = freezed,}) {
  return _then(_AppError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: null == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRecoverable: null == isRecoverable ? _self.isRecoverable : isRecoverable // ignore: cast_nullable_to_non_nullable
as bool,retryDelay: freezed == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration?,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
