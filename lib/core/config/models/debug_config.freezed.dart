// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DebugConfig {

 String get logLevel; bool get enableConsoleLogging; bool get enableFileLogging; bool get enableNetworkLogging; bool get enableCrashlytics;
/// Create a copy of DebugConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugConfigCopyWith<DebugConfig> get copyWith => _$DebugConfigCopyWithImpl<DebugConfig>(this as DebugConfig, _$identity);

  /// Serializes this DebugConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugConfig&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.enableConsoleLogging, enableConsoleLogging) || other.enableConsoleLogging == enableConsoleLogging)&&(identical(other.enableFileLogging, enableFileLogging) || other.enableFileLogging == enableFileLogging)&&(identical(other.enableNetworkLogging, enableNetworkLogging) || other.enableNetworkLogging == enableNetworkLogging)&&(identical(other.enableCrashlytics, enableCrashlytics) || other.enableCrashlytics == enableCrashlytics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,logLevel,enableConsoleLogging,enableFileLogging,enableNetworkLogging,enableCrashlytics);

@override
String toString() {
  return 'DebugConfig(logLevel: $logLevel, enableConsoleLogging: $enableConsoleLogging, enableFileLogging: $enableFileLogging, enableNetworkLogging: $enableNetworkLogging, enableCrashlytics: $enableCrashlytics)';
}


}

/// @nodoc
abstract mixin class $DebugConfigCopyWith<$Res>  {
  factory $DebugConfigCopyWith(DebugConfig value, $Res Function(DebugConfig) _then) = _$DebugConfigCopyWithImpl;
@useResult
$Res call({
 String logLevel, bool enableConsoleLogging, bool enableFileLogging, bool enableNetworkLogging, bool enableCrashlytics
});




}
/// @nodoc
class _$DebugConfigCopyWithImpl<$Res>
    implements $DebugConfigCopyWith<$Res> {
  _$DebugConfigCopyWithImpl(this._self, this._then);

  final DebugConfig _self;
  final $Res Function(DebugConfig) _then;

/// Create a copy of DebugConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? logLevel = null,Object? enableConsoleLogging = null,Object? enableFileLogging = null,Object? enableNetworkLogging = null,Object? enableCrashlytics = null,}) {
  return _then(_self.copyWith(
logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as String,enableConsoleLogging: null == enableConsoleLogging ? _self.enableConsoleLogging : enableConsoleLogging // ignore: cast_nullable_to_non_nullable
as bool,enableFileLogging: null == enableFileLogging ? _self.enableFileLogging : enableFileLogging // ignore: cast_nullable_to_non_nullable
as bool,enableNetworkLogging: null == enableNetworkLogging ? _self.enableNetworkLogging : enableNetworkLogging // ignore: cast_nullable_to_non_nullable
as bool,enableCrashlytics: null == enableCrashlytics ? _self.enableCrashlytics : enableCrashlytics // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DebugConfig].
extension DebugConfigPatterns on DebugConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebugConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebugConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebugConfig value)  $default,){
final _that = this;
switch (_that) {
case _DebugConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebugConfig value)?  $default,){
final _that = this;
switch (_that) {
case _DebugConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String logLevel,  bool enableConsoleLogging,  bool enableFileLogging,  bool enableNetworkLogging,  bool enableCrashlytics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebugConfig() when $default != null:
return $default(_that.logLevel,_that.enableConsoleLogging,_that.enableFileLogging,_that.enableNetworkLogging,_that.enableCrashlytics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String logLevel,  bool enableConsoleLogging,  bool enableFileLogging,  bool enableNetworkLogging,  bool enableCrashlytics)  $default,) {final _that = this;
switch (_that) {
case _DebugConfig():
return $default(_that.logLevel,_that.enableConsoleLogging,_that.enableFileLogging,_that.enableNetworkLogging,_that.enableCrashlytics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String logLevel,  bool enableConsoleLogging,  bool enableFileLogging,  bool enableNetworkLogging,  bool enableCrashlytics)?  $default,) {final _that = this;
switch (_that) {
case _DebugConfig() when $default != null:
return $default(_that.logLevel,_that.enableConsoleLogging,_that.enableFileLogging,_that.enableNetworkLogging,_that.enableCrashlytics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DebugConfig extends DebugConfig {
  const _DebugConfig({this.logLevel = 'info', this.enableConsoleLogging = false, this.enableFileLogging = false, this.enableNetworkLogging = true, this.enableCrashlytics = true}): super._();
  factory _DebugConfig.fromJson(Map<String, dynamic> json) => _$DebugConfigFromJson(json);

@override@JsonKey() final  String logLevel;
@override@JsonKey() final  bool enableConsoleLogging;
@override@JsonKey() final  bool enableFileLogging;
@override@JsonKey() final  bool enableNetworkLogging;
@override@JsonKey() final  bool enableCrashlytics;

/// Create a copy of DebugConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebugConfigCopyWith<_DebugConfig> get copyWith => __$DebugConfigCopyWithImpl<_DebugConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebugConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugConfig&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.enableConsoleLogging, enableConsoleLogging) || other.enableConsoleLogging == enableConsoleLogging)&&(identical(other.enableFileLogging, enableFileLogging) || other.enableFileLogging == enableFileLogging)&&(identical(other.enableNetworkLogging, enableNetworkLogging) || other.enableNetworkLogging == enableNetworkLogging)&&(identical(other.enableCrashlytics, enableCrashlytics) || other.enableCrashlytics == enableCrashlytics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,logLevel,enableConsoleLogging,enableFileLogging,enableNetworkLogging,enableCrashlytics);

@override
String toString() {
  return 'DebugConfig(logLevel: $logLevel, enableConsoleLogging: $enableConsoleLogging, enableFileLogging: $enableFileLogging, enableNetworkLogging: $enableNetworkLogging, enableCrashlytics: $enableCrashlytics)';
}


}

/// @nodoc
abstract mixin class _$DebugConfigCopyWith<$Res> implements $DebugConfigCopyWith<$Res> {
  factory _$DebugConfigCopyWith(_DebugConfig value, $Res Function(_DebugConfig) _then) = __$DebugConfigCopyWithImpl;
@override @useResult
$Res call({
 String logLevel, bool enableConsoleLogging, bool enableFileLogging, bool enableNetworkLogging, bool enableCrashlytics
});




}
/// @nodoc
class __$DebugConfigCopyWithImpl<$Res>
    implements _$DebugConfigCopyWith<$Res> {
  __$DebugConfigCopyWithImpl(this._self, this._then);

  final _DebugConfig _self;
  final $Res Function(_DebugConfig) _then;

/// Create a copy of DebugConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logLevel = null,Object? enableConsoleLogging = null,Object? enableFileLogging = null,Object? enableNetworkLogging = null,Object? enableCrashlytics = null,}) {
  return _then(_DebugConfig(
logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as String,enableConsoleLogging: null == enableConsoleLogging ? _self.enableConsoleLogging : enableConsoleLogging // ignore: cast_nullable_to_non_nullable
as bool,enableFileLogging: null == enableFileLogging ? _self.enableFileLogging : enableFileLogging // ignore: cast_nullable_to_non_nullable
as bool,enableNetworkLogging: null == enableNetworkLogging ? _self.enableNetworkLogging : enableNetworkLogging // ignore: cast_nullable_to_non_nullable
as bool,enableCrashlytics: null == enableCrashlytics ? _self.enableCrashlytics : enableCrashlytics // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
