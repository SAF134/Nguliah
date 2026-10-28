import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/features/settings/presentation/widgets/about_developer_sheets.dart';
import 'package:nguliah/features/settings/presentation/widgets/grade_conversion_sheet.dart';
import 'package:nguliah/features/settings/presentation/widgets/settings_tiles.dart';

/// Kartu grup preferensi (Tema, Bahasa, Konversi Nilai, Panduan Rumus).
class SettingsPreferencesCard extends ConsumerWidget {
  const SettingsPreferencesCard({
    required this.settings,
    required this.onOpenSheet,
    super.key,
  });

  final AppSettings settings;
  final void Function(Widget) onOpenSheet;

  Future<void> _update(WidgetRef ref, AppSettings updated) async {
    await ref.read(settingsRepositoryProvider).saveSettings(updated);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final l10n = context.l10n;
    final isDarkMode = settings.themeMode == 'dark';

    return GlassCard(
      borderColor: palette.primary,
      borderWidth: 1.5,
      padding: const EdgeInsets.symmetric(vertical: AppTokens.space8),
      child: Column(
        children: <Widget>[
          // Mode Tema
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.cardPadding,
              vertical: AppTokens.space8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      isDarkMode
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: palette.primary,
                    ),
                    const SizedBox(width: AppTokens.space12),
                    Expanded(
                      child: Text(
                        l10n.settingsThemeModeTitle,
                        style: AppTypography.title(palette.text900),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTokens.space8),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
                    segments: <ButtonSegment<String>>[
                      ButtonSegment<String>(
                        value: 'light',
                        label: Text(l10n.settingsThemeModeLight),
                        icon: const Icon(Icons.wb_sunny_outlined, size: 16),
                      ),
                      ButtonSegment<String>(
                        value: 'dark',
                        label: Text(l10n.settingsThemeModeDark),
                        icon: const Icon(Icons.nights_stay_outlined, size: 16),
                      ),
                    ],
                    selected: <String>{settings.themeMode},
                    onSelectionChanged: (val) {
                      final updated = _copySettings(
                        settings,
                        themeMode: val.first,
                      );
                      _update(ref, updated);
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Bahasa Aplikasi
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.cardPadding,
              vertical: AppTokens.space8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.language_rounded, color: palette.primary),
                    const SizedBox(width: AppTokens.space12),
                    Expanded(
                      child: Text(
                        l10n.settingsLanguageTitle,
                        style: AppTypography.title(palette.text900),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTokens.space8),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
                    segments: const <ButtonSegment<String>>[
                      ButtonSegment<String>(
                        value: 'id',
                        label: Text('Indonesia'),
                      ),
                      ButtonSegment<String>(
                        value: 'en',
                        label: Text('English'),
                      ),
                    ],
                    selected: <String>{settings.localeCode},
                    onSelectionChanged: (val) {
                      final updated = _copySettings(
                        settings,
                        localeCode: val.first,
                      );
                      _update(ref, updated);
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Konversi Nilai
          SettingsRowTile(
            icon: Icons.tune_rounded,
            title: l10n.settingsConversionTitle,
            subtitle: l10n.settingsConversionSubtitle,
            onTap: () => onOpenSheet(
              GradeConversionSheet(
                initialSettings: settings,
                onSave: (updated) => _update(ref, updated),
              ),
            ),
          ),
          const Divider(height: 1),
          // Sembunyikan Nilai Akademik (Sensor Bintang *)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.cardPadding,
              vertical: AppTokens.space8,
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  settings.hideAcademicScores
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: palette.primary,
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        l10n.settingsHideScoresTitle,
                        style: AppTypography.title(palette.text900),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.settingsHideScoresSubtitle,
                        style: AppTypography.caption(palette.text600),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: settings.hideAcademicScores,
                  onChanged: (val) {
                    final updated = _copySettings(
                      settings,
                      hideAcademicScores: val,
                    );
                    _update(ref, updated);
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Panduan Rumus
          SettingsRowTile(
            icon: Icons.functions_rounded,
            title: l10n.settingsFormulaGuideTitle,
            subtitle: l10n.settingsFormulaGuideSubtitle,
            onTap: () => onOpenSheet(const FormulaGuideSheet()),
          ),
        ],
      ),
    );
  }

  AppSettings _copySettings(
    AppSettings s, {
    String? themeMode,
    String? localeCode,
    bool? hideAcademicScores,
  }) {
    return AppSettings(
      id: 1,
      localeCode: localeCode ?? s.localeCode,
      themeMode: themeMode ?? s.themeMode,
      customGradeWeightsJson: s.customGradeWeightsJson,
      onboardingCompleted: s.onboardingCompleted,
      weightA: s.weightA,
      weightAB: s.weightAB,
      weightB: s.weightB,
      weightBC: s.weightBC,
      weightC: s.weightC,
      weightD: s.weightD,
      weightE: s.weightE,
      minPassingGrade: s.minPassingGrade,
      retakeRule: s.retakeRule,
      scheduleNotificationEnabled: s.scheduleNotificationEnabled,
      scheduleReminderOffsetMinutes: s.scheduleReminderOffsetMinutes,
      taskNotificationEnabled: s.taskNotificationEnabled,
      taskReminderOffsetMinutes: s.taskReminderOffsetMinutes,
      eventNotificationEnabled: s.eventNotificationEnabled,
      eventReminderOffsetMinutes: s.eventReminderOffsetMinutes,
      hideAcademicScores: hideAcademicScores ?? s.hideAcademicScores,
      lastBackupAt: s.lastBackupAt,
    );
  }
}
