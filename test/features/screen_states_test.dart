import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nguliah/core/theme/app_theme.dart';
import 'package:nguliah/core/widgets/profile_avatar.dart';
import 'package:nguliah/core/widgets/skeleton.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/models/user_profile_model.dart';
import 'package:nguliah/data/repositories/event_repository.dart';
import 'package:nguliah/data/repositories/grade_repository.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/schedule_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/data/repositories/task_repository.dart';
import 'package:nguliah/features/grades/presentation/widgets/grade_selector.dart';
import 'package:nguliah/features/home/presentation/home_screen.dart';
import 'package:nguliah/features/schedule/presentation/widgets/day_chips.dart';
import 'package:nguliah/features/settings/presentation/widgets/about_developer_sheets.dart';
import 'package:nguliah/l10n/app_localizations.dart';

class _StubProfileRepo implements ProfileRepository {
  @override
  Future<UserProfile?> getProfile() async => null;

  @override
  Stream<UserProfile?> watchProfile() => Stream<UserProfile?>.value(null);

  @override
  Future<void> saveProfile(UserProfile profile) async {}
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

class _PendingGradeRepo implements GradeRepository {
  final _ctrl = StreamController<List<CourseGrade>>.broadcast();

  @override
  Future<List<CourseGrade>> getAllGrades() async => const [];

  @override
  Stream<List<CourseGrade>> watchAllGrades() => _ctrl.stream;

  @override
  Future<int> saveGrade(CourseGrade grade) async => grade.id;

  @override
  Future<bool> deleteGrade(int id) async => true;
}

class _ErrorGradeRepo implements GradeRepository {
  @override
  Future<List<CourseGrade>> getAllGrades() async => const [];

  @override
  Stream<List<CourseGrade>> watchAllGrades() =>
      Stream<List<CourseGrade>>.error(Exception('DB Error'));

  @override
  Future<int> saveGrade(CourseGrade grade) async => grade.id;

  @override
  Future<bool> deleteGrade(int id) async => true;
}

class _EmptyGradeRepo implements GradeRepository {
  @override
  Future<List<CourseGrade>> getAllGrades() async => const [];

  @override
  Stream<List<CourseGrade>> watchAllGrades() =>
      Stream<List<CourseGrade>>.value(const []);

  @override
  Future<int> saveGrade(CourseGrade grade) async => grade.id;

  @override
  Future<bool> deleteGrade(int id) async => true;
}

class _EmptyScheduleRepo implements ScheduleRepository {
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

class _EmptyTaskRepo implements TaskRepository {
  @override
  Future<List<AcademicTask>> getAllTasks() async => const [];

  @override
  Stream<List<AcademicTask>> watchAllTasks() =>
      Stream<List<AcademicTask>>.value(const []);

  @override
  Future<int> saveTask(AcademicTask task) async => task.id;

  @override
  Future<bool> deleteTask(int id) async => true;
}

class _EmptyEventRepo implements EventRepository {
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

void main() {
  testWidgets(
    'HomeScreen menampilkan Skeleton saat memuat, Error + Coba Lagi saat gagal, dan tombol Nilai + Jadwal saat kosong',
    (tester) async {
      // 1. State Memuat (Loading -> Skeleton)
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileRepositoryProvider.overrideWithValue(_StubProfileRepo()),
            settingsRepositoryProvider.overrideWithValue(_StubSettingsRepo()),
            gradeRepositoryProvider.overrideWithValue(_PendingGradeRepo()),
            scheduleRepositoryProvider.overrideWithValue(_EmptyScheduleRepo()),
            taskRepositoryProvider.overrideWithValue(_EmptyTaskRepo()),
            eventRepositoryProvider.overrideWithValue(_EmptyEventRepo()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            locale: const Locale('id'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const HomeScreen(),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(Skeleton), findsOneWidget);

      // 2. State Error ("Gagal memuat data" + "Coba Lagi")
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileRepositoryProvider.overrideWithValue(_StubProfileRepo()),
            settingsRepositoryProvider.overrideWithValue(_StubSettingsRepo()),
            gradeRepositoryProvider.overrideWithValue(_ErrorGradeRepo()),
            scheduleRepositoryProvider.overrideWithValue(_EmptyScheduleRepo()),
            taskRepositoryProvider.overrideWithValue(_EmptyTaskRepo()),
            eventRepositoryProvider.overrideWithValue(_EmptyEventRepo()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            locale: const Locale('id'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Gagal memuat data'), findsOneWidget);
      expect(find.text('Coba Lagi'), findsOneWidget);

      // 3. State Kosong ("Belum ada data akademik" + tombol ke Nilai & Jadwal)
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileRepositoryProvider.overrideWithValue(_StubProfileRepo()),
            settingsRepositoryProvider.overrideWithValue(_StubSettingsRepo()),
            gradeRepositoryProvider.overrideWithValue(_EmptyGradeRepo()),
            scheduleRepositoryProvider.overrideWithValue(_EmptyScheduleRepo()),
            taskRepositoryProvider.overrideWithValue(_EmptyTaskRepo()),
            eventRepositoryProvider.overrideWithValue(_EmptyEventRepo()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            locale: const Locale('id'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Belum ada data akademik'), findsOneWidget);
      expect(find.text('Tambah Nilai Pertama'), findsOneWidget);
      expect(find.text('Tambah Jadwal'), findsOneWidget);
    },
  );

  testWidgets(
    'ProfileAvatar jatuh ke inisial saat tanpa foto atau foto tidak ditemukan, serta AboutAppSheet menampilkan versi & tautan GitHub',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          locale: const Locale('id'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: Column(
              children: <Widget>[
                ProfileAvatar(
                  name: 'Rani Putri',
                  photoPath: '/non_existent_broken_path.jpg',
                ),
                AboutAppSheet(),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('RP'), findsOneWidget);
      expect(find.text(AboutAppSheet.githubRepoUrl), findsOneWidget);
    },
  );

  testWidgets(
    'Navigasi keyboard panah kanan/kiri pada GradeSelector dan DayChips berfungsi sesuai DESIGN.md Bagian 10',
    (tester) async {
      String selectedGrade = 'A';
      int? selectedDay;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              theme: AppTheme.light(),
              locale: const Locale('id'),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: Scaffold(
                body: Column(
                  children: <Widget>[
                    GradeSelector(
                      selectedIndex: selectedGrade,
                      onSelected: (val) => setState(() => selectedGrade = val),
                    ),
                    DayChips(
                      selectedDay: selectedDay,
                      onSelected: (val) => setState(() => selectedDay = val),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      // Fokus pada GradeSelector lalu tekan panah kanan -> A berubah ke AB
      Focus.of(tester.element(find.text('A'))).requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(selectedGrade, 'AB');

      // Fokus pada DayChips lalu tekan panah kanan -> Semua (null) berubah ke Senin (1)
      Focus.of(tester.element(find.text('Semua'))).requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(selectedDay, 1);
    },
  );
}
