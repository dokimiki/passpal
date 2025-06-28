// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingStatus _$OnboardingStatusFromJson(Map<String, dynamic> json) =>
    _OnboardingStatus(
      campus: json['campus'] == null
          ? null
          : Campus.fromJson(json['campus'] as Map<String, dynamic>),
      notificationsGranted: json['notificationsGranted'] == null
          ? null
          : NotificationPermission.fromJson(
              json['notificationsGranted'] as Map<String, dynamic>,
            ),
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$OnboardingStatusToJson(_OnboardingStatus instance) =>
    <String, dynamic>{
      'campus': instance.campus,
      'notificationsGranted': instance.notificationsGranted,
      'completed': instance.completed,
    };
