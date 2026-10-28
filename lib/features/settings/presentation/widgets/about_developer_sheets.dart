import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/export_preview_card.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

export 'package:nguliah/features/settings/presentation/widgets/formula_guide_sheet.dart';

/// Bottom sheet Tentang Aplikasi.
class AboutAppSheet extends StatelessWidget {
  const AboutAppSheet({super.key});

  static const String appVersion = '1.0.0';
  static const String githubRepoUrl = 'https://github.com/SAF134/Nguliah';

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTokens.screenMargin,
        AppTokens.space20,
        AppTokens.screenMargin,
        AppTokens.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.settingsAboutAppTitle,
            style: AppTypography.h2(palette.text900),
          ),
          const SizedBox(height: AppTokens.space8),
          Text(
            '${l10n.settingsAboutAppSubtitle} (v$appVersion)',
            style: AppTypography.caption(palette.primary)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTokens.space12),
          Text(
            l10n.aboutAppDescription,
            style: AppTypography.body(palette.text700),
          ),
          const SizedBox(height: AppTokens.space12),
          Text(
            l10n.aboutAppLicenseLabel,
            style: AppTypography.caption(palette.text600),
          ),
          const SizedBox(height: AppTokens.space4),
          SelectableText(
            githubRepoUrl,
            style: AppTypography.caption(palette.primary),
          ),
          const SizedBox(height: AppTokens.space24),
          SecondaryButton(
            label: l10n.actionClose,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet Tentang Pengembang, Foto, QRIS & Panduan folder gambar.
class AboutDeveloperSheet extends StatefulWidget {
  const AboutDeveloperSheet({super.key});

  @override
  State<AboutDeveloperSheet> createState() => _AboutDeveloperSheetState();
}

class _AboutDeveloperSheetState extends State<AboutDeveloperSheet> {
  final GlobalKey _qrisBoundaryKey = GlobalKey();

  Future<void> _saveAndShareQris() async {
    final l10n = context.l10n;
    try {
      final pngBytes = await ExportPreviewCard.capturePngBytes(
        _qrisBoundaryKey,
      );
      if (pngBytes == null) return;
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/nguliah_qris.png');
      await file.writeAsBytes(pngBytes);
      await SharePlus.instance.share(
        ShareParams(files: <XFile>[XFile(file.path)]),
      );
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.toastExportSuccess)));
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTokens.screenMargin,
        AppTokens.space20,
        AppTokens.screenMargin,
        AppTokens.space24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              l10n.settingsAboutDevTitle,
              style: AppTypography.h2(palette.text900),
            ),
            const SizedBox(height: AppTokens.space16),
            GlassCard(
              padding: const EdgeInsets.all(AppTokens.space16),
              borderColor: palette.primary.withValues(alpha: 0.3),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppTokens.radiusFull),
                    child: Image.asset(
                      'assets/images/developer.jpg',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: palette.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: 36,
                          color: palette.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTokens.space16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Syauqi Akmal Fadhali',
                          style: AppTypography.title(palette.text900),
                        ),
                        const SizedBox(height: AppTokens.space4),
                        Text(
                          'Pengembang Aplikasi Nguliah',
                          style: AppTypography.caption(palette.primary),
                        ),
                        const SizedBox(height: AppTokens.space4),
                        Text(
                          'Membangun aplikasi berbasis offline-first untuk meningkatkan produktivitas mahasiswa.',
                          style: AppTypography.caption(palette.text600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.space16),
            GlassCard(
              padding: const EdgeInsets.all(AppTokens.cardPadding),
              borderColor: palette.primary.withValues(alpha: 0.3),
              child: Column(
                children: <Widget>[
                  Text(
                    l10n.qrisCardTitle,
                    style: AppTypography.title(palette.text900),
                  ),
                  const SizedBox(height: AppTokens.space12),
                  RepaintBoundary(
                    key: _qrisBoundaryKey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                      child: Image.asset(
                        'assets/images/qris.png',
                        width: 180,
                        height: 180,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) =>
                            const _StaticQrisArtwork(size: 180),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.space12),
            Container(
              padding: const EdgeInsets.all(AppTokens.space12),
              decoration: BoxDecoration(
                color: palette.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                border: Border.all(
                  color: palette.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.info_outline_rounded,
                    color: palette.primary,
                    size: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.space20),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: l10n.actionClose,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: SecondaryButton(
                    label: l10n.actionExport,
                    icon: Icons.download_rounded,
                    onPressed: _saveAndShareQris,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StaticQrisArtwork extends StatelessWidget {
  const _StaticQrisArtwork({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppTokens.lightSurface,
        borderRadius: BorderRadius.circular(AppTokens.radiusLg),
        border: Border.all(color: context.palette.border, width: 2),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.qr_code_2_rounded,
            size: size * 0.65,
            color: AppTokens.lightText900,
          ),
          Text(
            'QRIS · Nguliah',
            style: AppTypography.caption(AppTokens.lightText900)
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
