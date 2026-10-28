import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/data/database/isar_service.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';

/// Repository akses data lokal untuk koleksi Presensi kuliah.
class AttendanceRepository {
  const AttendanceRepository(this._isar);

  final Isar _isar;

  Future<List<AttendanceRecord>> getByScheduleId(int scheduleId) {
    return _isar.attendanceRecords
        .where()
        .scheduleIdEqualTo(scheduleId)
        .sortBySessionDateDesc()
        .findAll();
  }

  Stream<List<AttendanceRecord>> watchAllAttendance() {
    return _isar.attendanceRecords.where().sortBySessionDateDesc().watch(
      fireImmediately: true,
    );
  }

  Future<Id> saveAttendance(AttendanceRecord record) {
    return _isar.writeTxn(() => _isar.attendanceRecords.put(record));
  }

  Future<bool> deleteAttendance(Id id) {
    return _isar.writeTxn(() => _isar.attendanceRecords.delete(id));
  }
}

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository(ref.watch(isarProvider));
});
