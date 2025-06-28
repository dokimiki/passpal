import 'package:freezed_annotation/freezed_annotation.dart';

part 'mail_summary.freezed.dart';
part 'mail_summary.g.dart';

@freezed
abstract class MailSummary with _$MailSummary {
  const factory MailSummary({
    required String mailId,
    required String title,
    required String senderName,
    required DateTime receivedAt,
    required bool isRead,
    String? senderThumbnailUrl,
  }) = _MailSummary;

  factory MailSummary.fromJson(Map<String, dynamic> json) =>
      _$MailSummaryFromJson(json);
}
