import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/core/theme/app_theme.dart';
import 'package:nguliah/core/widgets/deadline_progress_bar.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/repositories/event_repository.dart';
import 'package:nguliah/data/repositories/task_repository.dart';
import 'package:nguliah/features/events/presentation/events_screen.dart';
import 'package:nguliah/features/tasks/presentation/tasks_screen.dart';
import 'package:nguliah/l10n/app_localizations.dart';

class FakeTaskRepository implements TaskRepository {
  FakeTaskRepository([List<AcademicTask>? initial])
    : _items = List<AcademicTask>.from(initial ?? const <AcademicTask>[]);

  final List<AcademicTask> _items;
  final _controller = StreamController<List<AcademicTask>>.broadcast();
  int _nextId = 1;

  List<AcademicTask> _sorted() {
    final copy = List<AcademicTask>.from(_items)
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return copy;
  }

  @override
  Future<List<AcademicTask>> getAllTasks() async => _sorted();

  @override
  Stream<List<AcademicTask>> watchAllTasks() async* {
    yield _sorted();
    yield* _controller.stream;
  }

  @override
  Future<Id> saveTask(AcademicTask task) async {
    if (task.id == Isar.autoIncrement || task.id <= 0) {
      task.id = _nextId++;
      _items.add(task);
    } else {
      final idx = _items.indexWhere((e) => e.id == task.id);
      if (idx >= 0) {
        _items[idx] = task;
      } else {
        _items.add(task);
      }
      if (task.id >= _nextId) {
        _nextId = task.id + 1;
      }
    }
    _controller.add(_sorted());
    return task.id;
  }

  @override
  Future<bool> deleteTask(Id id) async {
    final before = _items.length;
    _items.removeWhere((e) => e.id == id);
    _controller.add(_sorted());
    return _items.length < before;
  }
}

class FakeEventRepository implements EventRepository {
  FakeEventRepository([List<AcademicEvent>? initial])
    : _items = List<AcademicEvent>.from(initial ?? const <AcademicEvent>[]);

  final List<AcademicEvent> _items;
  final _controller = StreamController<List<AcademicEvent>>.broadcast();
  int _nextId = 1;

  List<AcademicEvent> _sorted() {
    final copy = List<AcademicEvent>.from(_items)
      ..sort((a, b) {
        final dateCmp = a.eventDate.compareTo(b.eventDate);
        if (dateCmp != 0) return dateCmp;
        return a.startTimeMinutes.compareTo(b.startTimeMinutes);
      });
    return copy;
  }

  @override
  Future<List<AcademicEvent>> getAllEvents() async => _sorted();

  @override
  Stream<List<AcademicEvent>> watchAllEvents() async* {
    yield _sorted();
    yield* _controller.stream;
  }

  @override
  Future<Id> saveEvent(AcademicEvent event) async {
    if (event.id == Isar.autoIncrement || event.id <= 0) {
      event.id = _nextId++;
      _items.add(event);
    } else {
      final idx = _items.indexWhere((e) => e.id == event.id);
      if (idx >= 0) {
        _items[idx] = event;
      } else {
        _items.add(event);
      }
      if (event.id >= _nextId) {
        _nextId = event.id + 1;
      }
    }
    _controller.add(_sorted());
    return event.id;
  }

  @override
  Future<bool> deleteEvent(Id id) async {
    final before = _items.length;
    _items.removeWhere((e) => e.id == id);
    _controller.add(_sorted());
    return _items.length < before;
  }
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id', null);
    await initializeDateFormatting('en', null);
  });

  group('Fase 5: CRUD Tugas Kuliah & Acara Kampus', () {
    test(
      'Unit DeadlineProgressBar: status normal, urgent (<=24j), overdue',
      () {
        final now = DateTime(2026, 10, 27, 12, 0);

        expect(
          DeadlineProgressBar.computeStatus(
            dueDate: now.add(const Duration(days: 3)),
            now: now,
          ),
          DeadlineStatus.normal,
        );
        expect(
          DeadlineProgressBar.computeStatus(
            dueDate: now.add(const Duration(hours: 10)),
            now: now,
          ),
          DeadlineStatus.urgent,
        );
        expect(
          DeadlineProgressBar.computeStatus(
            dueDate: now.subtract(const Duration(minutes: 5)),
            now: now,
          ),
          DeadlineStatus.overdue,
        );
      },
    );

    testWidgets(
      'TasksScreen: tambah tugas, indikator Terlambat, tandai selesai & pindah ke Rekap Selesai',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final pastTask = AcademicTask(
          id: 1,
          courseName: 'Basis Data',
          description: 'Laporan Normalisasi',
          dueDate: DateTime(2020, 1, 10, 23, 59),
          isCompleted: false,
          createdAt: DateTime(2020, 1, 1),
          updatedAt: DateTime(2020, 1, 1),
        );
        final taskRepo = FakeTaskRepository(<AcademicTask>[pastTask]);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [taskRepositoryProvider.overrideWithValue(taskRepo)],
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

        // 1. Tugas masa lalu menampilkan label "Terlambat"
        expect(find.text('Basis Data'), findsOneWidget);
        expect(find.text('Terlambat'), findsOneWidget);

        // 2. Tambah tugas baru lewat bottom sheet
        await tester.tap(find.text('Tambah Tugas'));
        await tester.pumpAndSettle();

        final sheetFields = find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(TextField),
        );
        await tester.enterText(sheetFields.at(0), 'Rekayasa Perangkat Lunak');
        await tester.enterText(sheetFields.at(1), 'Dokumen SRS Bab 1-3');
        await tester.enterText(sheetFields.at(2), '2030-05-15');
        await tester.enterText(sheetFields.at(3), '18:00');
        await tester.tap(find.text('Simpan'));
        await tester.pumpAndSettle();

        expect(find.text('Rekayasa Perangkat Lunak'), findsOneWidget);
        expect(find.text('Aktif (2)'), findsOneWidget);

        // 3. Tandai tugas pertama (Basis Data) selesai dengan konfirmasi pop up
        await tester.tap(find.byIcon(Icons.check_circle_outline_rounded).first);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Iya'));
        await tester.pumpAndSettle();

        expect(find.text('Aktif (1)'), findsOneWidget);
        expect(find.text('Selesai (Rekap) (1)'), findsOneWidget);

        final allSaved = await taskRepo.getAllTasks();
        final completedTask = allSaved.firstWhere((t) => t.id == 1);
        expect(completedTask.isCompleted, isTrue);
        expect(completedTask.completedAt, isNotNull);

        // 4. Pindah ke tab Selesai (Rekap)
        await tester.tap(find.text('Selesai (Rekap) (1)'));
        await tester.pumpAndSettle();

        expect(find.text('Basis Data'), findsOneWidget);
        expect(find.textContaining('Selesai'), findsWidgets);
      },
    );

    testWidgets(
      'EventsScreen: tambah acara, validasi jam selesai > mulai, dan hapus dengan Undo',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final eventRepo = FakeEventRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [eventRepositoryProvider.overrideWithValue(eventRepo)],
            child: MaterialApp(
              theme: AppTheme.light(),
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const EventsScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Tidak ada acara'), findsOneWidget);
        await tester.tap(find.text('Tambah Acara').first);
        await tester.pumpAndSettle();

        final sheetFields = find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(TextField),
        );

        // Validasi jam selesai <= jam mulai
        await tester.enterText(sheetFields.at(0), 'Seminar Nasional AI');
        await tester.enterText(
          sheetFields.at(1),
          'Masa depan kecerdasan buatan',
        );
        await tester.enterText(sheetFields.at(2), 'Aula Utama Kampus');
        await tester.enterText(sheetFields.at(3), '2026-11-20');
        await tester.enterText(sheetFields.at(4), '13:00');
        await tester.enterText(sheetFields.at(5), '12:00');
        await tester.tap(find.text('Simpan'));
        await tester.pumpAndSettle();

        expect(
          find.text('Jam selesai harus lebih besar dari jam mulai.'),
          findsOneWidget,
        );

        // Perbaiki jam selesai -> 15:00
        await tester.enterText(sheetFields.at(5), '15:00');
        await tester.tap(find.text('Simpan'));
        await tester.pumpAndSettle();

        expect(find.text('Seminar Nasional AI'), findsOneWidget);
        expect(find.textContaining('13:00 – 15:00'), findsOneWidget);

        // Hapus acara + konfirmasi + Undo
        await tester.tap(find.byIcon(Icons.delete_outline_rounded));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Iya'));
        await tester.pumpAndSettle();

        expect(find.text('Tidak ada acara'), findsOneWidget);
        await tester.tap(find.text('Urungkan'));
        await tester.pumpAndSettle();

        expect(find.text('Seminar Nasional AI'), findsOneWidget);
      },
    );
  });
}
