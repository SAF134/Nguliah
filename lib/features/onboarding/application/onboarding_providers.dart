import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/router/app_routes.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';

/// Menentukan rute tujuan awal saat aplikasi dibuka dari Splash Screen:
/// - Pengguna baru (belum onboarding) -> `/onboarding`
/// - Sudah onboarding tetapi profil belum diisi -> `/auth`
/// - Pengguna lama (profil sudah terisi) -> `/home`
final startupDestinationProvider = FutureProvider<String>((ref) async {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  final profileRepo = ref.watch(profileRepositoryProvider);

  final settings = await settingsRepo.getSettings();
  if (!settings.onboardingCompleted) {
    return AppRoutes.onboarding;
  }

  final profile = await profileRepo.getProfile();
  if (profile == null || profile.name.trim().isEmpty) {
    return AppRoutes.auth;
  }

  return AppRoutes.home;
});

/// Menandai bahwa pengguna telah menyelesaikan/melewati Onboarding.
Future<void> markOnboardingCompleted(WidgetRef ref) async {
  final settingsRepo = ref.read(settingsRepositoryProvider);
  final settings = await settingsRepo.getSettings();
  settings.onboardingCompleted = true;
  await settingsRepo.saveSettings(settings);
  ref.invalidate(startupDestinationProvider);
}
