import '../../domain/entities/assignment.dart';
import '../../domain/entities/course.dart';
import '../../domain/enums/assignment_status.dart';
import '../../domain/enums/assignment_type.dart';
import '../../domain/value_objects/assignment_id.dart';
import '../../domain/value_objects/course_id.dart';
import '../dtos/assignment_dto.dart';
import '../dtos/class_dto.dart';
import '../parsers/v1_quiz_result_parser.dart';

/// Mapper to convert DTOs to domain entities
class AssignmentMapper {
  /// Convert ClassDto to Course entity
  static Course toCourse(ClassDto dto) {
    final now = DateTime.now();

    return Course(
      id: CourseId(classId: dto.classId),
      name: dto.name,
      instructor: dto.instructor,
      description: null,
      url: dto.url,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Convert AssignmentDto to Assignment entity
  static Assignment toAssignment(
    AssignmentDto dto,
    String courseName,
    String instructor, {
    QuizResultInfo? resultInfo,
  }) {
    final now = DateTime.now();

    final assignmentId = AssignmentId(
      contentId: dto.contentId,
      classId: dto.classId,
      pluginId: dto.pluginId,
    );

    final courseId = CourseId(
      classId: dto.classId,
      directoryId: dto.directoryId,
    );

    final type = AssignmentType.fromPluginKey(dto.pluginKey);

    // Determine status based on available information
    AssignmentStatus status = AssignmentStatus.notStarted;

    if (resultInfo != null) {
      if (resultInfo.isSubmitted) {
        if (resultInfo.score != null) {
          status = AssignmentStatus.graded;
        } else {
          status = AssignmentStatus.submitted;
        }
      }
    } else if (dto.isSubmitted == true) {
      status = AssignmentStatus.submitted;
    }

    // Check if overdue
    if (dto.dueAt != null &&
        DateTime.now().isAfter(dto.dueAt!) &&
        !status.isCompleted) {
      status = AssignmentStatus.overdue;
    }

    return Assignment(
      id: assignmentId,
      title: dto.title,
      courseId: courseId,
      courseName: courseName,
      type: type,
      status: status,
      dueAt: dto.dueAt,
      submittedAt: resultInfo?.submittedAt,
      score: resultInfo?.score ?? dto.score,
      maxScore: resultInfo?.maxScore ?? dto.maxScore,
      resultUrl: dto.resultUrl,
      contentUrl: dto.contentUrl,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Convert list of DTOs to domain entities
  static List<Assignment> toAssignments(
    List<AssignmentDto> dtos,
    Map<String, ClassDto> classMap, {
    Map<String, QuizResultInfo>? resultMap,
  }) {
    return dtos.map((dto) {
      final classDto = classMap[dto.classId];
      if (classDto == null) {
        throw StateError('Class info not found for ${dto.classId}');
      }

      final resultInfo = resultMap?[dto.contentId];

      return toAssignment(
        dto,
        classDto.name,
        classDto.instructor,
        resultInfo: resultInfo,
      );
    }).toList();
  }
}
