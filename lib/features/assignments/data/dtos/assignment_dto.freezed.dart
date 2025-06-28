// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssignmentDto {

 String get contentId; String get classId; String get title; String get pluginKey; String? get pluginId; String? get directoryId; String? get contentUrl; String? get resultUrl; DateTime? get dueAt; bool? get isSubmitted; int? get score; int? get maxScore;
/// Create a copy of AssignmentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignmentDtoCopyWith<AssignmentDto> get copyWith => _$AssignmentDtoCopyWithImpl<AssignmentDto>(this as AssignmentDto, _$identity);

  /// Serializes this AssignmentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssignmentDto&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.title, title) || other.title == title)&&(identical(other.pluginKey, pluginKey) || other.pluginKey == pluginKey)&&(identical(other.pluginId, pluginId) || other.pluginId == pluginId)&&(identical(other.directoryId, directoryId) || other.directoryId == directoryId)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.resultUrl, resultUrl) || other.resultUrl == resultUrl)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.score, score) || other.score == score)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentId,classId,title,pluginKey,pluginId,directoryId,contentUrl,resultUrl,dueAt,isSubmitted,score,maxScore);

@override
String toString() {
  return 'AssignmentDto(contentId: $contentId, classId: $classId, title: $title, pluginKey: $pluginKey, pluginId: $pluginId, directoryId: $directoryId, contentUrl: $contentUrl, resultUrl: $resultUrl, dueAt: $dueAt, isSubmitted: $isSubmitted, score: $score, maxScore: $maxScore)';
}


}

/// @nodoc
abstract mixin class $AssignmentDtoCopyWith<$Res>  {
  factory $AssignmentDtoCopyWith(AssignmentDto value, $Res Function(AssignmentDto) _then) = _$AssignmentDtoCopyWithImpl;
@useResult
$Res call({
 String contentId, String classId, String title, String pluginKey, String? pluginId, String? directoryId, String? contentUrl, String? resultUrl, DateTime? dueAt, bool? isSubmitted, int? score, int? maxScore
});




}
/// @nodoc
class _$AssignmentDtoCopyWithImpl<$Res>
    implements $AssignmentDtoCopyWith<$Res> {
  _$AssignmentDtoCopyWithImpl(this._self, this._then);

  final AssignmentDto _self;
  final $Res Function(AssignmentDto) _then;

/// Create a copy of AssignmentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentId = null,Object? classId = null,Object? title = null,Object? pluginKey = null,Object? pluginId = freezed,Object? directoryId = freezed,Object? contentUrl = freezed,Object? resultUrl = freezed,Object? dueAt = freezed,Object? isSubmitted = freezed,Object? score = freezed,Object? maxScore = freezed,}) {
  return _then(_self.copyWith(
contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pluginKey: null == pluginKey ? _self.pluginKey : pluginKey // ignore: cast_nullable_to_non_nullable
as String,pluginId: freezed == pluginId ? _self.pluginId : pluginId // ignore: cast_nullable_to_non_nullable
as String?,directoryId: freezed == directoryId ? _self.directoryId : directoryId // ignore: cast_nullable_to_non_nullable
as String?,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,resultUrl: freezed == resultUrl ? _self.resultUrl : resultUrl // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSubmitted: freezed == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,maxScore: freezed == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AssignmentDto implements AssignmentDto {
  const _AssignmentDto({required this.contentId, required this.classId, required this.title, required this.pluginKey, this.pluginId, this.directoryId, this.contentUrl, this.resultUrl, this.dueAt, this.isSubmitted, this.score, this.maxScore});
  factory _AssignmentDto.fromJson(Map<String, dynamic> json) => _$AssignmentDtoFromJson(json);

@override final  String contentId;
@override final  String classId;
@override final  String title;
@override final  String pluginKey;
@override final  String? pluginId;
@override final  String? directoryId;
@override final  String? contentUrl;
@override final  String? resultUrl;
@override final  DateTime? dueAt;
@override final  bool? isSubmitted;
@override final  int? score;
@override final  int? maxScore;

/// Create a copy of AssignmentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignmentDtoCopyWith<_AssignmentDto> get copyWith => __$AssignmentDtoCopyWithImpl<_AssignmentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssignmentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssignmentDto&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.title, title) || other.title == title)&&(identical(other.pluginKey, pluginKey) || other.pluginKey == pluginKey)&&(identical(other.pluginId, pluginId) || other.pluginId == pluginId)&&(identical(other.directoryId, directoryId) || other.directoryId == directoryId)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.resultUrl, resultUrl) || other.resultUrl == resultUrl)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.score, score) || other.score == score)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentId,classId,title,pluginKey,pluginId,directoryId,contentUrl,resultUrl,dueAt,isSubmitted,score,maxScore);

@override
String toString() {
  return 'AssignmentDto(contentId: $contentId, classId: $classId, title: $title, pluginKey: $pluginKey, pluginId: $pluginId, directoryId: $directoryId, contentUrl: $contentUrl, resultUrl: $resultUrl, dueAt: $dueAt, isSubmitted: $isSubmitted, score: $score, maxScore: $maxScore)';
}


}

/// @nodoc
abstract mixin class _$AssignmentDtoCopyWith<$Res> implements $AssignmentDtoCopyWith<$Res> {
  factory _$AssignmentDtoCopyWith(_AssignmentDto value, $Res Function(_AssignmentDto) _then) = __$AssignmentDtoCopyWithImpl;
@override @useResult
$Res call({
 String contentId, String classId, String title, String pluginKey, String? pluginId, String? directoryId, String? contentUrl, String? resultUrl, DateTime? dueAt, bool? isSubmitted, int? score, int? maxScore
});




}
/// @nodoc
class __$AssignmentDtoCopyWithImpl<$Res>
    implements _$AssignmentDtoCopyWith<$Res> {
  __$AssignmentDtoCopyWithImpl(this._self, this._then);

  final _AssignmentDto _self;
  final $Res Function(_AssignmentDto) _then;

/// Create a copy of AssignmentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentId = null,Object? classId = null,Object? title = null,Object? pluginKey = null,Object? pluginId = freezed,Object? directoryId = freezed,Object? contentUrl = freezed,Object? resultUrl = freezed,Object? dueAt = freezed,Object? isSubmitted = freezed,Object? score = freezed,Object? maxScore = freezed,}) {
  return _then(_AssignmentDto(
contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pluginKey: null == pluginKey ? _self.pluginKey : pluginKey // ignore: cast_nullable_to_non_nullable
as String,pluginId: freezed == pluginId ? _self.pluginId : pluginId // ignore: cast_nullable_to_non_nullable
as String?,directoryId: freezed == directoryId ? _self.directoryId : directoryId // ignore: cast_nullable_to_non_nullable
as String?,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,resultUrl: freezed == resultUrl ? _self.resultUrl : resultUrl // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSubmitted: freezed == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,maxScore: freezed == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
