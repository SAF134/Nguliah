import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/skeleton.dart';

enum StatCardSize { large, mini }

/// Kartu ringkasan statistik angka besar (IPK/IPS) atau angka mini (SKS/MK)
/// sesuai DESIGN.md bagian 6 & 7.
class StatCard extends StatelessWidget {
  const StatCard({
    required this.label,
    required this.value,
    super.key,
    this.subtitle,
    this.size = StatCardSize.large,
    this.isLoading = false,
    this.onTap,
  });

  final String label;
  final String value;
  final String? subtitle;
  final StatCardSize size;
  final bool isLoading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Skeleton(height: size == StatCardSize.large ? 112 : 84);
    }

    final palette = context.palette;
    final displayValue = value.trim().isEmpty ? '–' : value;
    final isLarge = size == StatCardSize.large;

    return GlassCard(
      variant: onTap != null
          ? GlassCardVariant.tappable
          : GlassCardVariant.standard,
      onTap: onTap,
      semanticLabel: '$label: $displayValue',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label, style: AppTypography.caption(palette.text600)),
          const SizedBox(height: AppTokens.space4),
          Text(
            displayValue,
            style: isLarge
                ? AppTypography.numberXl(palette.primary)
                : AppTypography.h1(palette.text900),
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...<Widget>[
            const SizedBox(height: AppTokens.space4),
            Text(subtitle!, style: AppTypography.caption(palette.text500)),
          ],
        ],
      ),
    );
  }
}
