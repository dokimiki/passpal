import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/network_target.dart';
import '../../../core/network/providers.dart';
import '../data/datasources/manabo_assignments_remote_ds.dart';
import '../data/parsers/v1_class_content_parser.dart';
import '../data/parsers/v1_quiz_result_parser.dart';
import '../data/parsers/v1_timetable_parser.dart';
import '../data/repositories/assignment_repository_impl.dart';
import '../domain/entities/assignment.dart';
import '../domain/usecases/get_assignments.dart';
import '../domain/usecases/sync_assignments.dart';
import 'notifiers/assignments_notifier.dart';

/// Provider for MaNaBo assignments remote data source
final manaboAssignmentsRemoteDsProvider =
    Provider.autoDispose<ManaboAssignmentsRemoteDs>((ref) {
      final dio = ref.watch(networkClientProvider(NetworkTarget.manabo));
      return ManaboAssignmentsRemoteDs(dio);
    });

/// Provider for timetable parser
final timetableParserProvider = Provider<V1TimetableParser>((ref) {
  return V1TimetableParser();
});

/// Provider for class content parser
final classContentParserProvider = Provider<V1ClassContentParser>((ref) {
  return V1ClassContentParser();
});

/// Provider for quiz result parser
final quizResultParserProvider = Provider<V1QuizResultParser>((ref) {
  return V1QuizResultParser();
});

/// Provider for assignments repository
final assignmentsRepositoryProvider = Provider<AssignmentRepository>((ref) {
  final remoteDs = ref.watch(manaboAssignmentsRemoteDsProvider);
  final timetableParser = ref.watch(timetableParserProvider);
  final contentParser = ref.watch(classContentParserProvider);
  final resultParser = ref.watch(quizResultParserProvider);

  return AssignmentRepositoryImpl(
    remoteDs: remoteDs,
    timetableParser: timetableParser,
    contentParser: contentParser,
    resultParser: resultParser,
  );
});

/// Provider for get assignments use case
final getAssignmentsUseCaseProvider = Provider<GetAssignments>((ref) {
  final repository = ref.watch(assignmentsRepositoryProvider);
  return GetAssignments(repository);
});

/// Provider for sync assignments use case
final syncAssignmentsUseCaseProvider = Provider<SyncAssignments>((ref) {
  final repository = ref.watch(assignmentsRepositoryProvider);
  return SyncAssignments(repository);
});

/// Provider for assignments notifier
final assignmentsNotifierProvider =
    AsyncNotifierProvider.autoDispose<AssignmentsNotifier, List<Assignment>>(
      AssignmentsNotifier.new,
    );
