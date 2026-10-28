import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';

/// Status sisa waktu tenggat tugas sesuai DESIGN.md bagian 4.
enum DeadlineStatus { normal, urgent, overdue }

/// Bilah progres sisa waktu tenggat tugas (normal / mendesak <= 24 jam / terlambat).
class DeadlineProgressBar extends StatelessWidget {
  const DeadlineProgressBar({
    required this.createdAt,
    required this.dueDate,
    this.referenceTime,
    super.key,
  });

  final DateTime createdAt;
  final DateTime dueDate;
  final DateTime? referenceTime;

  /// Menentukan status tenggat tugas terhadap waktu referensi.
  static DeadlineStatus computeStatus({
    required DateTime dueDate,
    required DateTime now,
  }) {
    final remaining = dueDate.difference(now);
    if (remaining.isNegative) {
      return DeadlineStatus.overdue;
    }
    if (remaining.inHours < 24) {
      return DeadlineStatus.urgent;
    }
    return DeadlineStatus.normal;
  }

  /// Menghitung rasio waktu yang telah berjalan menuju tenggat (0.0 s.d. 1.0).
  static double computeProgress({
    required DateTime createdAt,
    required DateTime dueDate,
    required DateTime now,
  }) {
    if (!dueDate.isAfter(now)) {
      return 1.0;
    }
    final totalWindow = dueDate.difference(createdAt).inMinutes;
    if (totalWindow <= 0) {
      final remainingHours = dueDate.difference(now).inHours.clamp(0, 168);
      return (1.0 - (remainingHours / 168.0)).clamp(0.1, 1.0);
    }
    final elapsed = now.difference(createdAt).inMinutes;
    return (elapsed / totalWindow).clamp(0.08, 0.96);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final now = referenceTime ?? DateTime.now();
    final status = computeStatus(dueDate: dueDate, now: now);
    final progress = computeProgress(
      createdAt: createdAt,
      dueDate: dueDate,
      now: now,
    );
    final remaining = dueDate.difference(now);

    final String statusLabel;
    final IconData statusIcon;
    final Color statusColor;

    switch (status) {
      case DeadlineStatus.overdue:
        statusLabel = l10n.taskStatusOverdue;
        statusIcon = Icons.error_outline_rounded;
        statusColor = palette.error;
      case DeadlineStatus.urgent:
        final hours = remaining.inHours.clamp(1, 24);
        statusLabel = l10n.taskStatusUrgentHours(hours);
        statusIcon = Icons.warning_amber_rounded;
        statusColor = palette.warning;
      case DeadlineStatus.normal:
        final days = remaining.inDays.clamp(1, 3650);
        statusLabel = l10n.taskStatusRemainingDays(days);
        statusIcon = Icons.schedule_rounded;
        statusColor = palette.primary;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(statusIcon, size: 16, color: statusColor),
            const SizedBox(width: AppTokens.space4),
            Expanded(
              child: Text(
                statusLabel,
                style: AppTypography.caption(statusColor)
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTokens.space4),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTokens.radiusFull),
          child: SizedBox(
            height: AppTokens.space8,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: palette.border.withValues(alpha: 0.4),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: status == DeadlineStatus.normal
                          ? AppTokens.gradientPrimary
                          : null,
                      color: status == DeadlineStatus.normal
                          ? null
                          : statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
