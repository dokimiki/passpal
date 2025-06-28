// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Assignment {

 AssignmentId get id; String get title; CourseId get courseId; String get courseName; AssignmentType get type; AssignmentStatus get status; DateTime? get dueAt; DateTime? get submittedAt; int? get score; int? get maxScore; String? get resultUrl; String? get contentUrl; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignmentCopyWith<Assignment> get copyWith => _$AssignmentCopyWithImpl<Assignment>(this as Assignment, _$identity);

  /// Serializes this Assignment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Assignment&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.score, score) || other.score == score)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.resultUrl, resultUrl) || other.resultUrl == resultUrl)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,courseId,courseName,type,status,dueAt,submittedAt,score,maxScore,resultUrl,contentUrl,createdAt,updatedAt);

@override
String toString() {
  return 'Assignment(id: $id, title: $title, courseId: $courseId, courseName: $courseName, type: $type, status: $status, dueAt: $dueAt, submittedAt: $submittedAt, score: $score, maxScore: $maxScore, resultUrl: $resultUrl, contentUrl: $contentUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AssignmentCopyWith<$Res>  {
  factory $AssignmentCopyWith(Assignment value, $Res Function(Assignment) _then) = _$AssignmentCopyWithImpl;
@useResult
$Res call({
 AssignmentId id, String title, CourseId courseId, String courseName, AssignmentType type, AssignmentStatus status, DateTime? dueAt, DateTime? submittedAt, int? score, int? maxScore, String? resultUrl, String? contentUrl, DateTime createdAt, DateTime updatedAt
});


$AssignmentIdCopyWith<$Res> get id;$CourseIdCopyWith<$Res> get courseId;

}
/// @nodoc
class _$AssignmentCopyWithImpl<$Res>
    implements $AssignmentCopyWith<$Res> {
  _$AssignmentCopyWithImpl(this._self, this._then);

  final Assignment _self;
  final $Res Function(Assignment) _then;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? courseId = null,Object? courseName = null,Object? type = null,Object? status = null,Object? dueAt = freezed,Object? submittedAt = freezed,Object? score = freezed,Object? maxScore = freezed,Object? resultUrl = freezed,Object? contentUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as AssignmentId,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as CourseId,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AssignmentType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AssignmentStatus,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,maxScore: freezed == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int?,resultUrl: freezed == resultUrl ? _self.resultUrl : resultUrl // ignore: cast_nullable_to_non_nullable
as String?,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssignmentIdCopyWith<$Res> get id {
  
  return $AssignmentIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseIdCopyWith<$Res> get courseId {
  
  return $CourseIdCopyWith<$Res>(_self.courseId, (value) {
    return _then(_self.copyWith(courseId: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Assignment implements Assignment {
  const _Assignment({required this.id, required this.title, required this.courseId, required this.courseName, required this.type, required this.status, this.dueAt, this.submittedAt, this.score, this.maxScore, this.resultUrl, this.contentUrl, required this.createdAt, required this.updatedAt});
  factory _Assignment.fromJson(Map<String, dynamic> json) => _$AssignmentFromJson(json);

@override final  AssignmentId id;
@override final  String title;
@override final  CourseId courseId;
@override final  String courseName;
@override final  AssignmentType type;
@override final  AssignmentStatus status;
@override final  DateTime? dueAt;
@override final  DateTime? submittedAt;
@override final  int? score;
@override final  int? maxScore;
@override final  String? resultUrl;
@override final  String? contentUrl;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignmentCopyWith<_Assignment> get copyWith => __$AssignmentCopyWithImpl<_Assignment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssignmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Assignment&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.score, score) || other.score == score)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.resultUrl, resultUrl) || other.resultUrl == resultUrl)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,courseId,courseName,type,status,dueAt,submittedAt,score,maxScore,resultUrl,contentUrl,createdAt,updatedAt);

@override
String toString() {
  return 'Assignment(id: $id, title: $title, courseId: $courseId, courseName: $courseName, type: $type, status: $status, dueAt: $dueAt, submittedAt: $submittedAt, score: $score, maxScore: $maxScore, resultUrl: $resultUrl, contentUrl: $contentUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AssignmentCopyWith<$Res> implements $AssignmentCopyWith<$Res> {
  factory _$AssignmentCopyWith(_Assignment value, $Res Function(_Assignment) _then) = __$AssignmentCopyWithImpl;
@override @useResult
$Res call({
 AssignmentId id, String title, CourseId courseId, String courseName, AssignmentType type, AssignmentStatus status, DateTime? dueAt, DateTime? submittedAt, int? score, int? maxScore, String? resultUrl, String? contentUrl, DateTime createdAt, DateTime updatedAt
});


@override $AssignmentIdCopyWith<$Res> get id;@override $CourseIdCopyWith<$Res> get courseId;

}
/// @nodoc
class __$AssignmentCopyWithImpl<$Res>
    implements _$AssignmentCopyWith<$Res> {
  __$AssignmentCopyWithImpl(this._self, this._then);

  final _Assignment _self;
  final $Res Function(_Assignment) _then;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? courseId = null,Object? courseName = null,Object? type = null,Object? status = null,Object? dueAt = freezed,Object? submittedAt = freezed,Object? score = freezed,Object? maxScore = freezed,Object? resultUrl = freezed,Object? contentUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Assignment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as AssignmentId,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as CourseId,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AssignmentType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AssignmentStatus,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,maxScore: freezed == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int?,resultUrl: freezed == resultUrl ? _self.resultUrl : resultUrl // ignore: cast_nullable_to_non_nullable
as String?,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssignmentIdCopyWith<$Res> get id {
  
  return $AssignmentIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CourseIdCopyWith<$Res> get courseId {
  
  return $CourseIdCopyWith<$Res>(_self.courseId, (value) {
    return _then(_self.copyWith(courseId: value));
  });
}
}

// dart format on
