// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'albo_news_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlboNewsDto {

 String get id; String get title; DateTime get publishedAt; AlboNewsCategory get category; bool get isImportant; bool get isRead; String get detailUrl; bool? get hasAttachment;
/// Create a copy of AlboNewsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlboNewsDtoCopyWith<AlboNewsDto> get copyWith => _$AlboNewsDtoCopyWithImpl<AlboNewsDto>(this as AlboNewsDto, _$identity);

  /// Serializes this AlboNewsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlboNewsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.detailUrl, detailUrl) || other.detailUrl == detailUrl)&&(identical(other.hasAttachment, hasAttachment) || other.hasAttachment == hasAttachment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,publishedAt,category,isImportant,isRead,detailUrl,hasAttachment);

@override
String toString() {
  return 'AlboNewsDto(id: $id, title: $title, publishedAt: $publishedAt, category: $category, isImportant: $isImportant, isRead: $isRead, detailUrl: $detailUrl, hasAttachment: $hasAttachment)';
}


}

/// @nodoc
abstract mixin class $AlboNewsDtoCopyWith<$Res>  {
  factory $AlboNewsDtoCopyWith(AlboNewsDto value, $Res Function(AlboNewsDto) _then) = _$AlboNewsDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime publishedAt, AlboNewsCategory category, bool isImportant, bool isRead, String detailUrl, bool? hasAttachment
});




}
/// @nodoc
class _$AlboNewsDtoCopyWithImpl<$Res>
    implements $AlboNewsDtoCopyWith<$Res> {
  _$AlboNewsDtoCopyWithImpl(this._self, this._then);

  final AlboNewsDto _self;
  final $Res Function(AlboNewsDto) _then;

/// Create a copy of AlboNewsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? publishedAt = null,Object? category = null,Object? isImportant = null,Object? isRead = null,Object? detailUrl = null,Object? hasAttachment = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AlboNewsCategory,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,detailUrl: null == detailUrl ? _self.detailUrl : detailUrl // ignore: cast_nullable_to_non_nullable
as String,hasAttachment: freezed == hasAttachment ? _self.hasAttachment : hasAttachment // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AlboNewsDto implements AlboNewsDto {
  const _AlboNewsDto({required this.id, required this.title, required this.publishedAt, required this.category, required this.isImportant, required this.isRead, required this.detailUrl, this.hasAttachment});
  factory _AlboNewsDto.fromJson(Map<String, dynamic> json) => _$AlboNewsDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime publishedAt;
@override final  AlboNewsCategory category;
@override final  bool isImportant;
@override final  bool isRead;
@override final  String detailUrl;
@override final  bool? hasAttachment;

/// Create a copy of AlboNewsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlboNewsDtoCopyWith<_AlboNewsDto> get copyWith => __$AlboNewsDtoCopyWithImpl<_AlboNewsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlboNewsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlboNewsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.detailUrl, detailUrl) || other.detailUrl == detailUrl)&&(identical(other.hasAttachment, hasAttachment) || other.hasAttachment == hasAttachment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,publishedAt,category,isImportant,isRead,detailUrl,hasAttachment);

@override
String toString() {
  return 'AlboNewsDto(id: $id, title: $title, publishedAt: $publishedAt, category: $category, isImportant: $isImportant, isRead: $isRead, detailUrl: $detailUrl, hasAttachment: $hasAttachment)';
}


}

/// @nodoc
abstract mixin class _$AlboNewsDtoCopyWith<$Res> implements $AlboNewsDtoCopyWith<$Res> {
  factory _$AlboNewsDtoCopyWith(_AlboNewsDto value, $Res Function(_AlboNewsDto) _then) = __$AlboNewsDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime publishedAt, AlboNewsCategory category, bool isImportant, bool isRead, String detailUrl, bool? hasAttachment
});




}
/// @nodoc
class __$AlboNewsDtoCopyWithImpl<$Res>
    implements _$AlboNewsDtoCopyWith<$Res> {
  __$AlboNewsDtoCopyWithImpl(this._self, this._then);

  final _AlboNewsDto _self;
  final $Res Function(_AlboNewsDto) _then;

/// Create a copy of AlboNewsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? publishedAt = null,Object? category = null,Object? isImportant = null,Object? isRead = null,Object? detailUrl = null,Object? hasAttachment = freezed,}) {
  return _then(_AlboNewsDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AlboNewsCategory,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,detailUrl: null == detailUrl ? _self.detailUrl : detailUrl // ignore: cast_nullable_to_non_nullable
as String,hasAttachment: freezed == hasAttachment ? _self.hasAttachment : hasAttachment // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
