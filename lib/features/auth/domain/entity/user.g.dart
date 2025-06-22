// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String,
      studentId: json['studentId'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      campus: $enumDecode(_$CampusEnumMap, json['campus']),
      created: DateTime.parse(json['created'] as String),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'studentId': instance.studentId,
      'displayName': instance.displayName,
      'email': instance.email,
      'campus': _$CampusEnumMap[instance.campus]!,
      'created': instance.created.toIso8601String(),
      'photoUrl': instance.photoUrl,
    };

const _$CampusEnumMap = {
  Campus.toyota: 'toyota',
  Campus.nagoya: 'nagoya',
  Campus.unknown: 'unknown',
};
