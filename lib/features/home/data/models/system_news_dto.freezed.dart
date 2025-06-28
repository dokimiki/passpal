// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_news_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SystemNewsDto {

 String get id; String get title; DateTime get publishedAt; String get bodyHtml; String? get detailUrl;
/// Create a copy of SystemNewsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemNewsDtoCopyWith<SystemNewsDto> get copyWith => _$SystemNewsDtoCopyWithImpl<SystemNewsDto>(this as SystemNewsDto, _$identity);

  /// Serializes this SystemNewsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemNewsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.detailUrl, detailUrl) || other.detailUrl == detailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,publishedAt,bodyHtml,detailUrl);

@override
String toString() {
  return 'SystemNewsDto(id: $id, title: $title, publishedAt: $publishedAt, bodyHtml: $bodyHtml, detailUrl: $detailUrl)';
}


}

/// @nodoc
abstract mixin class $SystemNewsDtoCopyWith<$Res>  {
  factory $SystemNewsDtoCopyWith(SystemNewsDto value, $Res Function(SystemNewsDto) _then) = _$SystemNewsDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime publishedAt, String bodyHtml, String? detailUrl
});




}
/// @nodoc
class _$SystemNewsDtoCopyWithImpl<$Res>
    implements $SystemNewsDtoCopyWith<$Res> {
  _$SystemNewsDtoCopyWithImpl(this._self, this._then);

  final SystemNewsDto _self;
  final $Res Function(SystemNewsDto) _then;

/// Create a copy of SystemNewsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? publishedAt = null,Object? bodyHtml = null,Object? detailUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bodyHtml: null == bodyHtml ? _self.bodyHtml : bodyHtml // ignore: cast_nullable_to_non_nullable
as String,detailUrl: freezed == detailUrl ? _self.detailUrl : detailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SystemNewsDto implements SystemNewsDto {
  const _SystemNewsDto({required this.id, required this.title, required this.publishedAt, required this.bodyHtml, this.detailUrl});
  factory _SystemNewsDto.fromJson(Map<String, dynamic> json) => _$SystemNewsDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime publishedAt;
@override final  String bodyHtml;
@override final  String? detailUrl;

/// Create a copy of SystemNewsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystemNewsDtoCopyWith<_SystemNewsDto> get copyWith => __$SystemNewsDtoCopyWithImpl<_SystemNewsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SystemNewsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystemNewsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.detailUrl, detailUrl) || other.detailUrl == detailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,publishedAt,bodyHtml,detailUrl);

@override
String toString() {
  return 'SystemNewsDto(id: $id, title: $title, publishedAt: $publishedAt, bodyHtml: $bodyHtml, detailUrl: $detailUrl)';
}


}

/// @nodoc
abstract mixin class _$SystemNewsDtoCopyWith<$Res> implements $SystemNewsDtoCopyWith<$Res> {
  factory _$SystemNewsDtoCopyWith(_SystemNewsDto value, $Res Function(_SystemNewsDto) _then) = __$SystemNewsDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime publishedAt, String bodyHtml, String? detailUrl
});




}
/// @nodoc
class __$SystemNewsDtoCopyWithImpl<$Res>
    implements _$SystemNewsDtoCopyWith<$Res> {
  __$SystemNewsDtoCopyWithImpl(this._self, this._then);

  final _SystemNewsDto _self;
  final $Res Function(_SystemNewsDto) _then;

/// Create a copy of SystemNewsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? publishedAt = null,Object? bodyHtml = null,Object? detailUrl = freezed,}) {
  return _then(_SystemNewsDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bodyHtml: null == bodyHtml ? _self.bodyHtml : bodyHtml // ignore: cast_nullable_to_non_nullable
as String,detailUrl: freezed == detailUrl ? _self.detailUrl : detailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
