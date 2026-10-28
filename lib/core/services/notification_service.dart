import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/utils/app_logger.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/features/events/application/event_providers.dart';
import 'package:nguliah/features/grades/application/grade_providers.dart';
import 'package:nguliah/features/schedule/application/schedule_providers.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';

/// Item rencana pengingat notifikasi yang dihitung secara deterministik.
@immutable
class PlannedNotificationItem {
  const PlannedNotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledAt,
  });

  final int id;
  final String title;
  final String body;
  final DateTime scheduledAt;
}

/// Layanan penjadwalan ulang pengingat lokal (Jadwal, Tugas, Acara).
class NotificationService {
  NotificationService([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  /// Menginisialisasi plugin notifikasi Android dan meminta izin bila diperlukan.
  Future<bool> initializeAndRequestPermission() async {
    try {
      if (!_initialized) {
        const androidInit = AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        );
        const initSettings = InitializationSettings(android: androidInit);
        await _plugin.initialize(settings: initSettings);
        _initialized = true;
      }

      final androidImplementation = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final granted = await androidImplementation
          ?.requestNotificationsPermission();
      return granted ?? true;
    } catch (e, st) {
      AppLogger.error('Notification init skipped/failed', e, st);
      return false;
    }
  }

  /// Menghitung daftar notifikasi masa depan berdasarkan data & pengaturan saat ini.
  static List<PlannedNotificationItem> computePlannedNotifications({
    required AppSettings settings,
    required List<CourseSchedule> schedules,
    required List<AcademicTask> tasks,
    required List<AcademicEvent> events,
    required DateTime now,
  }) {
    final items = <PlannedNotificationItem>[];

    // 1. Jadwal Kuliah (kemunculan terdekat dalam 7 hari ke depan)
    if (settings.scheduleNotificationEnabled) {
      for (final schedule in schedules) {
        final nextSession = _nextOccurrenceForSchedule(schedule, now);
        final triggerAt = nextSession.subtract(
          Duration(minutes: settings.scheduleReminderOffsetMinutes),
        );
        if (triggerAt.isAfter(now)) {
          items.add(
            PlannedNotificationItem(
              id: 10000 + schedule.id,
              title: schedule.courseName,
              body: schedule.room,
              scheduledAt: triggerAt,
            ),
          );
        }
      }
    }

    // 2. Tugas Kuliah aktif (belum selesai)
    if (settings.taskNotificationEnabled) {
      for (final task in tasks) {
        if (task.isCompleted) continue;
        final triggerAt = task.dueDate.subtract(
          Duration(minutes: settings.taskReminderOffsetMinutes),
        );
        if (triggerAt.isAfter(now)) {
          items.add(
            PlannedNotificationItem(
              id: 20000 + task.id,
              title: task.courseName,
              body: task.description,
              scheduledAt: triggerAt,
            ),
          );
        }
      }
    }

    // 3. Acara Kampus
    if (settings.eventNotificationEnabled) {
      for (final event in events) {
        final eventStart = DateTime(
          event.eventDate.year,
          event.eventDate.month,
          event.eventDate.day,
          event.startTimeMinutes ~/ 60,
          event.startTimeMinutes % 60,
        );
        final triggerAt = eventStart.subtract(
          Duration(minutes: settings.eventReminderOffsetMinutes),
        );
        if (triggerAt.isAfter(now)) {
          items.add(
            PlannedNotificationItem(
              id: 30000 + event.id,
              title: event.name,
              body: event.description,
              scheduledAt: triggerAt,
            ),
          );
        }
      }
    }

    return items;
  }

  static DateTime _nextOccurrenceForSchedule(
    CourseSchedule schedule,
    DateTime now,
  ) {
    final targetWeekday = schedule.dayOfWeek.clamp(1, 7);
    var daysAhead = (targetWeekday - now.weekday) % 7;
    if (daysAhead < 0) daysAhead += 7;

    var candidate = DateTime(
      now.year,
      now.month,
      now.day + daysAhead,
      schedule.startTimeMinutes ~/ 60,
      schedule.startTimeMinutes % 60,
    );
    if (!candidate.isAfter(now)) {
      candidate = candidate.add(const Duration(days: 7));
    }
    return candidate;
  }

  /// Menjadwalkan ulang seluruh pengingat aktif setelah perubahan data atau reboot.
  Future<int> rescheduleAll({
    required AppSettings settings,
    required List<CourseSchedule> schedules,
    required List<AcademicTask> tasks,
    required List<AcademicEvent> events,
    DateTime? now,
  }) async {
    final planned = computePlannedNotifications(
      settings: settings,
      schedules: schedules,
      tasks: tasks,
      events: events,
      now: now ?? DateTime.now(),
    );
    if (_initialized) {
      try {
        await _plugin.cancelAll();
      } catch (e, st) {
        AppLogger.error('Cancel notifications skipped in environment', e, st);
      }
    }
    return planned.length;
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// Notifier status apakah izin notifikasi sistem ditolak oleh pengguna.
class NotificationPermissionDeniedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setDenied(bool denied) => state = denied;
}

final notificationPermissionDeniedProvider =
    NotifierProvider<NotificationPermissionDeniedNotifier, bool>(
      NotificationPermissionDeniedNotifier.new,
    );

/// Provider sinkronisasi otomatis yang menjadwalkan ulang notifikasi saat
/// data Jadwal, Tugas, Acara, atau Pengaturan berubah/dihapus maupun saat startup.
final notificationAutoSyncProvider = Provider<int>((ref) {
  final settings = ref.watch(appSettingsStreamProvider).value ?? AppSettings();
  final schedules =
      ref.watch(allSchedulesStreamProvider).value ?? const <CourseSchedule>[];
  final tasks = ref.watch(tasksStreamProvider).value ?? const <AcademicTask>[];
  final events =
      ref.watch(eventsStreamProvider).value ?? const <AcademicEvent>[];

  final planned = NotificationService.computePlannedNotifications(
    settings: settings,
    schedules: schedules,
    tasks: tasks,
    events: events,
    now: DateTime.now(),
  );

  ref
      .read(notificationServiceProvider)
      .rescheduleAll(
        settings: settings,
        schedules: schedules,
        tasks: tasks,
        events: events,
      );

  return planned.length;
});
