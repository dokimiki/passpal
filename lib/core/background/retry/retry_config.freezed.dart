// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'retry_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RetryConfig {

 int get maxAttempts; Duration get baseDelay; double get multiplier; Duration get maxDelay; double get jitterFactor;
/// Create a copy of RetryConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetryConfigCopyWith<RetryConfig> get copyWith => _$RetryConfigCopyWithImpl<RetryConfig>(this as RetryConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetryConfig&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.baseDelay, baseDelay) || other.baseDelay == baseDelay)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier)&&(identical(other.maxDelay, maxDelay) || other.maxDelay == maxDelay)&&(identical(other.jitterFactor, jitterFactor) || other.jitterFactor == jitterFactor));
}


@override
int get hashCode => Object.hash(runtimeType,maxAttempts,baseDelay,multiplier,maxDelay,jitterFactor);

@override
String toString() {
  return 'RetryConfig(maxAttempts: $maxAttempts, baseDelay: $baseDelay, multiplier: $multiplier, maxDelay: $maxDelay, jitterFactor: $jitterFactor)';
}


}

/// @nodoc
abstract mixin class $RetryConfigCopyWith<$Res>  {
  factory $RetryConfigCopyWith(RetryConfig value, $Res Function(RetryConfig) _then) = _$RetryConfigCopyWithImpl;
@useResult
$Res call({
 int maxAttempts, Duration baseDelay, double multiplier, Duration maxDelay, double jitterFactor
});




}
/// @nodoc
class _$RetryConfigCopyWithImpl<$Res>
    implements $RetryConfigCopyWith<$Res> {
  _$RetryConfigCopyWithImpl(this._self, this._then);

  final RetryConfig _self;
  final $Res Function(RetryConfig) _then;

/// Create a copy of RetryConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxAttempts = null,Object? baseDelay = null,Object? multiplier = null,Object? maxDelay = null,Object? jitterFactor = null,}) {
  return _then(_self.copyWith(
maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,baseDelay: null == baseDelay ? _self.baseDelay : baseDelay // ignore: cast_nullable_to_non_nullable
as Duration,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,maxDelay: null == maxDelay ? _self.maxDelay : maxDelay // ignore: cast_nullable_to_non_nullable
as Duration,jitterFactor: null == jitterFactor ? _self.jitterFactor : jitterFactor // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _RetryConfig implements RetryConfig {
  const _RetryConfig({this.maxAttempts = 5, this.baseDelay = const Duration(minutes: 1), this.multiplier = 2.0, this.maxDelay = const Duration(hours: 1), this.jitterFactor = 0.3});
  

@override@JsonKey() final  int maxAttempts;
@override@JsonKey() final  Duration baseDelay;
@override@JsonKey() final  double multiplier;
@override@JsonKey() final  Duration maxDelay;
@override@JsonKey() final  double jitterFactor;

/// Create a copy of RetryConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryConfigCopyWith<_RetryConfig> get copyWith => __$RetryConfigCopyWithImpl<_RetryConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryConfig&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.baseDelay, baseDelay) || other.baseDelay == baseDelay)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier)&&(identical(other.maxDelay, maxDelay) || other.maxDelay == maxDelay)&&(identical(other.jitterFactor, jitterFactor) || other.jitterFactor == jitterFactor));
}


@override
int get hashCode => Object.hash(runtimeType,maxAttempts,baseDelay,multiplier,maxDelay,jitterFactor);

@override
String toString() {
  return 'RetryConfig(maxAttempts: $maxAttempts, baseDelay: $baseDelay, multiplier: $multiplier, maxDelay: $maxDelay, jitterFactor: $jitterFactor)';
}


}

/// @nodoc
abstract mixin class _$RetryConfigCopyWith<$Res> implements $RetryConfigCopyWith<$Res> {
  factory _$RetryConfigCopyWith(_RetryConfig value, $Res Function(_RetryConfig) _then) = __$RetryConfigCopyWithImpl;
@override @useResult
$Res call({
 int maxAttempts, Duration baseDelay, double multiplier, Duration maxDelay, double jitterFactor
});




}
/// @nodoc
class __$RetryConfigCopyWithImpl<$Res>
    implements _$RetryConfigCopyWith<$Res> {
  __$RetryConfigCopyWithImpl(this._self, this._then);

  final _RetryConfig _self;
  final $Res Function(_RetryConfig) _then;

/// Create a copy of RetryConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxAttempts = null,Object? baseDelay = null,Object? multiplier = null,Object? maxDelay = null,Object? jitterFactor = null,}) {
  return _then(_RetryConfig(
maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,baseDelay: null == baseDelay ? _self.baseDelay : baseDelay // ignore: cast_nullable_to_non_nullable
as Duration,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,maxDelay: null == maxDelay ? _self.maxDelay : maxDelay // ignore: cast_nullable_to_non_nullable
as Duration,jitterFactor: null == jitterFactor ? _self.jitterFactor : jitterFactor // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
