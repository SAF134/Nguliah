import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nguliah/core/services/export_service.dart';
import 'package:nguliah/core/services/notification_service.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/confirm_dialog.dart';
import 'package:nguliah/core/widgets/export_sheet.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/repositories/event_repository.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/schedule_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/data/repositories/task_repository.dart';
import 'package:nguliah/features/grades/application/grade_providers.dart';
import 'package:nguliah/features/home/application/home_providers.dart';
import 'package:nguliah/features/settings/presentation/widgets/about_developer_sheets.dart';
import 'package:nguliah/features/settings/presentation/widgets/backup_restore_sheet.dart';
import 'package:nguliah/features/settings/presentation/widgets/notification_settings_sheet.dart';
import 'package:nguliah/features/settings/presentation/widgets/profile_edit_sheet.dart';
import 'package:nguliah/features/settings/presentation/widgets/settings_preferences_card.dart';
import 'package:nguliah/features/settings/presentation/widgets/settings_tiles.dart';

/// Layar Pengaturan lengkap dengan preferensi tema, ekspor data & keluar akun.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _showSheet(BuildContext context, Widget child) async {
    final palette = context.palette;
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTokens.radius2xl),
        ),
      ),
      builder: (_) => child,
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'Keluar Akun',
      message: 'Apakah Anda yakin ingin keluar ke halaman masuk profil?',
      confirmLabel: l10n.actionYes,
      cancelLabel: l10n.actionNo,
    );
    if (!confirmed || !context.mounted) return;
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final l10n = context.l10n;
    final profile = ref.watch(userProfileStreamProvider).value;
    final settings =
        ref.watch(appSettingsStreamProvider).value ?? AppSettings();

    return Scaffold(
      backgroundColor: palette.bg,
      appBar: AppBar(title: Text(l10n.screenSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppTokens.screenMargin),
        children: <Widget>[
          SettingsSectionTitle(title: l10n.settingsGroupAccount),
          const SizedBox(height: AppTokens.space8),
          SettingsProfileHeaderCard(
            profile: profile,
            onTapEdit: () => _showSheet(
              context,
              ProfileEditSheet(
                initialProfile: profile,
                onSave: (updated) async {
                  await ref
                      .read(profileRepositoryProvider)
                      .saveProfile(updated);
                },
              ),
            ),
          ),
          const SizedBox(height: AppTokens.space20),
          SettingsSectionTitle(title: l10n.settingsGroupPreferences),
          const SizedBox(height: AppTokens.space8),
          SettingsPreferencesCard(
            settings: settings,
            onOpenSheet: (sheet) => _showSheet(context, sheet),
          ),
          const SizedBox(height: AppTokens.space20),
          SettingsSectionTitle(title: l10n.settingsGroupData),
          const SizedBox(height: AppTokens.space8),
          GlassCard(
            borderColor: palette.primary,
            borderWidth: 1.5,
            padding: const EdgeInsets.symmetric(vertical: AppTokens.space8),
            child: Column(
              children: <Widget>[
                SettingsRowTile(
                  icon: Icons.notifications_active_outlined,
                  title: l10n.settingsNotificationsTitle,
                  subtitle: l10n.settingsNotificationsSubtitle,
                  onTap: () => _showSheet(
                    context,
                    NotificationSettingsSheet(
                      initialSettings: settings,
                      onSave: (updated) async {
                        await ref
                            .read(settingsRepositoryProvider)
                            .saveSettings(updated);
                        final s = await ref
                            .read(scheduleRepositoryProvider)
                            .getAllSchedules();
                        final t = await ref
                            .read(taskRepositoryProvider)
                            .getAllTasks();
                        final e = await ref
                            .read(eventRepositoryProvider)
                            .getAllEvents();
                        await ref
                            .read(notificationServiceProvider)
                            .rescheduleAll(
                              settings: updated,
                              schedules: s,
                              tasks: t,
                              events: e,
                            );
                      },
                    ),
                  ),
                ),
                const Divider(height: 1),
                SettingsRowTile(
                  icon: Icons.backup_outlined,
                  title: l10n.settingsBackupTitle,
                  subtitle: l10n.settingsBackupSubtitle,
                  onTap: () => _showSheet(context, const BackupRestoreSheet()),
                ),
                const Divider(height: 1),
                SettingsRowTile(
                  icon: Icons.ios_share_rounded,
                  title: 'Ekspor Data Akademik',
                  subtitle: 'Transkrip Nilai, Jadwal, & Rekap Presensi',
                  onTap: () => ExportSheet.show(
                    context,
                    initialScope: ExportScope.allGrades,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.space20),
          SettingsSectionTitle(title: l10n.settingsGroupAbout),
          const SizedBox(height: AppTokens.space8),
          GlassCard(
            borderColor: palette.primary,
            borderWidth: 1.5,
            padding: const EdgeInsets.symmetric(vertical: AppTokens.space8),
            child: Column(
              children: <Widget>[
                SettingsRowTile(
                  icon: Icons.info_outline_rounded,
                  title: l10n.settingsAboutAppTitle,
                  subtitle: l10n.settingsAboutAppSubtitle,
                  onTap: () => _showSheet(context, const AboutAppSheet()),
                ),
                const Divider(height: 1),
                SettingsRowTile(
                  icon: Icons.favorite_border_rounded,
                  title: l10n.settingsAboutDevTitle,
                  subtitle: l10n.settingsAboutDevSubtitle,
                  onTap: () => _showSheet(context, const AboutDeveloperSheet()),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.space24),
          SecondaryButton(
            label: l10n.settingsLogoutTitle,
            icon: Icons.logout_rounded,
            variant: SecondaryButtonVariant.danger,
            fullWidth: true,
            onPressed: () => _confirmLogout(context),
          ),
          const SizedBox(height: AppTokens.space24),
        ],
      ),
    );
  }
}
