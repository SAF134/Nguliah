import 'dart:convert';

import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/models/course_grade_model.dart';

/// Konfigurasi konversi bobot dan aturan perhitungan nilai murni (tanpa UI).
class GradeConversionConfig {
  const GradeConversionConfig({
    this.weights = defaultWeights,
    this.minPassingGrade = 'D',
    this.retakeRule = RetakeRule.highest,
  });

  factory GradeConversionConfig.fromSettings(AppSettings settings) {
    var weightsMap = <String, double>{
      'A': settings.weightA,
      'AB': settings.weightAB,
      'B': settings.weightB,
      'BC': settings.weightBC,
      'C': settings.weightC,
      'D': settings.weightD,
      'E': settings.weightE,
    };

    if (settings.customGradeWeightsJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(settings.customGradeWeightsJson);
        if (decoded is Map<String, dynamic>) {
          weightsMap = decoded.map(
            (k, v) => MapEntry(k.trim().toUpperCase(), (v as num).toDouble()),
          );
        }
      } catch (_) {}
    }

    return GradeConversionConfig(
      weights: weightsMap,
      minPassingGrade: settings.minPassingGrade,
      retakeRule: settings.retakeRule,
    );
  }

  static const List<String> orderedIndices = <String>[
    'A',
    'AB',
    'B',
    'BC',
    'C',
    'D',
    'E',
  ];

  static const Map<String, double> defaultWeights = <String, double>{
    'A': 4.0,
    'AB': 3.5,
    'B': 3.0,
    'BC': 2.5,
    'C': 2.0,
    'D': 1.0,
    'E': 0.0,
  };

  final Map<String, double> weights;
  final String minPassingGrade;
  final RetakeRule retakeRule;

  double weightOf(String gradeIndex) {
    final normalized = gradeIndex.trim().toUpperCase();
    return weights[normalized] ?? defaultWeights[normalized] ?? 0.0;
  }

  /// Nilai E selalu tidak lulus (wajib mengulang) sesuai PRD.md.
  bool isPassing(String gradeIndex) {
    final normalized = gradeIndex.trim().toUpperCase();
    if (normalized == 'E') return false;
    return weightOf(normalized) >= weightOf(minPassingGrade);
  }
}

/// Representasi satu kelompok mata kuliah (entri awal beserta riwayat mengulang).
class CourseGroupEvaluation {
  const CourseGroupEvaluation({
    required this.entries,
    required this.effectiveEntry,
    required this.isPassed,
    required this.needsRetake,
  });

  final List<CourseGrade> entries;
  final CourseGrade effectiveEntry;
  final bool isPassed;
  final bool needsRetake;
}

/// Ringkasan hasil perhitungan akademik keseluruhan.
class AcademicSummaryResult {
  const AcademicSummaryResult({
    required this.ipk,
    required this.ipsBySemester,
    required this.completedSks,
    required this.completedCoursesCount,
    required this.totalEffectiveSks,
    required this.gradeDistribution,
    required this.courseGroups,
  });

  final double ipk;
  final Map<int, double> ipsBySemester;
  final int completedSks;
  final int completedCoursesCount;
  final int totalEffectiveSks;
  final Map<String, int> gradeDistribution;
  final List<CourseGroupEvaluation> courseGroups;

  String get formattedIpk => GradeCalculator.formatScore(ipk);

  String formattedIpsFor(int semester) =>
      GradeCalculator.formatScore(ipsBySemester[semester] ?? 0.0);
}

/// Kalkulator murni untuk logika nilai sesuai bagian "Logika Perhitungan Nilai" PRD.md.
abstract final class GradeCalculator {
  static String formatScore(double value) => value.toStringAsFixed(2);

  /// Menghitung IPS historis untuk satu semester tertentu.
  static double calculateSemesterIps(
    Iterable<CourseGrade> allGrades,
    int semester, {
    GradeConversionConfig config = const GradeConversionConfig(),
  }) {
    var totalQualityPoints = 0.0;
    var totalSks = 0;
    for (final entry in allGrades) {
      if (entry.semester != semester || entry.sks <= 0) continue;
      totalQualityPoints += config.weightOf(entry.gradeIndex) * entry.sks;
      totalSks += entry.sks;
    }
    return totalSks == 0 ? 0.0 : totalQualityPoints / totalSks;
  }

  /// Menghitung seluruh metrik akademik (IPS per semester, IPK, SKS/MK selesai, sebaran).
  static AcademicSummaryResult evaluateAll(
    Iterable<CourseGrade> allGrades, {
    GradeConversionConfig config = const GradeConversionConfig(),
  }) {
    final validGrades = allGrades.where((g) => g.sks > 0).toList();
    final semesters = validGrades.map((e) => e.semester).toSet().toList()
      ..sort();
    final ipsBySemester = <int, double>{
      for (final s in semesters)
        s: calculateSemesterIps(validGrades, s, config: config),
    };

    final groups = _buildCourseGroups(validGrades, config);
    var totalQualityPoints = 0.0;
    var totalEffectiveSks = 0;
    var completedSks = 0;
    var completedCoursesCount = 0;

    final distribution = <String, int>{
      for (final idx in GradeConversionConfig.orderedIndices) idx: 0,
      for (final key in config.weights.keys) key: 0,
    };

    for (final group in groups) {
      final effective = group.effectiveEntry;
      final normalizedIndex = effective.gradeIndex.trim().toUpperCase();
      totalQualityPoints += config.weightOf(normalizedIndex) * effective.sks;
      totalEffectiveSks += effective.sks;
      distribution[normalizedIndex] = (distribution[normalizedIndex] ?? 0) + 1;

      if (group.isPassed) {
        completedSks += effective.sks;
        completedCoursesCount += 1;
      }
    }

    return AcademicSummaryResult(
      ipk: totalEffectiveSks == 0
          ? 0.0
          : totalQualityPoints / totalEffectiveSks,
      ipsBySemester: ipsBySemester,
      completedSks: completedSks,
      completedCoursesCount: completedCoursesCount,
      totalEffectiveSks: totalEffectiveSks,
      gradeDistribution: distribution,
      courseGroups: groups,
    );
  }

  /// Mencari kandidat entri sebelumnya bila nama mata kuliah sama (case-insensitive).
  static List<CourseGrade> suggestRetakeCandidates(
    Iterable<CourseGrade> allGrades,
    String courseName, {
    int? excludeId,
  }) {
    final normalizedTarget = courseName.trim().toLowerCase();
    if (normalizedTarget.isEmpty) return const <CourseGrade>[];
    return allGrades.where((entry) {
      if (excludeId != null && entry.id == excludeId) return false;
      return entry.courseName.trim().toLowerCase() == normalizedTarget;
    }).toList()..sort(_compareChronological);
  }

  static List<CourseGroupEvaluation> _buildCourseGroups(
    List<CourseGrade> grades,
    GradeConversionConfig config,
  ) {
    if (grades.isEmpty) return const <CourseGroupEvaluation>[];
    final n = grades.length;
    final idToIndex = <int, int>{for (var i = 0; i < n; i++) grades[i].id: i};
    final parent = List<int>.generate(n, (i) => i);

    int find(int x) {
      var root = x;
      while (parent[root] != root) {
        root = parent[root];
      }
      var curr = x;
      while (curr != root) {
        final nxt = parent[curr];
        parent[curr] = root;
        curr = nxt;
      }
      return root;
    }

    for (var i = 0; i < n; i++) {
      final targetId = grades[i].retakeOfId;
      if (targetId != null && idToIndex.containsKey(targetId)) {
        final rootA = find(idToIndex[targetId]!);
        final rootB = find(i);
        if (rootA != rootB) parent[rootB] = rootA;
      }
    }

    final groupedMap = <int, List<CourseGrade>>{};
    for (var i = 0; i < n; i++) {
      groupedMap.putIfAbsent(find(i), () => <CourseGrade>[]).add(grades[i]);
    }

    return groupedMap.values.map((entries) {
      entries.sort(_compareChronological);
      final effective = _selectEffectiveEntry(entries, config);
      return CourseGroupEvaluation(
        entries: List<CourseGrade>.unmodifiable(entries),
        effectiveEntry: effective,
        isPassed: config.isPassing(effective.gradeIndex),
        needsRetake: effective.gradeIndex.trim().toUpperCase() == 'E',
      );
    }).toList();
  }

  static CourseGrade _selectEffectiveEntry(
    List<CourseGrade> entries,
    GradeConversionConfig config,
  ) {
    var chosen = entries.first;
    for (var i = 1; i < entries.length; i++) {
      final candidate = entries[i];
      if (config.retakeRule == RetakeRule.latest) {
        if (_compareChronological(candidate, chosen) >= 0) chosen = candidate;
      } else {
        final candidateWeight = config.weightOf(candidate.gradeIndex);
        final chosenWeight = config.weightOf(chosen.gradeIndex);
        if (candidateWeight > chosenWeight ||
            (candidateWeight == chosenWeight &&
                _compareChronological(candidate, chosen) >= 0)) {
          chosen = candidate;
        }
      }
    }
    return chosen;
  }

  static int _compareChronological(CourseGrade a, CourseGrade b) {
    final semCmp = a.semester.compareTo(b.semester);
    if (semCmp != 0) return semCmp;
    final dateCmp = a.createdAt.compareTo(b.createdAt);
    return dateCmp != 0 ? dateCmp : a.id.compareTo(b.id);
  }
}
