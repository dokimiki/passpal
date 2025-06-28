import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment_id.freezed.dart';
part 'assignment_id.g.dart';

/// Unique identifier for an assignment
@freezed
abstract class AssignmentId with _$AssignmentId {
  const factory AssignmentId({
    required String contentId,
    required String classId,
    String? pluginId,
  }) = _AssignmentId;

  factory AssignmentId.fromJson(Map<String, dynamic> json) =>
      _$AssignmentIdFromJson(json);
}

extension AssignmentIdExt on AssignmentId {
  /// Generate a unique string representation
  String get uniqueKey {
    if (pluginId != null) {
      return '${classId}_${contentId}_$pluginId';
    }
    return '${classId}_$contentId';
  }
}
