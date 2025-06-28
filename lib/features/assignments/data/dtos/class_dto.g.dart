// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClassDto _$ClassDtoFromJson(Map<String, dynamic> json) => _ClassDto(
  classId: json['classId'] as String,
  name: json['name'] as String,
  instructor: json['instructor'] as String,
  url: json['url'] as String?,
);

Map<String, dynamic> _$ClassDtoToJson(_ClassDto instance) => <String, dynamic>{
  'classId': instance.classId,
  'name': instance.name,
  'instructor': instance.instructor,
  'url': instance.url,
};
