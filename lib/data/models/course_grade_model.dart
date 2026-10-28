import 'package:isar_community/isar.dart';

part 'course_grade_model.g.dart';

/// Model Isar untuk koleksi Nilai mata kuliah per semester.
@collection
class CourseGrade {
  CourseGrade({
    this.id = Isar.autoIncrement,
    required this.courseName,
    required this.semester,
    required this.sks,
    required this.gradeIndex,
    this.retakeOfId,
    required this.createdAt,
    required this.updatedAt,
  });

  Id id;

  @Index(type: IndexType.value, caseSensitive: false)
  late String courseName;

  @Index()
  late int semester;

  late int sks;

  /// Indeks nilai: A, AB, B, BC, C, D, E.
  late String gradeIndex;

  /// ID entri sebelumnya apabila entri ini adalah mengulang/perbaikan nilai.
  @Index()
  int? retakeOfId;

  late DateTime createdAt;
  late DateTime updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'courseName': courseName,
    'semester': semester,
    'sks': sks,
    'gradeIndex': gradeIndex,
    'retakeOfId': retakeOfId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory CourseGrade.fromJson(Map<String, dynamic> json) => CourseGrade(
    id: (json['id'] as num).toInt(),
    courseName: json['courseName'] as String,
    semester: (json['semester'] as num).toInt(),
    sks: (json['sks'] as num).toInt(),
    gradeIndex: json['gradeIndex'] as String,
    retakeOfId: (json['retakeOfId'] as num?)?.toInt(),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}
