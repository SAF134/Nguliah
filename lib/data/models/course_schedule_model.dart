import 'package:isar_community/isar.dart';

part 'course_schedule_model.g.dart';

/// Model Isar untuk koleksi Jadwal kuliah mingguan.
@collection
class CourseSchedule {
  CourseSchedule({
    this.id = Isar.autoIncrement,
    required this.courseName,
    required this.dayOfWeek,
    required this.startTimeMinutes,
    required this.endTimeMinutes,
    required this.room,
    required this.createdAt,
    required this.updatedAt,
  });

  Id id;

  late String courseName;

  /// Hari kuliah: 1 (Senin) hingga 7 (Minggu).
  @Index()
  late int dayOfWeek;

  /// Waktu mulai dalam menit sejak pukul 00:00 (mis. 08:30 = 510).
  late int startTimeMinutes;

  /// Waktu selesai dalam menit sejak pukul 00:00 (wajib > startTimeMinutes).
  late int endTimeMinutes;

  late String room;
  late DateTime createdAt;
  late DateTime updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'courseName': courseName,
    'dayOfWeek': dayOfWeek,
    'startTimeMinutes': startTimeMinutes,
    'endTimeMinutes': endTimeMinutes,
    'room': room,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory CourseSchedule.fromJson(Map<String, dynamic> json) => CourseSchedule(
    id: (json['id'] as num).toInt(),
    courseName: json['courseName'] as String,
    dayOfWeek: (json['dayOfWeek'] as num).toInt(),
    startTimeMinutes: (json['startTimeMinutes'] as num).toInt(),
    endTimeMinutes: (json['endTimeMinutes'] as num).toInt(),
    room: json['room'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}
