import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/models/user_profile_model.dart';
import 'package:path_provider/path_provider.dart';

/// Versi skema database & backup JSON saat ini (Aturan Wajib #4 & #8).
const int kDatabaseSchemaVersion = 1;

/// Layanan pembuka dan penyedia instance Isar lokal.
abstract final class IsarService {
  static Future<Isar> open() async {
    final existing = Isar.getInstance();
    if (existing != null && existing.isOpen) {
      return existing;
    }

    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(<CollectionSchema<dynamic>>[
      UserProfileSchema,
      CourseGradeSchema,
      CourseScheduleSchema,
      AttendanceRecordSchema,
      AcademicTaskSchema,
      AcademicEventSchema,
      AppSettingsSchema,
    ], directory: dir.path);
  }
}

/// Provider utama untuk instance Isar (di-override saat inisialisasi atau test).
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
    'isarProvider wajib diinisialisasi sebelum dipakai.',
  );
});
