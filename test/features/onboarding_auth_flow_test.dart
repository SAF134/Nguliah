import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:nguliah/main.dart';

class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository([AppSettings? initial])
    : _settings = initial ?? AppSettings();

  AppSettings _settings;
  final _controller = StreamController<AppSettings?>.broadcast();

  @override
  Future<AppSettings> getSettings() async => _settings;

  @override
  Stream<AppSettings?> watchSettings() async* {
    yield _settings;
    yield* _controller.stream;
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    _settings = settings;
    _controller.add(_settings);
  }
}

class FakeProfileRepository implements ProfileRepository {
  FakeProfileRepository([this._profile]);

  UserProfile? _profile;
  final _controller = StreamController<UserProfile?>.broadcast();

  UserProfile? get currentProfile => _profile;

  @override
  Future<UserProfile?> getProfile() async => _profile;

  @override
  Stream<UserProfile?> watchProfile() async* {
    yield _profile;
    yield* _controller.stream;
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    _profile = profile;
    _controller.add(_profile);
  }
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
  group('Fase 2: Alur Pertama Kali Membuka Aplikasi (Splash -> Onboarding -> Masuk -> Beranda)', () {
    testWidgets(
      'Pengguna baru melewati Splash -> Onboarding 4 slide (SlideToConfirm aksesibel) -> Masuk (validasi & simpan) -> Beranda',
      (tester) async {
        final fakeSettings = FakeSettingsRepository();
        final fakeProfile = FakeProfileRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              settingsRepositoryProvider.overrideWithValue(fakeSettings),
              profileRepositoryProvider.overrideWithValue(fakeProfile),
              gradeRepositoryProvider.overrideWithValue(_EmptyGradeRepo()),
              scheduleRepositoryProvider.overrideWithValue(
                _EmptyScheduleRepo(),
              ),
              taskRepositoryProvider.overrideWithValue(_EmptyTaskRepo()),
              eventRepositoryProvider.overrideWithValue(_EmptyEventRepo()),
            ],
            child: const NguliahApp(),
          ),
        );

        // 1. Splash tampil
        expect(find.text('Memuat data akademik...'), findsOneWidget);

        // Tunggu durasi splash (400ms) selesai dan rute berpindah ke Onboarding
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pumpAndSettle();

        // 2. Onboarding Slide 1 tampil
        expect(find.text('Pantau Nilai & IPK'), findsOneWidget);

        // Lanjut ke Slide 2
        await tester.tap(find.text('Lanjut'));
        await tester.pumpAndSettle();
        expect(find.text('Jadwal & Presensi Kuliah'), findsOneWidget);

        // Lanjut ke Slide 3
        await tester.tap(find.text('Lanjut'));
        await tester.pumpAndSettle();
        expect(find.text('Lacak Tugas & Tenggat'), findsOneWidget);

        // Lanjut ke Slide 4
        await tester.tap(find.text('Lanjut'));
        await tester.pumpAndSettle();
        expect(find.text('Kelola Acara Kampus'), findsOneWidget);
        expect(find.text('Mulai Sekarang'), findsOneWidget);

        // Ketuk tombol "Mulai Sekarang" pada Slide 4
        await tester.tap(find.text('Mulai Sekarang'));
        await tester.pumpAndSettle();

        // 3. Halaman Masuk (Profil Mahasiswa) tampil & onboardingCompleted tersimpan
        expect((await fakeSettings.getSettings()).onboardingCompleted, isTrue);
        expect(find.text('Profil Mahasiswa'), findsOneWidget);

        // Coba tekan Simpan & Mulai saat semua kolom kosong -> wajib muncul 5 pesan error
        final saveBtn = find.text('Simpan & Mulai');
        await tester.ensureVisible(saveBtn);
        await tester.tap(saveBtn);
        await tester.pumpAndSettle();

        expect(
          find.text('Nama lengkap wajib diisi. Masukkan minimal 2 karakter.'),
          findsOneWidget,
        );
        expect(
          find.text('Universitas wajib diisi. Masukkan nama kampusmu.'),
          findsOneWidget,
        );
        expect(
          find.text(
            'Fakultas wajib diisi. Masukkan nama fakultas atau jurusanmu.',
          ),
          findsOneWidget,
        );
        expect(
          find.text(
            'Program studi wajib diisi. Masukkan nama program studimu.',
          ),
          findsOneWidget,
        );
        expect(
          find.text(
            'Tahun masuk wajib dipilih. Pilih tahun angkatan yang valid.',
          ),
          findsOneWidget,
        );

        // Isi ke-5 kolom dengan data valid
        final textFields = find.byType(TextField);
        await tester.enterText(textFields.at(0), 'Rani Putri');
        await tester.enterText(textFields.at(1), 'Universitas Indonesia');
        await tester.enterText(textFields.at(2), 'Fakultas Ilmu Komputer');
        await tester.enterText(textFields.at(3), 'Sistem Informasi');
        await tester.enterText(textFields.at(4), '2026');

        // Simpan & Mulai
        await tester.ensureVisible(saveBtn);
        await tester.tap(saveBtn);
        await tester.pumpAndSettle();

        // 4. Data profil tersimpan lokal dan masuk ke Beranda
        expect(fakeProfile.currentProfile, isNotNull);
        expect(fakeProfile.currentProfile!.name, 'Rani Putri');
        expect(fakeProfile.currentProfile!.university, 'Universitas Indonesia');
        expect(find.text('Belum ada data akademik'), findsOneWidget);
      },
    );

    testWidgets(
      'Pengguna lama (onboarding selesai & profil sudah ada) langsung diarahkan dari Splash ke Beranda',
      (tester) async {
        final fakeSettings = FakeSettingsRepository(
          AppSettings(onboardingCompleted: true),
        );
        final fakeProfile = FakeProfileRepository(
          UserProfile(
            name: 'Dimas Pratama',
            university: 'ITB',
            faculty: 'STEI',
            major: 'Teknik Informatika',
            entryYear: 2022,
            updatedAt: DateTime(2026),
          ),
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              settingsRepositoryProvider.overrideWithValue(fakeSettings),
              profileRepositoryProvider.overrideWithValue(fakeProfile),
              gradeRepositoryProvider.overrideWithValue(_EmptyGradeRepo()),
              scheduleRepositoryProvider.overrideWithValue(
                _EmptyScheduleRepo(),
              ),
              taskRepositoryProvider.overrideWithValue(_EmptyTaskRepo()),
              eventRepositoryProvider.overrideWithValue(_EmptyEventRepo()),
            ],
            child: const NguliahApp(),
          ),
        );

        await tester.pump(const Duration(milliseconds: 500));
        await tester.pumpAndSettle();

        expect(find.text('Belum ada data akademik'), findsOneWidget);
      },
    );
  });
}
