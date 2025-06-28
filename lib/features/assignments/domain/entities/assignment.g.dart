// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Assignment _$AssignmentFromJson(Map<String, dynamic> json) => _Assignment(
  id: AssignmentId.fromJson(json['id'] as Map<String, dynamic>),
  title: json['title'] as String,
  courseId: CourseId.fromJson(json['courseId'] as Map<String, dynamic>),
  courseName: json['courseName'] as String,
  type: $enumDecode(_$AssignmentTypeEnumMap, json['type']),
  status: $enumDecode(_$AssignmentStatusEnumMap, json['status']),
  dueAt: json['dueAt'] == null ? null : DateTime.parse(json['dueAt'] as String),
  submittedAt: json['submittedAt'] == null
      ? null
      : DateTime.parse(json['submittedAt'] as String),
  score: (json['score'] as num?)?.toInt(),
  maxScore: (json['maxScore'] as num?)?.toInt(),
  resultUrl: json['resultUrl'] as String?,
  contentUrl: json['contentUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AssignmentToJson(_Assignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'courseId': instance.courseId,
      'courseName': instance.courseName,
      'type': _$AssignmentTypeEnumMap[instance.type]!,
      'status': _$AssignmentStatusEnumMap[instance.status]!,
      'dueAt': instance.dueAt?.toIso8601String(),
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'score': instance.score,
      'maxScore': instance.maxScore,
      'resultUrl': instance.resultUrl,
      'contentUrl': instance.contentUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$AssignmentTypeEnumMap = {
  AssignmentType.quiz: 'quiz',
  AssignmentType.report: 'report',
  AssignmentType.presentation: 'presentation',
  AssignmentType.other: 'other',
};

const _$AssignmentStatusEnumMap = {
  AssignmentStatus.notStarted: 'notStarted',
  AssignmentStatus.inProgress: 'inProgress',
  AssignmentStatus.submitted: 'submitted',
  AssignmentStatus.graded: 'graded',
  AssignmentStatus.overdue: 'overdue',
};
