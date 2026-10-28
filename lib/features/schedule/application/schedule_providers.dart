import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/repositories/attendance_repository.dart';
import 'package:nguliah/data/repositories/schedule_repository.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';

/// Notifier untuk filter hari kuliah terpilih pada layar Jadwal (null = Semua Hari).
class SelectedDayNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void select(int? dayOfWeek) {
    state = dayOfWeek;
  }
}

final selectedScheduleDayProvider = NotifierProvider<SelectedDayNotifier, int?>(
  SelectedDayNotifier.new,
);

/// Stream seluruh jadwal kuliah terurut per hari & jam mulai.
final allSchedulesStreamProvider = StreamProvider<List<CourseSchedule>>((ref) {
  return ref.watch(scheduleRepositoryProvider).watchAllSchedules();
});

/// Stream seluruh catatan presensi kuliah.
final allAttendanceStreamProvider = StreamProvider<List<AttendanceRecord>>((
  ref,
) {
  return ref.watch(attendanceRepositoryProvider).watchAllAttendance();
});

/// Provider rekap kehadiran per mata kuliah secara real-time.
final courseAttendanceRecapProvider = Provider<List<CourseAttendanceSummary>>((
  ref,
) {
  final schedules =
      ref.watch(allSchedulesStreamProvider).value ?? const <CourseSchedule>[];
  final records =
      ref.watch(allAttendanceStreamProvider).value ??
      const <AttendanceRecord>[];
  return ScheduleCalculator.buildAttendanceRecap(schedules, records);
});
