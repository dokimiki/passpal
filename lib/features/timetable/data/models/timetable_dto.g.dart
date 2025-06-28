// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ManaboTimetableResponseDto _$ManaboTimetableResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ManaboTimetableResponseDto(
  html: json['html'] as String,
  success: json['success'] as bool? ?? true,
);

Map<String, dynamic> _$ManaboTimetableResponseDtoToJson(
  _ManaboTimetableResponseDto instance,
) => <String, dynamic>{'html': instance.html, 'success': instance.success};

_CubicsRoomDto _$CubicsRoomDtoFromJson(Map<String, dynamic> json) =>
    _CubicsRoomDto(
      building: json['building'] as String,
      room: json['room'] as String,
      campus: json['campus'] as String,
    );

Map<String, dynamic> _$CubicsRoomDtoToJson(_CubicsRoomDto instance) =>
    <String, dynamic>{
      'building': instance.building,
      'room': instance.room,
      'campus': instance.campus,
    };

_ManaboSlotDto _$ManaboSlotDtoFromJson(Map<String, dynamic> json) =>
    _ManaboSlotDto(
      weekday: (json['weekday'] as num).toInt(),
      period: (json['period'] as num).toInt(),
      courseName: json['courseName'] as String?,
      teacher: json['teacher'] as String?,
      room: json['room'] as String?,
      manaboClassId: (json['manaboClassId'] as num?)?.toInt(),
      courseCode: json['courseCode'] as String?,
    );

Map<String, dynamic> _$ManaboSlotDtoToJson(_ManaboSlotDto instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'period': instance.period,
      'courseName': instance.courseName,
      'teacher': instance.teacher,
      'room': instance.room,
      'manaboClassId': instance.manaboClassId,
      'courseCode': instance.courseCode,
    };
