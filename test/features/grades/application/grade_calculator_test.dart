import 'package:flutter_test/flutter_test.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';

CourseGrade _entry({
  required int id,
  required String name,
  required int semester,
  required int sks,
  required String index,
  int? retakeOfId,
  DateTime? createdAt,
}) {
  final ts = createdAt ?? DateTime(2026, 1, id);
  return CourseGrade(
    id: id,
    courseName: name,
    semester: semester,
    sks: sks,
    gradeIndex: index,
    retakeOfId: retakeOfId,
    createdAt: ts,
    updatedAt: ts,
  );
}

void main() {
  group('GradeCalculator - Logika Perhitungan Nilai (PRD.md)', () {
    test(
      '1. Nilai E: menurunkan IPS & IPK sebelum diulang, wajib mengulang, '
      'dan digantikan di IPK setelah diulang tanpa mengubah IPS historis',
      () {
        // Semester 2: Algoritma (3 SKS, A) + Statistika (3 SKS, E)
        final alg = _entry(
          id: 1,
          name: 'Algoritma',
          semester: 2,
          sks: 3,
          index: 'A',
        );
        final statE = _entry(
          id: 2,
          name: 'Statistika',
          semester: 2,
          sks: 3,
          index: 'E',
        );

        final beforeRetake = GradeCalculator.evaluateAll(<CourseGrade>[
          alg,
          statE,
        ]);

        // IPS Sem 2 = (4*3 + 0*3) / 6 = 2.00
        expect(beforeRetake.ipsBySemester[2], closeTo(2.0, 1e-6));
        expect(beforeRetake.ipk, closeTo(2.0, 1e-6));
        expect(beforeRetake.completedSks, 3);
        expect(beforeRetake.completedCoursesCount, 1);
        expect(beforeRetake.gradeDistribution['A'], 1);
        expect(beforeRetake.gradeDistribution['E'], 1);

        final statGroupBefore = beforeRetake.courseGroups.firstWhere(
          (g) => g.effectiveEntry.courseName == 'Statistika',
        );
        expect(statGroupBefore.isPassed, isFalse);
        expect(statGroupBefore.needsRetake, isTrue);

        // Semester 3: Statistika diulang dapat B (3 SKS)
        final statRetakeB = _entry(
          id: 3,
          name: 'Statistika',
          semester: 3,
          sks: 3,
          index: 'B',
          retakeOfId: 2,
        );

        final afterRetake = GradeCalculator.evaluateAll(<CourseGrade>[
          alg,
          statE,
          statRetakeB,
        ]);

        // IPS Sem 2 tetap historis 2.00; IPS Sem 3 = 3.00
        expect(afterRetake.ipsBySemester[2], closeTo(2.0, 1e-6));
        expect(afterRetake.ipsBySemester[3], closeTo(3.0, 1e-6));

        // IPK memakai A (4*3) + B (3*3) = 21 / 6 = 3.50
        expect(afterRetake.ipk, closeTo(3.5, 1e-6));
        expect(afterRetake.formattedIpk, '3.50');
        expect(afterRetake.completedSks, 6);
        expect(afterRetake.completedCoursesCount, 2);
        expect(afterRetake.gradeDistribution['B'], 1);
        expect(afterRetake.gradeDistribution['E'], 0);
      },
    );

    test('2. Perbaikan lebih tinggi (C -> B) & perubahan SKS antar-entri', () {
      final calcSem1 = _entry(
        id: 1,
        name: 'Kalkulus',
        semester: 1,
        sks: 3,
        index: 'C',
      );
      final calcSem3 = _entry(
        id: 2,
        name: 'Kalkulus',
        semester: 3,
        sks: 4, // Kurikulum berubah menjadi 4 SKS
        index: 'B',
        retakeOfId: 1,
      );

      final summary = GradeCalculator.evaluateAll(<CourseGrade>[
        calcSem1,
        calcSem3,
      ]);

      // IPS historis tiap semester
      expect(summary.ipsBySemester[1], closeTo(2.0, 1e-6));
      expect(summary.ipsBySemester[3], closeTo(3.0, 1e-6));

      // Entri terpakai adalah Sem 3 (B, 4 SKS)
      expect(summary.ipk, closeTo(3.0, 1e-6));
      expect(summary.completedSks, 4);
      expect(summary.completedCoursesCount, 1);
      expect(summary.gradeDistribution['B'], 1);
      expect(summary.gradeDistribution['C'], 0);
    });

    test('3. Perbaikan lebih rendah (C -> D), aturan terbaru, tie-break, & rantai A<-B<-C', () {
      final dbSem2 = _entry(
        id: 10,
        name: 'Basis Data',
        semester: 2,
        sks: 3,
        index: 'C',
      );
      final dbSem4Lower = _entry(
        id: 11,
        name: 'Basis Data',
        semester: 4,
        sks: 3,
        index: 'D',
        retakeOfId: 10,
      );

      // Default (highest): nilai C (2.0) tetap dipakai
      final highestResult = GradeCalculator.evaluateAll(<CourseGrade>[
        dbSem2,
        dbSem4Lower,
      ]);
      expect(highestResult.ipk, closeTo(2.0, 1e-6));
      expect(highestResult.gradeDistribution['C'], 1);
      expect(highestResult.gradeDistribution['D'], 0);

      // Opsi (latest): nilai D (1.0) dipakai
      final latestResult = GradeCalculator.evaluateAll(<CourseGrade>[
        dbSem2,
        dbSem4Lower,
      ], config: const GradeConversionConfig(retakeRule: RetakeRule.latest));
      expect(latestResult.ipk, closeTo(1.0, 1e-6));
      expect(latestResult.gradeDistribution['C'], 0);
      expect(latestResult.gradeDistribution['D'], 1);

      // Rantai 3 entri (A <- B <- C) dan nilai sama memilih yang terbaru
      final chain1 = _entry(
        id: 20,
        name: 'Jaringan Komputer',
        semester: 2,
        sks: 2,
        index: 'B',
      );
      final chain2 = _entry(
        id: 21,
        name: 'Jaringan Komputer',
        semester: 4,
        sks: 3,
        index: 'C',
        retakeOfId: 20,
      );
      final chain3SameAs1 = _entry(
        id: 22,
        name: 'Jaringan Komputer',
        semester: 6,
        sks: 4, // Bobot sama-sama B dengan chain1, tapi Sem 6 lebih baru
        index: 'B',
        retakeOfId: 21,
      );

      final chainSummary = GradeCalculator.evaluateAll(<CourseGrade>[
        chain1,
        chain2,
        chain3SameAs1,
      ]);
      expect(chainSummary.courseGroups.length, 1);
      expect(chainSummary.courseGroups.first.effectiveEntry.id, 22);
      expect(chainSummary.completedSks, 4);
    });

    test('4. Hapus entri ulang: kelompok kembali memakai entri tersisa dan IPK dihitung ulang', () {
      final initialE = _entry(
        id: 1,
        name: 'Struktur Data',
        semester: 2,
        sks: 3,
        index: 'E',
      );
      final retakeA = _entry(
        id: 2,
        name: 'Struktur Data',
        semester: 4,
        sks: 3,
        index: 'A',
        retakeOfId: 1,
      );

      final withRetake = GradeCalculator.evaluateAll(<CourseGrade>[
        initialE,
        retakeA,
      ]);
      expect(withRetake.ipk, closeTo(4.0, 1e-6));
      expect(withRetake.completedSks, 3);
      expect(withRetake.completedCoursesCount, 1);

      // Simulasi hapus entri ulang (hanya tersisa initialE)
      final afterDelete = GradeCalculator.evaluateAll(<CourseGrade>[initialE]);
      expect(afterDelete.ipk, closeTo(0.0, 1e-6));
      expect(afterDelete.completedSks, 0);
      expect(afterDelete.completedCoursesCount, 0);
      expect(afterDelete.courseGroups.first.needsRetake, isTrue);
    });

    test('5. Bobot kustom & batas nilai lulus minimum kustom', () {
      final customConfig = GradeConversionConfig(
        weights: const <String, double>{
          'A': 4.0,
          'AB': 3.7,
          'B': 3.3,
          'BC': 2.7,
          'C': 2.0,
          'D': 1.0,
          'E': 0.0,
        },
        minPassingGrade: 'C', // Nilai D menjadi tidak lulus
      );

      final entries = <CourseGrade>[
        _entry(id: 1, name: 'Fisika', semester: 1, sks: 3, index: 'AB'),
        _entry(id: 2, name: 'Kimia', semester: 1, sks: 2, index: 'D'),
      ];

      final result = GradeCalculator.evaluateAll(entries, config: customConfig);

      // IPK = (3.7 * 3 + 1.0 * 2) / 5 = 13.1 / 5 = 2.62
      expect(result.ipk, closeTo(2.62, 1e-6));
      expect(result.formattedIpk, '2.62');

      // Karena minPassingGrade = C, Kimia (D) tidak masuk SKS/MK selesai
      expect(result.completedSks, 3);
      expect(result.completedCoursesCount, 1);
    });
  });
}
