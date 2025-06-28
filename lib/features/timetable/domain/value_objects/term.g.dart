// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Term _$TermFromJson(Map<String, dynamic> json) => _Term(
  archiveId: (json['archiveId'] as num).toInt(),
  year: (json['year'] as num).toInt(),
  semester: $enumDecode(_$SemesterEnumMap, json['semester']),
  displayName: json['displayName'] as String,
);

Map<String, dynamic> _$TermToJson(_Term instance) => <String, dynamic>{
  'archiveId': instance.archiveId,
  'year': instance.year,
  'semester': _$SemesterEnumMap[instance.semester]!,
  'displayName': instance.displayName,
};

const _$SemesterEnumMap = {
  Semester.spring: 'spring',
  Semester.autumn: 'autumn',
};
