import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';
import 'package:nguliah/features/schedule/presentation/widgets/attendance_selector_row.dart';

export 'package:nguliah/features/schedule/presentation/widgets/attendance_selector_row.dart';

/// BottomSheet pengisian/pengubahan presensi per sesi kuliah.
class AttendanceSheet extends StatefulWidget {
  const AttendanceSheet({
    required this.schedule,
    required this.existingRecords,
    super.key,
    this.initialDate,
  });

  final CourseSchedule schedule;
  final List<AttendanceRecord> existingRecords;
  final DateTime? initialDate;

  static Future<AttendanceRecord?> show(
    BuildContext context, {
    required CourseSchedule schedule,
    required List<AttendanceRecord> existingRecords,
    DateTime? initialDate,
  }) {
    return showModalBottomSheet<AttendanceRecord>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AttendanceSheet(
        schedule: schedule,
        existingRecords: existingRecords,
        initialDate: initialDate,
      ),
    );
  }

  @override
  State<AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  late DateTime _sessionDate;
  late AttendanceStatus _status;
  late bool _isInClassHours;
  AttendanceRecord? _matchedRecord;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _sessionDate = ScheduleCalculator.normalizeSessionDate(
      widget.initialDate ?? now,
    );
    _isInClassHours = ScheduleCalculator.isCurrentlyInClass(
      widget.schedule,
      now: now,
    );
    final existing = ScheduleCalculator.findSessionAttendance(
      widget.existingRecords,
      scheduleId: widget.schedule.id,
      sessionDate: _sessionDate,
    );
    _matchedRecord = existing;
    if (!_isInClassHours) {
      _status = AttendanceStatus.absent;
    } else {
      _status = existing?.status ?? AttendanceStatus.present;
    }
  }

  void _handleSave() {
    final record = AttendanceRecord(
      scheduleId: widget.schedule.id,
      courseName: widget.schedule.courseName,
      sessionDate: _sessionDate,
      status: _status,
      notes: '',
      recordedAt: DateTime.now(),
    );
    if (_matchedRecord != null) record.id = _matchedRecord!.id;
    Navigator.of(context).pop(record);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final formattedDate =
        '${_sessionDate.day.toString().padLeft(2, '0')}/${_sessionDate.month.toString().padLeft(2, '0')}/${_sessionDate.year}';

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTokens.radius2xl),
        ),
        boxShadow: AppTokens.shadowLg,
      ),
      padding: EdgeInsets.fromLTRB(
        AppTokens.screenMargin,
        AppTokens.space20,
        AppTokens.screenMargin,
        bottomInset + AppTokens.space24,
      ),
      child: SingleChildScrollView(
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
            Semantics(
              header: true,
              child: Text(
                '${l10n.attendanceSheetTitle} · ${widget.schedule.courseName}',
                style: AppTypography.h2(palette.text900),
              ),
            ),
            const SizedBox(height: AppTokens.space8),
            Text(
              '${l10n.attendanceDateLabel}: $formattedDate (${l10n.attendanceRecordedAtInfo})',
              style: AppTypography.caption(palette.text600),
            ),
            const SizedBox(height: AppTokens.space12),
            if (!_isInClassHours) ...<Widget>[
              Container(
                padding: const EdgeInsets.all(AppTokens.space12),
                decoration: BoxDecoration(
                  color: palette.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                  border: Border.all(color: palette.error),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info_outline_rounded, color: palette.error),
                    const SizedBox(width: AppTokens.space8),
                    Expanded(
                      child: Text(
                        l10n.attendanceOutsideHoursWarning,
                        style: AppTypography.caption(palette.error),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTokens.space12),
            ],
            Text(
              l10n.attendanceStatusLabel,
              style: AppTypography.caption(palette.text700),
            ),
            const SizedBox(height: AppTokens.space8),
            AttendanceSelectorRow(
              selectedStatus: _status,
              lockedToAbsent: !_isInClassHours,
              onSelected: (status) => setState(() => _status = status),
            ),
            const SizedBox(height: AppTokens.space24),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: l10n.actionCancel,
                    fullWidth: true,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: PrimaryButton(
                    label: l10n.actionSave,
                    onPressed: _handleSave,
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
