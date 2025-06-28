// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceState _$AttendanceStateFromJson(Map<String, dynamic> json) =>
    _AttendanceState(
      classId: (json['classId'] as num).toInt(),
      status: $enumDecode(_$AttendanceStatusEnumMap, json['status']),
      errorMessage: json['errorMessage'] as String?,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$AttendanceStateToJson(_AttendanceState instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.none: 'none',
  AttendanceStatus.open: 'open',
  AttendanceStatus.success: 'success',
  AttendanceStatus.fail: 'fail',
};
