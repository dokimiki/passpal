import 'package:freezed_annotation/freezed_annotation.dart';

part 'term.freezed.dart';
part 'term.g.dart';

/// 学期を表すValue Object
@freezed
abstract class Term with _$Term {
  const factory Term({
    /// アーカイブID (MaNaBoで使用)
    required int archiveId,

    /// 年度
    required int year,

    /// 学期 (春学期/秋学期)
    required Semester semester,

    /// 表示名 (例: "2025 春学期")
    required String displayName,
  }) = _Term;

  factory Term.fromJson(Map<String, Object?> json) => _$TermFromJson(json);
}

/// 学期種別
enum Semester {
  @JsonValue('spring')
  spring,
  @JsonValue('autumn')
  autumn;

  String get displayName {
    switch (this) {
      case Semester.spring:
        return '春学期';
      case Semester.autumn:
        return '秋学期';
    }
  }
}

/// よく使用される学期の定数
class TermConstants {
  static const Term current2025Spring = Term(
    archiveId: 20,
    year: 2025,
    semester: Semester.spring,
    displayName: '2025 春学期',
  );

  static const Term current2025Autumn = Term(
    archiveId: 21,
    year: 2025,
    semester: Semester.autumn,
    displayName: '2025 秋学期',
  );
}
