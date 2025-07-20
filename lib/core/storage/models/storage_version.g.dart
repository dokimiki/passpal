// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StorageVersion _$StorageVersionFromJson(Map<String, dynamic> json) =>
    _StorageVersion(
      version: (json['version'] as num).toInt(),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      migrations:
          (json['migrations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$StorageVersionToJson(_StorageVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'migrations': instance.migrations,
    };

_MigrationStep _$MigrationStepFromJson(Map<String, dynamic> json) =>
    _MigrationStep(
      id: json['id'] as String,
      fromVersion: (json['fromVersion'] as num).toInt(),
      toVersion: (json['toVersion'] as num).toInt(),
      description: json['description'] as String,
      type: $enumDecode(_$MigrationTypeEnumMap, json['type']),
      parameters: json['parameters'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$MigrationStepToJson(_MigrationStep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromVersion': instance.fromVersion,
      'toVersion': instance.toVersion,
      'description': instance.description,
      'type': _$MigrationTypeEnumMap[instance.type]!,
      'parameters': instance.parameters,
    };

const _$MigrationTypeEnumMap = {
  MigrationType.keyRename: 'key_rename',
  MigrationType.dataTransform: 'data_transform',
  MigrationType.schemaUpdate: 'schema_update',
  MigrationType.dataMigration: 'data_migration',
};

_MigrationResult _$MigrationResultFromJson(Map<String, dynamic> json) =>
    _MigrationResult(
      success: json['success'] as bool,
      fromVersion: (json['fromVersion'] as num).toInt(),
      toVersion: (json['toVersion'] as num).toInt(),
      appliedMigrations: (json['appliedMigrations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      error: json['error'] as String?,
      metadata:
          json['metadata'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$MigrationResultToJson(_MigrationResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'fromVersion': instance.fromVersion,
      'toVersion': instance.toVersion,
      'appliedMigrations': instance.appliedMigrations,
      'error': instance.error,
      'metadata': instance.metadata,
    };
