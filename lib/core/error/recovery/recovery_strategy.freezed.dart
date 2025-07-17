// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recovery_strategy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecoveryResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoveryResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecoveryResult()';
}


}

/// @nodoc
class $RecoveryResultCopyWith<$Res>  {
$RecoveryResultCopyWith(RecoveryResult _, $Res Function(RecoveryResult) __);
}


/// Adds pattern-matching-related methods to [RecoveryResult].
extension RecoveryResultPatterns on RecoveryResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,TResult Function( _Retry value)?  retry,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _Retry() when retry != null:
return retry(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,required TResult Function( _Retry value)  retry,}){
final _that = this;
switch (_that) {
case _Success():
return success(_that);case _Failure():
return failure(_that);case _Retry():
return retry(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,TResult? Function( _Retry value)?  retry,}){
final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _Retry() when retry != null:
return retry(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  success,TResult Function( String reason,  Duration? retryAfter)?  failure,TResult Function( Duration delay,  int attempt,  int? maxAttempts)?  retry,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Success() when success != null:
return success();case _Failure() when failure != null:
return failure(_that.reason,_that.retryAfter);case _Retry() when retry != null:
return retry(_that.delay,_that.attempt,_that.maxAttempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  success,required TResult Function( String reason,  Duration? retryAfter)  failure,required TResult Function( Duration delay,  int attempt,  int? maxAttempts)  retry,}) {final _that = this;
switch (_that) {
case _Success():
return success();case _Failure():
return failure(_that.reason,_that.retryAfter);case _Retry():
return retry(_that.delay,_that.attempt,_that.maxAttempts);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  success,TResult? Function( String reason,  Duration? retryAfter)?  failure,TResult? Function( Duration delay,  int attempt,  int? maxAttempts)?  retry,}) {final _that = this;
switch (_that) {
case _Success() when success != null:
return success();case _Failure() when failure != null:
return failure(_that.reason,_that.retryAfter);case _Retry() when retry != null:
return retry(_that.delay,_that.attempt,_that.maxAttempts);case _:
  return null;

}
}

}

/// @nodoc


class _Success implements RecoveryResult {
  const _Success();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecoveryResult.success()';
}


}




/// @nodoc


class _Failure implements RecoveryResult {
  const _Failure({required this.reason, this.retryAfter});
  

 final  String reason;
 final  Duration? retryAfter;

/// Create a copy of RecoveryResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.retryAfter, retryAfter) || other.retryAfter == retryAfter));
}


@override
int get hashCode => Object.hash(runtimeType,reason,retryAfter);

@override
String toString() {
  return 'RecoveryResult.failure(reason: $reason, retryAfter: $retryAfter)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $RecoveryResultCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String reason, Duration? retryAfter
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of RecoveryResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? retryAfter = freezed,}) {
  return _then(_Failure(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,retryAfter: freezed == retryAfter ? _self.retryAfter : retryAfter // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

/// @nodoc


class _Retry implements RecoveryResult {
  const _Retry({required this.delay, required this.attempt, this.maxAttempts});
  

 final  Duration delay;
 final  int attempt;
 final  int? maxAttempts;

/// Create a copy of RecoveryResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryCopyWith<_Retry> get copyWith => __$RetryCopyWithImpl<_Retry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Retry&&(identical(other.delay, delay) || other.delay == delay)&&(identical(other.attempt, attempt) || other.attempt == attempt)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,delay,attempt,maxAttempts);

@override
String toString() {
  return 'RecoveryResult.retry(delay: $delay, attempt: $attempt, maxAttempts: $maxAttempts)';
}


}

/// @nodoc
abstract mixin class _$RetryCopyWith<$Res> implements $RecoveryResultCopyWith<$Res> {
  factory _$RetryCopyWith(_Retry value, $Res Function(_Retry) _then) = __$RetryCopyWithImpl;
@useResult
$Res call({
 Duration delay, int attempt, int? maxAttempts
});




}
/// @nodoc
class __$RetryCopyWithImpl<$Res>
    implements _$RetryCopyWith<$Res> {
  __$RetryCopyWithImpl(this._self, this._then);

  final _Retry _self;
  final $Res Function(_Retry) _then;

/// Create a copy of RecoveryResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? delay = null,Object? attempt = null,Object? maxAttempts = freezed,}) {
  return _then(_Retry(
delay: null == delay ? _self.delay : delay // ignore: cast_nullable_to_non_nullable
as Duration,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,maxAttempts: freezed == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$RetryPolicy {

 int get maxAttempts; Duration get initialDelay; double get backoffMultiplier; Duration get maxDelay;
/// Create a copy of RetryPolicy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetryPolicyCopyWith<RetryPolicy> get copyWith => _$RetryPolicyCopyWithImpl<RetryPolicy>(this as RetryPolicy, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetryPolicy&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.initialDelay, initialDelay) || other.initialDelay == initialDelay)&&(identical(other.backoffMultiplier, backoffMultiplier) || other.backoffMultiplier == backoffMultiplier)&&(identical(other.maxDelay, maxDelay) || other.maxDelay == maxDelay));
}


@override
int get hashCode => Object.hash(runtimeType,maxAttempts,initialDelay,backoffMultiplier,maxDelay);

@override
String toString() {
  return 'RetryPolicy(maxAttempts: $maxAttempts, initialDelay: $initialDelay, backoffMultiplier: $backoffMultiplier, maxDelay: $maxDelay)';
}


}

/// @nodoc
abstract mixin class $RetryPolicyCopyWith<$Res>  {
  factory $RetryPolicyCopyWith(RetryPolicy value, $Res Function(RetryPolicy) _then) = _$RetryPolicyCopyWithImpl;
@useResult
$Res call({
 int maxAttempts, Duration initialDelay, double backoffMultiplier, Duration maxDelay
});




}
/// @nodoc
class _$RetryPolicyCopyWithImpl<$Res>
    implements $RetryPolicyCopyWith<$Res> {
  _$RetryPolicyCopyWithImpl(this._self, this._then);

  final RetryPolicy _self;
  final $Res Function(RetryPolicy) _then;

/// Create a copy of RetryPolicy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxAttempts = null,Object? initialDelay = null,Object? backoffMultiplier = null,Object? maxDelay = null,}) {
  return _then(_self.copyWith(
maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,initialDelay: null == initialDelay ? _self.initialDelay : initialDelay // ignore: cast_nullable_to_non_nullable
as Duration,backoffMultiplier: null == backoffMultiplier ? _self.backoffMultiplier : backoffMultiplier // ignore: cast_nullable_to_non_nullable
as double,maxDelay: null == maxDelay ? _self.maxDelay : maxDelay // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [RetryPolicy].
extension RetryPolicyPatterns on RetryPolicy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RetryPolicy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RetryPolicy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RetryPolicy value)  $default,){
final _that = this;
switch (_that) {
case _RetryPolicy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RetryPolicy value)?  $default,){
final _that = this;
switch (_that) {
case _RetryPolicy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxAttempts,  Duration initialDelay,  double backoffMultiplier,  Duration maxDelay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RetryPolicy() when $default != null:
return $default(_that.maxAttempts,_that.initialDelay,_that.backoffMultiplier,_that.maxDelay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxAttempts,  Duration initialDelay,  double backoffMultiplier,  Duration maxDelay)  $default,) {final _that = this;
switch (_that) {
case _RetryPolicy():
return $default(_that.maxAttempts,_that.initialDelay,_that.backoffMultiplier,_that.maxDelay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxAttempts,  Duration initialDelay,  double backoffMultiplier,  Duration maxDelay)?  $default,) {final _that = this;
switch (_that) {
case _RetryPolicy() when $default != null:
return $default(_that.maxAttempts,_that.initialDelay,_that.backoffMultiplier,_that.maxDelay);case _:
  return null;

}
}

}

/// @nodoc


class _RetryPolicy implements RetryPolicy {
  const _RetryPolicy({this.maxAttempts = 3, this.initialDelay = const Duration(seconds: 1), this.backoffMultiplier = 2.0, this.maxDelay = const Duration(seconds: 30)});
  

@override@JsonKey() final  int maxAttempts;
@override@JsonKey() final  Duration initialDelay;
@override@JsonKey() final  double backoffMultiplier;
@override@JsonKey() final  Duration maxDelay;

/// Create a copy of RetryPolicy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryPolicyCopyWith<_RetryPolicy> get copyWith => __$RetryPolicyCopyWithImpl<_RetryPolicy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryPolicy&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.initialDelay, initialDelay) || other.initialDelay == initialDelay)&&(identical(other.backoffMultiplier, backoffMultiplier) || other.backoffMultiplier == backoffMultiplier)&&(identical(other.maxDelay, maxDelay) || other.maxDelay == maxDelay));
}


@override
int get hashCode => Object.hash(runtimeType,maxAttempts,initialDelay,backoffMultiplier,maxDelay);

@override
String toString() {
  return 'RetryPolicy(maxAttempts: $maxAttempts, initialDelay: $initialDelay, backoffMultiplier: $backoffMultiplier, maxDelay: $maxDelay)';
}


}

/// @nodoc
abstract mixin class _$RetryPolicyCopyWith<$Res> implements $RetryPolicyCopyWith<$Res> {
  factory _$RetryPolicyCopyWith(_RetryPolicy value, $Res Function(_RetryPolicy) _then) = __$RetryPolicyCopyWithImpl;
@override @useResult
$Res call({
 int maxAttempts, Duration initialDelay, double backoffMultiplier, Duration maxDelay
});




}
/// @nodoc
class __$RetryPolicyCopyWithImpl<$Res>
    implements _$RetryPolicyCopyWith<$Res> {
  __$RetryPolicyCopyWithImpl(this._self, this._then);

  final _RetryPolicy _self;
  final $Res Function(_RetryPolicy) _then;

/// Create a copy of RetryPolicy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxAttempts = null,Object? initialDelay = null,Object? backoffMultiplier = null,Object? maxDelay = null,}) {
  return _then(_RetryPolicy(
maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,initialDelay: null == initialDelay ? _self.initialDelay : initialDelay // ignore: cast_nullable_to_non_nullable
as Duration,backoffMultiplier: null == backoffMultiplier ? _self.backoffMultiplier : backoffMultiplier // ignore: cast_nullable_to_non_nullable
as double,maxDelay: null == maxDelay ? _self.maxDelay : maxDelay // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
