import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nguliah/core/router/app_routes.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/profile_avatar.dart';
import 'package:nguliah/features/home/application/home_providers.dart';

/// Header atas paten (tetap berada di atas saat halaman digulir)
/// Seragam untuk halaman Beranda, Nilai, Jadwal, Tugas, dan Acara.
class AppFixedTopHeader extends ConsumerWidget {
  const AppFixedTopHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final l10n = context.l10n;
    final profile = ref.watch(userProfileStreamProvider).value;

    final studentName = (profile?.name.trim().isNotEmpty ?? false)
        ? profile!.name.trim()
        : l10n.homeDefaultStudentName;
    final photoPath = profile?.photoPath;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppTokens.glassBlurSigma,
          sigmaY: AppTokens.glassBlurSigma,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: palette.glass,
            border: Border(
              bottom: BorderSide(color: palette.primary, width: 1.5),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: palette.primary.withValues(alpha: 0.15),
                offset: const Offset(0, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.screenMargin,
                vertical: AppTokens.space8,
              ),
              child: Row(
                children: <Widget>[
                  // Pojok Kiri: Avatar Foto Profil + Nama Mahasiswa
                  ProfileAvatar(
                    name: studentName,
                    photoPath: photoPath,
                    radius: AppTokens.space20,
                  ),
                  const SizedBox(width: AppTokens.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          studentName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.title(palette.text900),
                        ),
                      ],
                    ),
                  ),
                  // Pojok Kanan: Tombol ke Pengaturan
                  Semantics(
                    button: true,
                    label: l10n.semanticsOpenSettings,
                    child: IconButton(
                      constraints: const BoxConstraints(
                        minWidth: AppTokens.minTouchTarget,
                        minHeight: AppTokens.minTouchTarget,
                      ),
                      tooltip: l10n.semanticsOpenSettings,
                      icon: Icon(
                        Icons.settings_outlined,
                        color: palette.primary,
                        size: AppTokens.space24,
                      ),
                      onPressed: () => context.push(AppRoutes.settings),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
