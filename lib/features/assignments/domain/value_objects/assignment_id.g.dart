// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssignmentId _$AssignmentIdFromJson(Map<String, dynamic> json) =>
    _AssignmentId(
      contentId: json['contentId'] as String,
      classId: json['classId'] as String,
      pluginId: json['pluginId'] as String?,
    );

Map<String, dynamic> _$AssignmentIdToJson(_AssignmentId instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'classId': instance.classId,
      'pluginId': instance.pluginId,
    };
