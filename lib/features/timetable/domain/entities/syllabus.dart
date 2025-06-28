import 'package:freezed_annotation/freezed_annotation.dart';

part 'syllabus.freezed.dart';
part 'syllabus.g.dart';

/// シラバスを表すエンティティ
@freezed
abstract class Syllabus with _$Syllabus {
  const factory Syllabus({
    /// シラバスID
    required String id,

    /// 授業名
    required String courseName,

    /// 教員名
    required String instructor,

    /// 授業の概要
    String? overview,

    /// 授業の目標
    String? objectives,

    /// 授業計画
    @Default([]) List<LessonPlan> lessonPlan,

    /// 評価方法
    String? evaluationMethod,

    /// 教科書
    String? textbook,

    /// 参考書
    String? references,

    /// 履修上の注意
    String? notes,

    /// オフィスアワー
    String? officeHours,

    /// 単位数
    int? credits,

    /// 授業形態
    String? format,

    /// 開講年度
    int? academicYear,

    /// 学期
    String? semester,
  }) = _Syllabus;

  factory Syllabus.fromJson(Map<String, Object?> json) =>
      _$SyllabusFromJson(json);
}

/// 授業計画の各回を表すエンティティ
@freezed
abstract class LessonPlan with _$LessonPlan {
  const factory LessonPlan({
    /// 回数
    required int week,

    /// タイトル
    required String title,

    /// 内容
    String? content,

    /// 事前学習
    String? preparation,

    /// 事後学習
    String? review,
  }) = _LessonPlan;

  factory LessonPlan.fromJson(Map<String, Object?> json) =>
      _$LessonPlanFromJson(json);
}
