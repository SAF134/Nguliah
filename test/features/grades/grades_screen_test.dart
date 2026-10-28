import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/core/theme/app_theme.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/repositories/grade_repository.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/features/grades/presentation/grades_screen.dart';
import 'package:nguliah/features/grades/presentation/widgets/semester_chips.dart';
import 'package:nguliah/l10n/app_localizations.dart';

import '../onboarding_auth_flow_test.dart';

class FakeGradeRepository implements GradeRepository {
  FakeGradeRepository([List<CourseGrade>? initial])
    : _items = List<CourseGrade>.from(initial ?? const <CourseGrade>[]);

  final List<CourseGrade> _items;
  final _controller = StreamController<List<CourseGrade>>.broadcast();
  int _nextId = 1;

  List<CourseGrade> _sorted() {
    final copy = List<CourseGrade>.from(_items)
      ..sort((a, b) => a.semester.compareTo(b.semester));
    return copy;
  }

  @override
  Future<List<CourseGrade>> getAllGrades() async => _sorted();

  @override
  Stream<List<CourseGrade>> watchAllGrades() async* {
    yield _sorted();
    yield* _controller.stream;
  }

  @override
  Future<Id> saveGrade(CourseGrade grade) async {
    if (grade.id == Isar.autoIncrement || grade.id <= 0) {
      grade.id = _nextId++;
      _items.add(grade);
    } else {
      final idx = _items.indexWhere((e) => e.id == grade.id);
      if (idx >= 0) {
        _items[idx] = grade;
      } else {
        _items.add(grade);
      }
      if (grade.id >= _nextId) {
        _nextId = grade.id + 1;
      }
    }
    _controller.add(_sorted());
    return grade.id;
  }

  @override
  Future<bool> deleteGrade(Id id) async {
    final before = _items.length;
    _items.removeWhere((e) => e.id == id);
    _controller.add(_sorted());
    return _items.length < before;
  }
}

Widget _buildGradesTestApp({
  required FakeGradeRepository gradeRepo,
  required FakeSettingsRepository settingsRepo,
}) {
  return ProviderScope(
    overrides: [
      profileRepositoryProvider.overrideWithValue(FakeProfileRepository()),
      gradeRepositoryProvider.overrideWithValue(gradeRepo),
      settingsRepositoryProvider.overrideWithValue(settingsRepo),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      locale: const Locale('id'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const GradesScreen(),
    ),
  );
}

void main() {
  group(
    'Fase 3: CRUD Nilai, Mengulang MK, Filter Semester, dan Hapus + Undo',
    () {
      testWidgets(
        'Menampilkan EmptyState saat kosong, tambah nilai E (Perlu mengulang), '
        'ulang MK menjadi B, filter IPS per semester, dan hapus dengan Undo',
        (tester) async {
          tester.view.physicalSize = const Size(1080, 2400);
          tester.view.devicePixelRatio = 2.0;
          addTearDown(() {
            tester.view.resetPhysicalSize();
            tester.view.resetDevicePixelRatio();
          });

          final gradeRepo = FakeGradeRepository();
          final settingsRepo = FakeSettingsRepository();

          await tester.pumpWidget(
            _buildGradesTestApp(
              gradeRepo: gradeRepo,
              settingsRepo: settingsRepo,
            ),
          );
          await tester.pumpAndSettle();

          // 1. Empty state tampil
          expect(find.text('Belum ada catatan nilai'), findsOneWidget);
          expect(find.text('Tambah Nilai Pertama'), findsOneWidget);

          // Buka form tambah nilai pertama
          await tester.tap(find.text('Tambah Nilai Pertama'));
          await tester.pumpAndSettle();

          // Uji validasi kolom kosong
          await tester.ensureVisible(find.text('Simpan'));
          await tester.tap(find.text('Simpan'));
          await tester.pumpAndSettle();
          expect(
            find.text(
              'Nama mata kuliah wajib diisi. Masukkan nama mata kuliah.',
            ),
            findsOneWidget,
          );

          // Isi Statistika, Semester 1, 3 SKS, nilai E
          final sheetTextFields = find.descendant(
            of: find.byType(BottomSheet),
            matching: find.byType(TextField),
          );
          await tester.enterText(sheetTextFields.at(0), 'Statistika');
          await tester.enterText(sheetTextFields.at(1), '1');
          await tester.enterText(sheetTextFields.at(2), '3');
          await tester.tap(find.byType(DropdownButtonFormField<String>));
          await tester.pumpAndSettle();
          await tester.tap(find.text('E').last);
          await tester.pumpAndSettle();

          await tester.tap(find.text('Simpan'));
          await tester.pumpAndSettle();

          // 2. Kartu nilai E tampil dengan label "E · Perlu mengulang" dan IPK 0.00
          expect(find.text('Statistika'), findsOneWidget);
          expect(find.text('E · Perlu mengulang'), findsOneWidget);
          expect(find.text('0.00'), findsOneWidget);

          // 3. Ketuk tombol "Ulang" pada kartu nilai E -> form terisi Statistika & Sem 2
          await tester.tap(find.text('Ulang'));
          await tester.pumpAndSettle();

          // Pilih nilai B lalu Simpan
          await tester.tap(find.byType(DropdownButtonFormField<String>));
          await tester.pumpAndSettle();
          await tester.tap(find.text('B').last);
          await tester.pumpAndSettle();
          await tester.tap(find.text('Simpan'));
          await tester.pumpAndSettle();

          // 4. IPK menjadi 3.00, SKS Selesai 3, MK Selesai 1, riwayat tetap terlihat
          expect(find.text('3.00'), findsOneWidget);
          expect(find.text('Perbaikan'), findsOneWidget);
          expect(find.text('Mengulang dari Sem 1 (E)'), findsOneWidget);

          // 5. Filter Semester 1 -> menampilkan IPS 1 historis (0.00)
          final sem1Chip = find.descendant(
            of: find.byType(SemesterChips),
            matching: find.text('Semester 1'),
          );
          await tester.tap(sem1Chip);
          await tester.pumpAndSettle();
          expect(find.text('IPS 1'), findsOneWidget);
          expect(find.text('0.00'), findsOneWidget);

          // Kembalikan filter ke "Semua"
          await tester.tap(find.text('Semua'));
          await tester.pumpAndSettle();

          // 6. Hapus entri ulang (Semester 2) dengan ConfirmDialog, lalu batalkan lewat "Urungkan"
          final deleteButtons = find.byIcon(Icons.delete_outline_rounded);
          await tester.tap(deleteButtons.last);
          await tester.pumpAndSettle();

          expect(find.text('Hapus Nilai Mata Kuliah?'), findsOneWidget);
          await tester.tap(find.text('Iya'));
          await tester.pumpAndSettle();

          // Setelah dihapus, IPK kembali 0.00 dan Toast "Nilai dihapus" tampil
          expect(find.text('Nilai dihapus'), findsOneWidget);
          expect(find.text('0.00'), findsOneWidget);

          // Ketuk aksi "Urungkan" pada SnackBar
          await tester.tap(find.text('Urungkan'));
          await tester.pumpAndSettle();

          // Entri perbaikan kembali pulih dan IPK kembali 3.00
          expect(find.text('3.00'), findsOneWidget);
        },
      );
    },
  );
}
