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

/// PalAPI のベースURL
 String get palapiBaseUrl;/// ALBO ポータルのベースURL
 String get alboBaseUrl;/// MaNaBo ポータルのベースURL
 String get manaboBaseUrl;/// Cubics ポータルのベースURL
 String get cubicsBaseUrl;/// SSO のベースURL
 String get ssoBaseUrl;
/// Create a copy of ApiConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiConfigCopyWith<ApiConfig> get copyWith => _$ApiConfigCopyWithImpl<ApiConfig>(this as ApiConfig, _$identity);

  /// Serializes this ApiConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiConfig&&(identical(other.palapiBaseUrl, palapiBaseUrl) || other.palapiBaseUrl == palapiBaseUrl)&&(identical(other.alboBaseUrl, alboBaseUrl) || other.alboBaseUrl == alboBaseUrl)&&(identical(other.manaboBaseUrl, manaboBaseUrl) || other.manaboBaseUrl == manaboBaseUrl)&&(identical(other.cubicsBaseUrl, cubicsBaseUrl) || other.cubicsBaseUrl == cubicsBaseUrl)&&(identical(other.ssoBaseUrl, ssoBaseUrl) || other.ssoBaseUrl == ssoBaseUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,palapiBaseUrl,alboBaseUrl,manaboBaseUrl,cubicsBaseUrl,ssoBaseUrl);

@override
String toString() {
  return 'ApiConfig(palapiBaseUrl: $palapiBaseUrl, alboBaseUrl: $alboBaseUrl, manaboBaseUrl: $manaboBaseUrl, cubicsBaseUrl: $cubicsBaseUrl, ssoBaseUrl: $ssoBaseUrl)';
}


}

/// @nodoc
abstract mixin class $ApiConfigCopyWith<$Res>  {
  factory $ApiConfigCopyWith(ApiConfig value, $Res Function(ApiConfig) _then) = _$ApiConfigCopyWithImpl;
@useResult
$Res call({
 String palapiBaseUrl, String alboBaseUrl, String manaboBaseUrl, String cubicsBaseUrl, String ssoBaseUrl
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
@pragma('vm:prefer-inline') @override $Res call({Object? palapiBaseUrl = null,Object? alboBaseUrl = null,Object? manaboBaseUrl = null,Object? cubicsBaseUrl = null,Object? ssoBaseUrl = null,}) {
  return _then(_self.copyWith(
palapiBaseUrl: null == palapiBaseUrl ? _self.palapiBaseUrl : palapiBaseUrl // ignore: cast_nullable_to_non_nullable
as String,alboBaseUrl: null == alboBaseUrl ? _self.alboBaseUrl : alboBaseUrl // ignore: cast_nullable_to_non_nullable
as String,manaboBaseUrl: null == manaboBaseUrl ? _self.manaboBaseUrl : manaboBaseUrl // ignore: cast_nullable_to_non_nullable
as String,cubicsBaseUrl: null == cubicsBaseUrl ? _self.cubicsBaseUrl : cubicsBaseUrl // ignore: cast_nullable_to_non_nullable
as String,ssoBaseUrl: null == ssoBaseUrl ? _self.ssoBaseUrl : ssoBaseUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ApiConfig implements ApiConfig {
  const _ApiConfig({required this.palapiBaseUrl, required this.alboBaseUrl, required this.manaboBaseUrl, required this.cubicsBaseUrl, required this.ssoBaseUrl});
  factory _ApiConfig.fromJson(Map<String, dynamic> json) => _$ApiConfigFromJson(json);

/// PalAPI のベースURL
@override final  String palapiBaseUrl;
/// ALBO ポータルのベースURL
@override final  String alboBaseUrl;
/// MaNaBo ポータルのベースURL
@override final  String manaboBaseUrl;
/// Cubics ポータルのベースURL
@override final  String cubicsBaseUrl;
/// SSO のベースURL
@override final  String ssoBaseUrl;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiConfig&&(identical(other.palapiBaseUrl, palapiBaseUrl) || other.palapiBaseUrl == palapiBaseUrl)&&(identical(other.alboBaseUrl, alboBaseUrl) || other.alboBaseUrl == alboBaseUrl)&&(identical(other.manaboBaseUrl, manaboBaseUrl) || other.manaboBaseUrl == manaboBaseUrl)&&(identical(other.cubicsBaseUrl, cubicsBaseUrl) || other.cubicsBaseUrl == cubicsBaseUrl)&&(identical(other.ssoBaseUrl, ssoBaseUrl) || other.ssoBaseUrl == ssoBaseUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,palapiBaseUrl,alboBaseUrl,manaboBaseUrl,cubicsBaseUrl,ssoBaseUrl);

@override
String toString() {
  return 'ApiConfig(palapiBaseUrl: $palapiBaseUrl, alboBaseUrl: $alboBaseUrl, manaboBaseUrl: $manaboBaseUrl, cubicsBaseUrl: $cubicsBaseUrl, ssoBaseUrl: $ssoBaseUrl)';
}


}

/// @nodoc
abstract mixin class _$ApiConfigCopyWith<$Res> implements $ApiConfigCopyWith<$Res> {
  factory _$ApiConfigCopyWith(_ApiConfig value, $Res Function(_ApiConfig) _then) = __$ApiConfigCopyWithImpl;
@override @useResult
$Res call({
 String palapiBaseUrl, String alboBaseUrl, String manaboBaseUrl, String cubicsBaseUrl, String ssoBaseUrl
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
@override @pragma('vm:prefer-inline') $Res call({Object? palapiBaseUrl = null,Object? alboBaseUrl = null,Object? manaboBaseUrl = null,Object? cubicsBaseUrl = null,Object? ssoBaseUrl = null,}) {
  return _then(_ApiConfig(
palapiBaseUrl: null == palapiBaseUrl ? _self.palapiBaseUrl : palapiBaseUrl // ignore: cast_nullable_to_non_nullable
as String,alboBaseUrl: null == alboBaseUrl ? _self.alboBaseUrl : alboBaseUrl // ignore: cast_nullable_to_non_nullable
as String,manaboBaseUrl: null == manaboBaseUrl ? _self.manaboBaseUrl : manaboBaseUrl // ignore: cast_nullable_to_non_nullable
as String,cubicsBaseUrl: null == cubicsBaseUrl ? _self.cubicsBaseUrl : cubicsBaseUrl // ignore: cast_nullable_to_non_nullable
as String,ssoBaseUrl: null == ssoBaseUrl ? _self.ssoBaseUrl : ssoBaseUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
