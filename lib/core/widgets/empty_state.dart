import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/primary_button.dart';

/// Komponen EmptyState (ilustrasi ikon + teks + tombol aksi opsional)
/// sesuai DESIGN.md bagian 7 & 8.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
    this.actionLabel,
    this.onAction,
    this.borderColor,
    this.borderWidth,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return GlassCard(
      borderColor: borderColor ?? palette.primary,
      borderWidth: borderWidth ?? 1.5,
      padding: const EdgeInsets.all(AppTokens.space24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: AppTokens.space48 + AppTokens.space16,
            height: AppTokens.space48 + AppTokens.space16,
            decoration: BoxDecoration(
              color: palette.primarySoft,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: AppTokens.space32, color: palette.primary),
          ),
          const SizedBox(height: AppTokens.space16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.h2(palette.text900),
          ),
          const SizedBox(height: AppTokens.space8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.body(palette.text600),
          ),
          if (actionLabel != null && onAction != null) ...<Widget>[
            const SizedBox(height: AppTokens.space20),
            PrimaryButton(
              label: actionLabel!,
              onPressed: onAction,
              icon: Icons.add_rounded,
            ),
          ],
        ],
      ),
    );
  }
}
