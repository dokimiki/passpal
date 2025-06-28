// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MailSummaryDto _$MailSummaryDtoFromJson(Map<String, dynamic> json) =>
    _MailSummaryDto(
      mailId: json['mailId'] as String,
      title: json['title'] as String,
      senderName: json['senderName'] as String,
      receivedAt: DateTime.parse(json['receivedAt'] as String),
      isRead: json['isRead'] as bool,
      senderThumbnailUrl: json['senderThumbnailUrl'] as String?,
    );

Map<String, dynamic> _$MailSummaryDtoToJson(_MailSummaryDto instance) =>
    <String, dynamic>{
      'mailId': instance.mailId,
      'title': instance.title,
      'senderName': instance.senderName,
      'receivedAt': instance.receivedAt.toIso8601String(),
      'isRead': instance.isRead,
      'senderThumbnailUrl': instance.senderThumbnailUrl,
    };
