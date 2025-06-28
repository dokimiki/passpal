// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiConfig {

 String get baseUrl;
/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiConfigCopyWith<ApiConfig> get copyWith => _$ApiConfigCopyWithImpl<ApiConfig>(this as ApiConfig, _$identity);

  /// Serializes this ApiConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiConfig&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl);

@override
String toString() {
  return 'ApiConfig(baseUrl: $baseUrl)';
}


}

/// @nodoc
abstract mixin class $ApiConfigCopyWith<$Res>  {
  factory $ApiConfigCopyWith(ApiConfig value, $Res Function(ApiConfig) _then) = _$ApiConfigCopyWithImpl;
@useResult
$Res call({
 String baseUrl
});




}
/// @nodoc
class _$ApiConfigCopyWithImpl<$Res>
    implements $ApiConfigCopyWith<$Res> {
  _$ApiConfigCopyWithImpl(this._self, this._then);

  final ApiConfig _self;
  final $Res Function(ApiConfig) _then;

/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ApiConfig implements ApiConfig {
  const _ApiConfig({required this.baseUrl});
  factory _ApiConfig.fromJson(Map<String, dynamic> json) => _$ApiConfigFromJson(json);

@override final  String baseUrl;

/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiConfigCopyWith<_ApiConfig> get copyWith => __$ApiConfigCopyWithImpl<_ApiConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiConfig&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl);

@override
String toString() {
  return 'ApiConfig(baseUrl: $baseUrl)';
}


}

/// @nodoc
abstract mixin class _$ApiConfigCopyWith<$Res> implements $ApiConfigCopyWith<$Res> {
  factory _$ApiConfigCopyWith(_ApiConfig value, $Res Function(_ApiConfig) _then) = __$ApiConfigCopyWithImpl;
@override @useResult
$Res call({
 String baseUrl
});




}
/// @nodoc
class __$ApiConfigCopyWithImpl<$Res>
    implements _$ApiConfigCopyWith<$Res> {
  __$ApiConfigCopyWithImpl(this._self, this._then);

  final _ApiConfig _self;
  final $Res Function(_ApiConfig) _then;

/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,}) {
  return _then(_ApiConfig(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
