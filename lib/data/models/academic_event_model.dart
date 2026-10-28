import 'package:isar_community/isar.dart';

part 'academic_event_model.g.dart';

/// Model Isar untuk koleksi Acara kampus/non-kuliah.
@collection
class AcademicEvent {
  AcademicEvent({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.description,
    this.location = '',
    this.isCompleted = false,
    required this.eventDate,
    required this.startTimeMinutes,
    required this.endTimeMinutes,
    required this.createdAt,
    required this.updatedAt,
  });

  Id id;

  late String name;
  late String description;
  late String location;
  late bool isCompleted;

  @Index()
  late DateTime eventDate;

  late int startTimeMinutes;
  late int endTimeMinutes;
  late DateTime createdAt;
  late DateTime updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'description': description,
    'location': location,
    'isCompleted': isCompleted,
    'eventDate': eventDate.toIso8601String(),
    'startTimeMinutes': startTimeMinutes,
    'endTimeMinutes': endTimeMinutes,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory AcademicEvent.fromJson(Map<String, dynamic> json) => AcademicEvent(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String,
    description: json['description'] as String,
    location: (json['location'] as String?) ?? '',
    isCompleted: (json['isCompleted'] as bool?) ?? false,
    eventDate: DateTime.parse(json['eventDate'] as String),
    startTimeMinutes: (json['startTimeMinutes'] as num).toInt(),
    endTimeMinutes: (json['endTimeMinutes'] as num).toInt(),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}
