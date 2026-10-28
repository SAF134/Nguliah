import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/models/user_profile_model.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/features/events/application/event_providers.dart';
import 'package:nguliah/features/schedule/application/schedule_providers.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';

/// Stream profil mahasiswa lokal dari repository.
final userProfileStreamProvider = StreamProvider<UserProfile?>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfile();
});

/// Provider jadwal kuliah pada hari ini (berdasarkan DateTime.now().weekday).
final todaySchedulesProvider = Provider<List<CourseSchedule>>((ref) {
  final schedules =
      ref.watch(allSchedulesStreamProvider).value ?? const <CourseSchedule>[];
  final todayWeekday = DateTime.now().weekday;
  return schedules.where((s) => s.dayOfWeek == todayWeekday).toList();
});

/// Provider daftar tugas aktif dengan tenggat dalam 7 hari ke depan (termasuk terlambat).
final weekUpcomingTasksProvider = Provider<List<AcademicTask>>((ref) {
  final tasks = ref.watch(tasksStreamProvider).value ?? const <AcademicTask>[];
  final horizon = DateTime.now().add(const Duration(days: 7));
  return tasks
      .where((t) => !t.isCompleted && !t.dueDate.isAfter(horizon))
      .toList();
});

/// Provider daftar acara kampus aktif dalam 7 hari ke depan.
final weekUpcomingEventsProvider = Provider<List<AcademicEvent>>((ref) {
  final events =
      ref.watch(eventsStreamProvider).value ?? const <AcademicEvent>[];
  final now = DateTime.now();
  final startOfToday = DateTime(now.year, now.month, now.day);
  final horizon = startOfToday.add(
    const Duration(days: 7, hours: 23, minutes: 59),
  );
  return events
      .where(
        (e) =>
            !EventTimeUtils.isPastEvent(e, now) &&
            !e.eventDate.isBefore(startOfToday) &&
            !e.eventDate.isAfter(horizon),
      )
      .toList()
    ..sort((a, b) => a.eventDate.compareTo(b.eventDate));
});
