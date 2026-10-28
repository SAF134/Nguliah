import 'package:isar_community/isar.dart';

part 'academic_task_model.g.dart';

/// Model Isar untuk koleksi Tugas kuliah dan tenggatnya.
@collection
class AcademicTask {
  AcademicTask({
    this.id = Isar.autoIncrement,
    required this.courseName,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Id id;

  late String courseName;
  late String description;

  @Index()
  late DateTime dueDate;

  @Index()
  late bool isCompleted;

  DateTime? completedAt;
  late DateTime createdAt;
  late DateTime updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'courseName': courseName,
    'description': description,
    'dueDate': dueDate.toIso8601String(),
    'isCompleted': isCompleted,
    'completedAt': completedAt?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory AcademicTask.fromJson(Map<String, dynamic> json) => AcademicTask(
    id: (json['id'] as num).toInt(),
    courseName: json['courseName'] as String,
    description: json['description'] as String,
    dueDate: DateTime.parse(json['dueDate'] as String),
    isCompleted: (json['isCompleted'] as bool?) ?? false,
    completedAt: json['completedAt'] != null
        ? DateTime.parse(json['completedAt'] as String)
        : null,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}
