import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/data/database/isar_service.dart';
import 'package:nguliah/data/models/academic_event_model.dart';

/// Repository akses data lokal untuk koleksi Acara kampus.
class EventRepository {
  const EventRepository(this._isar);

  final Isar _isar;

  Future<List<AcademicEvent>> getAllEvents() {
    return _isar.academicEvents
        .where()
        .sortByEventDate()
        .thenByStartTimeMinutes()
        .findAll();
  }

  Stream<List<AcademicEvent>> watchAllEvents() {
    return _isar.academicEvents
        .where()
        .sortByEventDate()
        .thenByStartTimeMinutes()
        .watch(fireImmediately: true);
  }

  Future<Id> saveEvent(AcademicEvent event) {
    event.updatedAt = DateTime.now();
    return _isar.writeTxn(() => _isar.academicEvents.put(event));
  }

  Future<bool> deleteEvent(Id id) {
    return _isar.writeTxn(() => _isar.academicEvents.delete(id));
  }
}

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository(ref.watch(isarProvider));
});
