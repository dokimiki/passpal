// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_material.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseMaterial {

/// 資料ID
 String get id;/// 資料名
 String get title;/// 資料タイプ
 MaterialType get type;/// ダウンロードURL
 String? get downloadUrl;/// ファイルサイズ（バイト）
 int? get fileSize;/// 作成日時
 DateTime? get createdAt;/// 更新日時
 DateTime? get updatedAt;/// 説明
 String? get description;
/// Create a copy of CourseMaterial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseMaterialCopyWith<CourseMaterial> get copyWith => _$CourseMaterialCopyWithImpl<CourseMaterial>(this as CourseMaterial, _$identity);

  /// Serializes this CourseMaterial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseMaterial&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,downloadUrl,fileSize,createdAt,updatedAt,description);

@override
String toString() {
  return 'CourseMaterial(id: $id, title: $title, type: $type, downloadUrl: $downloadUrl, fileSize: $fileSize, createdAt: $createdAt, updatedAt: $updatedAt, description: $description)';
}


}

/// @nodoc
abstract mixin class $CourseMaterialCopyWith<$Res>  {
  factory $CourseMaterialCopyWith(CourseMaterial value, $Res Function(CourseMaterial) _then) = _$CourseMaterialCopyWithImpl;
@useResult
$Res call({
 String id, String title, MaterialType type, String? downloadUrl, int? fileSize, DateTime? createdAt, DateTime? updatedAt, String? description
});




}
/// @nodoc
class _$CourseMaterialCopyWithImpl<$Res>
    implements $CourseMaterialCopyWith<$Res> {
  _$CourseMaterialCopyWithImpl(this._self, this._then);

  final CourseMaterial _self;
  final $Res Function(CourseMaterial) _then;

/// Create a copy of CourseMaterial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? type = null,Object? downloadUrl = freezed,Object? fileSize = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MaterialType,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CourseMaterial implements CourseMaterial {
  const _CourseMaterial({required this.id, required this.title, required this.type, this.downloadUrl, this.fileSize, this.createdAt, this.updatedAt, this.description});
  factory _CourseMaterial.fromJson(Map<String, dynamic> json) => _$CourseMaterialFromJson(json);

/// 資料ID
@override final  String id;
/// 資料名
@override final  String title;
/// 資料タイプ
@override final  MaterialType type;
/// ダウンロードURL
@override final  String? downloadUrl;
/// ファイルサイズ（バイト）
@override final  int? fileSize;
/// 作成日時
@override final  DateTime? createdAt;
/// 更新日時
@override final  DateTime? updatedAt;
/// 説明
@override final  String? description;

/// Create a copy of CourseMaterial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseMaterialCopyWith<_CourseMaterial> get copyWith => __$CourseMaterialCopyWithImpl<_CourseMaterial>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseMaterialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseMaterial&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,downloadUrl,fileSize,createdAt,updatedAt,description);

@override
String toString() {
  return 'CourseMaterial(id: $id, title: $title, type: $type, downloadUrl: $downloadUrl, fileSize: $fileSize, createdAt: $createdAt, updatedAt: $updatedAt, description: $description)';
}


}

/// @nodoc
abstract mixin class _$CourseMaterialCopyWith<$Res> implements $CourseMaterialCopyWith<$Res> {
  factory _$CourseMaterialCopyWith(_CourseMaterial value, $Res Function(_CourseMaterial) _then) = __$CourseMaterialCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, MaterialType type, String? downloadUrl, int? fileSize, DateTime? createdAt, DateTime? updatedAt, String? description
});




}
/// @nodoc
class __$CourseMaterialCopyWithImpl<$Res>
    implements _$CourseMaterialCopyWith<$Res> {
  __$CourseMaterialCopyWithImpl(this._self, this._then);

  final _CourseMaterial _self;
  final $Res Function(_CourseMaterial) _then;

/// Create a copy of CourseMaterial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? type = null,Object? downloadUrl = freezed,Object? fileSize = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? description = freezed,}) {
  return _then(_CourseMaterial(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MaterialType,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CourseNews {

/// お知らせID
 String get id;/// タイトル
 String get title;/// 内容
 String get content;/// 投稿日時
 DateTime get postedAt;/// 重要度
 NewsImportance get importance;/// 添付ファイル
 List<CourseMaterial> get attachments;
/// Create a copy of CourseNews
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseNewsCopyWith<CourseNews> get copyWith => _$CourseNewsCopyWithImpl<CourseNews>(this as CourseNews, _$identity);

  /// Serializes this CourseNews to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseNews&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.importance, importance) || other.importance == importance)&&const DeepCollectionEquality().equals(other.attachments, attachments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,postedAt,importance,const DeepCollectionEquality().hash(attachments));

@override
String toString() {
  return 'CourseNews(id: $id, title: $title, content: $content, postedAt: $postedAt, importance: $importance, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class $CourseNewsCopyWith<$Res>  {
  factory $CourseNewsCopyWith(CourseNews value, $Res Function(CourseNews) _then) = _$CourseNewsCopyWithImpl;
@useResult
$Res call({
 String id, String title, String content, DateTime postedAt, NewsImportance importance, List<CourseMaterial> attachments
});




}
/// @nodoc
class _$CourseNewsCopyWithImpl<$Res>
    implements $CourseNewsCopyWith<$Res> {
  _$CourseNewsCopyWithImpl(this._self, this._then);

  final CourseNews _self;
  final $Res Function(CourseNews) _then;

/// Create a copy of CourseNews
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? postedAt = null,Object? importance = null,Object? attachments = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as NewsImportance,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<CourseMaterial>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CourseNews implements CourseNews {
  const _CourseNews({required this.id, required this.title, required this.content, required this.postedAt, this.importance = NewsImportance.normal, final  List<CourseMaterial> attachments = const []}): _attachments = attachments;
  factory _CourseNews.fromJson(Map<String, dynamic> json) => _$CourseNewsFromJson(json);

/// お知らせID
@override final  String id;
/// タイトル
@override final  String title;
/// 内容
@override final  String content;
/// 投稿日時
@override final  DateTime postedAt;
/// 重要度
@override@JsonKey() final  NewsImportance importance;
/// 添付ファイル
 final  List<CourseMaterial> _attachments;
/// 添付ファイル
@override@JsonKey() List<CourseMaterial> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}


/// Create a copy of CourseNews
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseNewsCopyWith<_CourseNews> get copyWith => __$CourseNewsCopyWithImpl<_CourseNews>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseNewsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseNews&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.importance, importance) || other.importance == importance)&&const DeepCollectionEquality().equals(other._attachments, _attachments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,postedAt,importance,const DeepCollectionEquality().hash(_attachments));

@override
String toString() {
  return 'CourseNews(id: $id, title: $title, content: $content, postedAt: $postedAt, importance: $importance, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class _$CourseNewsCopyWith<$Res> implements $CourseNewsCopyWith<$Res> {
  factory _$CourseNewsCopyWith(_CourseNews value, $Res Function(_CourseNews) _then) = __$CourseNewsCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String content, DateTime postedAt, NewsImportance importance, List<CourseMaterial> attachments
});




}
/// @nodoc
class __$CourseNewsCopyWithImpl<$Res>
    implements _$CourseNewsCopyWith<$Res> {
  __$CourseNewsCopyWithImpl(this._self, this._then);

  final _CourseNews _self;
  final $Res Function(_CourseNews) _then;

/// Create a copy of CourseNews
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? postedAt = null,Object? importance = null,Object? attachments = null,}) {
  return _then(_CourseNews(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as NewsImportance,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<CourseMaterial>,
  ));
}


}

// dart format on
