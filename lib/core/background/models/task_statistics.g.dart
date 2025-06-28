// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskStatistics _$TaskStatisticsFromJson(Map<String, dynamic> json) =>
    _TaskStatistics(
      totalExecutions: (json['totalExecutions'] as num?)?.toInt() ?? 0,
      successfulExecutions:
          (json['successfulExecutions'] as num?)?.toInt() ?? 0,
      failedExecutions: (json['failedExecutions'] as num?)?.toInt() ?? 0,
      averageExecutionTimeMs:
          (json['averageExecutionTimeMs'] as num?)?.toInt() ?? 0,
      lastExecution: json['lastExecution'] == null
          ? null
          : DateTime.parse(json['lastExecution'] as String),
      errorCounts:
          (json['errorCounts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$TaskStatisticsToJson(_TaskStatistics instance) =>
    <String, dynamic>{
      'totalExecutions': instance.totalExecutions,
      'successfulExecutions': instance.successfulExecutions,
      'failedExecutions': instance.failedExecutions,
      'averageExecutionTimeMs': instance.averageExecutionTimeMs,
      'lastExecution': instance.lastExecution?.toIso8601String(),
      'errorCounts': instance.errorCounts,
    };

_TaskExecutionRecord _$TaskExecutionRecordFromJson(Map<String, dynamic> json) =>
    _TaskExecutionRecord(
      taskId: json['taskId'] as String,
      executedAt: DateTime.parse(json['executedAt'] as String),
      success: json['success'] as bool,
      executionTimeMs: (json['executionTimeMs'] as num).toInt(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$TaskExecutionRecordToJson(
  _TaskExecutionRecord instance,
) => <String, dynamic>{
  'taskId': instance.taskId,
  'executedAt': instance.executedAt.toIso8601String(),
  'success': instance.success,
  'executionTimeMs': instance.executionTimeMs,
  'error': instance.error,
};
