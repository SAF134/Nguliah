import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/data/database/isar_service.dart';
import 'package:nguliah/data/models/course_grade_model.dart';

/// Repository akses data lokal untuk koleksi Nilai.
class GradeRepository {
  const GradeRepository(this._isar);

  final Isar _isar;

  Future<List<CourseGrade>> getAllGrades() {
    return _isar.courseGrades.where().sortBySemester().findAll();
  }

  Stream<List<CourseGrade>> watchAllGrades() {
    return _isar.courseGrades.where().sortBySemester().watch(
      fireImmediately: true,
    );
  }

  Future<Id> saveGrade(CourseGrade grade) {
    grade.updatedAt = DateTime.now();
    return _isar.writeTxn(() => _isar.courseGrades.put(grade));
  }

  Future<bool> deleteGrade(Id id) {
    return _isar.writeTxn(() => _isar.courseGrades.delete(id));
  }
}

final gradeRepositoryProvider = Provider<GradeRepository>((ref) {
  return GradeRepository(ref.watch(isarProvider));
});
