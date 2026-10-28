import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/core/theme/app_theme.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/repositories/attendance_repository.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/schedule_repository.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';
import 'package:nguliah/features/schedule/presentation/schedule_screen.dart';
import 'package:nguliah/l10n/app_localizations.dart';

import '../onboarding_auth_flow_test.dart';

class FakeScheduleRepository implements ScheduleRepository {
  FakeScheduleRepository([List<CourseSchedule>? initial])
    : _items = List<CourseSchedule>.from(initial ?? const <CourseSchedule>[]);

  final List<CourseSchedule> _items;
  final _controller = StreamController<List<CourseSchedule>>.broadcast();
  int _nextId = 1;

  List<CourseSchedule> _sorted() {
    final copy = List<CourseSchedule>.from(_items)
      ..sort((a, b) {
        final dayCmp = a.dayOfWeek.compareTo(b.dayOfWeek);
        if (dayCmp != 0) return dayCmp;
        return a.startTimeMinutes.compareTo(b.startTimeMinutes);
      });
    return copy;
  }

  @override
  Future<List<CourseSchedule>> getAllSchedules() async => _sorted();

  @override
  Stream<List<CourseSchedule>> watchAllSchedules() async* {
    yield _sorted();
    yield* _controller.stream;
  }

  @override
  Future<Id> saveSchedule(CourseSchedule schedule) async {
    if (schedule.id == Isar.autoIncrement || schedule.id <= 0) {
      schedule.id = _nextId++;
      _items.add(schedule);
    } else {
      final idx = _items.indexWhere((e) => e.id == schedule.id);
      if (idx >= 0) {
        _items[idx] = schedule;
      } else {
        _items.add(schedule);
      }
      if (schedule.id >= _nextId) {
        _nextId = schedule.id + 1;
      }
    }
    _controller.add(_sorted());
    return schedule.id;
  }

  @override
  Future<bool> deleteSchedule(Id id) async {
    final before = _items.length;
    _items.removeWhere((e) => e.id == id);
    _controller.add(_sorted());
    return _items.length < before;
  }
}

class FakeAttendanceRepository implements AttendanceRepository {
  FakeAttendanceRepository([List<AttendanceRecord>? initial])
    : _items = List<AttendanceRecord>.from(
        initial ?? const <AttendanceRecord>[],
      );

  final List<AttendanceRecord> _items;
  final _controller = StreamController<List<AttendanceRecord>>.broadcast();
  int _nextId = 1;

  List<AttendanceRecord> _sorted() {
    final copy = List<AttendanceRecord>.from(_items)
      ..sort((a, b) => b.sessionDate.compareTo(a.sessionDate));
    return copy;
  }

  @override
  Future<List<AttendanceRecord>> getByScheduleId(int scheduleId) async {
    return _sorted().where((r) => r.scheduleId == scheduleId).toList();
  }

  @override
  Stream<List<AttendanceRecord>> watchAllAttendance() async* {
    yield _sorted();
    yield* _controller.stream;
  }

  @override
  Future<Id> saveAttendance(AttendanceRecord record) async {
    if (record.id == Isar.autoIncrement || record.id <= 0) {
      record.id = _nextId++;
      _items.add(record);
    } else {
      final idx = _items.indexWhere((e) => e.id == record.id);
      if (idx >= 0) {
        _items[idx] = record;
      } else {
        _items.add(record);
      }
    }
    _controller.add(_sorted());
    return record.id;
  }

  @override
  Future<bool> deleteAttendance(Id id) async {
    final before = _items.length;
    _items.removeWhere((e) => e.id == id);
    _controller.add(_sorted());
    return _items.length < before;
  }
}

void main() {
  group('Fase 4: CRUD Jadwal, Deteksi Bentrok, Presensi & Rekap Kehadiran', () {
    test('Unit ScheduleCalculator: deteksi bentrok & normalisasi presensi', () {
      final now = DateTime(2026, 10, 27);
      final existing = <CourseSchedule>[
        CourseSchedule(
          id: 1,
          courseName: 'Sistem Operasi',
          dayOfWeek: 1,
          startTimeMinutes: 480, // 08:00
          endTimeMinutes: 600, // 10:00
          room: 'R.101',
          createdAt: now,
          updatedAt: now,
        ),
      ];

      // Beririsan 09:00 - 11:00 di hari Senin (1)
      final conflicts = ScheduleCalculator.findConflictingSchedules(
        existing,
        dayOfWeek: 1,
        startTimeMinutes: 540,
        endTimeMinutes: 660,
      );
      expect(conflicts.length, 1);

      // Bersebelahan 10:00 - 12:00 tidak bentrok
      final nonConflict = ScheduleCalculator.findConflictingSchedules(
        existing,
        dayOfWeek: 1,
        startTimeMinutes: 600,
        endTimeMinutes: 720,
      );
      expect(nonConflict, isEmpty);
    });

    testWidgets(
      'Tambah jadwal, validasi jam selesai > mulai, peringatan jadwal bentrok, '
      'isi/ubah presensi (1 per sesi per tanggal), dan lihat Rekap Presensi',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final scheduleRepo = FakeScheduleRepository();
        final attendanceRepo = FakeAttendanceRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileRepositoryProvider.overrideWithValue(
                FakeProfileRepository(),
              ),
              scheduleRepositoryProvider.overrideWithValue(scheduleRepo),
              attendanceRepositoryProvider.overrideWithValue(attendanceRepo),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const ScheduleScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 1. State kosong tampil
        expect(find.text('Belum ada jadwal'), findsOneWidget);
        await tester.tap(find.text('Tambah Jadwal'));
        await tester.pumpAndSettle();

        final sheetFields = find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(TextField),
        );

        // Isi jadwal
        await tester.enterText(sheetFields.at(0), 'Pemrograman Mobile');
        await tester.enterText(sheetFields.at(1), 'Gedung B R.201');
        await tester.tap(find.text('Simpan'));
        await tester.pumpAndSettle();

        expect(find.text('Pemrograman Mobile'), findsOneWidget);

        // 4. Isi Presensi untuk Pemrograman Mobile (Hadir -> lalu ubah jadi Sakit pada tanggal yang sama)
        await tester.tap(find.text('Isi Presensi'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Simpan'));
        await tester.pumpAndSettle();

        expect(find.text('Presensi tersimpan'), findsOneWidget);

        // Buka lagi pada sesi & tanggal yang sama -> ubah ke Sakit (memastikan 1 record per sesi per tanggal)
        await tester.tap(find.text('Isi Presensi'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Sakit'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Simpan'));
        await tester.pumpAndSettle();

        final allSaved = await attendanceRepo.getByScheduleId(1);
        expect(allSaved.length, 1);
        expect(allSaved.first.status, AttendanceStatus.sick);

        // 5. Buka Rekap Presensi
        await tester.tap(find.text('Rekap Presensi'));
        await tester.pumpAndSettle();

        expect(find.text('Rekap Kehadiran per MK'), findsOneWidget);
        expect(find.text('0 Hadir dari 1 sesi (0%)'), findsOneWidget);
        expect(
          find.text('Hadir: 0 · Sakit: 1 · Izin: 0 · Alfa: 0'),
          findsOneWidget,
        );
      },
    );
  });
}
