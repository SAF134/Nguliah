import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nguliah/core/router/app_routes.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';

/// Banner peringatan ketika izin notifikasi ditolak sesuai DESIGN.md bagian 8.
class NotificationPermissionBanner extends StatelessWidget {
  const NotificationPermissionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return Semantics(
      liveRegion: true,
      child: GlassCard(
        padding: const EdgeInsets.all(AppTokens.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.notifications_off_outlined,
                  color: palette.warning,
                  size: 20,
                ),
                const SizedBox(width: AppTokens.space8),
                Expanded(
                  child: Text(
                    l10n.permissionNotificationDeniedBanner,
                    style: AppTypography.caption(palette.text900),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.space4),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(
                    AppTokens.minTouchTarget,
                    AppTokens.minTouchTarget,
                  ),
                ),
                onPressed: () {
                  final router = GoRouter.maybeOf(context);
                  if (router != null) {
                    router.push(AppRoutes.settings);
                  }
                },
                child: Text(
                  l10n.actionOpenSettings,
                  style: AppTypography.caption(palette.primary)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
