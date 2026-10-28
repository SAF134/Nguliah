import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';

/// Badge indeks nilai (A..E) beserta label status aksesibel (ikon + teks)
/// sesuai DESIGN.md bagian 3, 7, & 10.
class GradeBadge extends StatelessWidget {
  const GradeBadge({
    required this.gradeIndex,
    super.key,
    this.showNeedsRetake = false,
    this.isRetakeEntry = false,
  });

  final String gradeIndex;
  final bool showNeedsRetake;
  final bool isRetakeEntry;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final normalized = gradeIndex.trim().toUpperCase();
    final color = AppTokens.colorForGrade(normalized);

    return Wrap(
      spacing: AppTokens.space8,
      runSpacing: AppTokens.space4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Container(
          constraints: const BoxConstraints(
            minWidth: AppTokens.space40,
            minHeight: AppTokens.space32,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space12,
            vertical: AppTokens.space4,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(AppTokens.radiusSm),
            border: Border.all(color: color),
          ),
          alignment: Alignment.center,
          child: Text(normalized, style: AppTypography.title(color)),
        ),
        if (showNeedsRetake)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.space8,
              vertical: AppTokens.space4,
            ),
            decoration: BoxDecoration(
              color: palette.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppTokens.radiusSm),
              border: Border.all(color: palette.error),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  size: AppTokens.space16,
                  color: palette.error,
                ),
                const SizedBox(width: AppTokens.space4),
                Text(
                  '$normalized · ${l10n.gradeNeedsRetake}',
                  style: AppTypography.caption(palette.error),
                ),
              ],
            ),
          )
        else if (isRetakeEntry)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.space8,
              vertical: AppTokens.space4,
            ),
            decoration: BoxDecoration(
              color: palette.primarySoft,
              borderRadius: BorderRadius.circular(AppTokens.radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.replay_rounded,
                  size: AppTokens.space16,
                  color: palette.primary,
                ),
                const SizedBox(width: AppTokens.space4),
                Text(
                  l10n.gradeRetakeBadge,
                  style: AppTypography.caption(palette.primary),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
