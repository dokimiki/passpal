// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'motion_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MotionTokens {

/// デュレーション（持続時間）
 DurationTokens get duration;/// イージング（加速曲線）
 EasingTokens get easing;/// スタンダードトランジション
 StandardTransitions get standard;
/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotionTokensCopyWith<MotionTokens> get copyWith => _$MotionTokensCopyWithImpl<MotionTokens>(this as MotionTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotionTokens&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.easing, easing) || other.easing == easing)&&(identical(other.standard, standard) || other.standard == standard));
}


@override
int get hashCode => Object.hash(runtimeType,duration,easing,standard);

@override
String toString() {
  return 'MotionTokens(duration: $duration, easing: $easing, standard: $standard)';
}


}

/// @nodoc
abstract mixin class $MotionTokensCopyWith<$Res>  {
  factory $MotionTokensCopyWith(MotionTokens value, $Res Function(MotionTokens) _then) = _$MotionTokensCopyWithImpl;
@useResult
$Res call({
 DurationTokens duration, EasingTokens easing, StandardTransitions standard
});


$DurationTokensCopyWith<$Res> get duration;$EasingTokensCopyWith<$Res> get easing;$StandardTransitionsCopyWith<$Res> get standard;

}
/// @nodoc
class _$MotionTokensCopyWithImpl<$Res>
    implements $MotionTokensCopyWith<$Res> {
  _$MotionTokensCopyWithImpl(this._self, this._then);

  final MotionTokens _self;
  final $Res Function(MotionTokens) _then;

/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? duration = null,Object? easing = null,Object? standard = null,}) {
  return _then(_self.copyWith(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as DurationTokens,easing: null == easing ? _self.easing : easing // ignore: cast_nullable_to_non_nullable
as EasingTokens,standard: null == standard ? _self.standard : standard // ignore: cast_nullable_to_non_nullable
as StandardTransitions,
  ));
}
/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DurationTokensCopyWith<$Res> get duration {
  
  return $DurationTokensCopyWith<$Res>(_self.duration, (value) {
    return _then(_self.copyWith(duration: value));
  });
}/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EasingTokensCopyWith<$Res> get easing {
  
  return $EasingTokensCopyWith<$Res>(_self.easing, (value) {
    return _then(_self.copyWith(easing: value));
  });
}/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StandardTransitionsCopyWith<$Res> get standard {
  
  return $StandardTransitionsCopyWith<$Res>(_self.standard, (value) {
    return _then(_self.copyWith(standard: value));
  });
}
}


/// Adds pattern-matching-related methods to [MotionTokens].
extension MotionTokensPatterns on MotionTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MotionTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MotionTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MotionTokens value)  $default,){
final _that = this;
switch (_that) {
case _MotionTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MotionTokens value)?  $default,){
final _that = this;
switch (_that) {
case _MotionTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DurationTokens duration,  EasingTokens easing,  StandardTransitions standard)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotionTokens() when $default != null:
return $default(_that.duration,_that.easing,_that.standard);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DurationTokens duration,  EasingTokens easing,  StandardTransitions standard)  $default,) {final _that = this;
switch (_that) {
case _MotionTokens():
return $default(_that.duration,_that.easing,_that.standard);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DurationTokens duration,  EasingTokens easing,  StandardTransitions standard)?  $default,) {final _that = this;
switch (_that) {
case _MotionTokens() when $default != null:
return $default(_that.duration,_that.easing,_that.standard);case _:
  return null;

}
}

}

/// @nodoc


class _MotionTokens implements MotionTokens {
  const _MotionTokens({required this.duration, required this.easing, required this.standard});
  

/// デュレーション（持続時間）
@override final  DurationTokens duration;
/// イージング（加速曲線）
@override final  EasingTokens easing;
/// スタンダードトランジション
@override final  StandardTransitions standard;

/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotionTokensCopyWith<_MotionTokens> get copyWith => __$MotionTokensCopyWithImpl<_MotionTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotionTokens&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.easing, easing) || other.easing == easing)&&(identical(other.standard, standard) || other.standard == standard));
}


@override
int get hashCode => Object.hash(runtimeType,duration,easing,standard);

@override
String toString() {
  return 'MotionTokens(duration: $duration, easing: $easing, standard: $standard)';
}


}

/// @nodoc
abstract mixin class _$MotionTokensCopyWith<$Res> implements $MotionTokensCopyWith<$Res> {
  factory _$MotionTokensCopyWith(_MotionTokens value, $Res Function(_MotionTokens) _then) = __$MotionTokensCopyWithImpl;
@override @useResult
$Res call({
 DurationTokens duration, EasingTokens easing, StandardTransitions standard
});


@override $DurationTokensCopyWith<$Res> get duration;@override $EasingTokensCopyWith<$Res> get easing;@override $StandardTransitionsCopyWith<$Res> get standard;

}
/// @nodoc
class __$MotionTokensCopyWithImpl<$Res>
    implements _$MotionTokensCopyWith<$Res> {
  __$MotionTokensCopyWithImpl(this._self, this._then);

  final _MotionTokens _self;
  final $Res Function(_MotionTokens) _then;

/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? duration = null,Object? easing = null,Object? standard = null,}) {
  return _then(_MotionTokens(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as DurationTokens,easing: null == easing ? _self.easing : easing // ignore: cast_nullable_to_non_nullable
as EasingTokens,standard: null == standard ? _self.standard : standard // ignore: cast_nullable_to_non_nullable
as StandardTransitions,
  ));
}

/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DurationTokensCopyWith<$Res> get duration {
  
  return $DurationTokensCopyWith<$Res>(_self.duration, (value) {
    return _then(_self.copyWith(duration: value));
  });
}/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EasingTokensCopyWith<$Res> get easing {
  
  return $EasingTokensCopyWith<$Res>(_self.easing, (value) {
    return _then(_self.copyWith(easing: value));
  });
}/// Create a copy of MotionTokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StandardTransitionsCopyWith<$Res> get standard {
  
  return $StandardTransitionsCopyWith<$Res>(_self.standard, (value) {
    return _then(_self.copyWith(standard: value));
  });
}
}

/// @nodoc
mixin _$DurationTokens {

/// 瞬時（50ms）
 Duration get instant;/// 極短（100ms）
 Duration get quick;/// 短い（150ms）
 Duration get fast;/// 標準（200ms）
 Duration get normal;/// やや長い（250ms）
 Duration get medium;/// 長い（300ms）
 Duration get slow;/// 極長（400ms）
 Duration get slower;/// 最長（500ms）
 Duration get slowest;/// 特別長い（1秒）
 Duration get extended;
/// Create a copy of DurationTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DurationTokensCopyWith<DurationTokens> get copyWith => _$DurationTokensCopyWithImpl<DurationTokens>(this as DurationTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DurationTokens&&(identical(other.instant, instant) || other.instant == instant)&&(identical(other.quick, quick) || other.quick == quick)&&(identical(other.fast, fast) || other.fast == fast)&&(identical(other.normal, normal) || other.normal == normal)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.slow, slow) || other.slow == slow)&&(identical(other.slower, slower) || other.slower == slower)&&(identical(other.slowest, slowest) || other.slowest == slowest)&&(identical(other.extended, extended) || other.extended == extended));
}


@override
int get hashCode => Object.hash(runtimeType,instant,quick,fast,normal,medium,slow,slower,slowest,extended);

@override
String toString() {
  return 'DurationTokens(instant: $instant, quick: $quick, fast: $fast, normal: $normal, medium: $medium, slow: $slow, slower: $slower, slowest: $slowest, extended: $extended)';
}


}

/// @nodoc
abstract mixin class $DurationTokensCopyWith<$Res>  {
  factory $DurationTokensCopyWith(DurationTokens value, $Res Function(DurationTokens) _then) = _$DurationTokensCopyWithImpl;
@useResult
$Res call({
 Duration instant, Duration quick, Duration fast, Duration normal, Duration medium, Duration slow, Duration slower, Duration slowest, Duration extended
});




}
/// @nodoc
class _$DurationTokensCopyWithImpl<$Res>
    implements $DurationTokensCopyWith<$Res> {
  _$DurationTokensCopyWithImpl(this._self, this._then);

  final DurationTokens _self;
  final $Res Function(DurationTokens) _then;

/// Create a copy of DurationTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? instant = null,Object? quick = null,Object? fast = null,Object? normal = null,Object? medium = null,Object? slow = null,Object? slower = null,Object? slowest = null,Object? extended = null,}) {
  return _then(_self.copyWith(
instant: null == instant ? _self.instant : instant // ignore: cast_nullable_to_non_nullable
as Duration,quick: null == quick ? _self.quick : quick // ignore: cast_nullable_to_non_nullable
as Duration,fast: null == fast ? _self.fast : fast // ignore: cast_nullable_to_non_nullable
as Duration,normal: null == normal ? _self.normal : normal // ignore: cast_nullable_to_non_nullable
as Duration,medium: null == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as Duration,slow: null == slow ? _self.slow : slow // ignore: cast_nullable_to_non_nullable
as Duration,slower: null == slower ? _self.slower : slower // ignore: cast_nullable_to_non_nullable
as Duration,slowest: null == slowest ? _self.slowest : slowest // ignore: cast_nullable_to_non_nullable
as Duration,extended: null == extended ? _self.extended : extended // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [DurationTokens].
extension DurationTokensPatterns on DurationTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DurationTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DurationTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DurationTokens value)  $default,){
final _that = this;
switch (_that) {
case _DurationTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DurationTokens value)?  $default,){
final _that = this;
switch (_that) {
case _DurationTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration instant,  Duration quick,  Duration fast,  Duration normal,  Duration medium,  Duration slow,  Duration slower,  Duration slowest,  Duration extended)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DurationTokens() when $default != null:
return $default(_that.instant,_that.quick,_that.fast,_that.normal,_that.medium,_that.slow,_that.slower,_that.slowest,_that.extended);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration instant,  Duration quick,  Duration fast,  Duration normal,  Duration medium,  Duration slow,  Duration slower,  Duration slowest,  Duration extended)  $default,) {final _that = this;
switch (_that) {
case _DurationTokens():
return $default(_that.instant,_that.quick,_that.fast,_that.normal,_that.medium,_that.slow,_that.slower,_that.slowest,_that.extended);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration instant,  Duration quick,  Duration fast,  Duration normal,  Duration medium,  Duration slow,  Duration slower,  Duration slowest,  Duration extended)?  $default,) {final _that = this;
switch (_that) {
case _DurationTokens() when $default != null:
return $default(_that.instant,_that.quick,_that.fast,_that.normal,_that.medium,_that.slow,_that.slower,_that.slowest,_that.extended);case _:
  return null;

}
}

}

/// @nodoc


class _DurationTokens implements DurationTokens {
  const _DurationTokens({required this.instant, required this.quick, required this.fast, required this.normal, required this.medium, required this.slow, required this.slower, required this.slowest, required this.extended});
  

/// 瞬時（50ms）
@override final  Duration instant;
/// 極短（100ms）
@override final  Duration quick;
/// 短い（150ms）
@override final  Duration fast;
/// 標準（200ms）
@override final  Duration normal;
/// やや長い（250ms）
@override final  Duration medium;
/// 長い（300ms）
@override final  Duration slow;
/// 極長（400ms）
@override final  Duration slower;
/// 最長（500ms）
@override final  Duration slowest;
/// 特別長い（1秒）
@override final  Duration extended;

/// Create a copy of DurationTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DurationTokensCopyWith<_DurationTokens> get copyWith => __$DurationTokensCopyWithImpl<_DurationTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DurationTokens&&(identical(other.instant, instant) || other.instant == instant)&&(identical(other.quick, quick) || other.quick == quick)&&(identical(other.fast, fast) || other.fast == fast)&&(identical(other.normal, normal) || other.normal == normal)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.slow, slow) || other.slow == slow)&&(identical(other.slower, slower) || other.slower == slower)&&(identical(other.slowest, slowest) || other.slowest == slowest)&&(identical(other.extended, extended) || other.extended == extended));
}


@override
int get hashCode => Object.hash(runtimeType,instant,quick,fast,normal,medium,slow,slower,slowest,extended);

@override
String toString() {
  return 'DurationTokens(instant: $instant, quick: $quick, fast: $fast, normal: $normal, medium: $medium, slow: $slow, slower: $slower, slowest: $slowest, extended: $extended)';
}


}

/// @nodoc
abstract mixin class _$DurationTokensCopyWith<$Res> implements $DurationTokensCopyWith<$Res> {
  factory _$DurationTokensCopyWith(_DurationTokens value, $Res Function(_DurationTokens) _then) = __$DurationTokensCopyWithImpl;
@override @useResult
$Res call({
 Duration instant, Duration quick, Duration fast, Duration normal, Duration medium, Duration slow, Duration slower, Duration slowest, Duration extended
});




}
/// @nodoc
class __$DurationTokensCopyWithImpl<$Res>
    implements _$DurationTokensCopyWith<$Res> {
  __$DurationTokensCopyWithImpl(this._self, this._then);

  final _DurationTokens _self;
  final $Res Function(_DurationTokens) _then;

/// Create a copy of DurationTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? instant = null,Object? quick = null,Object? fast = null,Object? normal = null,Object? medium = null,Object? slow = null,Object? slower = null,Object? slowest = null,Object? extended = null,}) {
  return _then(_DurationTokens(
instant: null == instant ? _self.instant : instant // ignore: cast_nullable_to_non_nullable
as Duration,quick: null == quick ? _self.quick : quick // ignore: cast_nullable_to_non_nullable
as Duration,fast: null == fast ? _self.fast : fast // ignore: cast_nullable_to_non_nullable
as Duration,normal: null == normal ? _self.normal : normal // ignore: cast_nullable_to_non_nullable
as Duration,medium: null == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as Duration,slow: null == slow ? _self.slow : slow // ignore: cast_nullable_to_non_nullable
as Duration,slower: null == slower ? _self.slower : slower // ignore: cast_nullable_to_non_nullable
as Duration,slowest: null == slowest ? _self.slowest : slowest // ignore: cast_nullable_to_non_nullable
as Duration,extended: null == extended ? _self.extended : extended // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc
mixin _$EasingTokens {

/// 線形（一定速度）
 Curve get linear;/// 標準イージング
 Curve get standard;/// 加速（開始が遅く、終了が速い）
 Curve get accelerate;/// 減速（開始が速く、終了が遅い）
 Curve get decelerate;/// 強調イージング
 Curve get emphasized;/// 入場イージング
 Curve get enter;/// 退場イージング
 Curve get exit;/// バウンス
 Curve get bounce;/// 弾性
 Curve get elastic;
/// Create a copy of EasingTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EasingTokensCopyWith<EasingTokens> get copyWith => _$EasingTokensCopyWithImpl<EasingTokens>(this as EasingTokens, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EasingTokens&&(identical(other.linear, linear) || other.linear == linear)&&(identical(other.standard, standard) || other.standard == standard)&&(identical(other.accelerate, accelerate) || other.accelerate == accelerate)&&(identical(other.decelerate, decelerate) || other.decelerate == decelerate)&&(identical(other.emphasized, emphasized) || other.emphasized == emphasized)&&(identical(other.enter, enter) || other.enter == enter)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.bounce, bounce) || other.bounce == bounce)&&(identical(other.elastic, elastic) || other.elastic == elastic));
}


@override
int get hashCode => Object.hash(runtimeType,linear,standard,accelerate,decelerate,emphasized,enter,exit,bounce,elastic);

@override
String toString() {
  return 'EasingTokens(linear: $linear, standard: $standard, accelerate: $accelerate, decelerate: $decelerate, emphasized: $emphasized, enter: $enter, exit: $exit, bounce: $bounce, elastic: $elastic)';
}


}

/// @nodoc
abstract mixin class $EasingTokensCopyWith<$Res>  {
  factory $EasingTokensCopyWith(EasingTokens value, $Res Function(EasingTokens) _then) = _$EasingTokensCopyWithImpl;
@useResult
$Res call({
 Curve linear, Curve standard, Curve accelerate, Curve decelerate, Curve emphasized, Curve enter, Curve exit, Curve bounce, Curve elastic
});




}
/// @nodoc
class _$EasingTokensCopyWithImpl<$Res>
    implements $EasingTokensCopyWith<$Res> {
  _$EasingTokensCopyWithImpl(this._self, this._then);

  final EasingTokens _self;
  final $Res Function(EasingTokens) _then;

/// Create a copy of EasingTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? linear = null,Object? standard = null,Object? accelerate = null,Object? decelerate = null,Object? emphasized = null,Object? enter = null,Object? exit = null,Object? bounce = null,Object? elastic = null,}) {
  return _then(_self.copyWith(
linear: null == linear ? _self.linear : linear // ignore: cast_nullable_to_non_nullable
as Curve,standard: null == standard ? _self.standard : standard // ignore: cast_nullable_to_non_nullable
as Curve,accelerate: null == accelerate ? _self.accelerate : accelerate // ignore: cast_nullable_to_non_nullable
as Curve,decelerate: null == decelerate ? _self.decelerate : decelerate // ignore: cast_nullable_to_non_nullable
as Curve,emphasized: null == emphasized ? _self.emphasized : emphasized // ignore: cast_nullable_to_non_nullable
as Curve,enter: null == enter ? _self.enter : enter // ignore: cast_nullable_to_non_nullable
as Curve,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as Curve,bounce: null == bounce ? _self.bounce : bounce // ignore: cast_nullable_to_non_nullable
as Curve,elastic: null == elastic ? _self.elastic : elastic // ignore: cast_nullable_to_non_nullable
as Curve,
  ));
}

}


/// Adds pattern-matching-related methods to [EasingTokens].
extension EasingTokensPatterns on EasingTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EasingTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EasingTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EasingTokens value)  $default,){
final _that = this;
switch (_that) {
case _EasingTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EasingTokens value)?  $default,){
final _that = this;
switch (_that) {
case _EasingTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Curve linear,  Curve standard,  Curve accelerate,  Curve decelerate,  Curve emphasized,  Curve enter,  Curve exit,  Curve bounce,  Curve elastic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EasingTokens() when $default != null:
return $default(_that.linear,_that.standard,_that.accelerate,_that.decelerate,_that.emphasized,_that.enter,_that.exit,_that.bounce,_that.elastic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Curve linear,  Curve standard,  Curve accelerate,  Curve decelerate,  Curve emphasized,  Curve enter,  Curve exit,  Curve bounce,  Curve elastic)  $default,) {final _that = this;
switch (_that) {
case _EasingTokens():
return $default(_that.linear,_that.standard,_that.accelerate,_that.decelerate,_that.emphasized,_that.enter,_that.exit,_that.bounce,_that.elastic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Curve linear,  Curve standard,  Curve accelerate,  Curve decelerate,  Curve emphasized,  Curve enter,  Curve exit,  Curve bounce,  Curve elastic)?  $default,) {final _that = this;
switch (_that) {
case _EasingTokens() when $default != null:
return $default(_that.linear,_that.standard,_that.accelerate,_that.decelerate,_that.emphasized,_that.enter,_that.exit,_that.bounce,_that.elastic);case _:
  return null;

}
}

}

/// @nodoc


class _EasingTokens implements EasingTokens {
  const _EasingTokens({required this.linear, required this.standard, required this.accelerate, required this.decelerate, required this.emphasized, required this.enter, required this.exit, required this.bounce, required this.elastic});
  

/// 線形（一定速度）
@override final  Curve linear;
/// 標準イージング
@override final  Curve standard;
/// 加速（開始が遅く、終了が速い）
@override final  Curve accelerate;
/// 減速（開始が速く、終了が遅い）
@override final  Curve decelerate;
/// 強調イージング
@override final  Curve emphasized;
/// 入場イージング
@override final  Curve enter;
/// 退場イージング
@override final  Curve exit;
/// バウンス
@override final  Curve bounce;
/// 弾性
@override final  Curve elastic;

/// Create a copy of EasingTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EasingTokensCopyWith<_EasingTokens> get copyWith => __$EasingTokensCopyWithImpl<_EasingTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EasingTokens&&(identical(other.linear, linear) || other.linear == linear)&&(identical(other.standard, standard) || other.standard == standard)&&(identical(other.accelerate, accelerate) || other.accelerate == accelerate)&&(identical(other.decelerate, decelerate) || other.decelerate == decelerate)&&(identical(other.emphasized, emphasized) || other.emphasized == emphasized)&&(identical(other.enter, enter) || other.enter == enter)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.bounce, bounce) || other.bounce == bounce)&&(identical(other.elastic, elastic) || other.elastic == elastic));
}


@override
int get hashCode => Object.hash(runtimeType,linear,standard,accelerate,decelerate,emphasized,enter,exit,bounce,elastic);

@override
String toString() {
  return 'EasingTokens(linear: $linear, standard: $standard, accelerate: $accelerate, decelerate: $decelerate, emphasized: $emphasized, enter: $enter, exit: $exit, bounce: $bounce, elastic: $elastic)';
}


}

/// @nodoc
abstract mixin class _$EasingTokensCopyWith<$Res> implements $EasingTokensCopyWith<$Res> {
  factory _$EasingTokensCopyWith(_EasingTokens value, $Res Function(_EasingTokens) _then) = __$EasingTokensCopyWithImpl;
@override @useResult
$Res call({
 Curve linear, Curve standard, Curve accelerate, Curve decelerate, Curve emphasized, Curve enter, Curve exit, Curve bounce, Curve elastic
});




}
/// @nodoc
class __$EasingTokensCopyWithImpl<$Res>
    implements _$EasingTokensCopyWith<$Res> {
  __$EasingTokensCopyWithImpl(this._self, this._then);

  final _EasingTokens _self;
  final $Res Function(_EasingTokens) _then;

/// Create a copy of EasingTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? linear = null,Object? standard = null,Object? accelerate = null,Object? decelerate = null,Object? emphasized = null,Object? enter = null,Object? exit = null,Object? bounce = null,Object? elastic = null,}) {
  return _then(_EasingTokens(
linear: null == linear ? _self.linear : linear // ignore: cast_nullable_to_non_nullable
as Curve,standard: null == standard ? _self.standard : standard // ignore: cast_nullable_to_non_nullable
as Curve,accelerate: null == accelerate ? _self.accelerate : accelerate // ignore: cast_nullable_to_non_nullable
as Curve,decelerate: null == decelerate ? _self.decelerate : decelerate // ignore: cast_nullable_to_non_nullable
as Curve,emphasized: null == emphasized ? _self.emphasized : emphasized // ignore: cast_nullable_to_non_nullable
as Curve,enter: null == enter ? _self.enter : enter // ignore: cast_nullable_to_non_nullable
as Curve,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as Curve,bounce: null == bounce ? _self.bounce : bounce // ignore: cast_nullable_to_non_nullable
as Curve,elastic: null == elastic ? _self.elastic : elastic // ignore: cast_nullable_to_non_nullable
as Curve,
  ));
}


}

/// @nodoc
mixin _$StandardTransitions {

/// フェードイン・アウト
 TransitionConfig get fade;/// スライド（水平）
 TransitionConfig get slideHorizontal;/// スライド（垂直）
 TransitionConfig get slideVertical;/// スケール（拡大縮小）
 TransitionConfig get scale;/// 回転
 TransitionConfig get rotation;/// コンテナトランスフォーム
 TransitionConfig get containerTransform;/// シェアードアクシス
 TransitionConfig get sharedAxis;/// FABトランジション
 TransitionConfig get fabTransition;/// ボトムシート
 TransitionConfig get bottomSheet;/// モーダル
 TransitionConfig get modal;
/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StandardTransitionsCopyWith<StandardTransitions> get copyWith => _$StandardTransitionsCopyWithImpl<StandardTransitions>(this as StandardTransitions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StandardTransitions&&(identical(other.fade, fade) || other.fade == fade)&&(identical(other.slideHorizontal, slideHorizontal) || other.slideHorizontal == slideHorizontal)&&(identical(other.slideVertical, slideVertical) || other.slideVertical == slideVertical)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.containerTransform, containerTransform) || other.containerTransform == containerTransform)&&(identical(other.sharedAxis, sharedAxis) || other.sharedAxis == sharedAxis)&&(identical(other.fabTransition, fabTransition) || other.fabTransition == fabTransition)&&(identical(other.bottomSheet, bottomSheet) || other.bottomSheet == bottomSheet)&&(identical(other.modal, modal) || other.modal == modal));
}


@override
int get hashCode => Object.hash(runtimeType,fade,slideHorizontal,slideVertical,scale,rotation,containerTransform,sharedAxis,fabTransition,bottomSheet,modal);

@override
String toString() {
  return 'StandardTransitions(fade: $fade, slideHorizontal: $slideHorizontal, slideVertical: $slideVertical, scale: $scale, rotation: $rotation, containerTransform: $containerTransform, sharedAxis: $sharedAxis, fabTransition: $fabTransition, bottomSheet: $bottomSheet, modal: $modal)';
}


}

/// @nodoc
abstract mixin class $StandardTransitionsCopyWith<$Res>  {
  factory $StandardTransitionsCopyWith(StandardTransitions value, $Res Function(StandardTransitions) _then) = _$StandardTransitionsCopyWithImpl;
@useResult
$Res call({
 TransitionConfig fade, TransitionConfig slideHorizontal, TransitionConfig slideVertical, TransitionConfig scale, TransitionConfig rotation, TransitionConfig containerTransform, TransitionConfig sharedAxis, TransitionConfig fabTransition, TransitionConfig bottomSheet, TransitionConfig modal
});


$TransitionConfigCopyWith<$Res> get fade;$TransitionConfigCopyWith<$Res> get slideHorizontal;$TransitionConfigCopyWith<$Res> get slideVertical;$TransitionConfigCopyWith<$Res> get scale;$TransitionConfigCopyWith<$Res> get rotation;$TransitionConfigCopyWith<$Res> get containerTransform;$TransitionConfigCopyWith<$Res> get sharedAxis;$TransitionConfigCopyWith<$Res> get fabTransition;$TransitionConfigCopyWith<$Res> get bottomSheet;$TransitionConfigCopyWith<$Res> get modal;

}
/// @nodoc
class _$StandardTransitionsCopyWithImpl<$Res>
    implements $StandardTransitionsCopyWith<$Res> {
  _$StandardTransitionsCopyWithImpl(this._self, this._then);

  final StandardTransitions _self;
  final $Res Function(StandardTransitions) _then;

/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fade = null,Object? slideHorizontal = null,Object? slideVertical = null,Object? scale = null,Object? rotation = null,Object? containerTransform = null,Object? sharedAxis = null,Object? fabTransition = null,Object? bottomSheet = null,Object? modal = null,}) {
  return _then(_self.copyWith(
fade: null == fade ? _self.fade : fade // ignore: cast_nullable_to_non_nullable
as TransitionConfig,slideHorizontal: null == slideHorizontal ? _self.slideHorizontal : slideHorizontal // ignore: cast_nullable_to_non_nullable
as TransitionConfig,slideVertical: null == slideVertical ? _self.slideVertical : slideVertical // ignore: cast_nullable_to_non_nullable
as TransitionConfig,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as TransitionConfig,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as TransitionConfig,containerTransform: null == containerTransform ? _self.containerTransform : containerTransform // ignore: cast_nullable_to_non_nullable
as TransitionConfig,sharedAxis: null == sharedAxis ? _self.sharedAxis : sharedAxis // ignore: cast_nullable_to_non_nullable
as TransitionConfig,fabTransition: null == fabTransition ? _self.fabTransition : fabTransition // ignore: cast_nullable_to_non_nullable
as TransitionConfig,bottomSheet: null == bottomSheet ? _self.bottomSheet : bottomSheet // ignore: cast_nullable_to_non_nullable
as TransitionConfig,modal: null == modal ? _self.modal : modal // ignore: cast_nullable_to_non_nullable
as TransitionConfig,
  ));
}
/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get fade {
  
  return $TransitionConfigCopyWith<$Res>(_self.fade, (value) {
    return _then(_self.copyWith(fade: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get slideHorizontal {
  
  return $TransitionConfigCopyWith<$Res>(_self.slideHorizontal, (value) {
    return _then(_self.copyWith(slideHorizontal: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get slideVertical {
  
  return $TransitionConfigCopyWith<$Res>(_self.slideVertical, (value) {
    return _then(_self.copyWith(slideVertical: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get scale {
  
  return $TransitionConfigCopyWith<$Res>(_self.scale, (value) {
    return _then(_self.copyWith(scale: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get rotation {
  
  return $TransitionConfigCopyWith<$Res>(_self.rotation, (value) {
    return _then(_self.copyWith(rotation: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get containerTransform {
  
  return $TransitionConfigCopyWith<$Res>(_self.containerTransform, (value) {
    return _then(_self.copyWith(containerTransform: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get sharedAxis {
  
  return $TransitionConfigCopyWith<$Res>(_self.sharedAxis, (value) {
    return _then(_self.copyWith(sharedAxis: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get fabTransition {
  
  return $TransitionConfigCopyWith<$Res>(_self.fabTransition, (value) {
    return _then(_self.copyWith(fabTransition: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get bottomSheet {
  
  return $TransitionConfigCopyWith<$Res>(_self.bottomSheet, (value) {
    return _then(_self.copyWith(bottomSheet: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get modal {
  
  return $TransitionConfigCopyWith<$Res>(_self.modal, (value) {
    return _then(_self.copyWith(modal: value));
  });
}
}


/// Adds pattern-matching-related methods to [StandardTransitions].
extension StandardTransitionsPatterns on StandardTransitions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StandardTransitions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StandardTransitions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StandardTransitions value)  $default,){
final _that = this;
switch (_that) {
case _StandardTransitions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StandardTransitions value)?  $default,){
final _that = this;
switch (_that) {
case _StandardTransitions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransitionConfig fade,  TransitionConfig slideHorizontal,  TransitionConfig slideVertical,  TransitionConfig scale,  TransitionConfig rotation,  TransitionConfig containerTransform,  TransitionConfig sharedAxis,  TransitionConfig fabTransition,  TransitionConfig bottomSheet,  TransitionConfig modal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StandardTransitions() when $default != null:
return $default(_that.fade,_that.slideHorizontal,_that.slideVertical,_that.scale,_that.rotation,_that.containerTransform,_that.sharedAxis,_that.fabTransition,_that.bottomSheet,_that.modal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransitionConfig fade,  TransitionConfig slideHorizontal,  TransitionConfig slideVertical,  TransitionConfig scale,  TransitionConfig rotation,  TransitionConfig containerTransform,  TransitionConfig sharedAxis,  TransitionConfig fabTransition,  TransitionConfig bottomSheet,  TransitionConfig modal)  $default,) {final _that = this;
switch (_that) {
case _StandardTransitions():
return $default(_that.fade,_that.slideHorizontal,_that.slideVertical,_that.scale,_that.rotation,_that.containerTransform,_that.sharedAxis,_that.fabTransition,_that.bottomSheet,_that.modal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransitionConfig fade,  TransitionConfig slideHorizontal,  TransitionConfig slideVertical,  TransitionConfig scale,  TransitionConfig rotation,  TransitionConfig containerTransform,  TransitionConfig sharedAxis,  TransitionConfig fabTransition,  TransitionConfig bottomSheet,  TransitionConfig modal)?  $default,) {final _that = this;
switch (_that) {
case _StandardTransitions() when $default != null:
return $default(_that.fade,_that.slideHorizontal,_that.slideVertical,_that.scale,_that.rotation,_that.containerTransform,_that.sharedAxis,_that.fabTransition,_that.bottomSheet,_that.modal);case _:
  return null;

}
}

}

/// @nodoc


class _StandardTransitions implements StandardTransitions {
  const _StandardTransitions({required this.fade, required this.slideHorizontal, required this.slideVertical, required this.scale, required this.rotation, required this.containerTransform, required this.sharedAxis, required this.fabTransition, required this.bottomSheet, required this.modal});
  

/// フェードイン・アウト
@override final  TransitionConfig fade;
/// スライド（水平）
@override final  TransitionConfig slideHorizontal;
/// スライド（垂直）
@override final  TransitionConfig slideVertical;
/// スケール（拡大縮小）
@override final  TransitionConfig scale;
/// 回転
@override final  TransitionConfig rotation;
/// コンテナトランスフォーム
@override final  TransitionConfig containerTransform;
/// シェアードアクシス
@override final  TransitionConfig sharedAxis;
/// FABトランジション
@override final  TransitionConfig fabTransition;
/// ボトムシート
@override final  TransitionConfig bottomSheet;
/// モーダル
@override final  TransitionConfig modal;

/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StandardTransitionsCopyWith<_StandardTransitions> get copyWith => __$StandardTransitionsCopyWithImpl<_StandardTransitions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StandardTransitions&&(identical(other.fade, fade) || other.fade == fade)&&(identical(other.slideHorizontal, slideHorizontal) || other.slideHorizontal == slideHorizontal)&&(identical(other.slideVertical, slideVertical) || other.slideVertical == slideVertical)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.containerTransform, containerTransform) || other.containerTransform == containerTransform)&&(identical(other.sharedAxis, sharedAxis) || other.sharedAxis == sharedAxis)&&(identical(other.fabTransition, fabTransition) || other.fabTransition == fabTransition)&&(identical(other.bottomSheet, bottomSheet) || other.bottomSheet == bottomSheet)&&(identical(other.modal, modal) || other.modal == modal));
}


@override
int get hashCode => Object.hash(runtimeType,fade,slideHorizontal,slideVertical,scale,rotation,containerTransform,sharedAxis,fabTransition,bottomSheet,modal);

@override
String toString() {
  return 'StandardTransitions(fade: $fade, slideHorizontal: $slideHorizontal, slideVertical: $slideVertical, scale: $scale, rotation: $rotation, containerTransform: $containerTransform, sharedAxis: $sharedAxis, fabTransition: $fabTransition, bottomSheet: $bottomSheet, modal: $modal)';
}


}

/// @nodoc
abstract mixin class _$StandardTransitionsCopyWith<$Res> implements $StandardTransitionsCopyWith<$Res> {
  factory _$StandardTransitionsCopyWith(_StandardTransitions value, $Res Function(_StandardTransitions) _then) = __$StandardTransitionsCopyWithImpl;
@override @useResult
$Res call({
 TransitionConfig fade, TransitionConfig slideHorizontal, TransitionConfig slideVertical, TransitionConfig scale, TransitionConfig rotation, TransitionConfig containerTransform, TransitionConfig sharedAxis, TransitionConfig fabTransition, TransitionConfig bottomSheet, TransitionConfig modal
});


@override $TransitionConfigCopyWith<$Res> get fade;@override $TransitionConfigCopyWith<$Res> get slideHorizontal;@override $TransitionConfigCopyWith<$Res> get slideVertical;@override $TransitionConfigCopyWith<$Res> get scale;@override $TransitionConfigCopyWith<$Res> get rotation;@override $TransitionConfigCopyWith<$Res> get containerTransform;@override $TransitionConfigCopyWith<$Res> get sharedAxis;@override $TransitionConfigCopyWith<$Res> get fabTransition;@override $TransitionConfigCopyWith<$Res> get bottomSheet;@override $TransitionConfigCopyWith<$Res> get modal;

}
/// @nodoc
class __$StandardTransitionsCopyWithImpl<$Res>
    implements _$StandardTransitionsCopyWith<$Res> {
  __$StandardTransitionsCopyWithImpl(this._self, this._then);

  final _StandardTransitions _self;
  final $Res Function(_StandardTransitions) _then;

/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fade = null,Object? slideHorizontal = null,Object? slideVertical = null,Object? scale = null,Object? rotation = null,Object? containerTransform = null,Object? sharedAxis = null,Object? fabTransition = null,Object? bottomSheet = null,Object? modal = null,}) {
  return _then(_StandardTransitions(
fade: null == fade ? _self.fade : fade // ignore: cast_nullable_to_non_nullable
as TransitionConfig,slideHorizontal: null == slideHorizontal ? _self.slideHorizontal : slideHorizontal // ignore: cast_nullable_to_non_nullable
as TransitionConfig,slideVertical: null == slideVertical ? _self.slideVertical : slideVertical // ignore: cast_nullable_to_non_nullable
as TransitionConfig,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as TransitionConfig,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as TransitionConfig,containerTransform: null == containerTransform ? _self.containerTransform : containerTransform // ignore: cast_nullable_to_non_nullable
as TransitionConfig,sharedAxis: null == sharedAxis ? _self.sharedAxis : sharedAxis // ignore: cast_nullable_to_non_nullable
as TransitionConfig,fabTransition: null == fabTransition ? _self.fabTransition : fabTransition // ignore: cast_nullable_to_non_nullable
as TransitionConfig,bottomSheet: null == bottomSheet ? _self.bottomSheet : bottomSheet // ignore: cast_nullable_to_non_nullable
as TransitionConfig,modal: null == modal ? _self.modal : modal // ignore: cast_nullable_to_non_nullable
as TransitionConfig,
  ));
}

/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get fade {
  
  return $TransitionConfigCopyWith<$Res>(_self.fade, (value) {
    return _then(_self.copyWith(fade: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get slideHorizontal {
  
  return $TransitionConfigCopyWith<$Res>(_self.slideHorizontal, (value) {
    return _then(_self.copyWith(slideHorizontal: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get slideVertical {
  
  return $TransitionConfigCopyWith<$Res>(_self.slideVertical, (value) {
    return _then(_self.copyWith(slideVertical: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get scale {
  
  return $TransitionConfigCopyWith<$Res>(_self.scale, (value) {
    return _then(_self.copyWith(scale: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get rotation {
  
  return $TransitionConfigCopyWith<$Res>(_self.rotation, (value) {
    return _then(_self.copyWith(rotation: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get containerTransform {
  
  return $TransitionConfigCopyWith<$Res>(_self.containerTransform, (value) {
    return _then(_self.copyWith(containerTransform: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get sharedAxis {
  
  return $TransitionConfigCopyWith<$Res>(_self.sharedAxis, (value) {
    return _then(_self.copyWith(sharedAxis: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get fabTransition {
  
  return $TransitionConfigCopyWith<$Res>(_self.fabTransition, (value) {
    return _then(_self.copyWith(fabTransition: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get bottomSheet {
  
  return $TransitionConfigCopyWith<$Res>(_self.bottomSheet, (value) {
    return _then(_self.copyWith(bottomSheet: value));
  });
}/// Create a copy of StandardTransitions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<$Res> get modal {
  
  return $TransitionConfigCopyWith<$Res>(_self.modal, (value) {
    return _then(_self.copyWith(modal: value));
  });
}
}

/// @nodoc
mixin _$TransitionConfig {

 Duration get duration; Curve get curve; Duration? get reverseDuration; Curve? get reverseCurve;
/// Create a copy of TransitionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransitionConfigCopyWith<TransitionConfig> get copyWith => _$TransitionConfigCopyWithImpl<TransitionConfig>(this as TransitionConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransitionConfig&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.curve, curve) || other.curve == curve)&&(identical(other.reverseDuration, reverseDuration) || other.reverseDuration == reverseDuration)&&(identical(other.reverseCurve, reverseCurve) || other.reverseCurve == reverseCurve));
}


@override
int get hashCode => Object.hash(runtimeType,duration,curve,reverseDuration,reverseCurve);

@override
String toString() {
  return 'TransitionConfig(duration: $duration, curve: $curve, reverseDuration: $reverseDuration, reverseCurve: $reverseCurve)';
}


}

/// @nodoc
abstract mixin class $TransitionConfigCopyWith<$Res>  {
  factory $TransitionConfigCopyWith(TransitionConfig value, $Res Function(TransitionConfig) _then) = _$TransitionConfigCopyWithImpl;
@useResult
$Res call({
 Duration duration, Curve curve, Duration? reverseDuration, Curve? reverseCurve
});




}
/// @nodoc
class _$TransitionConfigCopyWithImpl<$Res>
    implements $TransitionConfigCopyWith<$Res> {
  _$TransitionConfigCopyWithImpl(this._self, this._then);

  final TransitionConfig _self;
  final $Res Function(TransitionConfig) _then;

/// Create a copy of TransitionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? duration = null,Object? curve = null,Object? reverseDuration = freezed,Object? reverseCurve = freezed,}) {
  return _then(_self.copyWith(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,curve: null == curve ? _self.curve : curve // ignore: cast_nullable_to_non_nullable
as Curve,reverseDuration: freezed == reverseDuration ? _self.reverseDuration : reverseDuration // ignore: cast_nullable_to_non_nullable
as Duration?,reverseCurve: freezed == reverseCurve ? _self.reverseCurve : reverseCurve // ignore: cast_nullable_to_non_nullable
as Curve?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransitionConfig].
extension TransitionConfigPatterns on TransitionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransitionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransitionConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransitionConfig value)  $default,){
final _that = this;
switch (_that) {
case _TransitionConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransitionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TransitionConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration duration,  Curve curve,  Duration? reverseDuration,  Curve? reverseCurve)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransitionConfig() when $default != null:
return $default(_that.duration,_that.curve,_that.reverseDuration,_that.reverseCurve);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration duration,  Curve curve,  Duration? reverseDuration,  Curve? reverseCurve)  $default,) {final _that = this;
switch (_that) {
case _TransitionConfig():
return $default(_that.duration,_that.curve,_that.reverseDuration,_that.reverseCurve);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration duration,  Curve curve,  Duration? reverseDuration,  Curve? reverseCurve)?  $default,) {final _that = this;
switch (_that) {
case _TransitionConfig() when $default != null:
return $default(_that.duration,_that.curve,_that.reverseDuration,_that.reverseCurve);case _:
  return null;

}
}

}

/// @nodoc


class _TransitionConfig implements TransitionConfig {
  const _TransitionConfig({required this.duration, required this.curve, this.reverseDuration, this.reverseCurve});
  

@override final  Duration duration;
@override final  Curve curve;
@override final  Duration? reverseDuration;
@override final  Curve? reverseCurve;

/// Create a copy of TransitionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransitionConfigCopyWith<_TransitionConfig> get copyWith => __$TransitionConfigCopyWithImpl<_TransitionConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransitionConfig&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.curve, curve) || other.curve == curve)&&(identical(other.reverseDuration, reverseDuration) || other.reverseDuration == reverseDuration)&&(identical(other.reverseCurve, reverseCurve) || other.reverseCurve == reverseCurve));
}


@override
int get hashCode => Object.hash(runtimeType,duration,curve,reverseDuration,reverseCurve);

@override
String toString() {
  return 'TransitionConfig(duration: $duration, curve: $curve, reverseDuration: $reverseDuration, reverseCurve: $reverseCurve)';
}


}

/// @nodoc
abstract mixin class _$TransitionConfigCopyWith<$Res> implements $TransitionConfigCopyWith<$Res> {
  factory _$TransitionConfigCopyWith(_TransitionConfig value, $Res Function(_TransitionConfig) _then) = __$TransitionConfigCopyWithImpl;
@override @useResult
$Res call({
 Duration duration, Curve curve, Duration? reverseDuration, Curve? reverseCurve
});




}
/// @nodoc
class __$TransitionConfigCopyWithImpl<$Res>
    implements _$TransitionConfigCopyWith<$Res> {
  __$TransitionConfigCopyWithImpl(this._self, this._then);

  final _TransitionConfig _self;
  final $Res Function(_TransitionConfig) _then;

/// Create a copy of TransitionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? duration = null,Object? curve = null,Object? reverseDuration = freezed,Object? reverseCurve = freezed,}) {
  return _then(_TransitionConfig(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,curve: null == curve ? _self.curve : curve // ignore: cast_nullable_to_non_nullable
as Curve,reverseDuration: freezed == reverseDuration ? _self.reverseDuration : reverseDuration // ignore: cast_nullable_to_non_nullable
as Duration?,reverseCurve: freezed == reverseCurve ? _self.reverseCurve : reverseCurve // ignore: cast_nullable_to_non_nullable
as Curve?,
  ));
}


}

// dart format on
