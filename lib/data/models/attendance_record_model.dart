import 'package:isar_community/isar.dart';

part 'attendance_record_model.g.dart';

/// Status kehadiran kuliah sesuai PRD.md (termasuk Dispen yang dihitung hadir).
enum AttendanceStatus { present, sick, permission, absent, dispensation }

/// Model Isar untuk koleksi Presensi per sesi kuliah dan tanggal.
@collection
class AttendanceRecord {
  AttendanceRecord({
    this.id = Isar.autoIncrement,
    required this.scheduleId,
    required this.courseName,
    required this.sessionDate,
    required this.status,
    this.notes = '',
    required this.recordedAt,
  });

  Id id;

  @Index()
  late int scheduleId;

  late String courseName;

  /// Tanggal pertemuan (dinormalisasi ke 00:00 tanggal tersebut).
  @Index()
  late DateTime sessionDate;

  @Enumerated(EnumType.name)
  late AttendanceStatus status;

  late String notes;

  /// Waktu pengisian dicatat otomatis sesuai PRD.md.
  late DateTime recordedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'scheduleId': scheduleId,
    'courseName': courseName,
    'sessionDate': sessionDate.toIso8601String(),
    'status': status.name,
    'notes': notes,
    'recordedAt': recordedAt.toIso8601String(),
  };

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      AttendanceRecord(
        id: (json['id'] as num).toInt(),
        scheduleId: (json['scheduleId'] as num).toInt(),
        courseName: json['courseName'] as String,
        sessionDate: DateTime.parse(json['sessionDate'] as String),
        status: AttendanceStatus.values.byName(json['status'] as String),
        notes: (json['notes'] as String?) ?? '',
        recordedAt: DateTime.parse(json['recordedAt'] as String),
      );
}
