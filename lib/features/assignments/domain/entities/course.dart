import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/course_id.dart';

part 'course.freezed.dart';
part 'course.g.dart';

/// Domain entity representing a course/class from MaNaBo
@freezed
abstract class Course with _$Course {
  const factory Course({
    required CourseId id,
    required String name,
    required String instructor,
    String? description,
    String? url,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
