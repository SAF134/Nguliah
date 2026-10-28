import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/data/database/isar_service.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';

/// Repository akses data lokal untuk koleksi Jadwal kuliah.
class ScheduleRepository {
  const ScheduleRepository(this._isar);

  final Isar _isar;

  Future<List<CourseSchedule>> getAllSchedules() {
    return _isar.courseSchedules
        .where()
        .sortByDayOfWeek()
        .thenByStartTimeMinutes()
        .findAll();
  }

  Stream<List<CourseSchedule>> watchAllSchedules() {
    return _isar.courseSchedules
        .where()
        .sortByDayOfWeek()
        .thenByStartTimeMinutes()
        .watch(fireImmediately: true);
  }

  Future<Id> saveSchedule(CourseSchedule schedule) {
    schedule.updatedAt = DateTime.now();
    return _isar.writeTxn(() => _isar.courseSchedules.put(schedule));
  }

  Future<bool> deleteSchedule(Id id) {
    return _isar.writeTxn(() => _isar.courseSchedules.delete(id));
  }
}

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepository(ref.watch(isarProvider));
});
