import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_data.freezed.dart';
part 'route_data.g.dart';

/// Assignment detail page arguments
@freezed
abstract class AssignmentDetailArgs with _$AssignmentDetailArgs {
  const factory AssignmentDetailArgs({
    required String courseId,
    required String assignmentId,
  }) = _AssignmentDetailArgs;

  factory AssignmentDetailArgs.fromJson(Map<String, dynamic> json) =>
      _$AssignmentDetailArgsFromJson(json);
}

/// Course detail page arguments
@freezed
abstract class CourseDetailArgs with _$CourseDetailArgs {
  const factory CourseDetailArgs({required String courseId}) =
      _CourseDetailArgs;

  factory CourseDetailArgs.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailArgsFromJson(json);
}

/// Course materials page arguments
@freezed
abstract class CourseMaterialsArgs with _$CourseMaterialsArgs {
  const factory CourseMaterialsArgs({required String courseId}) =
      _CourseMaterialsArgs;

  factory CourseMaterialsArgs.fromJson(Map<String, dynamic> json) =>
      _$CourseMaterialsArgsFromJson(json);
}

/// Error page arguments
@freezed
abstract class ErrorPageArgs with _$ErrorPageArgs {
  const factory ErrorPageArgs({
    required String title,
    required String message,
    @Default(true) bool canRetry,
  }) = _ErrorPageArgs;

  factory ErrorPageArgs.fromJson(Map<String, dynamic> json) =>
      _$ErrorPageArgsFromJson(json);
}

/// Deep link data from FCM or external sources
@freezed
abstract class DeepLinkData with _$DeepLinkData {
  const factory DeepLinkData({
    required Uri uri,
    Map<String, dynamic>? pushPayload,
    DateTime? timestamp,
  }) = _DeepLinkData;

  factory DeepLinkData.fromJson(Map<String, dynamic> json) =>
      _$DeepLinkDataFromJson(json);
}
