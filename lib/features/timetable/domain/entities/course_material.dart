import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_material.freezed.dart';
part 'course_material.g.dart';

/// 授業資料を表すエンティティ
@freezed
abstract class CourseMaterial with _$CourseMaterial {
  const factory CourseMaterial({
    /// 資料ID
    required String id,

    /// 資料名
    required String title,

    /// 資料タイプ
    required MaterialType type,

    /// ダウンロードURL
    String? downloadUrl,

    /// ファイルサイズ（バイト）
    int? fileSize,

    /// 作成日時
    DateTime? createdAt,

    /// 更新日時
    DateTime? updatedAt,

    /// 説明
    String? description,
  }) = _CourseMaterial;

  factory CourseMaterial.fromJson(Map<String, Object?> json) =>
      _$CourseMaterialFromJson(json);
}

/// 資料の種類
enum MaterialType {
  @JsonValue('document')
  document,
  @JsonValue('video')
  video,
  @JsonValue('audio')
  audio,
  @JsonValue('link')
  link,
  @JsonValue('quiz')
  quiz,
  @JsonValue('assignment')
  assignment;

  String get displayName {
    switch (this) {
      case MaterialType.document:
        return '資料';
      case MaterialType.video:
        return '動画';
      case MaterialType.audio:
        return '音声';
      case MaterialType.link:
        return 'リンク';
      case MaterialType.quiz:
        return 'クイズ';
      case MaterialType.assignment:
        return '課題';
    }
  }

  String get icon {
    switch (this) {
      case MaterialType.document:
        return '📄';
      case MaterialType.video:
        return '🎥';
      case MaterialType.audio:
        return '🎵';
      case MaterialType.link:
        return '🔗';
      case MaterialType.quiz:
        return '❓';
      case MaterialType.assignment:
        return '📝';
    }
  }
}

/// 授業のお知らせを表すエンティティ
@freezed
abstract class CourseNews with _$CourseNews {
  const factory CourseNews({
    /// お知らせID
    required String id,

    /// タイトル
    required String title,

    /// 内容
    required String content,

    /// 投稿日時
    required DateTime postedAt,

    /// 重要度
    @Default(NewsImportance.normal) NewsImportance importance,

    /// 添付ファイル
    @Default([]) List<CourseMaterial> attachments,
  }) = _CourseNews;

  factory CourseNews.fromJson(Map<String, Object?> json) =>
      _$CourseNewsFromJson(json);
}

/// お知らせの重要度
enum NewsImportance {
  @JsonValue('low')
  low,
  @JsonValue('normal')
  normal,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent;

  String get displayName {
    switch (this) {
      case NewsImportance.low:
        return '低';
      case NewsImportance.normal:
        return '普通';
      case NewsImportance.high:
        return '重要';
      case NewsImportance.urgent:
        return '緊急';
    }
  }
}
