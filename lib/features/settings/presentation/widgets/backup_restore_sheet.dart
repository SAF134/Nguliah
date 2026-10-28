import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nguliah/core/services/backup_service.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/core/widgets/slide_to_confirm.dart';
import 'package:nguliah/features/grades/application/grade_providers.dart';

/// Bottom sheet Backup & Restore JSON berstempel waktu dengan validasi skema & SlideToConfirm.
class BackupRestoreSheet extends ConsumerStatefulWidget {
  const BackupRestoreSheet({super.key});

  @override
  ConsumerState<BackupRestoreSheet> createState() => _BackupRestoreSheetState();
}

class _BackupRestoreSheetState extends ConsumerState<BackupRestoreSheet> {
  bool _isWorking = false;
  BackupDataBundle? _pendingRestoreBundle;
  String? _errorMessage;

  Future<void> _handleCreateBackup() async {
    final l10n = context.l10n;
    setState(() {
      _isWorking = true;
      _errorMessage = null;
    });
    try {
      await ref.read(backupServiceProvider).createAndShareBackupFile();
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.toastBackupCreated)));
      }
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = l10n.errorExportFailed);
      }
    } finally {
      if (mounted) {
        setState(() => _isWorking = false);
      }
    }
  }

  Future<void> _handlePickRestoreFile() async {
    final l10n = context.l10n;
    setState(() {
      _errorMessage = null;
      _pendingRestoreBundle = null;
    });

    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const <String>['json'],
      );
      if (files.isEmpty) return;
      final filePath = files.first.path;
      if (filePath == null) return;

      final rawJson = await File(filePath).readAsString();
      final validated = BackupService.parseAndValidateJson(rawJson);
      if (mounted) {
        setState(() => _pendingRestoreBundle = validated);
      }
    } on PlatformException {
      if (mounted) {
        setState(() => _errorMessage = l10n.permissionStorageDeniedBanner);
      }
    } on BackupFormatException {
      if (mounted) {
        setState(() => _errorMessage = l10n.errorBackupInvalid);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = l10n.errorBackupInvalid);
      }
    }
  }

  Future<void> _executeRestore(BackupDataBundle bundle) async {
    final l10n = context.l10n;
    setState(() => _isWorking = true);
    try {
      await ref.read(backupServiceProvider).applyRestoreBundle(bundle);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.toastRestoreSuccess)));
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isWorking = false;
          _errorMessage = l10n.errorBackupInvalid;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final settings = ref.watch(appSettingsStreamProvider).value;
    final lastBackup = settings?.lastBackupAt;

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
              l10n.settingsBackupTitle,
              style: AppTypography.h2(palette.text900),
            ),
            const SizedBox(height: AppTokens.space12),
            GlassCard(
              padding: const EdgeInsets.all(AppTokens.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    lastBackup != null
                        ? l10n.backupLastAtInfo(
                            DateFormat.yMMMd(localeName)
                                .add_Hm()
                                .format(lastBackup),
                          )
                        : l10n.backupNeverInfo,
                    style: AppTypography.title(palette.text900),
                  ),
                  const SizedBox(height: AppTokens.space8),
                  Text(
                    l10n.backupGuideBody,
                    style: AppTypography.body(palette.text600),
                  ),
                ],
              ),
            ),
            if (_errorMessage != null) ...<Widget>[
              const SizedBox(height: AppTokens.space12),
              Semantics(
                liveRegion: true,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.error_outline_rounded,
                      color: palette.error,
                      size: 18,
                    ),
                    const SizedBox(width: AppTokens.space8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: AppTypography.caption(palette.error),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppTokens.space16),
            if (_pendingRestoreBundle != null) ...<Widget>[
              Text(
                l10n.restoreConfirmTitle,
                style: AppTypography.title(palette.text900),
              ),
              const SizedBox(height: AppTokens.space4),
              Text(
                l10n.restoreConfirmDescription,
                style: AppTypography.body(palette.text600),
              ),
              const SizedBox(height: AppTokens.space12),
              SlideToConfirm(
                label: l10n.slideToRestoreLabel,
                variant: SlideToConfirmVariant.restore,
                onConfirmed: () => _executeRestore(_pendingRestoreBundle!),
              ),
              const SizedBox(height: AppTokens.space8),
              SecondaryButton(
                label: l10n.actionCancel,
                onPressed: () => setState(() => _pendingRestoreBundle = null),
              ),
            ] else ...<Widget>[
              PrimaryButton(
                label: l10n.actionCreateBackup,
                isLoading: _isWorking,
                onPressed: _handleCreateBackup,
              ),
              const SizedBox(height: AppTokens.space12),
              SecondaryButton(
                label: l10n.actionRestoreBackup,
                onPressed: _isWorking ? null : _handlePickRestoreFile,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
