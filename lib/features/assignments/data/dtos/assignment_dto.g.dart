// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssignmentDto _$AssignmentDtoFromJson(Map<String, dynamic> json) =>
    _AssignmentDto(
      contentId: json['contentId'] as String,
      classId: json['classId'] as String,
      title: json['title'] as String,
      pluginKey: json['pluginKey'] as String,
      pluginId: json['pluginId'] as String?,
      directoryId: json['directoryId'] as String?,
      contentUrl: json['contentUrl'] as String?,
      resultUrl: json['resultUrl'] as String?,
      dueAt: json['dueAt'] == null
          ? null
          : DateTime.parse(json['dueAt'] as String),
      isSubmitted: json['isSubmitted'] as bool?,
      score: (json['score'] as num?)?.toInt(),
      maxScore: (json['maxScore'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssignmentDtoToJson(_AssignmentDto instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'classId': instance.classId,
      'title': instance.title,
      'pluginKey': instance.pluginKey,
      'pluginId': instance.pluginId,
      'directoryId': instance.directoryId,
      'contentUrl': instance.contentUrl,
      'resultUrl': instance.resultUrl,
      'dueAt': instance.dueAt?.toIso8601String(),
      'isSubmitted': instance.isSubmitted,
      'score': instance.score,
      'maxScore': instance.maxScore,
    };
