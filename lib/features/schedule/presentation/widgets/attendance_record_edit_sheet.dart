import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/slide_to_confirm.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';

/// BottomSheet untuk mengedit status catatan presensi pertemuan dengan konfirmasi geser.
class AttendanceRecordEditSheet extends StatefulWidget {
  const AttendanceRecordEditSheet({
    required this.record,
    super.key,
    this.onSave,
  });

  final AttendanceRecord record;
  final ValueChanged<AttendanceRecord>? onSave;

  static Future<void> show(
    BuildContext context, {
    required AttendanceRecord record,
    ValueChanged<AttendanceRecord>? onSave,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AttendanceRecordEditSheet(record: record, onSave: onSave),
    );
  }

  @override
  State<AttendanceRecordEditSheet> createState() =>
      _AttendanceRecordEditSheetState();
}

class _AttendanceRecordEditSheetState extends State<AttendanceRecordEditSheet> {
  late AttendanceStatus _chosen;

  @override
  void initState() {
    super.initState();
    _chosen = widget.record.status;
  }

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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;

    return Container(
      padding: const EdgeInsets.all(AppTokens.space20),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTokens.radius2xl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${l10n.actionEdit} - ${widget.record.courseName}',
            style: AppTypography.h2(palette.text900),
          ),
          const SizedBox(height: AppTokens.space12),
          DropdownButtonFormField<AttendanceStatus>(
            initialValue: _chosen,
            decoration: InputDecoration(labelText: l10n.attendanceStatusLabel),
            items: AttendanceStatus.values.map((st) {
              return DropdownMenuItem(
                value: st,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _colorForStatus(context, st),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppTokens.space8),
                    Text(_labelForStatus(context, st)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _chosen = val);
              }
            },
          ),
          const SizedBox(height: AppTokens.space20),
          SlideToConfirm(
            label: l10n.actionConfirm,
            onConfirmed: () {
              final updated = AttendanceRecord(
                scheduleId: widget.record.scheduleId,
                courseName: widget.record.courseName,
                sessionDate: widget.record.sessionDate,
                status: _chosen,
                notes: widget.record.notes,
                recordedAt: DateTime.now(),
              )..id = widget.record.id;
              widget.onSave?.call(updated);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
