import 'package:test/test.dart';
import 'package:passpal/features/assignments/domain/enums/assignment_type.dart';

void main() {
  group('AssignmentType', () {
    test('should return correct display names', () {
      expect(AssignmentType.quiz.displayName, equals('クイズ・テスト'));
      expect(AssignmentType.report.displayName, equals('レポート'));
      expect(AssignmentType.presentation.displayName, equals('プレゼンテーション'));
      expect(AssignmentType.other.displayName, equals('その他'));
    });

    test('should parse from plugin key correctly', () {
      expect(AssignmentType.fromPluginKey('quiz'), equals(AssignmentType.quiz));
      expect(AssignmentType.fromPluginKey('QUIZ'), equals(AssignmentType.quiz));
      expect(
        AssignmentType.fromPluginKey('report'),
        equals(AssignmentType.report),
      );
      expect(
        AssignmentType.fromPluginKey('presentation'),
        equals(AssignmentType.presentation),
      );
      expect(
        AssignmentType.fromPluginKey('unknown'),
        equals(AssignmentType.other),
      );
      expect(AssignmentType.fromPluginKey(null), equals(AssignmentType.other));
    });
  });
}
