import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/mail_body.dart';

part 'mail_body_dto.freezed.dart';
part 'mail_body_dto.g.dart';

@freezed
abstract class MailBodyDto with _$MailBodyDto {
  const factory MailBodyDto({
    required String mailId,
    required String title,
    required String senderName,
    required DateTime receivedAt,
    required String bodyHtml,
    String? senderThumbnailUrl,
    String? replyToMailId,
  }) = _MailBodyDto;

  factory MailBodyDto.fromJson(Map<String, dynamic> json) =>
      _$MailBodyDtoFromJson(json);
}

extension MailBodyDtoX on MailBodyDto {
  MailBody toDomain() {
    return MailBody(
      mailId: mailId,
      title: title,
      senderName: senderName,
      receivedAt: receivedAt,
      bodyHtml: bodyHtml,
      senderThumbnailUrl: senderThumbnailUrl,
      replyToMailId: replyToMailId,
    );
  }
}
