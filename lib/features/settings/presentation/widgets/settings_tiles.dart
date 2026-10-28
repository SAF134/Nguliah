import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/profile_avatar.dart';
import 'package:nguliah/data/models/user_profile_model.dart';

/// Kartu header profil mahasiswa pada layar Pengaturan.
class SettingsProfileHeaderCard extends StatelessWidget {
  const SettingsProfileHeaderCard({
    required this.profile,
    required this.onTapEdit,
    super.key,
  });

  final UserProfile? profile;
  final VoidCallback onTapEdit;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final studentName = profile?.name ?? l10n.homeDefaultStudentName;
    final avatarPath = profile?.photoPath;

    return GlassCard(
      onTap: onTapEdit,
      borderColor: palette.primary,
      borderWidth: 1.5,
      padding: const EdgeInsets.all(AppTokens.cardPadding),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: palette.primary, width: 2),
            ),
            child: ProfileAvatar(
              name: studentName,
              photoPath: avatarPath,
              radius: AppTokens.space24,
            ),
          ),
          const SizedBox(width: AppTokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(studentName, style: AppTypography.title(palette.text900)),
                const SizedBox(height: 2),
                Text(
                  profile != null
                      ? '${profile!.major} · ${profile!.university}'
                      : l10n.settingsEditProfileSubtitle,
                  style: AppTypography.caption(palette.text600),
                ),
              ],
            ),
          ),
          Semantics(
            button: true,
            label: l10n.actionEdit,
            child: IconButton(
              constraints: const BoxConstraints(
                minWidth: AppTokens.minTouchTarget,
                minHeight: AppTokens.minTouchTarget,
              ),
              tooltip: l10n.actionEdit,
              onPressed: onTapEdit,
              style: IconButton.styleFrom(
                backgroundColor: palette.primary.withValues(alpha: 0.12),
                foregroundColor: palette.primary,
              ),
              icon: const Icon(Icons.edit_outlined, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

/// Judul grup menu pada layar Pengaturan.
class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      header: true,
      child: Text(title, style: AppTypography.h2(palette.text900)),
    );
  }
}

/// Baris menu navigasi pada layar Pengaturan.
class SettingsRowTile extends StatelessWidget {
  const SettingsRowTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppTokens.minTouchTarget),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.cardPadding,
          vertical: AppTokens.space12,
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, color: palette.primary),
            const SizedBox(width: AppTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: AppTypography.title(palette.text900)),
                  Text(subtitle, style: AppTypography.caption(palette.text600)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: palette.text500),
          ],
        ),
      ),
    );
  }
}
