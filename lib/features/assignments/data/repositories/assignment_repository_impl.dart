import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/assignment.dart';
import '../../domain/usecases/get_assignments.dart';
import '../../domain/value_objects/course_id.dart';
import '../datasources/manabo_assignments_remote_ds.dart';
import '../dtos/assignment_dto.dart';
import '../dtos/class_dto.dart';
import '../mappers/assignment_mapper.dart';
import '../parsers/v1_class_content_parser.dart';
import '../parsers/v1_quiz_result_parser.dart';
import '../parsers/v1_timetable_parser.dart';

/// Implementation of AssignmentRepository
class AssignmentRepositoryImpl implements AssignmentRepository {
  final ManaboAssignmentsRemoteDs _remoteDs;
  final V1TimetableParser _timetableParser;
  final V1ClassContentParser _contentParser;
  final V1QuizResultParser _resultParser;

  // Cache management
  final Map<String, List<Assignment>> _cache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  static const Duration _cacheTtl = Duration(hours: 1);

  // Stream controller for real-time updates
  final StreamController<List<Assignment>> _assignmentsController =
      StreamController<List<Assignment>>.broadcast();

  AssignmentRepositoryImpl({
    required ManaboAssignmentsRemoteDs remoteDs,
    required V1TimetableParser timetableParser,
    required V1ClassContentParser contentParser,
    required V1QuizResultParser resultParser,
  }) : _remoteDs = remoteDs,
       _timetableParser = timetableParser,
       _contentParser = contentParser,
       _resultParser = resultParser;

  @override
  Stream<List<Assignment>> watchAssignments(String term) {
    debugPrint('🔍 watchAssignments called for term: $term');

    // Emit cached data immediately if available
    if (_isCacheValid(term)) {
      debugPrint(
        '✅ Found valid cache, emitting ${_cache[term]!.length} assignments',
      );
      _assignmentsController.add(_cache[term]!);
    } else {
      debugPrint('❌ No valid cache, emitting empty list and starting refresh');
      // Emit empty list initially and then load data
      _assignmentsController.add([]);
      // Load from remote if cache is stale
      refreshAssignments(term).catchError((error) {
        debugPrint('💥 Refresh failed: $error');
        _assignmentsController.addError(error);
      });
    }

    return _assignmentsController.stream;
  }

  @override
  Future<void> refreshAssignments(String term) async {
    debugPrint('🔄 Starting refresh for term: $term');

    try {
      // Step 1: Fetch timetable to get class list
      debugPrint('📅 Fetching timetable...');
      final timetableHtml = await _remoteDs.fetchTimetable(term);
      final classes = _timetableParser.parseTimetable(timetableHtml);
      debugPrint('📚 Found ${classes.length} classes');

      if (classes.isEmpty) {
        debugPrint('⚠️ No classes found, updating cache with empty list');
        _updateCache(term, []);
        return;
      }

      // Step 2: Fetch assignments for each class
      final allAssignments = <AssignmentDto>[];
      final classMap = <String, ClassDto>{};

      for (final classDto in classes) {
        classMap[classDto.classId] = classDto;

        try {
          // Fetch class content (assignments)
          final contentHtml = await _remoteDs.fetchClassContent(
            classDto.classId,
            '0', // Root directory
          );

          final assignments = _contentParser.parseContent(
            contentHtml,
            classDto.classId,
          );

          allAssignments.addAll(assignments);
        } catch (e) {
          // Skip classes that fail to load
          continue;
        }
      }

      // Step 3: Fetch quiz results for quiz-type assignments
      final resultMap = <String, QuizResultInfo>{};

      for (final assignmentDto in allAssignments) {
        if (assignmentDto.pluginKey == 'quiz' &&
            assignmentDto.resultUrl != null) {
          try {
            final resultHtml = await _remoteDs.fetchQuizResult({
              'plugin_id': assignmentDto.pluginId ?? '',
              'classId': assignmentDto.classId,
              'id': assignmentDto.contentId,
            });

            final resultInfo = _resultParser.parseResult(resultHtml);
            resultMap[assignmentDto.contentId] = resultInfo;
          } catch (e) {
            // Skip quiz results that fail to load
            continue;
          }
        }
      }

      // Step 4: Convert to domain entities
      final assignments = AssignmentMapper.toAssignments(
        allAssignments,
        classMap,
        resultMap: resultMap,
      );

      // Step 5: Update cache and notify listeners
      _updateCache(term, assignments);
    } catch (e) {
      // On error, emit cached data if available
      if (_cache.containsKey(term)) {
        _assignmentsController.add(_cache[term]!);
      } else {
        _assignmentsController.addError(e);
      }
      rethrow;
    }
  }

  @override
  Future<void> markSeen(String assignmentId) async {
    // Implementation for marking assignments as seen
    // This could involve updating local storage or remote API
    // For now, we'll implement this as a no-op
  }

  @override
  Future<List<Assignment>> getAssignmentsForCourse(CourseId courseId) async {
    // Get assignments from cache or fetch if needed
    final allAssignments = _cache.values.expand((list) => list).toList();

    return allAssignments
        .where((assignment) => assignment.courseId.classId == courseId.classId)
        .toList();
  }

  @override
  @override
  Future<int> getAssignmentsCount(String term) async {
    if (_cache.containsKey(term)) {
      return _cache[term]!.length;
    }
    return 0;
  }

  /// Check if cache is valid for the given term
  bool _isCacheValid(String term) {
    if (!_cache.containsKey(term) || !_cacheTimestamps.containsKey(term)) {
      return false;
    }

    final timestamp = _cacheTimestamps[term]!;
    return DateTime.now().difference(timestamp) < _cacheTtl;
  }

  /// Update cache with new assignments
  void _updateCache(String term, List<Assignment> assignments) {
    _cache[term] = assignments;
    _cacheTimestamps[term] = DateTime.now();
    _assignmentsController.add(assignments);
  }

  /// Dispose resources
  void dispose() {
    _assignmentsController.close();
  }
}
