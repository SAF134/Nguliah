import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/repositories/event_repository.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';

/// Opsi tab penyaringan acara kampus.
enum EventFilterTab { active, completed }

/// Utilitas murni pemformatan waktu dan pemfilteran acara kampus.
abstract final class EventTimeUtils {
  /// Menghitung jumlah acara pada hari kalender tertentu.
  static int countEventsOnDay(List<AcademicEvent> events, DateTime day) {
    var count = 0;
    for (final event in events) {
      if (TaskDateUtils.isSameCalendarDay(event.eventDate, day)) {
        count++;
      }
    }
    return count;
  }

  /// Memformat menit dari 00:00 menjadi HH:MM.
  static String formatMinutes(int totalMinutes) {
    final clamped = totalMinutes.clamp(0, 1439);
    final h = (clamped ~/ 60).toString().padLeft(2, '0');
    final m = (clamped % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  /// Memformat rentang waktu acara (HH:MM - HH:MM).
  static String formatRange(int startMinutes, int endMinutes) {
    return '${formatMinutes(startMinutes)} – ${formatMinutes(endMinutes)}';
  }

  /// Menentukan apakah suatu acara sudah selesai (lewat waktu selesai atau ditandai selesai).
  static bool isPastEvent(AcademicEvent event, [DateTime? referenceTime]) {
    final now = referenceTime ?? DateTime.now();
    final endDateTime = DateTime(
      event.eventDate.year,
      event.eventDate.month,
      event.eventDate.day,
      event.endTimeMinutes ~/ 60,
      event.endTimeMinutes % 60,
    );
    return event.isCompleted || now.isAfter(endDateTime);
  }
}

/// Stream seluruh acara kampus yang diurutkan menurut tanggal & waktu mulai.
final eventsStreamProvider = StreamProvider<List<AcademicEvent>>((ref) {
  return ref.watch(eventRepositoryProvider).watchAllEvents();
});

class _SelectedEventTabNotifier extends Notifier<EventFilterTab> {
  @override
  EventFilterTab build() => EventFilterTab.active;

  void select(EventFilterTab tab) => state = tab;
}

/// Provider tab Aktif vs Selesai (Rekap).
final selectedEventTabProvider =
    NotifierProvider<_SelectedEventTabNotifier, EventFilterTab>(
      _SelectedEventTabNotifier.new,
    );

class _SelectedEventDateNotifier extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void select(DateTime? date) => state = date;
}

/// Provider filter tanggal kalender pada layar Acara (null = semua tanggal).
final selectedEventDateProvider =
    NotifierProvider<_SelectedEventDateNotifier, DateTime?>(
      _SelectedEventDateNotifier.new,
    );

class _FocusedEventMonthNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void setMonth(DateTime month) => state = month;
}

/// Provider bulan fokus pada kalender layar Acara.
final focusedEventMonthProvider =
    NotifierProvider<_FocusedEventMonthNotifier, DateTime>(
      _FocusedEventMonthNotifier.new,
    );

/// Provider daftar acara yang telah difilter berdasarkan tanggal kalender & tab terpilih.
final filteredEventsProvider = Provider<AsyncValue<List<AcademicEvent>>>((ref) {
  final eventsAsync = ref.watch(eventsStreamProvider);
  final selectedDate = ref.watch(selectedEventDateProvider);
  final selectedTab = ref.watch(selectedEventTabProvider);

  return eventsAsync.whenData((events) {
    var filtered = events;
    if (selectedDate != null) {
      filtered = filtered
          .where(
            (event) =>
                TaskDateUtils.isSameCalendarDay(event.eventDate, selectedDate),
          )
          .toList();
    }
    final now = DateTime.now();
    if (selectedTab == EventFilterTab.active) {
      return filtered
          .where((e) => !EventTimeUtils.isPastEvent(e, now))
          .toList();
    } else {
      return filtered.where((e) => EventTimeUtils.isPastEvent(e, now)).toList();
    }
  });
});
