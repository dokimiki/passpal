import 'package:freezed_annotation/freezed_annotation.dart';

part 'mail_body.freezed.dart';
part 'mail_body.g.dart';

@freezed
abstract class MailBody with _$MailBody {
  const factory MailBody({
    required String mailId,
    required String title,
    required String senderName,
    required DateTime receivedAt,
    required String bodyHtml,
    String? senderThumbnailUrl,
    String? replyToMailId,
  }) = _MailBody;

  factory MailBody.fromJson(Map<String, dynamic> json) =>
      _$MailBodyFromJson(json);
}
