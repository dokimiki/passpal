import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment_dto.freezed.dart';
part 'assignment_dto.g.dart';

/// DTO for assignment content information
@freezed
abstract class AssignmentDto with _$AssignmentDto {
  const factory AssignmentDto({
    required String contentId,
    required String classId,
    required String title,
    required String pluginKey,
    String? pluginId,
    String? directoryId,
    String? contentUrl,
    String? resultUrl,
    DateTime? dueAt,
    bool? isSubmitted,
    int? score,
    int? maxScore,
  }) = _AssignmentDto;

  factory AssignmentDto.fromJson(Map<String, dynamic> json) =>
      _$AssignmentDtoFromJson(json);
}
