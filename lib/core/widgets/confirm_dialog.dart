import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/destructive_button.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';

/// Dialog konfirmasi aksi destruktif (hapus/timpa data) sesuai DESIGN.md bagian 7.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    required this.title,
    required this.message,
    this.confirmLabel,
    this.cancelLabel,
    this.isDestructive = true,
    super.key,
  });

  final String title;
  final String message;
  final String? confirmLabel;
  final String? cancelLabel;
  final bool isDestructive;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool isDestructive = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    final noText = cancelLabel ?? l10n.actionNo;
    final yesText = confirmLabel ?? l10n.actionYes;

    return Dialog(
      backgroundColor: palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusXl),
        side: BorderSide(color: palette.border, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Semantics(
              header: true,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.h2(palette.text900),
              ),
            ),
            const SizedBox(height: AppTokens.space12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.body(palette.text600),
            ),
            const SizedBox(height: AppTokens.space24),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: noText,
                    fullWidth: true,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: isDestructive
                      ? DestructiveButton(
                          label: yesText,
                          fullWidth: true,
                          onPressed: () => Navigator.of(context).pop(true),
                        )
                      : PrimaryButton(
                          label: yesText,
                          fullWidth: true,
                          onPressed: () => Navigator.of(context).pop(true),
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
