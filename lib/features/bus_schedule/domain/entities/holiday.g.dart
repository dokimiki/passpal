// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HolidayEntity _$HolidayEntityFromJson(Map<String, dynamic> json) =>
    _HolidayEntity(
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
    );

Map<String, dynamic> _$HolidayEntityToJson(_HolidayEntity instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'name': instance.name,
    };

_HolidayCollection _$HolidayCollectionFromJson(Map<String, dynamic> json) =>
    _HolidayCollection(
      holidays: Map<String, String>.from(json['holidays'] as Map),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$HolidayCollectionToJson(_HolidayCollection instance) =>
    <String, dynamic>{
      'holidays': instance.holidays,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
