// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ErrorState {

 List<AppError> get errors; List<String> get dismissedErrorIds; AppError? get lastError; bool get isHandlingError;
/// Create a copy of ErrorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorStateCopyWith<ErrorState> get copyWith => _$ErrorStateCopyWithImpl<ErrorState>(this as ErrorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorState&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.dismissedErrorIds, dismissedErrorIds)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.isHandlingError, isHandlingError) || other.isHandlingError == isHandlingError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(dismissedErrorIds),lastError,isHandlingError);

@override
String toString() {
  return 'ErrorState(errors: $errors, dismissedErrorIds: $dismissedErrorIds, lastError: $lastError, isHandlingError: $isHandlingError)';
}


}

/// @nodoc
abstract mixin class $ErrorStateCopyWith<$Res>  {
  factory $ErrorStateCopyWith(ErrorState value, $Res Function(ErrorState) _then) = _$ErrorStateCopyWithImpl;
@useResult
$Res call({
 List<AppError> errors, List<String> dismissedErrorIds, AppError? lastError, bool isHandlingError
});


$AppErrorCopyWith<$Res>? get lastError;

}
/// @nodoc
class _$ErrorStateCopyWithImpl<$Res>
    implements $ErrorStateCopyWith<$Res> {
  _$ErrorStateCopyWithImpl(this._self, this._then);

  final ErrorState _self;
  final $Res Function(ErrorState) _then;

/// Create a copy of ErrorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errors = null,Object? dismissedErrorIds = null,Object? lastError = freezed,Object? isHandlingError = null,}) {
  return _then(_self.copyWith(
errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<AppError>,dismissedErrorIds: null == dismissedErrorIds ? _self.dismissedErrorIds : dismissedErrorIds // ignore: cast_nullable_to_non_nullable
as List<String>,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as AppError?,isHandlingError: null == isHandlingError ? _self.isHandlingError : isHandlingError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ErrorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppErrorCopyWith<$Res>? get lastError {
    if (_self.lastError == null) {
    return null;
  }

  return $AppErrorCopyWith<$Res>(_self.lastError!, (value) {
    return _then(_self.copyWith(lastError: value));
  });
}
}


/// Adds pattern-matching-related methods to [ErrorState].
extension ErrorStatePatterns on ErrorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorState value)  $default,){
final _that = this;
switch (_that) {
case _ErrorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorState value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AppError> errors,  List<String> dismissedErrorIds,  AppError? lastError,  bool isHandlingError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorState() when $default != null:
return $default(_that.errors,_that.dismissedErrorIds,_that.lastError,_that.isHandlingError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AppError> errors,  List<String> dismissedErrorIds,  AppError? lastError,  bool isHandlingError)  $default,) {final _that = this;
switch (_that) {
case _ErrorState():
return $default(_that.errors,_that.dismissedErrorIds,_that.lastError,_that.isHandlingError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AppError> errors,  List<String> dismissedErrorIds,  AppError? lastError,  bool isHandlingError)?  $default,) {final _that = this;
switch (_that) {
case _ErrorState() when $default != null:
return $default(_that.errors,_that.dismissedErrorIds,_that.lastError,_that.isHandlingError);case _:
  return null;

}
}

}

/// @nodoc


class _ErrorState extends ErrorState {
  const _ErrorState({final  List<AppError> errors = const [], final  List<String> dismissedErrorIds = const [], this.lastError, this.isHandlingError = false}): _errors = errors,_dismissedErrorIds = dismissedErrorIds,super._();
  

 final  List<AppError> _errors;
@override@JsonKey() List<AppError> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}

 final  List<String> _dismissedErrorIds;
@override@JsonKey() List<String> get dismissedErrorIds {
  if (_dismissedErrorIds is EqualUnmodifiableListView) return _dismissedErrorIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dismissedErrorIds);
}

@override final  AppError? lastError;
@override@JsonKey() final  bool isHandlingError;

/// Create a copy of ErrorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorStateCopyWith<_ErrorState> get copyWith => __$ErrorStateCopyWithImpl<_ErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorState&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other._dismissedErrorIds, _dismissedErrorIds)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.isHandlingError, isHandlingError) || other.isHandlingError == isHandlingError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(_dismissedErrorIds),lastError,isHandlingError);

@override
String toString() {
  return 'ErrorState(errors: $errors, dismissedErrorIds: $dismissedErrorIds, lastError: $lastError, isHandlingError: $isHandlingError)';
}


}

/// @nodoc
abstract mixin class _$ErrorStateCopyWith<$Res> implements $ErrorStateCopyWith<$Res> {
  factory _$ErrorStateCopyWith(_ErrorState value, $Res Function(_ErrorState) _then) = __$ErrorStateCopyWithImpl;
@override @useResult
$Res call({
 List<AppError> errors, List<String> dismissedErrorIds, AppError? lastError, bool isHandlingError
});


@override $AppErrorCopyWith<$Res>? get lastError;

}
/// @nodoc
class __$ErrorStateCopyWithImpl<$Res>
    implements _$ErrorStateCopyWith<$Res> {
  __$ErrorStateCopyWithImpl(this._self, this._then);

  final _ErrorState _self;
  final $Res Function(_ErrorState) _then;

/// Create a copy of ErrorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errors = null,Object? dismissedErrorIds = null,Object? lastError = freezed,Object? isHandlingError = null,}) {
  return _then(_ErrorState(
errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<AppError>,dismissedErrorIds: null == dismissedErrorIds ? _self._dismissedErrorIds : dismissedErrorIds // ignore: cast_nullable_to_non_nullable
as List<String>,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as AppError?,isHandlingError: null == isHandlingError ? _self.isHandlingError : isHandlingError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ErrorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppErrorCopyWith<$Res>? get lastError {
    if (_self.lastError == null) {
    return null;
  }

  return $AppErrorCopyWith<$Res>(_self.lastError!, (value) {
    return _then(_self.copyWith(lastError: value));
  });
}
}

// dart format on
