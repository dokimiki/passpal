// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssignmentDetailArgs _$AssignmentDetailArgsFromJson(
  Map<String, dynamic> json,
) => _AssignmentDetailArgs(
  courseId: json['courseId'] as String,
  assignmentId: json['assignmentId'] as String,
);

Map<String, dynamic> _$AssignmentDetailArgsToJson(
  _AssignmentDetailArgs instance,
) => <String, dynamic>{
  'courseId': instance.courseId,
  'assignmentId': instance.assignmentId,
};

_CourseDetailArgs _$CourseDetailArgsFromJson(Map<String, dynamic> json) =>
    _CourseDetailArgs(courseId: json['courseId'] as String);

Map<String, dynamic> _$CourseDetailArgsToJson(_CourseDetailArgs instance) =>
    <String, dynamic>{'courseId': instance.courseId};

_CourseMaterialsArgs _$CourseMaterialsArgsFromJson(Map<String, dynamic> json) =>
    _CourseMaterialsArgs(courseId: json['courseId'] as String);

Map<String, dynamic> _$CourseMaterialsArgsToJson(
  _CourseMaterialsArgs instance,
) => <String, dynamic>{'courseId': instance.courseId};

_ErrorPageArgs _$ErrorPageArgsFromJson(Map<String, dynamic> json) =>
    _ErrorPageArgs(
      title: json['title'] as String,
      message: json['message'] as String,
      canRetry: json['canRetry'] as bool? ?? true,
    );

Map<String, dynamic> _$ErrorPageArgsToJson(_ErrorPageArgs instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'canRetry': instance.canRetry,
    };

_DeepLinkData _$DeepLinkDataFromJson(Map<String, dynamic> json) =>
    _DeepLinkData(
      uri: Uri.parse(json['uri'] as String),
      pushPayload: json['pushPayload'] as Map<String, dynamic>?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$DeepLinkDataToJson(_DeepLinkData instance) =>
    <String, dynamic>{
      'uri': instance.uri.toString(),
      'pushPayload': instance.pushPayload,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
