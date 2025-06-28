/// Assignment types supported by the MaNaBo system
enum AssignmentType {
  /// Quiz or test assignments
  quiz,

  /// Report assignments
  report,

  /// Presentation assignments
  presentation,

  /// Other types of assignments
  other;

  /// Get display name for the assignment type
  String get displayName {
    switch (this) {
      case AssignmentType.quiz:
        return 'クイズ・テスト';
      case AssignmentType.report:
        return 'レポート';
      case AssignmentType.presentation:
        return 'プレゼンテーション';
      case AssignmentType.other:
        return 'その他';
    }
  }

  /// Parse assignment type from plugin key
  static AssignmentType fromPluginKey(String? pluginKey) {
    switch (pluginKey?.toLowerCase()) {
      case 'quiz':
        return AssignmentType.quiz;
      case 'report':
        return AssignmentType.report;
      case 'presentation':
        return AssignmentType.presentation;
      default:
        return AssignmentType.other;
    }
  }
}
