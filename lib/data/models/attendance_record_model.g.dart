// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_record_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetAttendanceRecordCollection on Isar {
  IsarCollection<AttendanceRecord> get attendanceRecords => this.collection();
}

const AttendanceRecordSchema = CollectionSchema(
  name: r'AttendanceRecord',
  id: 3264724351450497341,
  properties: {
    r'courseName': PropertySchema(
      id: 0,
      name: r'courseName',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(id: 1, name: r'notes', type: IsarType.string),
    r'recordedAt': PropertySchema(
      id: 2,
      name: r'recordedAt',
      type: IsarType.dateTime,
    ),
    r'scheduleId': PropertySchema(
      id: 3,
      name: r'scheduleId',
      type: IsarType.long,
    ),
    r'sessionDate': PropertySchema(
      id: 4,
      name: r'sessionDate',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.string,
      enumMap: _AttendanceRecordstatusEnumValueMap,
    ),
  },

  estimateSize: _attendanceRecordEstimateSize,
  serialize: _attendanceRecordSerialize,
  deserialize: _attendanceRecordDeserialize,
  deserializeProp: _attendanceRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'scheduleId': IndexSchema(
      id: 1899306264659753312,
      name: r'scheduleId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'scheduleId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'sessionDate': IndexSchema(
      id: 2006552208572811236,
      name: r'sessionDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sessionDate',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _attendanceRecordGetId,
  getLinks: _attendanceRecordGetLinks,
  attach: _attendanceRecordAttach,
  version: '3.4.1',
);

int _attendanceRecordEstimateSize(
  AttendanceRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.courseName.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.status.name.length * 3;
  return bytesCount;
}

void _attendanceRecordSerialize(
  AttendanceRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.courseName);
  writer.writeString(offsets[1], object.notes);
  writer.writeDateTime(offsets[2], object.recordedAt);
  writer.writeLong(offsets[3], object.scheduleId);
  writer.writeDateTime(offsets[4], object.sessionDate);
  writer.writeString(offsets[5], object.status.name);
}

AttendanceRecord _attendanceRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AttendanceRecord(
    courseName: reader.readString(offsets[0]),
    id: id,
    notes: reader.readStringOrNull(offsets[1]) ?? '',
    recordedAt: reader.readDateTime(offsets[2]),
    scheduleId: reader.readLong(offsets[3]),
    sessionDate: reader.readDateTime(offsets[4]),
    status:
        _AttendanceRecordstatusValueEnumMap[reader.readStringOrNull(
          offsets[5],
        )] ??
        AttendanceStatus.present,
  );
  return object;
}

P _attendanceRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (_AttendanceRecordstatusValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              AttendanceStatus.present)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AttendanceRecordstatusEnumValueMap = {
  r'present': r'present',
  r'sick': r'sick',
  r'permission': r'permission',
  r'absent': r'absent',
  r'dispensation': r'dispensation',
};
const _AttendanceRecordstatusValueEnumMap = {
  r'present': AttendanceStatus.present,
  r'sick': AttendanceStatus.sick,
  r'permission': AttendanceStatus.permission,
  r'absent': AttendanceStatus.absent,
  r'dispensation': AttendanceStatus.dispensation,
};

Id _attendanceRecordGetId(AttendanceRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _attendanceRecordGetLinks(AttendanceRecord object) {
  return [];
}

void _attendanceRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  AttendanceRecord object,
) {
  object.id = id;
}

extension AttendanceRecordQueryWhereSort
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QWhere> {
  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhere>
  anyScheduleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'scheduleId'),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhere>
  anySessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sessionDate'),
      );
    });
  }
}

extension AttendanceRecordQueryWhere
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QWhereClause> {
  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  scheduleIdEqualTo(int scheduleId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'scheduleId', value: [scheduleId]),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  scheduleIdNotEqualTo(int scheduleId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'scheduleId',
                lower: [],
                upper: [scheduleId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'scheduleId',
                lower: [scheduleId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'scheduleId',
                lower: [scheduleId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'scheduleId',
                lower: [],
                upper: [scheduleId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  scheduleIdGreaterThan(int scheduleId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'scheduleId',
          lower: [scheduleId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  scheduleIdLessThan(int scheduleId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'scheduleId',
          lower: [],
          upper: [scheduleId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  scheduleIdBetween(
    int lowerScheduleId,
    int upperScheduleId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'scheduleId',
          lower: [lowerScheduleId],
          includeLower: includeLower,
          upper: [upperScheduleId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  sessionDateEqualTo(DateTime sessionDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'sessionDate',
          value: [sessionDate],
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  sessionDateNotEqualTo(DateTime sessionDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sessionDate',
                lower: [],
                upper: [sessionDate],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sessionDate',
                lower: [sessionDate],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sessionDate',
                lower: [sessionDate],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sessionDate',
                lower: [],
                upper: [sessionDate],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  sessionDateGreaterThan(DateTime sessionDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sessionDate',
          lower: [sessionDate],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  sessionDateLessThan(DateTime sessionDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sessionDate',
          lower: [],
          upper: [sessionDate],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterWhereClause>
  sessionDateBetween(
    DateTime lowerSessionDate,
    DateTime upperSessionDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sessionDate',
          lower: [lowerSessionDate],
          includeLower: includeLower,
          upper: [upperSessionDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AttendanceRecordQueryFilter
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QFilterCondition> {
  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'courseName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'courseName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'courseName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'courseName', value: ''),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  courseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'courseName', value: ''),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  recordedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recordedAt', value: value),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  recordedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'recordedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  recordedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'recordedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  recordedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'recordedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  scheduleIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduleId', value: value),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  scheduleIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduleId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  scheduleIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduleId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  scheduleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduleId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  sessionDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sessionDate', value: value),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  sessionDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sessionDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  sessionDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sessionDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  sessionDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sessionDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusEqualTo(AttendanceStatus value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusGreaterThan(
    AttendanceStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusLessThan(
    AttendanceStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusBetween(
    AttendanceStatus lower,
    AttendanceStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }
}

extension AttendanceRecordQueryObject
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QFilterCondition> {}

extension AttendanceRecordQueryLinks
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QFilterCondition> {}

extension AttendanceRecordQuerySortBy
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QSortBy> {
  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByCourseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByScheduleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleId', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByScheduleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleId', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortBySessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionDate', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortBySessionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionDate', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension AttendanceRecordQuerySortThenBy
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QSortThenBy> {
  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByCourseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByScheduleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleId', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByScheduleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleId', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenBySessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionDate', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenBySessionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionDate', Sort.desc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension AttendanceRecordQueryWhereDistinct
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QDistinct> {
  QueryBuilder<AttendanceRecord, AttendanceRecord, QDistinct>
  distinctByCourseName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'courseName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QDistinct> distinctByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QDistinct>
  distinctByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordedAt');
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QDistinct>
  distinctByScheduleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleId');
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QDistinct>
  distinctBySessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionDate');
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceRecord, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension AttendanceRecordQueryProperty
    on QueryBuilder<AttendanceRecord, AttendanceRecord, QQueryProperty> {
  QueryBuilder<AttendanceRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AttendanceRecord, String, QQueryOperations>
  courseNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'courseName');
    });
  }

  QueryBuilder<AttendanceRecord, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<AttendanceRecord, DateTime, QQueryOperations>
  recordedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordedAt');
    });
  }

  QueryBuilder<AttendanceRecord, int, QQueryOperations> scheduleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleId');
    });
  }

  QueryBuilder<AttendanceRecord, DateTime, QQueryOperations>
  sessionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionDate');
    });
  }

  QueryBuilder<AttendanceRecord, AttendanceStatus, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
