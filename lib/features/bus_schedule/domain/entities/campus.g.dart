// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampusEntity _$CampusEntityFromJson(Map<String, dynamic> json) =>
    _CampusEntity(
      id: $enumDecode(_$CampusEnumMap, json['id']),
      name: json['name'] as String,
      description: json['description'] as String,
      availableLines: (json['availableLines'] as List<dynamic>)
          .map((e) => LineId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampusEntityToJson(_CampusEntity instance) =>
    <String, dynamic>{
      'id': _$CampusEnumMap[instance.id]!,
      'name': instance.name,
      'description': instance.description,
      'availableLines': instance.availableLines,
    };

const _$CampusEnumMap = {Campus.toyota: 'toyota', Campus.yagoto: 'yagoto'};
