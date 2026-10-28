import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';

/// Pemilih 5 opsi status kehadiran sejajar sesuai PRD.md & revisi user.
class AttendanceSelectorRow extends StatelessWidget {
  const AttendanceSelectorRow({
    required this.selectedStatus,
    required this.onSelected,
    super.key,
    this.lockedToAbsent = false,
  });

  final AttendanceStatus selectedStatus;
  final ValueChanged<AttendanceStatus> onSelected;
  final bool lockedToAbsent;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    final options = <(AttendanceStatus, IconData, String, Color)>[
      (
        AttendanceStatus.present,
        Icons.check_circle_outline_rounded,
        l10n.attendanceStatusPresent,
        palette.success,
      ),
      (
        AttendanceStatus.dispensation,
        Icons.verified_outlined,
        l10n.attendanceStatusDispensation,
        palette.primary,
      ),
      (
        AttendanceStatus.sick,
        Icons.healing_outlined,
        l10n.attendanceStatusSick,
        palette.warning,
      ),
      (
        AttendanceStatus.permission,
        Icons.info_outline_rounded,
        l10n.attendanceStatusPermission,
        palette.warning,
      ),
      (
        AttendanceStatus.absent,
        Icons.cancel_outlined,
        l10n.attendanceStatusAbsent,
        palette.error,
      ),
    ];

    return Row(
      children: options.map((opt) {
        final (status, icon, label, activeColor) = opt;
        final isSelected = status == selectedStatus;
        final isEnabled = !lockedToAbsent || status == AttendanceStatus.absent;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Semantics(
              button: true,
              selected: isSelected,
              enabled: isEnabled,
              label: label,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                onTap: isEnabled ? () => onSelected(status) : null,
                child: Opacity(
                  opacity: isEnabled ? 1.0 : 0.38,
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: AppTokens.minTouchTarget * 1.3,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                      vertical: AppTokens.space8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? activeColor.withValues(alpha: 0.16)
                          : palette.surface,
                      borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                      border: Border.all(
                        color: isSelected ? activeColor : palette.border,
                        width: isSelected ? AppTokens.focusRingWidth : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          icon,
                          size: AppTokens.space20,
                          color: isSelected ? activeColor : palette.text600,
                        ),
                        const SizedBox(height: AppTokens.space4),
                        Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: AppTypography.caption(
                            isSelected ? activeColor : palette.text700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
