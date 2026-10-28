import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/data/models/user_profile_model.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/features/onboarding/application/onboarding_providers.dart';

/// Stream profil mahasiswa aktif untuk dipakai di seluruh aplikasi.
final currentUserProfileProvider = StreamProvider<UserProfile?>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfile();
});

/// Daftar pilihan tahun masuk (tahun berjalan + 1 hingga 14 tahun sebelumnya).
List<int> buildAvailableEntryYears([int? currentYear]) {
  final baseYear = currentYear ?? DateTime.now().year;
  return List<int>.generate(15, (index) => baseYear + 1 - index);
}

/// Menyimpan biodata mahasiswa ke repository lokal dan menandai onboarding selesai.
Future<void> saveStudentBiodata(
  WidgetRef ref, {
  required String name,
  required String university,
  required String faculty,
  required String major,
  required int entryYear,
  String? photoPath,
}) async {
  final profileRepo = ref.read(profileRepositoryProvider);
  final settingsRepo = ref.read(settingsRepositoryProvider);

  final profile = UserProfile(
    name: name.trim(),
    university: university.trim(),
    faculty: faculty.trim(),
    major: major.trim(),
    entryYear: entryYear,
    photoPath: photoPath,
    updatedAt: DateTime.now(),
  );

  await profileRepo.saveProfile(profile);

  final settings = await settingsRepo.getSettings();
  if (!settings.onboardingCompleted) {
    settings.onboardingCompleted = true;
    await settingsRepo.saveSettings(settings);
  }

  ref.invalidate(startupDestinationProvider);
}
