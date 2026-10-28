import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/data/database/isar_service.dart';
import 'package:nguliah/data/models/academic_task_model.dart';

/// Repository akses data lokal untuk koleksi Tugas kuliah.
class TaskRepository {
  const TaskRepository(this._isar);

  final Isar _isar;

  Future<List<AcademicTask>> getAllTasks() {
    return _isar.academicTasks.where().sortByDueDate().findAll();
  }

  Stream<List<AcademicTask>> watchAllTasks() {
    return _isar.academicTasks.where().sortByDueDate().watch(
      fireImmediately: true,
    );
  }

  Future<Id> saveTask(AcademicTask task) {
    task.updatedAt = DateTime.now();
    return _isar.writeTxn(() => _isar.academicTasks.put(task));
  }

  Future<bool> deleteTask(Id id) {
    return _isar.writeTxn(() => _isar.academicTasks.delete(id));
  }
}

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.watch(isarProvider));
});
