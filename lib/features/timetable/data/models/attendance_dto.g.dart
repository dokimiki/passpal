// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ManaboAttendanceResponseDto _$ManaboAttendanceResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ManaboAttendanceResponseDto(
  success: json['success'] as bool,
  html: json['html'] as String?,
  error: json['error'] as String?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : ManaboAttendanceDataDto.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ManaboAttendanceResponseDtoToJson(
  _ManaboAttendanceResponseDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'html': instance.html,
  'error': instance.error,
  'message': instance.message,
  'data': instance.data,
};

_ManaboAttendanceDataDto _$ManaboAttendanceDataDtoFromJson(
  Map<String, dynamic> json,
) => _ManaboAttendanceDataDto(isAccepted: (json['isAccepted'] as num).toInt());

Map<String, dynamic> _$ManaboAttendanceDataDtoToJson(
  _ManaboAttendanceDataDto instance,
) => <String, dynamic>{'isAccepted': instance.isAccepted};

_AttendanceFormDto _$AttendanceFormDtoFromJson(Map<String, dynamic> json) =>
    _AttendanceFormDto(
      entryId: json['entryId'] as String,
      uniqid: json['uniqid'] as String,
      requiresPassword: json['requiresPassword'] as bool? ?? false,
    );

Map<String, dynamic> _$AttendanceFormDtoToJson(_AttendanceFormDto instance) =>
    <String, dynamic>{
      'entryId': instance.entryId,
      'uniqid': instance.uniqid,
      'requiresPassword': instance.requiresPassword,
    };
