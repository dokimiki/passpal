import 'package:flutter_test/flutter_test.dart';

import 'package:passpal/core/storage/isar_service.dart';
import 'package:passpal/core/storage/entities/timetable.dart';
import 'package:passpal/core/storage/entities/assignment_log.dart';

void main() {
  group('IsarService', () {
    late IsarService isarService;

    setUp(() {
      isarService = IsarService.instance;
    });

    test('should return singleton instance', () {
      final instance1 = IsarService.instance;
      final instance2 = IsarService.instance;

      expect(identical(instance1, instance2), true);
      expect(instance1, equals(instance2));
    });

    test('should return null isar before opening', () {
      expect(isarService.isar, isNull);
    });

    test('should throw StateError when clearing unopened database', () async {
      expect(() => isarService.clear(), throwsA(isA<StateError>()));
    });

    test(
      'should throw StateError when getting stats from unopened database',
      () async {
        expect(() => isarService.getStats(), throwsA(isA<StateError>()));
      },
    );

    group('Entity validation', () {
      test('should create Timetable entity with correct properties', () {
        final timetable = Timetable(
          campusId: 'toyota',
          weekday: 1,
          period: 1,
          courseName: 'Computer Science',
          instructor: 'Dr. Smith',
        );

        expect(timetable.campusId, equals('toyota'));
        expect(timetable.weekday, equals(1));
        expect(timetable.period, equals(1));
        expect(timetable.courseName, equals('Computer Science'));
        expect(timetable.instructor, equals('Dr. Smith'));
        expect(timetable.updatedAt, isA<DateTime>());
        expect(timetable.searchKey, equals('toyota-1-1'));
      });
      test('should create empty Timetable entity', () {
        final timetable = Timetable.empty();
        expect(timetable.id, isA<int>()); // Auto-increment ID
      });

      test('should create AssignmentLog entity with correct properties', () {
        final dueDate = DateTime(2025, 6, 30);
        final log = AssignmentLog(
          assignmentId: 'assignment-123',
          action: AssignmentAction.added,
          dueAt: dueDate,
        );

        expect(log.assignmentId, equals('assignment-123'));
        expect(log.action, equals(AssignmentAction.added));
        expect(log.dueAt, equals(dueDate));
        expect(log.notified, false);
        expect(log.createdAt, isA<DateTime>());
        expect(log.hasDueDate, true);
      });

      test('should create AssignmentLog entity without due date', () {
        final log = AssignmentLog(
          assignmentId: 'no-due-date',
          action: AssignmentAction.added,
        );

        expect(log.assignmentId, equals('no-due-date'));
        expect(log.action, equals(AssignmentAction.added));
        expect(log.dueAt, isNull);
        expect(log.hasDueDate, false);
        expect(log.isOverdue, false);
      });
      test('should create empty AssignmentLog entity', () {
        final log = AssignmentLog.empty();
        expect(log.id, isA<int>()); // Auto-increment ID
      });

      test('should detect overdue assignments', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final log = AssignmentLog(
          assignmentId: 'overdue-test',
          action: AssignmentAction.added,
          dueAt: yesterday,
        );

        expect(log.isOverdue, true);
      });

      test('should not detect future assignments as overdue', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        final log = AssignmentLog(
          assignmentId: 'future-test',
          action: AssignmentAction.added,
          dueAt: tomorrow,
        );

        expect(log.isOverdue, false);
      });
    });

    group('String representations', () {
      test('should provide meaningful toString for Timetable', () {
        final timetable = Timetable(
          campusId: 'toyota',
          weekday: 1,
          period: 1,
          courseName: 'Computer Science',
          instructor: 'Dr. Smith',
        );

        final stringRep = timetable.toString();
        expect(stringRep, contains('Timetable'));
        expect(stringRep, contains('toyota'));
        expect(stringRep, contains('Computer Science'));
        expect(stringRep, contains('Dr. Smith'));
      });

      test('should provide meaningful toString for AssignmentLog', () {
        final log = AssignmentLog(
          assignmentId: 'test-123',
          action: AssignmentAction.added,
        );

        final stringRep = log.toString();
        expect(stringRep, contains('AssignmentLog'));
        expect(stringRep, contains('test-123'));
        expect(stringRep, contains('AssignmentAction.added'));
      });
    });

    // Note: Full database integration tests require platform-specific setup
    // and are skipped in this test suite to avoid Isar native library issues
    // on Windows. These tests would be run in a proper testing environment
    // with Flutter integration test setup.
  });
}
