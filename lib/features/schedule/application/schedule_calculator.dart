import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';

/// Ringkasan rekap kehadiran untuk satu mata kuliah.
class CourseAttendanceSummary {
  const CourseAttendanceSummary({
    required this.courseName,
    required this.presentCount,
    this.dispensationCount = 0,
    required this.sickCount,
    required this.permissionCount,
    required this.absentCount,
    required this.records,
  });

  final String courseName;
  final int presentCount;
  final int dispensationCount;
  final int sickCount;
  final int permissionCount;
  final int absentCount;
  final List<AttendanceRecord> records;

  int get effectivePresentCount => presentCount + dispensationCount;

  int get totalSessions =>
      presentCount +
      dispensationCount +
      sickCount +
      permissionCount +
      absentCount;

  double get presentPercentage => totalSessions == 0
      ? 0.0
      : (effectivePresentCount / totalSessions) * 100.0;

  String get formattedPercentage => presentPercentage.toStringAsFixed(0);
}

/// Utilitas murni untuk perhitungan jadwal, deteksi bentrok, dan rekap presensi.
abstract final class ScheduleCalculator {
  /// Mengonversi menit sejak 00:00 menjadi string "JJ:MM" (mis. 510 -> "08:30").
  static String formatTimeMinutes(int minutes) {
    final clamped = minutes.clamp(0, 24 * 60 - 1);
    final h = (clamped ~/ 60).toString().padLeft(2, '0');
    final m = (clamped % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  /// Mengonversi rentang waktu mulai dan selesai menjadi "JJ:MM – JJ:MM".
  static String formatTimeRange(int startMinutes, int endMinutes) {
    return '${formatTimeMinutes(startMinutes)} – ${formatTimeMinutes(endMinutes)}';
  }

  /// Mem-parse string "JJ:MM" menjadi menit sejak 00:00, atau null jika tidak valid.
  static int? parseTimeMinutes(String input) {
    final trimmed = input.trim();
    final parts = trimmed.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
    return hour * 60 + minute;
  }

  /// Menormalisasi tanggal ke pukul 00:00:00 untuk kunci presensi per sesi per tanggal.
  static DateTime normalizeSessionDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Mencari jadwal lain pada hari yang sama yang beririsan waktu (bentrok).
  static List<CourseSchedule> findConflictingSchedules(
    Iterable<CourseSchedule> existingSchedules, {
    required int dayOfWeek,
    required int startTimeMinutes,
    required int endTimeMinutes,
    int? excludeId,
  }) {
    if (endTimeMinutes <= startTimeMinutes) {
      return const <CourseSchedule>[];
    }

    return existingSchedules.where((item) {
      if (excludeId != null && item.id == excludeId) return false;
      if (item.dayOfWeek != dayOfWeek) return false;
      return item.startTimeMinutes < endTimeMinutes &&
          item.endTimeMinutes > startTimeMinutes;
    }).toList();
  }

  /// Mencari catatan presensi yang sudah ada untuk jadwal & tanggal pertemuan tertentu.
  static AttendanceRecord? findSessionAttendance(
    Iterable<AttendanceRecord> records, {
    required int scheduleId,
    required DateTime sessionDate,
  }) {
    final targetDate = normalizeSessionDate(sessionDate);
    for (final record in records) {
      if (record.scheduleId == scheduleId &&
          normalizeSessionDate(record.sessionDate) == targetDate) {
        return record;
      }
    }
    return null;
  }

  /// Menghitung rekap kehadiran per mata kuliah dari daftar jadwal dan catatan presensi.
  static List<CourseAttendanceSummary> buildAttendanceRecap(
    Iterable<CourseSchedule> schedules,
    Iterable<AttendanceRecord> records,
  ) {
    final courseNames = <String>{
      ...schedules.map((s) => s.courseName.trim()),
      ...records.map((r) => r.courseName.trim()),
    }..removeWhere((name) => name.isEmpty);

    final sortedNames = courseNames.toList()..sort();
    final summaries = <CourseAttendanceSummary>[];

    for (final name in sortedNames) {
      final courseRecords =
          records
              .where(
                (r) => r.courseName.trim().toLowerCase() == name.toLowerCase(),
              )
              .toList()
            ..sort((a, b) => b.sessionDate.compareTo(a.sessionDate));

      var present = 0;
      var dispensation = 0;
      var sick = 0;
      var permission = 0;
      var absent = 0;

      for (final rec in courseRecords) {
        switch (rec.status) {
          case AttendanceStatus.present:
            present++;
          case AttendanceStatus.dispensation:
            dispensation++;
          case AttendanceStatus.sick:
            sick++;
          case AttendanceStatus.permission:
            permission++;
          case AttendanceStatus.absent:
            absent++;
        }
      }

      summaries.add(
        CourseAttendanceSummary(
          courseName: name,
          presentCount: present,
          dispensationCount: dispensation,
          sickCount: sick,
          permissionCount: permission,
          absentCount: absent,
          records: courseRecords,
        ),
      );
    }

    return summaries;
  }

  /// Memeriksa apakah saat ini berada di dalam jam kegiatan belajar mengajar (KBM).
  static bool isCurrentlyInClass(CourseSchedule schedule, {DateTime? now}) {
    final current = now ?? DateTime.now();
    if (schedule.dayOfWeek != current.weekday) return false;
    final currentMinutes = current.hour * 60 + current.minute;
    return currentMinutes >= schedule.startTimeMinutes &&
        currentMinutes <= schedule.endTimeMinutes;
  }
}
