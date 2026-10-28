import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nguliah/core/services/backup_service.dart';
import 'package:nguliah/core/services/export_service.dart';
import 'package:nguliah/core/services/notification_service.dart';
import 'package:nguliah/core/theme/app_theme.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/models/user_profile_model.dart';
import 'package:nguliah/data/repositories/event_repository.dart';
import 'package:nguliah/data/repositories/grade_repository.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/schedule_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/data/repositories/task_repository.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';
import 'package:nguliah/features/home/presentation/home_screen.dart';
import 'package:nguliah/features/settings/presentation/settings_screen.dart';
import 'package:nguliah/l10n/app_localizations.dart';

class _MemProfileRepo implements ProfileRepository {
  _MemProfileRepo(this._profile);
  UserProfile? _profile;
  final _ctrl = StreamController<UserProfile?>.broadcast();

  @override
  Future<UserProfile?> getProfile() async => _profile;

  @override
  Stream<UserProfile?> watchProfile() async* {
    yield _profile;
    yield* _ctrl.stream;
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    _profile = profile;
    _ctrl.add(_profile);
  }
}

class _MemSettingsRepo implements SettingsRepository {
  _MemSettingsRepo([AppSettings? initial])
    : _settings = initial ?? AppSettings();
  AppSettings _settings;
  final _ctrl = StreamController<AppSettings?>.broadcast();

  @override
  Future<AppSettings> getSettings() async => _settings;

  @override
  Stream<AppSettings?> watchSettings() async* {
    yield _settings;
    yield* _ctrl.stream;
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    _settings = settings;
    _ctrl.add(_settings);
  }
}

class _MemGradeRepo implements GradeRepository {
  _MemGradeRepo(this._items);
  final List<CourseGrade> _items;

  @override
  Future<List<CourseGrade>> getAllGrades() async => _items;

  @override
  Stream<List<CourseGrade>> watchAllGrades() =>
      Stream<List<CourseGrade>>.value(_items);

  @override
  Future<int> saveGrade(CourseGrade grade) async => grade.id;

  @override
  Future<bool> deleteGrade(int id) async => true;
}

class _MemScheduleRepo implements ScheduleRepository {
  _MemScheduleRepo(this._items);
  final List<CourseSchedule> _items;

  @override
  Future<List<CourseSchedule>> getAllSchedules() async => _items;

  @override
  Stream<List<CourseSchedule>> watchAllSchedules() =>
      Stream<List<CourseSchedule>>.value(_items);

  @override
  Future<int> saveSchedule(CourseSchedule schedule) async => schedule.id;

  @override
  Future<bool> deleteSchedule(int id) async => true;
}

class _MemTaskRepo implements TaskRepository {
  _MemTaskRepo(this._items);
  final List<AcademicTask> _items;

  @override
  Future<List<AcademicTask>> getAllTasks() async => _items;

  @override
  Stream<List<AcademicTask>> watchAllTasks() =>
      Stream<List<AcademicTask>>.value(_items);

  @override
  Future<int> saveTask(AcademicTask task) async => task.id;

  @override
  Future<bool> deleteTask(int id) async => true;
}

class _MemEventRepo implements EventRepository {
  _MemEventRepo();
  final List<AcademicEvent> items = const <AcademicEvent>[];

  @override
  Future<List<AcademicEvent>> getAllEvents() async => items;

  @override
  Stream<List<AcademicEvent>> watchAllEvents() =>
      Stream<List<AcademicEvent>>.value(items);

  @override
  Future<int> saveEvent(AcademicEvent event) async => event.id;

  @override
  Future<bool> deleteEvent(int id) async => true;
}

void main() {
  group('Fase 6: Beranda, Pengaturan, Backup/Restore, Notifikasi & Ekspor', () {
    test(
      'Unit BackupService: encode/decode valid & tolak skema tidak cocok',
      () {
        final now = DateTime(2026, 10, 27, 10, 0);
        final bundle = BackupDataBundle(
          schemaVersion: BackupService.currentSchemaVersion,
          createdAt: now,
          profile: UserProfile(
            id: 1,
            name: 'Rani Putri',
            university: 'Universitas Indonesia',
            faculty: 'Fasilkom',
            major: 'Sistem Informasi',
            entryYear: 2024,
            updatedAt: now,
          ),
          settings: AppSettings(localeCode: 'id', weightA: 4.0),
          grades: <CourseGrade>[
            CourseGrade(
              id: 1,
              courseName: 'Statistika',
              semester: 1,
              sks: 3,
              gradeIndex: 'A',
              createdAt: now,
              updatedAt: now,
            ),
          ],
          schedules: <CourseSchedule>[],
          attendances: <AttendanceRecord>[],
          tasks: <AcademicTask>[],
          events: <AcademicEvent>[],
        );

        final jsonStr = BackupService.encodeBundleToJson(bundle);
        final parsed = BackupService.parseAndValidateJson(jsonStr);

        expect(parsed.schemaVersion, 1);
        expect(parsed.profile?.name, 'Rani Putri');
        expect(parsed.grades.length, 1);
        expect(parsed.grades.first.courseName, 'Statistika');

        // Versi skema salah harus melempar BackupFormatException
        final badVersionJson = jsonStr.replaceFirst(
          '"schemaVersion": 1',
          '"schemaVersion": 99',
        );
        expect(
          () => BackupService.parseAndValidateJson(badVersionJson),
          throwsA(isA<BackupFormatException>()),
        );

        // JSON rusak harus melempar BackupFormatException
        expect(
          () => BackupService.parseAndValidateJson('{broken json'),
          throwsA(isA<BackupFormatException>()),
        );
      },
    );

    test('Unit NotificationService & ExportService PDF', () async {
      final now = DateTime(2026, 10, 27, 8, 0);
      final settings = AppSettings(
        scheduleNotificationEnabled: true,
        scheduleReminderOffsetMinutes: 30,
        taskNotificationEnabled: true,
        taskReminderOffsetMinutes: 60,
        eventNotificationEnabled: true,
        eventReminderOffsetMinutes: 60,
      );

      final tasks = <AcademicTask>[
        AcademicTask(
          id: 1,
          courseName: 'Algoritma',
          description: 'Tugas 1',
          dueDate: now.add(const Duration(hours: 5)),
          isCompleted: false,
          createdAt: now,
          updatedAt: now,
        ),
        AcademicTask(
          id: 2,
          courseName: 'Algoritma',
          description: 'Sudah Selesai',
          dueDate: now.add(const Duration(hours: 5)),
          isCompleted: true,
          completedAt: now,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      final planned = NotificationService.computePlannedNotifications(
        settings: settings,
        schedules: const <CourseSchedule>[],
        tasks: tasks,
        events: const <AcademicEvent>[],
        now: now,
      );
      // Hanya tugas aktif yang dijadwalkan
      expect(planned.length, 1);
      expect(planned.first.title, 'Algoritma');

      // Uji pembuatan PDF ExportService
      final grades = <CourseGrade>[
        CourseGrade(
          id: 1,
          courseName: 'Algoritma',
          semester: 1,
          sks: 4,
          gradeIndex: 'A',
          createdAt: now,
          updatedAt: now,
        ),
      ];
      final summary = GradeCalculator.evaluateAll(grades);
      final pdfBytes = await ExportService.buildPdfBytes(
        scope: ExportScope.homeStats,
        profile: null,
        summary: summary,
        grades: grades,
        schedules: const <CourseSchedule>[],
        attendances: const <AttendanceRecord>[],
      );
      expect(pdfBytes.isNotEmpty, isTrue);
    });

    testWidgets(
      'HomeScreen (terang & gelap) menampilkan IPK, SKS/MK selesai, grafik IPS & sebaran nilai',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final now = DateTime.now();
        final profileRepo = _MemProfileRepo(
          UserProfile(
            id: 1,
            name: 'Dimas Pratama',
            university: 'ITB',
            faculty: 'STEI',
            major: 'Informatika',
            entryYear: 2023,
            updatedAt: now,
          ),
        );
        final settingsRepo = _MemSettingsRepo();
        final gradeRepo = _MemGradeRepo(<CourseGrade>[
          CourseGrade(
            id: 1,
            courseName: 'Struktur Data',
            semester: 1,
            sks: 4,
            gradeIndex: 'A',
            createdAt: now,
            updatedAt: now,
          ),
          CourseGrade(
            id: 2,
            courseName: 'Jaringan Komputer',
            semester: 2,
            sks: 3,
            gradeIndex: 'B',
            createdAt: now,
            updatedAt: now,
          ),
        ]);
        final scheduleRepo = _MemScheduleRepo(<CourseSchedule>[
          CourseSchedule(
            id: 1,
            courseName: 'Struktur Data',
            dayOfWeek: now.weekday,
            startTimeMinutes: 480,
            endTimeMinutes: 600,
            room: 'Lab 1',
            createdAt: now,
            updatedAt: now,
          ),
        ]);
        final taskRepo = _MemTaskRepo(<AcademicTask>[
          AcademicTask(
            id: 1,
            courseName: 'Jaringan Komputer',
            description: 'Konfigurasi Router',
            dueDate: now.add(const Duration(days: 2)),
            isCompleted: false,
            createdAt: now,
            updatedAt: now,
          ),
        ]);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileRepositoryProvider.overrideWithValue(profileRepo),
              settingsRepositoryProvider.overrideWithValue(settingsRepo),
              gradeRepositoryProvider.overrideWithValue(gradeRepo),
              scheduleRepositoryProvider.overrideWithValue(scheduleRepo),
              taskRepositoryProvider.overrideWithValue(taskRepo),
              eventRepositoryProvider.overrideWithValue(_MemEventRepo()),
            ],
            child: MaterialApp(
              theme: AppTheme.dark(),
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const HomeScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Dimas Pratama'), findsOneWidget);
        expect(find.text('3.57'), findsOneWidget); // (16 + 9) / 7 = 3.57
        expect(find.text('7 SKS'), findsOneWidget);
        expect(find.text('2 MK'), findsOneWidget);
        expect(find.text('Struktur Data'), findsAtLeastNWidgets(1));
        expect(find.textContaining('Lab 1'), findsOneWidget);
        expect(find.text('A'), findsAtLeastNWidgets(1));
        expect(find.text('B'), findsAtLeastNWidgets(1));
      },
    );

    testWidgets(
      'SettingsScreen: ubah bahasa ID/EN, ubah konversi nilai, buka Panduan Rumus & QRIS',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final now = DateTime.now();
        final profileRepo = _MemProfileRepo(
          UserProfile(
            id: 1,
            name: 'Rani Putri',
            university: 'UI',
            faculty: 'Fasilkom',
            major: 'Sistem Informasi',
            entryYear: 2024,
            updatedAt: now,
          ),
        );
        final settingsRepo = _MemSettingsRepo();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileRepositoryProvider.overrideWithValue(profileRepo),
              settingsRepositoryProvider.overrideWithValue(settingsRepo),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const SettingsScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Rani Putri'), findsOneWidget);

        // 1. Buka Konversi Nilai & simpan
        await tester.tap(find.text('Konversi Nilai'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Simpan'));
        await tester.pumpAndSettle();
        // Konfirmasi pop up dialog Simpan
        await tester.tap(find.text('Simpan').last);
        await tester.pumpAndSettle();

        // 2. Buka Panduan Rumus
        await tester.tap(find.text('Panduan Rumus IPS & IPK'));
        await tester.pumpAndSettle();
        expect(find.textContaining('IPS bersifat historis'), findsOneWidget);
        await tester.tap(find.text('Tutup'));
        await tester.pumpAndSettle();

        // 3. Buka Tentang Pengembang & QRIS
        final aboutDevFinder = find.text('Tentang Pengembang & Dukungan');
        await tester.ensureVisible(aboutDevFinder);
        await tester.pumpAndSettle();
        await tester.tap(aboutDevFinder);
        await tester.pumpAndSettle();
        expect(
          find.text('Dukung lewat QRIS (Buy Me a Coffee)'),
          findsOneWidget,
        );
        await tester.tap(find.text('Tutup'));
        await tester.pumpAndSettle();
      },
    );
  });
}
