// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_grade_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetCourseGradeCollection on Isar {
  IsarCollection<CourseGrade> get courseGrades => this.collection();
}

const CourseGradeSchema = CollectionSchema(
  name: r'CourseGrade',
  id: -7371834491385575366,
  properties: {
    r'courseName': PropertySchema(
      id: 0,
      name: r'courseName',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'gradeIndex': PropertySchema(
      id: 2,
      name: r'gradeIndex',
      type: IsarType.string,
    ),
    r'retakeOfId': PropertySchema(
      id: 3,
      name: r'retakeOfId',
      type: IsarType.long,
    ),
    r'semester': PropertySchema(id: 4, name: r'semester', type: IsarType.long),
    r'sks': PropertySchema(id: 5, name: r'sks', type: IsarType.long),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _courseGradeEstimateSize,
  serialize: _courseGradeSerialize,
  deserialize: _courseGradeDeserialize,
  deserializeProp: _courseGradeDeserializeProp,
  idName: r'id',
  indexes: {
    r'courseName': IndexSchema(
      id: -1503113066792696319,
      name: r'courseName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'courseName',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'semester': IndexSchema(
      id: 2655078537473598341,
      name: r'semester',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'semester',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'retakeOfId': IndexSchema(
      id: 7579221421106566492,
      name: r'retakeOfId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'retakeOfId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _courseGradeGetId,
  getLinks: _courseGradeGetLinks,
  attach: _courseGradeAttach,
  version: '3.4.1',
);

int _courseGradeEstimateSize(
  CourseGrade object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.courseName.length * 3;
  bytesCount += 3 + object.gradeIndex.length * 3;
  return bytesCount;
}

void _courseGradeSerialize(
  CourseGrade object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.courseName);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.gradeIndex);
  writer.writeLong(offsets[3], object.retakeOfId);
  writer.writeLong(offsets[4], object.semester);
  writer.writeLong(offsets[5], object.sks);
  writer.writeDateTime(offsets[6], object.updatedAt);
}

CourseGrade _courseGradeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CourseGrade(
    courseName: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    gradeIndex: reader.readString(offsets[2]),
    id: id,
    retakeOfId: reader.readLongOrNull(offsets[3]),
    semester: reader.readLong(offsets[4]),
    sks: reader.readLong(offsets[5]),
    updatedAt: reader.readDateTime(offsets[6]),
  );
  return object;
}

P _courseGradeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _courseGradeGetId(CourseGrade object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _courseGradeGetLinks(CourseGrade object) {
  return [];
}

void _courseGradeAttach(
  IsarCollection<dynamic> col,
  Id id,
  CourseGrade object,
) {
  object.id = id;
}

extension CourseGradeQueryWhereSort
    on QueryBuilder<CourseGrade, CourseGrade, QWhere> {
  QueryBuilder<CourseGrade, CourseGrade, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhere> anyCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'courseName'),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhere> anySemester() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'semester'),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhere> anyRetakeOfId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'retakeOfId'),
      );
    });
  }
}

extension CourseGradeQueryWhere
    on QueryBuilder<CourseGrade, CourseGrade, QWhereClause> {
  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> idBetween(
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> courseNameEqualTo(
    String courseName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'courseName', value: [courseName]),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause>
  courseNameNotEqualTo(String courseName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'courseName',
                lower: [],
                upper: [courseName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'courseName',
                lower: [courseName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'courseName',
                lower: [courseName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'courseName',
                lower: [],
                upper: [courseName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause>
  courseNameGreaterThan(String courseName, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'courseName',
          lower: [courseName],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> courseNameLessThan(
    String courseName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'courseName',
          lower: [],
          upper: [courseName],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> courseNameBetween(
    String lowerCourseName,
    String upperCourseName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'courseName',
          lower: [lowerCourseName],
          includeLower: includeLower,
          upper: [upperCourseName],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause>
  courseNameStartsWith(String CourseNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'courseName',
          lower: [CourseNamePrefix],
          upper: ['$CourseNamePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause>
  courseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'courseName', value: ['']),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause>
  courseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'courseName', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'courseName',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'courseName',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'courseName', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> semesterEqualTo(
    int semester,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'semester', value: [semester]),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> semesterNotEqualTo(
    int semester,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'semester',
                lower: [],
                upper: [semester],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'semester',
                lower: [semester],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'semester',
                lower: [semester],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'semester',
                lower: [],
                upper: [semester],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> semesterGreaterThan(
    int semester, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'semester',
          lower: [semester],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> semesterLessThan(
    int semester, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'semester',
          lower: [],
          upper: [semester],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> semesterBetween(
    int lowerSemester,
    int upperSemester, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'semester',
          lower: [lowerSemester],
          includeLower: includeLower,
          upper: [upperSemester],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> retakeOfIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'retakeOfId', value: [null]),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause>
  retakeOfIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'retakeOfId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> retakeOfIdEqualTo(
    int? retakeOfId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'retakeOfId', value: [retakeOfId]),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause>
  retakeOfIdNotEqualTo(int? retakeOfId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'retakeOfId',
                lower: [],
                upper: [retakeOfId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'retakeOfId',
                lower: [retakeOfId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'retakeOfId',
                lower: [retakeOfId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'retakeOfId',
                lower: [],
                upper: [retakeOfId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause>
  retakeOfIdGreaterThan(int? retakeOfId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'retakeOfId',
          lower: [retakeOfId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> retakeOfIdLessThan(
    int? retakeOfId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'retakeOfId',
          lower: [],
          upper: [retakeOfId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterWhereClause> retakeOfIdBetween(
    int? lowerRetakeOfId,
    int? upperRetakeOfId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'retakeOfId',
          lower: [lowerRetakeOfId],
          includeLower: includeLower,
          upper: [upperRetakeOfId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CourseGradeQueryFilter
    on QueryBuilder<CourseGrade, CourseGrade, QFilterCondition> {
  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  courseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'courseName', value: ''),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  courseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'courseName', value: ''),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'gradeIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gradeIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gradeIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gradeIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'gradeIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'gradeIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'gradeIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'gradeIndex',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'gradeIndex', value: ''),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  gradeIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'gradeIndex', value: ''),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  retakeOfIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'retakeOfId'),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  retakeOfIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'retakeOfId'),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  retakeOfIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'retakeOfId', value: value),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  retakeOfIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'retakeOfId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  retakeOfIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'retakeOfId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  retakeOfIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'retakeOfId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> semesterEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'semester', value: value),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  semesterGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'semester',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  semesterLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'semester',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> semesterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'semester',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> sksEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sks', value: value),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> sksGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sks',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> sksLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sks',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition> sksBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sks',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterFilterCondition>
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CourseGradeQueryObject
    on QueryBuilder<CourseGrade, CourseGrade, QFilterCondition> {}

extension CourseGradeQueryLinks
    on QueryBuilder<CourseGrade, CourseGrade, QFilterCondition> {}

extension CourseGradeQuerySortBy
    on QueryBuilder<CourseGrade, CourseGrade, QSortBy> {
  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByCourseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByGradeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeIndex', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByGradeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeIndex', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByRetakeOfId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retakeOfId', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByRetakeOfIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retakeOfId', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortBySemester() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semester', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortBySemesterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semester', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortBySks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sks', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortBySksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sks', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CourseGradeQuerySortThenBy
    on QueryBuilder<CourseGrade, CourseGrade, QSortThenBy> {
  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByCourseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByCourseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'courseName', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByGradeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeIndex', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByGradeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeIndex', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByRetakeOfId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retakeOfId', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByRetakeOfIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retakeOfId', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenBySemester() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semester', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenBySemesterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semester', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenBySks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sks', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenBySksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sks', Sort.desc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CourseGradeQueryWhereDistinct
    on QueryBuilder<CourseGrade, CourseGrade, QDistinct> {
  QueryBuilder<CourseGrade, CourseGrade, QDistinct> distinctByCourseName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'courseName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QDistinct> distinctByGradeIndex({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gradeIndex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QDistinct> distinctByRetakeOfId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'retakeOfId');
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QDistinct> distinctBySemester() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'semester');
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QDistinct> distinctBySks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sks');
    });
  }

  QueryBuilder<CourseGrade, CourseGrade, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CourseGradeQueryProperty
    on QueryBuilder<CourseGrade, CourseGrade, QQueryProperty> {
  QueryBuilder<CourseGrade, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CourseGrade, String, QQueryOperations> courseNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'courseName');
    });
  }

  QueryBuilder<CourseGrade, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CourseGrade, String, QQueryOperations> gradeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gradeIndex');
    });
  }

  QueryBuilder<CourseGrade, int?, QQueryOperations> retakeOfIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'retakeOfId');
    });
  }

  QueryBuilder<CourseGrade, int, QQueryOperations> semesterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'semester');
    });
  }

  QueryBuilder<CourseGrade, int, QQueryOperations> sksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sks');
    });
  }

  QueryBuilder<CourseGrade, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
