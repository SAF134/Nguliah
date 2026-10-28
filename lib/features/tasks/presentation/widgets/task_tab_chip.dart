import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';

/// Tombol pil pemilih tab Aktif / Selesai pada layar Tugas dan Acara.
class TaskTabChip extends StatelessWidget {
  const TaskTabChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTokens.radiusFull),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: AppTokens.minTouchTarget,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space12,
            vertical: AppTokens.space8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? palette.primary : palette.surface,
            borderRadius: BorderRadius.circular(AppTokens.radiusFull),
            border: Border.all(
              color: isSelected ? palette.primary : palette.border,
              width: 1.5,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: (isSelected ? palette.primary : palette.border)
                    .withValues(alpha: 0.15),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.caption(
              isSelected ? palette.onPrimary : palette.text700,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
