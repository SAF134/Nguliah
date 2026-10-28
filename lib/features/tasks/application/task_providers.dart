import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/repositories/task_repository.dart';

/// Tab filter daftar tugas (Aktif vs Selesai/Rekap).
enum TaskFilterTab { active, completed }

/// Utilitas murni pemformatan tanggal, waktu, dan pemfilteran tugas.
abstract final class TaskDateUtils {
  /// Memeriksa apakah dua tanggal berada pada hari kalender yang sama.
  static bool isSameCalendarDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Menghitung jumlah tugas (aktif maupun selesai) pada hari kalender tertentu.
  static int countTasksOnDay(List<AcademicTask> tasks, DateTime day) {
    var count = 0;
    for (final task in tasks) {
      if (isSameCalendarDay(task.dueDate, day)) {
        count++;
      }
    }
    return count;
  }

  /// Memformat DateTime menjadi YYYY-MM-DD.
  static String formatIsoDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Mem-parsing string YYYY-MM-DD menjadi DateTime (tanpa jam).
  static DateTime? tryParseIsoDate(String input) {
    final trimmed = input.trim();
    final parts = trimmed.split('-');
    if (parts.length != 3) return null;
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return null;
    if (year < 2000 || year > 2100 || month < 1 || month > 12 || day < 1) {
      return null;
    }
    final candidate = DateTime(year, month, day);
    if (candidate.year != year ||
        candidate.month != month ||
        candidate.day != day) {
      return null;
    }
    return candidate;
  }

  /// Memformat jam dan menit menjadi HH:MM.
  static String formatTimeHm(int hour, int minute) {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  /// Mem-parsing string HH:MM menjadi total menit dari 00:00 (0..1439).
  static int? tryParseTimeMinutes(String input) {
    final trimmed = input.trim();
    final parts = trimmed.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
    return hour * 60 + minute;
  }
}

/// Stream seluruh tugas kuliah yang diurutkan menurut tenggat waktu.
final tasksStreamProvider = StreamProvider<List<AcademicTask>>((ref) {
  return ref.watch(taskRepositoryProvider).watchAllTasks();
});

class _SelectedTaskTabNotifier extends Notifier<TaskFilterTab> {
  @override
  TaskFilterTab build() => TaskFilterTab.active;

  void select(TaskFilterTab tab) => state = tab;
}

/// Provider tab tugas terpilih (Aktif atau Selesai).
final selectedTaskTabProvider =
    NotifierProvider<_SelectedTaskTabNotifier, TaskFilterTab>(
      _SelectedTaskTabNotifier.new,
    );

class _SelectedTaskDateNotifier extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void select(DateTime? date) => state = date;
}

/// Provider filter tanggal kalender pada layar Tugas (null = semua tanggal).
final selectedTaskDateProvider =
    NotifierProvider<_SelectedTaskDateNotifier, DateTime?>(
      _SelectedTaskDateNotifier.new,
    );

class _FocusedTaskMonthNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void setMonth(DateTime month) => state = month;
}

/// Provider bulan fokus pada kalender layar Tugas.
final focusedTaskMonthProvider =
    NotifierProvider<_FocusedTaskMonthNotifier, DateTime>(
      _FocusedTaskMonthNotifier.new,
    );

/// Provider daftar tugas yang telah difilter berdasarkan tab & tanggal kalender.
final filteredTasksProvider = Provider<AsyncValue<List<AcademicTask>>>((ref) {
  final tasksAsync = ref.watch(tasksStreamProvider);
  final selectedTab = ref.watch(selectedTaskTabProvider);
  final selectedDate = ref.watch(selectedTaskDateProvider);

  return tasksAsync.whenData((tasks) {
    final byTab = tasks.where((task) {
      final matchesTab = selectedTab == TaskFilterTab.active
          ? !task.isCompleted
          : task.isCompleted;
      if (!matchesTab) return false;
      if (selectedDate != null) {
        return TaskDateUtils.isSameCalendarDay(task.dueDate, selectedDate);
      }
      return true;
    }).toList();

    if (selectedTab == TaskFilterTab.active) {
      byTab.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else {
      byTab.sort((a, b) {
        final aTime = a.completedAt ?? a.updatedAt;
        final bTime = b.completedAt ?? b.updatedAt;
        return bTime.compareTo(aTime);
      });
    }
    return byTab;
  });
});
