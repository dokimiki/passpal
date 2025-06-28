import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_dto.freezed.dart';
part 'class_dto.g.dart';

/// DTO for timetable class information
@freezed
abstract class ClassDto with _$ClassDto {
  const factory ClassDto({
    required String classId,
    required String name,
    required String instructor,
    String? url,
  }) = _ClassDto;

  factory ClassDto.fromJson(Map<String, dynamic> json) =>
      _$ClassDtoFromJson(json);
}
