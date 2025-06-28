// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimetableSlot _$TimetableSlotFromJson(Map<String, dynamic> json) =>
    _TimetableSlot(
      id: json['id'] as String,
      term: Term.fromJson(json['term'] as Map<String, dynamic>),
      weekday: $enumDecode(_$WeekdayEnumMap, json['weekday']),
      period: $enumDecode(_$PeriodEnumMap, json['period']),
      course: json['course'] == null
          ? null
          : Course.fromJson(json['course'] as Map<String, dynamic>),
      room: json['room'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TimetableSlotToJson(_TimetableSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'term': instance.term,
      'weekday': _$WeekdayEnumMap[instance.weekday]!,
      'period': _$PeriodEnumMap[instance.period]!,
      'course': instance.course,
      'room': instance.room,
      'notes': instance.notes,
    };

const _$WeekdayEnumMap = {
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
  Weekday.sunday: 'sunday',
};

const _$PeriodEnumMap = {
  Period.first: 1,
  Period.second: 2,
  Period.third: 3,
  Period.fourth: 4,
  Period.fifth: 5,
  Period.sixth: 6,
  Period.seventh: 7,
};
