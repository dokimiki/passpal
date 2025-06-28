import 'package:freezed_annotation/freezed_annotation.dart';
import 'syllabus.dart';
import 'course_material.dart';
import 'attendance_state.dart';

part 'course.freezed.dart';
part 'course.g.dart';

/// 授業コースを表すエンティティ
@freezed
abstract class Course with _$Course {
  const factory Course({
    /// コースID
    required String id,

    /// 授業名
    required String title,

    /// 教員名
    required String teacher,

    /// 教室
    String? room,

    /// MaNaBoクラスID
    required int manaboClassId,

    /// 授業コード
    String? courseCode,

    /// 単位数
    int? credits,

    /// 授業形態
    String? format,
  }) = _Course;

  factory Course.fromJson(Map<String, Object?> json) => _$CourseFromJson(json);
}

/// 授業の詳細情報
@freezed
abstract class CourseDetail with _$CourseDetail {
  const factory CourseDetail({
    /// 基本情報
    required Course course,

    /// シラバス
    Syllabus? syllabus,

    /// 授業資料リスト
    @Default([]) List<CourseMaterial> materials,

    /// お知らせリスト
    @Default([]) List<CourseNews> news,

    /// 出席状態
    AttendanceState? attendanceState,
  }) = _CourseDetail;

  factory CourseDetail.fromJson(Map<String, Object?> json) =>
      _$CourseDetailFromJson(json);
}
