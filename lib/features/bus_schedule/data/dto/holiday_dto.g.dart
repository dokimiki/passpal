// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HolidayDto _$HolidayDtoFromJson(Map<String, dynamic> json) => _HolidayDto(
  date: json['date'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$HolidayDtoToJson(_HolidayDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
      'description': instance.description,
    };

_HolidayResponseDto _$HolidayResponseDtoFromJson(Map<String, dynamic> json) =>
    _HolidayResponseDto(
      holidays: (json['holidays'] as List<dynamic>)
          .map((e) => HolidayDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HolidayResponseDtoToJson(_HolidayResponseDto instance) =>
    <String, dynamic>{'holidays': instance.holidays};
