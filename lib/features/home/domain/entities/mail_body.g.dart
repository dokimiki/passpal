// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MailBody _$MailBodyFromJson(Map<String, dynamic> json) => _MailBody(
  mailId: json['mailId'] as String,
  title: json['title'] as String,
  senderName: json['senderName'] as String,
  receivedAt: DateTime.parse(json['receivedAt'] as String),
  bodyHtml: json['bodyHtml'] as String,
  senderThumbnailUrl: json['senderThumbnailUrl'] as String?,
  replyToMailId: json['replyToMailId'] as String?,
);

Map<String, dynamic> _$MailBodyToJson(_MailBody instance) => <String, dynamic>{
  'mailId': instance.mailId,
  'title': instance.title,
  'senderName': instance.senderName,
  'receivedAt': instance.receivedAt.toIso8601String(),
  'bodyHtml': instance.bodyHtml,
  'senderThumbnailUrl': instance.senderThumbnailUrl,
  'replyToMailId': instance.replyToMailId,
};
