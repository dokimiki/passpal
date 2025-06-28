import 'package:test/test.dart';
import 'package:passpal/features/assignments/domain/enums/assignment_status.dart';

void main() {
  group('AssignmentStatus', () {
    test('should return correct display names', () {
      expect(AssignmentStatus.notStarted.displayName, equals('未着手'));
      expect(AssignmentStatus.inProgress.displayName, equals('進行中'));
      expect(AssignmentStatus.submitted.displayName, equals('提出済み'));
      expect(AssignmentStatus.graded.displayName, equals('採点済み'));
      expect(AssignmentStatus.overdue.displayName, equals('期限切れ'));
    });

    test('should return correct color names', () {
      expect(AssignmentStatus.notStarted.colorName, equals('grey'));
      expect(AssignmentStatus.inProgress.colorName, equals('blue'));
      expect(AssignmentStatus.submitted.colorName, equals('orange'));
      expect(AssignmentStatus.graded.colorName, equals('green'));
      expect(AssignmentStatus.overdue.colorName, equals('red'));
    });

    test('should correctly identify completed assignments', () {
      expect(AssignmentStatus.notStarted.isCompleted, isFalse);
      expect(AssignmentStatus.inProgress.isCompleted, isFalse);
      expect(AssignmentStatus.submitted.isCompleted, isTrue);
      expect(AssignmentStatus.graded.isCompleted, isTrue);
      expect(AssignmentStatus.overdue.isCompleted, isFalse);
    });
  });
}
