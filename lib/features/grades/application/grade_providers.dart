import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/repositories/grade_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';

/// Notifier untuk filter semester terpilih pada layar Nilai (null = Semua Semester).
class SelectedSemesterNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void select(int? semester) {
    state = semester;
  }
}

final selectedSemesterFilterProvider =
    NotifierProvider<SelectedSemesterNotifier, int?>(
      SelectedSemesterNotifier.new,
    );

/// Stream daftar seluruh entri nilai dari repository.
final allGradesStreamProvider = StreamProvider<List<CourseGrade>>((ref) {
  return ref.watch(gradeRepositoryProvider).watchAllGrades();
});

/// Stream pengaturan aplikasi dari repository.
final appSettingsStreamProvider = StreamProvider<AppSettings?>((ref) {
  return ref.watch(settingsRepositoryProvider).watchSettings();
});

/// Provider hasil evaluasi nilai (IPK, IPS, SKS/MK selesai, sebaran nilai).
final academicSummaryProvider = Provider<AcademicSummaryResult>((ref) {
  final grades =
      ref.watch(allGradesStreamProvider).value ?? const <CourseGrade>[];
  final settings = ref.watch(appSettingsStreamProvider).value;
  final config = settings != null
      ? GradeConversionConfig.fromSettings(settings)
      : const GradeConversionConfig();

  return GradeCalculator.evaluateAll(grades, config: config);
});

/// Notifier untuk privasi nilai akademik (sensor bintang * pada IPK, IPS, SKS, dan MK).
class HideAcademicScoresNotifier extends Notifier<bool> {
  @override
  bool build() {
    final settings = ref.watch(appSettingsStreamProvider).value;
    return settings?.hideAcademicScores ?? false;
  }

  Future<void> toggle([bool? overrideValue]) async {
    final nextValue = overrideValue ?? !state;
    state = nextValue;
    final repo = ref.read(settingsRepositoryProvider);
    final current = await repo.getSettings();
    current.hideAcademicScores = nextValue;
    await repo.saveSettings(current);
  }
}

final hideAcademicScoresProvider =
    NotifierProvider<HideAcademicScoresNotifier, bool>(
      HideAcademicScoresNotifier.new,
    );
