import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:nguliah/data/database/isar_service.dart';
import 'package:nguliah/data/models/user_profile_model.dart';

/// Repository akses data lokal untuk koleksi Profil.
class ProfileRepository {
  const ProfileRepository(this._isar);

  final Isar _isar;

  Future<UserProfile?> getProfile() {
    return _isar.userProfiles.get(1);
  }

  Stream<UserProfile?> watchProfile() {
    return _isar.userProfiles.watchObject(1, fireImmediately: true);
  }

  Future<void> saveProfile(UserProfile profile) async {
    profile
      ..id = 1
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.userProfiles.put(profile);
    });
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(isarProvider));
});
