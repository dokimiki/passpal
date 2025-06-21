// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAssignmentLogCollection on Isar {
  IsarCollection<AssignmentLog> get assignmentLogs => this.collection();
}

const AssignmentLogSchema = CollectionSchema(
  name: r'AssignmentLog',
  id: -7716443244627645551,
  properties: {
    r'action': PropertySchema(
      id: 0,
      name: r'action',
      type: IsarType.byte,
      enumMap: _AssignmentLogactionEnumValueMap,
    ),
    r'assignmentId': PropertySchema(
      id: 1,
      name: r'assignmentId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dueAt': PropertySchema(
      id: 3,
      name: r'dueAt',
      type: IsarType.dateTime,
    ),
    r'hasDueDate': PropertySchema(
      id: 4,
      name: r'hasDueDate',
      type: IsarType.bool,
    ),
    r'isOverdue': PropertySchema(
      id: 5,
      name: r'isOverdue',
      type: IsarType.bool,
    ),
    r'notified': PropertySchema(
      id: 6,
      name: r'notified',
      type: IsarType.bool,
    )
  },
  estimateSize: _assignmentLogEstimateSize,
  serialize: _assignmentLogSerialize,
  deserialize: _assignmentLogDeserialize,
  deserializeProp: _assignmentLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'assignmentId': IndexSchema(
      id: -2077143699295136292,
      name: r'assignmentId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'assignmentId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _assignmentLogGetId,
  getLinks: _assignmentLogGetLinks,
  attach: _assignmentLogAttach,
  version: '3.1.0+1',
);

int _assignmentLogEstimateSize(
  AssignmentLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.assignmentId.length * 3;
  return bytesCount;
}

void _assignmentLogSerialize(
  AssignmentLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.action.index);
  writer.writeString(offsets[1], object.assignmentId);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeDateTime(offsets[3], object.dueAt);
  writer.writeBool(offsets[4], object.hasDueDate);
  writer.writeBool(offsets[5], object.isOverdue);
  writer.writeBool(offsets[6], object.notified);
}

AssignmentLog _assignmentLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AssignmentLog(
    action:
        _AssignmentLogactionValueEnumMap[reader.readByteOrNull(offsets[0])] ??
            AssignmentAction.added,
    assignmentId: reader.readString(offsets[1]),
    dueAt: reader.readDateTimeOrNull(offsets[3]),
    notified: reader.readBoolOrNull(offsets[6]) ?? false,
  );
  object.createdAt = reader.readDateTime(offsets[2]);
  object.id = id;
  return object;
}

P _assignmentLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_AssignmentLogactionValueEnumMap[reader.readByteOrNull(offset)] ??
          AssignmentAction.added) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AssignmentLogactionEnumValueMap = {
  'added': 0,
  'removed': 1,
};
const _AssignmentLogactionValueEnumMap = {
  0: AssignmentAction.added,
  1: AssignmentAction.removed,
};

Id _assignmentLogGetId(AssignmentLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _assignmentLogGetLinks(AssignmentLog object) {
  return [];
}

void _assignmentLogAttach(
    IsarCollection<dynamic> col, Id id, AssignmentLog object) {
  object.id = id;
}

extension AssignmentLogByIndex on IsarCollection<AssignmentLog> {
  Future<AssignmentLog?> getByAssignmentId(String assignmentId) {
    return getByIndex(r'assignmentId', [assignmentId]);
  }

  AssignmentLog? getByAssignmentIdSync(String assignmentId) {
    return getByIndexSync(r'assignmentId', [assignmentId]);
  }

  Future<bool> deleteByAssignmentId(String assignmentId) {
    return deleteByIndex(r'assignmentId', [assignmentId]);
  }

  bool deleteByAssignmentIdSync(String assignmentId) {
    return deleteByIndexSync(r'assignmentId', [assignmentId]);
  }

  Future<List<AssignmentLog?>> getAllByAssignmentId(
      List<String> assignmentIdValues) {
    final values = assignmentIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'assignmentId', values);
  }

  List<AssignmentLog?> getAllByAssignmentIdSync(
      List<String> assignmentIdValues) {
    final values = assignmentIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'assignmentId', values);
  }

  Future<int> deleteAllByAssignmentId(List<String> assignmentIdValues) {
    final values = assignmentIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'assignmentId', values);
  }

  int deleteAllByAssignmentIdSync(List<String> assignmentIdValues) {
    final values = assignmentIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'assignmentId', values);
  }

  Future<Id> putByAssignmentId(AssignmentLog object) {
    return putByIndex(r'assignmentId', object);
  }

  Id putByAssignmentIdSync(AssignmentLog object, {bool saveLinks = true}) {
    return putByIndexSync(r'assignmentId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByAssignmentId(List<AssignmentLog> objects) {
    return putAllByIndex(r'assignmentId', objects);
  }

  List<Id> putAllByAssignmentIdSync(List<AssignmentLog> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'assignmentId', objects, saveLinks: saveLinks);
  }
}

extension AssignmentLogQueryWhereSort
    on QueryBuilder<AssignmentLog, AssignmentLog, QWhere> {
  QueryBuilder<AssignmentLog, AssignmentLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AssignmentLogQueryWhere
    on QueryBuilder<AssignmentLog, AssignmentLog, QWhereClause> {
  QueryBuilder<AssignmentLog, AssignmentLog, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterWhereClause>
      assignmentIdEqualTo(String assignmentId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'assignmentId',
        value: [assignmentId],
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterWhereClause>
      assignmentIdNotEqualTo(String assignmentId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'assignmentId',
              lower: [],
              upper: [assignmentId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'assignmentId',
              lower: [assignmentId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'assignmentId',
              lower: [assignmentId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'assignmentId',
              lower: [],
              upper: [assignmentId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AssignmentLogQueryFilter
    on QueryBuilder<AssignmentLog, AssignmentLog, QFilterCondition> {
  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      actionEqualTo(AssignmentAction value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'action',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      actionGreaterThan(
    AssignmentAction value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'action',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      actionLessThan(
    AssignmentAction value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'action',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      actionBetween(
    AssignmentAction lower,
    AssignmentAction upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'action',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignmentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assignmentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      assignmentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assignmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      dueAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dueAt',
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      dueAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dueAt',
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      dueAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      dueAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      dueAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      dueAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      hasDueDateEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      isOverdueEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOverdue',
        value: value,
      ));
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterFilterCondition>
      notifiedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notified',
        value: value,
      ));
    });
  }
}

extension AssignmentLogQueryObject
    on QueryBuilder<AssignmentLog, AssignmentLog, QFilterCondition> {}

extension AssignmentLogQueryLinks
    on QueryBuilder<AssignmentLog, AssignmentLog, QFilterCondition> {}

extension AssignmentLogQuerySortBy
    on QueryBuilder<AssignmentLog, AssignmentLog, QSortBy> {
  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> sortByAction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'action', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> sortByActionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'action', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      sortByAssignmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      sortByAssignmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> sortByDueAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueAt', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> sortByDueAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueAt', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> sortByHasDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDueDate', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      sortByHasDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDueDate', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> sortByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      sortByIsOverdueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> sortByNotified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notified', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      sortByNotifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notified', Sort.desc);
    });
  }
}

extension AssignmentLogQuerySortThenBy
    on QueryBuilder<AssignmentLog, AssignmentLog, QSortThenBy> {
  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByAction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'action', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByActionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'action', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      thenByAssignmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      thenByAssignmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByDueAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueAt', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByDueAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueAt', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByHasDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDueDate', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      thenByHasDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDueDate', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      thenByIsOverdueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOverdue', Sort.desc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy> thenByNotified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notified', Sort.asc);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QAfterSortBy>
      thenByNotifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notified', Sort.desc);
    });
  }
}

extension AssignmentLogQueryWhereDistinct
    on QueryBuilder<AssignmentLog, AssignmentLog, QDistinct> {
  QueryBuilder<AssignmentLog, AssignmentLog, QDistinct> distinctByAction() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'action');
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QDistinct> distinctByAssignmentId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignmentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QDistinct> distinctByDueAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueAt');
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QDistinct> distinctByHasDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasDueDate');
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QDistinct> distinctByIsOverdue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOverdue');
    });
  }

  QueryBuilder<AssignmentLog, AssignmentLog, QDistinct> distinctByNotified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notified');
    });
  }
}

extension AssignmentLogQueryProperty
    on QueryBuilder<AssignmentLog, AssignmentLog, QQueryProperty> {
  QueryBuilder<AssignmentLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AssignmentLog, AssignmentAction, QQueryOperations>
      actionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'action');
    });
  }

  QueryBuilder<AssignmentLog, String, QQueryOperations> assignmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignmentId');
    });
  }

  QueryBuilder<AssignmentLog, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AssignmentLog, DateTime?, QQueryOperations> dueAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueAt');
    });
  }

  QueryBuilder<AssignmentLog, bool, QQueryOperations> hasDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasDueDate');
    });
  }

  QueryBuilder<AssignmentLog, bool, QQueryOperations> isOverdueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOverdue');
    });
  }

  QueryBuilder<AssignmentLog, bool, QQueryOperations> notifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notified');
    });
  }
}
