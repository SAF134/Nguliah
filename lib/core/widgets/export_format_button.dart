import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';

/// Tombol pemilih format ekspor dengan ikon dan border seleksi.
class ExportFormatButton extends StatelessWidget {
  const ExportFormatButton({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return InkWell(
      borderRadius: BorderRadius.circular(AppTokens.radiusMd),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space12,
          vertical: AppTokens.space12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? palette.primary.withValues(alpha: 0.12)
              : palette.surface,
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          border: Border.all(
            color: isSelected ? palette.primary : palette.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 20,
              color: isSelected ? palette.primary : iconColor,
            ),
            const SizedBox(width: AppTokens.space8),
            Text(
              label,
              style: AppTypography.title(
                isSelected ? palette.primary : palette.text900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
