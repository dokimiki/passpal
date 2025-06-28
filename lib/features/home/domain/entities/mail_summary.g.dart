// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MailSummary _$MailSummaryFromJson(Map<String, dynamic> json) => _MailSummary(
  mailId: json['mailId'] as String,
  title: json['title'] as String,
  senderName: json['senderName'] as String,
  receivedAt: DateTime.parse(json['receivedAt'] as String),
  isRead: json['isRead'] as bool,
  senderThumbnailUrl: json['senderThumbnailUrl'] as String?,
);

Map<String, dynamic> _$MailSummaryToJson(_MailSummary instance) =>
    <String, dynamic>{
      'mailId': instance.mailId,
      'title': instance.title,
      'senderName': instance.senderName,
      'receivedAt': instance.receivedAt.toIso8601String(),
      'isRead': instance.isRead,
      'senderThumbnailUrl': instance.senderThumbnailUrl,
    };
