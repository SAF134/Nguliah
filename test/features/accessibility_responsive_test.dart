import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
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
import 'package:nguliah/features/grades/presentation/grades_screen.dart';
import 'package:nguliah/features/home/presentation/home_screen.dart';
import 'package:nguliah/features/tasks/presentation/tasks_screen.dart';
import 'package:nguliah/l10n/app_localizations.dart';

class _ReactiveTaskRepo implements TaskRepository {
  _ReactiveTaskRepo([List<AcademicTask>? initial])
    : _items = List<AcademicTask>.from(initial ?? const <AcademicTask>[]);

  final List<AcademicTask> _items;
  final _ctrl = StreamController<List<AcademicTask>>.broadcast();

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

class _StubSettingsRepo implements SettingsRepository {
  @override
  Future<AppSettings> getSettings() async => AppSettings();

  @override
  Stream<AppSettings?> watchSettings() =>
      Stream<AppSettings?>.value(AppSettings());

  @override
  Future<void> saveSettings(AppSettings settings) async {}
}

class _StubScheduleRepo implements ScheduleRepository {
  @override
  Future<List<CourseSchedule>> getAllSchedules() async => const [];

  @override
  Stream<List<CourseSchedule>> watchAllSchedules() =>
      Stream<List<CourseSchedule>>.value(const []);

  @override
  Future<int> saveSchedule(CourseSchedule schedule) async => schedule.id;

  @override
  Future<bool> deleteSchedule(int id) async => true;
}

class _StubEventRepo implements EventRepository {
  @override
  Future<List<AcademicEvent>> getAllEvents() async => const [];

  @override
  Stream<List<AcademicEvent>> watchAllEvents() =>
      Stream<List<AcademicEvent>>.value(const []);

  @override
  Future<int> saveEvent(AcademicEvent event) async => event.id;

  @override
  Future<bool> deleteEvent(int id) async => true;
}

class _StubProfileRepo implements ProfileRepository {
  @override
  Future<UserProfile?> getProfile() async => null;

  @override
  Stream<UserProfile?> watchProfile() => Stream<UserProfile?>.value(null);

  @override
  Future<void> saveProfile(UserProfile profile) async {}
}

class _StubGradeRepo implements GradeRepository {
  _StubGradeRepo(this._grades);
  final List<CourseGrade> _grades;

  @override
  Future<List<CourseGrade>> getAllGrades() async => _grades;

  @override
  Stream<List<CourseGrade>> watchAllGrades() =>
      Stream<List<CourseGrade>>.value(_grades);

  @override
  Future<int> saveGrade(CourseGrade grade) async => grade.id;

  @override
  Future<bool> deleteGrade(int id) async => true;
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id', null);
    await initializeDateFormatting('en', null);
  });

  group('Fase 7: Sinkronisasi Notifikasi, Banner Izin, Ekspor per Semester & Font 200%', () {
    test('Penjadwalan ulang notifikasi otomatis saat tugas ditambah/dihapus & Ekspor per Semester', () async {
      final taskRepo = _ReactiveTaskRepo();
      final container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(_StubSettingsRepo()),
          scheduleRepositoryProvider.overrideWithValue(_StubScheduleRepo()),
          taskRepositoryProvider.overrideWithValue(taskRepo),
          eventRepositoryProvider.overrideWithValue(_StubEventRepo()),
        ],
      );
      final sub = container.listen<int>(
        notificationAutoSyncProvider,
        (_, _) {},
      );
      addTearDown(sub.close);
      addTearDown(container.dispose);

      // Tunggu stream awal
      await pumpEventQueue();
      expect(container.read(notificationAutoSyncProvider), 0);

      // Tambah tugas masa depan -> jumlah pengingat otomatis naik jadi 1
      final futureDue = DateTime.now().add(const Duration(days: 2));
      await taskRepo.saveTask(
        AcademicTask(
          id: 10,
          courseName: 'Keamanan Jaringan',
          description: 'Audit Firewall',
          dueDate: futureDue,
          isCompleted: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await pumpEventQueue();
      expect(container.read(notificationAutoSyncProvider), 1);

      // Hapus tugas -> jumlah pengingat otomatis turun jadi 0
      await taskRepo.deleteTask(10);
      await pumpEventQueue();
      expect(container.read(notificationAutoSyncProvider), 0);

      // Uji ExportService per semester (semesterFilter: 1)
      final now = DateTime(2026, 10, 27);
      final grades = <CourseGrade>[
        CourseGrade(
          id: 1,
          courseName: 'Kalkulus 1',
          semester: 1,
          sks: 3,
          gradeIndex: 'A',
          createdAt: now,
          updatedAt: now,
        ),
        CourseGrade(
          id: 2,
          courseName: 'Kalkulus 2',
          semester: 2,
          sks: 3,
          gradeIndex: 'B',
          createdAt: now,
          updatedAt: now,
        ),
      ];
      final summary = GradeCalculator.evaluateAll(grades);
      final sem1Pdf = await ExportService.buildPdfBytes(
        scope: ExportScope.allGrades,
        profile: null,
        summary: summary,
        grades: grades,
        schedules: const <CourseSchedule>[],
        attendances: const <AttendanceRecord>[],
        semesterFilter: 1,
      );
      expect(sem1Pdf.isNotEmpty, isTrue);

      // Benchmark PRD.md: hitung IPK untuk 500 data nilai <= 200 ms
      final largeGrades = List<CourseGrade>.generate(
        500,
        (i) => CourseGrade(
          id: i + 1,
          courseName: 'MK-$i',
          semester: (i % 14) + 1,
          sks: 3,
          gradeIndex: i.isEven ? 'A' : 'B',
          createdAt: now,
          updatedAt: now,
        ),
      );
      final sw = Stopwatch()..start();
      final largeResult = GradeCalculator.evaluateAll(largeGrades);
      sw.stop();
      expect(largeResult.completedCoursesCount, 500);
      expect(sw.elapsedMilliseconds, lessThanOrEqualTo(200));
    });

    testWidgets(
      'Banner Izin Notifikasi Ditolak tampil di TasksScreen & Layout tahan skala font 200% di layar kecil 320dp',
      (tester) async {
        // Simulasikan layar ponsel kecil 320dp (640px @ 2.0x) + skala font 200%
        tester.view.physicalSize = const Size(640, 1600);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final now = DateTime.now();
        final grades = <CourseGrade>[
          CourseGrade(
            id: 1,
            courseName: 'Pemrograman Web',
            semester: 1,
            sks: 3,
            gradeIndex: 'A',
            createdAt: now,
            updatedAt: now,
          ),
        ];

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileRepositoryProvider.overrideWithValue(_StubProfileRepo()),
              settingsRepositoryProvider.overrideWithValue(_StubSettingsRepo()),
              gradeRepositoryProvider.overrideWithValue(_StubGradeRepo(grades)),
              scheduleRepositoryProvider.overrideWithValue(_StubScheduleRepo()),
              taskRepositoryProvider.overrideWithValue(_ReactiveTaskRepo()),
              eventRepositoryProvider.overrideWithValue(_StubEventRepo()),
            ],
            child: MediaQuery(
              data: const MediaQueryData(
                size: Size(320, 800),
                textScaler: TextScaler.linear(2.0),
              ),
              child: MaterialApp(
                theme: AppTheme.light(),
                locale: const Locale('id'),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                home: const HomeScreen(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Pastikan Beranda tampil utuh tanpa overflow pada 320dp + 200% font scale
        expect(find.text('4.00'), findsOneWidget);

        // Uji TasksScreen dengan status izin notifikasi ditolak = true
        final container = ProviderContainer(
          overrides: [
            taskRepositoryProvider.overrideWithValue(_ReactiveTaskRepo()),
          ],
        );
        addTearDown(container.dispose);
        container
            .read(notificationPermissionDeniedProvider.notifier)
            .setDenied(true);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              theme: AppTheme.light(),
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const TasksScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('Izin notifikasi ditolak'), findsOneWidget);
        expect(find.text('Buka Pengaturan'), findsOneWidget);

        // Uji GradesScreen di mode Gelap + Bahasa Inggris + Tablet Master-Detail (900dp >= 840dp)
        tester.view.physicalSize = const Size(1800, 1600);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileRepositoryProvider.overrideWithValue(_StubProfileRepo()),
              settingsRepositoryProvider.overrideWithValue(_StubSettingsRepo()),
              gradeRepositoryProvider.overrideWithValue(_StubGradeRepo(grades)),
            ],
            child: MediaQuery(
              data: const MediaQueryData(size: Size(900, 800)),
              child: MaterialApp(
                theme: AppTheme.dark(),
                locale: const Locale('en'),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                home: const GradesScreen(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Pemrograman Web'), findsOneWidget);
      },
    );
  });
}
