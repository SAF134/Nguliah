import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';
import 'package:nguliah/features/schedule/presentation/widgets/attendance_record_edit_sheet.dart';

/// BottomSheet Rekap Kehadiran per Mata Kuliah beserta detail pertemuan & edit slide-to-confirm.
class AttendanceRecapSheet extends StatefulWidget {
  const AttendanceRecapSheet({
    required this.summaries,
    super.key,
    this.onUpdateRecord,
  });

  final List<CourseAttendanceSummary> summaries;
  final ValueChanged<AttendanceRecord>? onUpdateRecord;

  static Future<void> show(
    BuildContext context, {
    required List<CourseAttendanceSummary> summaries,
    ValueChanged<AttendanceRecord>? onUpdateRecord,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AttendanceRecapSheet(
        summaries: summaries,
        onUpdateRecord: onUpdateRecord,
      ),
    );
  }

  @override
  State<AttendanceRecapSheet> createState() => _AttendanceRecapSheetState();
}

class _AttendanceRecapSheetState extends State<AttendanceRecapSheet> {
  String _labelForStatus(BuildContext context, AttendanceStatus status) {
    final l10n = context.l10n;
    switch (status) {
      case AttendanceStatus.present:
        return l10n.attendanceStatusPresent;
      case AttendanceStatus.dispensation:
        return l10n.attendanceStatusDispensation;
      case AttendanceStatus.sick:
        return l10n.attendanceStatusSick;
      case AttendanceStatus.permission:
        return l10n.attendanceStatusPermission;
      case AttendanceStatus.absent:
        return l10n.attendanceStatusAbsent;
    }
  }

  Color _colorForStatus(BuildContext context, AttendanceStatus status) {
    final palette = context.palette;
    switch (status) {
      case AttendanceStatus.present:
        return palette.success;
      case AttendanceStatus.dispensation:
        return palette.primary;
      case AttendanceStatus.sick:
        return palette.warning;
      case AttendanceStatus.permission:
        return palette.accent;
      case AttendanceStatus.absent:
        return palette.error;
    }
  }

  Future<void> _editRecordStatus(
    BuildContext context,
    AttendanceRecord record,
  ) async {
    await AttendanceRecordEditSheet.show(
      context,
      record: record,
      onSave: widget.onUpdateRecord,
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTokens.radius2xl),
        ),
        boxShadow: AppTokens.shadowLg,
      ),
      padding: const EdgeInsets.fromLTRB(
        AppTokens.screenMargin,
        AppTokens.space20,
        AppTokens.screenMargin,
        AppTokens.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: AppTokens.space40,
              height: AppTokens.space4,
              decoration: BoxDecoration(
                color: palette.border,
                borderRadius: BorderRadius.circular(AppTokens.radiusFull),
              ),
            ),
          ),
          const SizedBox(height: AppTokens.space16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    l10n.attendanceRecapTitle,
                    style: AppTypography.h2(palette.text900),
                  ),
                ),
              ),
              SecondaryButton(
                label: l10n.actionClose,
                variant: SecondaryButtonVariant.text,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space16),
          if (widget.summaries.isEmpty ||
              widget.summaries.every((s) => s.totalSessions == 0))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppTokens.space24),
              child: Center(
                child: Text(
                  l10n.attendanceRecapEmpty,
                  style: AppTypography.body(palette.text600),
                ),
              ),
            )
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.summaries.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppTokens.cardGap),
                itemBuilder: (context, index) {
                  final item = widget.summaries[index];
                  return GlassCard(
                    useSolidFallback: true,
                    borderColor: palette.primary.withValues(alpha: 0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                item.courseName,
                                style: AppTypography.title(palette.text900),
                              ),
                            ),
                            Text(
                              '${item.formattedPercentage}%',
                              style: AppTypography.h2(palette.primary),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTokens.space4),
                        Text(
                          l10n.attendanceRecapSummary(
                            item.presentCount,
                            item.totalSessions,
                            item.formattedPercentage,
                          ),
                          style: AppTypography.body(palette.text700),
                        ),
                        const SizedBox(height: AppTokens.space4),
                        Text(
                          l10n.attendanceRecapBreakdown(
                            item.presentCount,
                            item.sickCount,
                            item.permissionCount,
                            item.absentCount,
                          ),
                          style: AppTypography.caption(palette.text600),
                        ),
                        if (item.records.isNotEmpty) ...<Widget>[
                          const Divider(height: AppTokens.space20),
                          Text(
                            l10n.attendanceMeetingHistoryTitle,
                            style: AppTypography.caption(palette.text900),
                          ),
                          const SizedBox(height: AppTokens.space8),
                          ...item.records.map((r) {
                            final sessionFmt =
                                '${r.sessionDate.day.toString().padLeft(2, '0')}/${r.sessionDate.month.toString().padLeft(2, '0')}/${r.sessionDate.year}';
                            final timeFmt =
                                '${r.recordedAt.hour.toString().padLeft(2, '0')}:${r.recordedAt.minute.toString().padLeft(2, '0')}';
                            final statusLabel = _labelForStatus(
                              context,
                              r.status,
                            );
                            final statusColor = _colorForStatus(
                              context,
                              r.status,
                            );
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppTokens.space4,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      '$sessionFmt ($timeFmt)',
                                      style: AppTypography.caption(
                                        palette.text700,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(
                                        alpha: 0.14,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppTokens.radiusSm,
                                      ),
                                      border: Border.all(
                                        color: statusColor.withValues(
                                          alpha: 0.4,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      statusLabel,
                                      style: AppTypography.caption(
                                        statusColor,
                                      ).copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 16,
                                    ),
                                    tooltip: l10n.actionEdit,
                                    onPressed: () =>
                                        _editRecordStatus(context, r),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
