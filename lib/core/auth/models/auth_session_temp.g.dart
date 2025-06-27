// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_temp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthSessionTemp _$AuthSessionTempFromJson(Map<String, dynamic> json) =>
    _AuthSessionTemp(
      username: json['username'] as String,
      cookies: Map<String, String>.from(json['cookies'] as Map),
      firebaseIdToken: json['firebaseIdToken'] as String?,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      lastRefreshed: DateTime.parse(json['lastRefreshed'] as String),
    );

Map<String, dynamic> _$AuthSessionTempToJson(_AuthSessionTemp instance) =>
    <String, dynamic>{
      'username': instance.username,
      'cookies': instance.cookies,
      'firebaseIdToken': instance.firebaseIdToken,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'lastRefreshed': instance.lastRefreshed.toIso8601String(),
    };
