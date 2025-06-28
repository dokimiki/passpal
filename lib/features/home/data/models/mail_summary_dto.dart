import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/mail_summary.dart';

part 'mail_summary_dto.freezed.dart';
part 'mail_summary_dto.g.dart';

@freezed
abstract class MailSummaryDto with _$MailSummaryDto {
  const factory MailSummaryDto({
    required String mailId,
    required String title,
    required String senderName,
    required DateTime receivedAt,
    required bool isRead,
    String? senderThumbnailUrl,
  }) = _MailSummaryDto;

  factory MailSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$MailSummaryDtoFromJson(json);
}

extension MailSummaryDtoX on MailSummaryDto {
  MailSummary toDomain() {
    return MailSummary(
      mailId: mailId,
      title: title,
      senderName: senderName,
      receivedAt: receivedAt,
      isRead: isRead,
      senderThumbnailUrl: senderThumbnailUrl,
    );
  }
}
