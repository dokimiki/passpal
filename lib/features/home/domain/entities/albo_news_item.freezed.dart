// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'albo_news_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlboNewsItem {

 String get id; String get title; DateTime get publishedAt; AlboNewsCategory get category; bool get isImportant; bool get isRead; Uri get detailUrl; bool? get hasAttachment;
/// Create a copy of AlboNewsItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlboNewsItemCopyWith<AlboNewsItem> get copyWith => _$AlboNewsItemCopyWithImpl<AlboNewsItem>(this as AlboNewsItem, _$identity);

  /// Serializes this AlboNewsItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlboNewsItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.detailUrl, detailUrl) || other.detailUrl == detailUrl)&&(identical(other.hasAttachment, hasAttachment) || other.hasAttachment == hasAttachment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,publishedAt,category,isImportant,isRead,detailUrl,hasAttachment);

@override
String toString() {
  return 'AlboNewsItem(id: $id, title: $title, publishedAt: $publishedAt, category: $category, isImportant: $isImportant, isRead: $isRead, detailUrl: $detailUrl, hasAttachment: $hasAttachment)';
}


}

/// @nodoc
abstract mixin class $AlboNewsItemCopyWith<$Res>  {
  factory $AlboNewsItemCopyWith(AlboNewsItem value, $Res Function(AlboNewsItem) _then) = _$AlboNewsItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime publishedAt, AlboNewsCategory category, bool isImportant, bool isRead, Uri detailUrl, bool? hasAttachment
});




}
/// @nodoc
class _$AlboNewsItemCopyWithImpl<$Res>
    implements $AlboNewsItemCopyWith<$Res> {
  _$AlboNewsItemCopyWithImpl(this._self, this._then);

  final AlboNewsItem _self;
  final $Res Function(AlboNewsItem) _then;

/// Create a copy of AlboNewsItem
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
as Uri,hasAttachment: freezed == hasAttachment ? _self.hasAttachment : hasAttachment // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AlboNewsItem implements AlboNewsItem {
  const _AlboNewsItem({required this.id, required this.title, required this.publishedAt, required this.category, required this.isImportant, required this.isRead, required this.detailUrl, this.hasAttachment});
  factory _AlboNewsItem.fromJson(Map<String, dynamic> json) => _$AlboNewsItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime publishedAt;
@override final  AlboNewsCategory category;
@override final  bool isImportant;
@override final  bool isRead;
@override final  Uri detailUrl;
@override final  bool? hasAttachment;

/// Create a copy of AlboNewsItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlboNewsItemCopyWith<_AlboNewsItem> get copyWith => __$AlboNewsItemCopyWithImpl<_AlboNewsItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlboNewsItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlboNewsItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.detailUrl, detailUrl) || other.detailUrl == detailUrl)&&(identical(other.hasAttachment, hasAttachment) || other.hasAttachment == hasAttachment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,publishedAt,category,isImportant,isRead,detailUrl,hasAttachment);

@override
String toString() {
  return 'AlboNewsItem(id: $id, title: $title, publishedAt: $publishedAt, category: $category, isImportant: $isImportant, isRead: $isRead, detailUrl: $detailUrl, hasAttachment: $hasAttachment)';
}


}

/// @nodoc
abstract mixin class _$AlboNewsItemCopyWith<$Res> implements $AlboNewsItemCopyWith<$Res> {
  factory _$AlboNewsItemCopyWith(_AlboNewsItem value, $Res Function(_AlboNewsItem) _then) = __$AlboNewsItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime publishedAt, AlboNewsCategory category, bool isImportant, bool isRead, Uri detailUrl, bool? hasAttachment
});




}
/// @nodoc
class __$AlboNewsItemCopyWithImpl<$Res>
    implements _$AlboNewsItemCopyWith<$Res> {
  __$AlboNewsItemCopyWithImpl(this._self, this._then);

  final _AlboNewsItem _self;
  final $Res Function(_AlboNewsItem) _then;

/// Create a copy of AlboNewsItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? publishedAt = null,Object? category = null,Object? isImportant = null,Object? isRead = null,Object? detailUrl = null,Object? hasAttachment = freezed,}) {
  return _then(_AlboNewsItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AlboNewsCategory,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,detailUrl: null == detailUrl ? _self.detailUrl : detailUrl // ignore: cast_nullable_to_non_nullable
as Uri,hasAttachment: freezed == hasAttachment ? _self.hasAttachment : hasAttachment // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
