import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nguliah/core/services/backup_service.dart';
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
import 'package:nguliah/main.dart';

class _InMemorySettingsRepo implements SettingsRepository {
  AppSettings _current = AppSettings();
  final _ctrl = StreamController<AppSettings?>.broadcast();

  @override
  Future<AppSettings> getSettings() async => _current;

  @override
  Stream<AppSettings?> watchSettings() async* {
    yield _current;
    yield* _ctrl.stream;
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    _current = settings;
    _ctrl.add(_current);
  }
}

class _InMemoryProfileRepo implements ProfileRepository {
  UserProfile? _current;
  final _ctrl = StreamController<UserProfile?>.broadcast();

  @override
  Future<UserProfile?> getProfile() async => _current;

  @override
  Stream<UserProfile?> watchProfile() async* {
    yield _current;
    yield* _ctrl.stream;
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    _current = profile;
    _ctrl.add(_current);
  }
}

class _InMemoryGradeRepo implements GradeRepository {
  final List<CourseGrade> _items = <CourseGrade>[];
  final _ctrl = StreamController<List<CourseGrade>>.broadcast();
  int _nextId = 1;

  @override
  Future<List<CourseGrade>> getAllGrades() async =>
      List<CourseGrade>.from(_items);

  @override
  Stream<List<CourseGrade>> watchAllGrades() async* {
    yield List<CourseGrade>.from(_items);
    yield* _ctrl.stream;
  }

  @override
  Future<int> saveGrade(CourseGrade grade) async {
    if (grade.id <= 0) grade.id = _nextId++;
    _items.removeWhere((g) => g.id == grade.id);
    _items.add(grade);
    _ctrl.add(List<CourseGrade>.from(_items));
    return grade.id;
  }

  @override
  Future<bool> deleteGrade(int id) async {
    _items.removeWhere((g) => g.id == id);
    _ctrl.add(List<CourseGrade>.from(_items));
    return true;
  }
}

class _InMemoryScheduleRepo implements ScheduleRepository {
  final List<CourseSchedule> _items = <CourseSchedule>[];
  final _ctrl = StreamController<List<CourseSchedule>>.broadcast();
  int _nextId = 1;

  @override
  Future<List<CourseSchedule>> getAllSchedules() async =>
      List<CourseSchedule>.from(_items);

  @override
  Stream<List<CourseSchedule>> watchAllSchedules() async* {
    yield List<CourseSchedule>.from(_items);
    yield* _ctrl.stream;
  }

  @override
  Future<int> saveSchedule(CourseSchedule schedule) async {
    if (schedule.id <= 0) schedule.id = _nextId++;
    _items.removeWhere((s) => s.id == schedule.id);
    _items.add(schedule);
    _ctrl.add(List<CourseSchedule>.from(_items));
    return schedule.id;
  }

  @override
  Future<bool> deleteSchedule(int id) async {
    _items.removeWhere((s) => s.id == id);
    _ctrl.add(List<CourseSchedule>.from(_items));
    return true;
  }
}

class _InMemoryAttendanceRepo implements AttendanceRepository {
  final List<AttendanceRecord> _items = <AttendanceRecord>[];
  final _ctrl = StreamController<List<AttendanceRecord>>.broadcast();
  int _nextId = 1;

  @override
  Future<List<AttendanceRecord>> getByScheduleId(int scheduleId) async =>
      _items.where((r) => r.scheduleId == scheduleId).toList();

  @override
  Stream<List<AttendanceRecord>> watchAllAttendance() async* {
    yield List<AttendanceRecord>.from(_items);
    yield* _ctrl.stream;
  }

  @override
  Future<int> saveAttendance(AttendanceRecord record) async {
    if (record.id <= 0) record.id = _nextId++;
    _items.removeWhere((r) => r.id == record.id);
    _items.add(record);
    _ctrl.add(List<AttendanceRecord>.from(_items));
    return record.id;
  }

  @override
  Future<bool> deleteAttendance(int id) async {
    _items.removeWhere((r) => r.id == id);
    _ctrl.add(List<AttendanceRecord>.from(_items));
    return true;
  }
}

class _InMemoryTaskRepo implements TaskRepository {
  final List<AcademicTask> _items = <AcademicTask>[];
  final _ctrl = StreamController<List<AcademicTask>>.broadcast();
  int _nextId = 1;

  @override
  Future<List<AcademicTask>> getAllTasks() async =>
      List<AcademicTask>.from(_items);

  @override
  Stream<List<AcademicTask>> watchAllTasks() async* {
    yield List<AcademicTask>.from(_items);
    yield* _ctrl.stream;
  }

  @override
  Future<int> saveTask(AcademicTask task) async {
    if (task.id <= 0) task.id = _nextId++;
    _items.removeWhere((t) => t.id == task.id);
    _items.add(task);
    _ctrl.add(List<AcademicTask>.from(_items));
    return task.id;
  }

  @override
  Future<bool> deleteTask(int id) async {
    _items.removeWhere((t) => t.id == id);
    _ctrl.add(List<AcademicTask>.from(_items));
    return true;
  }
}

class _InMemoryEventRepo implements EventRepository {
  final List<AcademicEvent> _items = <AcademicEvent>[];
  final _ctrl = StreamController<List<AcademicEvent>>.broadcast();
  int _nextId = 1;

  @override
  Future<List<AcademicEvent>> getAllEvents() async =>
      List<AcademicEvent>.from(_items);

  @override
  Stream<List<AcademicEvent>> watchAllEvents() async* {
    yield List<AcademicEvent>.from(_items);
    yield* _ctrl.stream;
  }

  @override
  Future<int> saveEvent(AcademicEvent event) async {
    if (event.id <= 0) event.id = _nextId++;
    _items.removeWhere((e) => e.id == event.id);
    _items.add(event);
    _ctrl.add(List<AcademicEvent>.from(_items));
    return event.id;
  }

  @override
  Future<bool> deleteEvent(int id) async {
    _items.removeWhere((e) => e.id == id);
    _ctrl.add(List<AcademicEvent>.from(_items));
    return true;
  }
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id', null);
    await initializeDateFormatting('en', null);
  });

  testWidgets(
    'E2E Full Journey: Splash -> Onboarding -> Masuk -> Beranda -> Nilai (E & Mengulang) -> Jadwal & Presensi -> Tugas -> Acara -> Pengaturan (Bahasa & Backup)',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(412, 915));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final settingsRepo = _InMemorySettingsRepo();
      final profileRepo = _InMemoryProfileRepo();
      final gradeRepo = _InMemoryGradeRepo();
      final scheduleRepo = _InMemoryScheduleRepo();
      final attendanceRepo = _InMemoryAttendanceRepo();
      final taskRepo = _InMemoryTaskRepo();
      final eventRepo = _InMemoryEventRepo();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsRepositoryProvider.overrideWithValue(settingsRepo),
            profileRepositoryProvider.overrideWithValue(profileRepo),
            gradeRepositoryProvider.overrideWithValue(gradeRepo),
            scheduleRepositoryProvider.overrideWithValue(scheduleRepo),
            attendanceRepositoryProvider.overrideWithValue(attendanceRepo),
            taskRepositoryProvider.overrideWithValue(taskRepo),
            eventRepositoryProvider.overrideWithValue(eventRepo),
          ],
          child: const NguliahApp(),
        ),
      );

      // 1. Splash -> Onboarding -> Masuk
      expect(find.text('Memuat data akademik...'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(find.text('Pantau Nilai & IPK'), findsOneWidget);
      await tester.tap(find.text('Lanjut'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lanjut'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lanjut'));
      await tester.pumpAndSettle();
      expect(find.text('Mulai Sekarang'), findsOneWidget);
      await tester.tap(find.text('Mulai Sekarang'));
      await tester.pumpAndSettle();

      // 2. Isi Biodata di Layar Masuk
      expect(find.text('Profil Mahasiswa'), findsOneWidget);
      final authFields = find.byType(TextField);
      await tester.enterText(authFields.at(0), 'Rani Putri');
      await tester.enterText(authFields.at(1), 'Universitas Indonesia');
      await tester.enterText(authFields.at(2), 'Fakultas Ilmu Komputer');
      await tester.enterText(authFields.at(3), 'Sistem Informasi');
      await tester.enterText(authFields.at(4), '2026');

      await tester.ensureVisible(find.text('Simpan & Mulai'));
      await tester.tap(find.text('Simpan & Mulai'));
      await tester.pumpAndSettle();

      // 3. Beranda kosong tampil -> navigasi ke Nilai via tombol Tambah Nilai Pertama
      expect(find.text('Rani Putri'), findsOneWidget);
      expect(find.text('Belum ada data akademik'), findsOneWidget);
      await tester.tap(find.text('Tambah Nilai Pertama'));
      await tester.pumpAndSettle();

      // 4. Layar Nilai: tambah MK nilai E di Semester 1, lalu Ulang di Semester 2 dapat A
      expect(find.text('Belum ada catatan nilai'), findsOneWidget);
      await tester.tap(find.text('Tambah Nilai Pertama'));
      await tester.pumpAndSettle();

      final gradeFields = find.byType(TextField);
      await tester.enterText(gradeFields.at(0), 'Statistika Dasar');
      await tester.enterText(gradeFields.at(1), '1');
      await tester.enterText(gradeFields.at(2), '3');
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('E').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('E · Perlu mengulang'), findsOneWidget);
      expect(find.text('0.00'), findsOneWidget);

      // Ketuk tombol Ulang pada kartu nilai E -> otomatis menautkan Mengulang dari Sem 1
      await tester.ensureVisible(find.text('Ulang'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Ulang'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      // IPK naik menjadi 4.00, SKS Selesai = 3, MK Selesai = 1
      expect(find.text('4.00'), findsOneWidget);
      expect(find.text('Perbaikan'), findsOneWidget);
      expect(find.text('Mengulang dari Sem 1 (E)'), findsOneWidget);

      // 5. Pindah ke tab Jadwal via BottomNavPill -> tambah jadwal & isi presensi
      await tester.tap(find.text('Jadwal'));
      await tester.pumpAndSettle();
      expect(find.text('Tambah Jadwal'), findsOneWidget);

      await tester.tap(find.text('Tambah Jadwal'));
      await tester.pumpAndSettle();
      final scheduleFields = find.byType(TextField);
      await tester.enterText(scheduleFields.at(0), 'Algoritma & Pemrograman');
      await tester.enterText(scheduleFields.at(1), 'Gedung A R.302');
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Algoritma & Pemrograman'), findsOneWidget);
      await tester.ensureVisible(find.text('Isi Presensi'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Isi Presensi'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Rekap Presensi'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rekap Presensi'));
      await tester.pumpAndSettle();
      expect(find.text('1 Hadir dari 1 sesi (100%)'), findsOneWidget);
      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();

      // 6. Pindah ke tab Tugas via BottomNavPill -> tambah tugas & tandai selesai
      await tester.tap(find.text('Tugas'));
      await tester.pumpAndSettle();
      expect(find.text('Tambah Tugas').first, findsOneWidget);

      await tester.tap(find.text('Tambah Tugas').first);
      await tester.pumpAndSettle();
      final taskFields = find.byType(TextField);
      await tester.enterText(taskFields.at(0), 'Algoritma & Pemrograman');
      await tester.enterText(taskFields.at(1), 'Laporan Praktikum Modul 1');
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Laporan Praktikum Modul 1'), findsOneWidget);
      await tester.ensureVisible(find.byTooltip('Tandai tugas selesai'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Tandai tugas selesai'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Iya'));
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('Selesai (Rekap)'));
      await tester.pumpAndSettle();
      expect(find.text('Laporan Praktikum Modul 1'), findsOneWidget);

      // 7. Pindah ke tab Acara via BottomNavPill -> tambah acara kampus
      await tester.tap(find.text('Acara'));
      await tester.pumpAndSettle();
      expect(find.text('Tambah Acara').first, findsOneWidget);

      await tester.tap(find.text('Tambah Acara').first);
      await tester.pumpAndSettle();
      final eventFields = find.byType(TextField);
      await tester.enterText(eventFields.at(0), 'Rapat Himpunan');
      await tester.enterText(eventFields.at(1), 'Ruang Himpunan Lt. 2');
      await tester.enterText(eventFields.at(2), 'Koordinasi Kegiatan Semester');
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Rapat Himpunan'), findsOneWidget);

      // 8. Kembali ke Beranda -> verifikasi statistik real-time & buka Pengaturan
      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();
      expect(find.text('4.00'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Tren IPS per Semester'), 200);
      expect(find.text('Tren IPS per Semester'), findsOneWidget);

      await tester.tap(find.byTooltip('Buka Pengaturan Profil dan Aplikasi'));
      await tester.pumpAndSettle();
      expect(find.text('Pengaturan'), findsOneWidget);

      // Ubah bahasa ke Inggris (EN) -> langsung berubah tanpa restart
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('App Language'), findsOneWidget);
      expect(find.text('Grade Conversion'), findsOneWidget);

      // Kembalikan ke Indonesia
      await tester.tap(find.text('Indonesia'));
      await tester.pumpAndSettle();
      expect(find.text('Pengaturan'), findsOneWidget);
      expect(find.text('Bahasa Aplikasi'), findsOneWidget);

      // 9. Verifikasi integritas Backup & Restore JSON untuk seluruh data E2E
      final profile = await profileRepo.getProfile();
      final settings = await settingsRepo.getSettings();
      final grades = await gradeRepo.getAllGrades();
      final schedules = await scheduleRepo.getAllSchedules();
      final attendances = await attendanceRepo.watchAllAttendance().first;
      final tasks = await taskRepo.getAllTasks();
      final events = await eventRepo.getAllEvents();
      expect(grades.length, 2);
      expect(schedules.length, 1);
      expect(attendances.length, 1);
      expect(tasks.length, 1);
      expect(events.length, 1);

      final rawJson = BackupService.encodeBundleToJson(
        BackupDataBundle(
          schemaVersion: BackupService.currentSchemaVersion,
          createdAt: DateTime(2026, 10, 27, 12),
          profile: profile,
          settings: settings,
          grades: grades,
          schedules: schedules,
          attendances: attendances,
          tasks: tasks,
          events: events,
        ),
      );
      final parsed = BackupService.parseAndValidateJson(rawJson);
      expect(parsed.schemaVersion, BackupService.currentSchemaVersion);
      expect(parsed.profile?.name, 'Rani Putri');
      expect(parsed.grades.length, 2);
      expect(parsed.schedules.length, 1);
      expect(parsed.attendances.length, 1);
      expect(parsed.tasks.length, 1);
      expect(parsed.events.length, 1);
    },
  );
}
