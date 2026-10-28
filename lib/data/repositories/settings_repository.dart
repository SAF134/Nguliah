import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/data/database/isar_service.dart';
import 'package:nguliah/data/models/app_settings_model.dart';

/// Repository akses data lokal untuk koleksi Pengaturan aplikasi.
class SettingsRepository {
  const SettingsRepository(this._isar);

  final Isar _isar;

  Future<AppSettings> getSettings() async {
    final existing = await _isar.appSettings.get(1);
    if (existing != null) {
      return existing;
    }
    final defaults = AppSettings();
    await _isar.writeTxn(() => _isar.appSettings.put(defaults));
    return defaults;
  }

  Stream<AppSettings?> watchSettings() {
    return _isar.appSettings.watchObject(1, fireImmediately: true);
  }

  Future<void> saveSettings(AppSettings settings) async {
    settings.id = 1;
    await _isar.writeTxn(() => _isar.appSettings.put(settings));
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(isarProvider));
});
