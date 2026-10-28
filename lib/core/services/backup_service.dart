import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/models/user_profile_model.dart';
import 'package:nguliah/data/repositories/attendance_repository.dart';
import 'package:nguliah/data/repositories/event_repository.dart';
import 'package:nguliah/data/repositories/grade_repository.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/schedule_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/data/repositories/task_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Exception khusus saat berkas JSON backup rusak atau versi skema tidak cocok.
class BackupFormatException implements Exception {
  const BackupFormatException(this.message);
  final String message;

  @override
  String toString() => 'BackupFormatException: $message';
}

/// Paket seluruh data hasil validasi berkas JSON backup.
class BackupDataBundle {
  const BackupDataBundle({
    required this.schemaVersion,
    required this.createdAt,
    required this.profile,
    required this.settings,
    required this.grades,
    required this.schedules,
    required this.attendances,
    required this.tasks,
    required this.events,
  });

  final int schemaVersion;
  final DateTime createdAt;
  final UserProfile? profile;
  final AppSettings settings;
  final List<CourseGrade> grades;
  final List<CourseSchedule> schedules;
  final List<AttendanceRecord> attendances;
  final List<AcademicTask> tasks;
  final List<AcademicEvent> events;
}

/// Layanan Backup & Restore data lokal berformat JSON dengan versi skema.
class BackupService {
  const BackupService({
    required this.profileRepository,
    required this.settingsRepository,
    required this.gradeRepository,
    required this.scheduleRepository,
    required this.attendanceRepository,
    required this.taskRepository,
    required this.eventRepository,
  });

  static const int currentSchemaVersion = 1;

  final ProfileRepository profileRepository;
  final SettingsRepository settingsRepository;
  final GradeRepository gradeRepository;
  final ScheduleRepository scheduleRepository;
  final AttendanceRepository attendanceRepository;
  final TaskRepository taskRepository;
  final EventRepository eventRepository;

  static String encodeBundleToJson(BackupDataBundle bundle) {
    final map = <String, dynamic>{
      'app': 'Nguliah',
      'schemaVersion': bundle.schemaVersion,
      'createdAt': bundle.createdAt.toIso8601String(),
      'data': <String, dynamic>{
        'profile': bundle.profile?.toJson(),
        'settings': bundle.settings.toJson(),
        'grades': bundle.grades.map((e) => e.toJson()).toList(),
        'schedules': bundle.schedules.map((e) => e.toJson()).toList(),
        'attendances': bundle.attendances.map((e) => e.toJson()).toList(),
        'tasks': bundle.tasks.map((e) => e.toJson()).toList(),
        'events': bundle.events.map((e) => e.toJson()).toList(),
      },
    };
    return const JsonEncoder.withIndent('  ').convert(map);
  }

  /// Memvalidasi string JSON backup sebelum menimpa data lokal.
  static BackupDataBundle parseAndValidateJson(String rawJson) {
    final Object? decoded;
    try {
      decoded = jsonDecode(rawJson);
    } on FormatException catch (e) {
      throw BackupFormatException('Invalid JSON syntax: ${e.message}');
    }
    if (decoded is! Map<String, dynamic>) {
      throw const BackupFormatException('Root JSON must be an object.');
    }

    final schemaVersion = decoded['schemaVersion'];
    if (schemaVersion is! int || schemaVersion != currentSchemaVersion) {
      throw BackupFormatException(
        'Unsupported schemaVersion: $schemaVersion (expected $currentSchemaVersion).',
      );
    }

    final createdAtRaw = decoded['createdAt'];
    final createdAt = createdAtRaw is String
        ? DateTime.tryParse(createdAtRaw)
        : null;
    if (createdAt == null) {
      throw const BackupFormatException('Missing or invalid createdAt.');
    }

    final data = decoded['data'];
    if (data is! Map<String, dynamic>) {
      throw const BackupFormatException('Missing data object.');
    }

    try {
      final profileRaw = data['profile'];
      final profile = profileRaw is Map<String, dynamic>
          ? UserProfile.fromJson(profileRaw)
          : null;
      final settingsRaw = data['settings'];
      if (settingsRaw is! Map<String, dynamic>) {
        throw const BackupFormatException('Missing settings object.');
      }

      return BackupDataBundle(
        schemaVersion: schemaVersion,
        createdAt: createdAt,
        profile: profile,
        settings: AppSettings.fromJson(settingsRaw),
        grades: _requireList(
          data,
          'grades',
        ).map((e) => CourseGrade.fromJson(_requireMap(e, 'grades'))).toList(),
        schedules: _requireList(data, 'schedules')
            .map((e) => CourseSchedule.fromJson(_requireMap(e, 'schedules')))
            .toList(),
        attendances: _requireList(data, 'attendances')
            .map(
              (e) => AttendanceRecord.fromJson(_requireMap(e, 'attendances')),
            )
            .toList(),
        tasks: _requireList(
          data,
          'tasks',
        ).map((e) => AcademicTask.fromJson(_requireMap(e, 'tasks'))).toList(),
        events: _requireList(
          data,
          'events',
        ).map((e) => AcademicEvent.fromJson(_requireMap(e, 'events'))).toList(),
      );
    } on BackupFormatException {
      rethrow;
    } catch (e) {
      throw BackupFormatException('Invalid collection entry format: $e');
    }
  }

  static List<dynamic> _requireList(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is! List<dynamic>) {
      throw BackupFormatException('Collection "$key" must be a list.');
    }
    return value;
  }

  static Map<String, dynamic> _requireMap(Object? item, String collection) {
    if (item is! Map<String, dynamic>) {
      throw BackupFormatException(
        'Entry in "$collection" must be a JSON object.',
      );
    }
    return item;
  }

  Future<BackupDataBundle> collectCurrentData({DateTime? now}) async {
    return BackupDataBundle(
      schemaVersion: currentSchemaVersion,
      createdAt: now ?? DateTime.now(),
      profile: await profileRepository.getProfile(),
      settings: await settingsRepository.getSettings(),
      grades: await gradeRepository.getAllGrades(),
      schedules: await scheduleRepository.getAllSchedules(),
      attendances: await attendanceRepository.watchAllAttendance().first,
      tasks: await taskRepository.getAllTasks(),
      events: await eventRepository.getAllEvents(),
    );
  }

  Future<File> createAndShareBackupFile({bool shareFile = true}) async {
    final now = DateTime.now();
    final settings = await settingsRepository.getSettings();
    settings.lastBackupAt = now;
    await settingsRepository.saveSettings(settings);

    final bundle = await collectCurrentData(now: now);
    final dir = await getTemporaryDirectory();
    final stamp =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_'
        '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    final file = File('${dir.path}/nguliah_backup_$stamp.json');
    await file.writeAsString(encodeBundleToJson(bundle));

    if (shareFile) {
      await SharePlus.instance.share(
        ShareParams(files: <XFile>[XFile(file.path)]),
      );
    }
    return file;
  }

  Future<void> applyRestoreBundle(BackupDataBundle bundle) async {
    for (final g in await gradeRepository.getAllGrades()) {
      await gradeRepository.deleteGrade(g.id);
    }
    for (final s in await scheduleRepository.getAllSchedules()) {
      await scheduleRepository.deleteSchedule(s.id);
    }
    for (final a in await attendanceRepository.watchAllAttendance().first) {
      await attendanceRepository.deleteAttendance(a.id);
    }
    for (final t in await taskRepository.getAllTasks()) {
      await taskRepository.deleteTask(t.id);
    }
    for (final e in await eventRepository.getAllEvents()) {
      await eventRepository.deleteEvent(e.id);
    }

    if (bundle.profile != null) {
      await profileRepository.saveProfile(bundle.profile!);
    }
    await settingsRepository.saveSettings(bundle.settings);
    for (final g in bundle.grades) {
      await gradeRepository.saveGrade(g);
    }
    for (final s in bundle.schedules) {
      await scheduleRepository.saveSchedule(s);
    }
    for (final a in bundle.attendances) {
      await attendanceRepository.saveAttendance(a);
    }
    for (final t in bundle.tasks) {
      await taskRepository.saveTask(t);
    }
    for (final e in bundle.events) {
      await eventRepository.saveEvent(e);
    }
  }
}

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(
    profileRepository: ref.watch(profileRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
    gradeRepository: ref.watch(gradeRepositoryProvider),
    scheduleRepository: ref.watch(scheduleRepositoryProvider),
    attendanceRepository: ref.watch(attendanceRepositoryProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
    eventRepository: ref.watch(eventRepositoryProvider),
  );
});
