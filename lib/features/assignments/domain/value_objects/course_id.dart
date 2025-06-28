import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_id.freezed.dart';
part 'course_id.g.dart';

/// Unique identifier for a course/class
@freezed
abstract class CourseId with _$CourseId {
  const factory CourseId({required String classId, String? directoryId}) =
      _CourseId;

  factory CourseId.fromJson(Map<String, dynamic> json) =>
      _$CourseIdFromJson(json);
}

extension CourseIdExt on CourseId {
  /// Generate a unique string representation
  String get uniqueKey {
    if (directoryId != null) {
      return '${classId}_$directoryId';
    }
    return classId;
  }
}
