import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/empty_state.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';
import 'package:nguliah/features/schedule/presentation/widgets/attendance_recap_sheet.dart';
import 'package:nguliah/features/schedule/presentation/widgets/day_chips.dart';
import 'package:nguliah/features/schedule/presentation/widgets/schedule_card.dart';

/// Komponen tata letak daftar jadwal dan pemilih hari.
class ScheduleContentList extends StatelessWidget {
  const ScheduleContentList({
    required this.allSchedules,
    required this.visibleSchedules,
    required this.attendanceRecords,
    required this.recapSummaries,
    required this.selectedDay,
    required this.onSelectDay,
    required this.onAddSchedule,
    required this.onOpenAttendance,
    required this.onEditSchedule,
    required this.onDeleteSchedule,
    required this.onUpdateAttendanceRecord,
    required this.isMasterDetail,
    required this.margin,
    super.key,
  });

  final List<CourseSchedule> allSchedules;
  final List<CourseSchedule> visibleSchedules;
  final List<AttendanceRecord> attendanceRecords;
  final List<CourseAttendanceSummary> recapSummaries;
  final int? selectedDay;
  final ValueChanged<int?> onSelectDay;
  final VoidCallback onAddSchedule;
  final ValueChanged<CourseSchedule> onOpenAttendance;
  final ValueChanged<CourseSchedule> onEditSchedule;
  final ValueChanged<CourseSchedule> onDeleteSchedule;
  final ValueChanged<AttendanceRecord> onUpdateAttendanceRecord;
  final bool isMasterDetail;
  final double margin;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final daySelector = DayChips(
      selectedDay: selectedDay,
      onSelected: onSelectDay,
    );

    final detailContent = visibleSchedules.isEmpty
        ? <Widget>[
            EmptyState(
              icon: Icons.calendar_today_outlined,
              title: l10n.emptyScheduleTitle,
              description: l10n.emptyScheduleDescription,
              actionLabel: l10n.actionAddSchedule,
              onAction: onAddSchedule,
            ),
          ]
        : <Widget>[
            ...visibleSchedules.map((schedule) {
              final latestForSchedule = attendanceRecords
                  .where((r) => r.scheduleId == schedule.id)
                  .firstOrNull;

              return Padding(
                padding: const EdgeInsets.only(bottom: AppTokens.cardGap),
                child: ScheduleCard(
                  schedule: schedule,
                  latestAttendance: latestForSchedule,
                  onTapAttendance: () => onOpenAttendance(schedule),
                  onEdit: () => onEditSchedule(schedule),
                  onDelete: () => onDeleteSchedule(schedule),
                ),
              );
            }),
            const SizedBox(height: AppTokens.space12),
            SecondaryButton(
              label: l10n.actionAttendanceRecap,
              icon: Icons.assessment_outlined,
              fullWidth: true,
              onPressed: () => AttendanceRecapSheet.show(
                context,
                summaries: recapSummaries,
                onUpdateRecord: onUpdateAttendanceRecord,
              ),
            ),
            const SizedBox(height: AppTokens.space8),
            PrimaryButton(
              label: l10n.actionAddSchedule,
              icon: Icons.add_rounded,
              onPressed: onAddSchedule,
            ),
          ];

    final width = MediaQuery.sizeOf(context).width;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isMasterDetail
              ? double.infinity
              : (width >= AppTokens.tabletMinBreakpoint
                    ? AppTokens.tabletContentMaxWidth
                    : double.infinity),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            margin,
            AppTokens.space8,
            margin,
            AppTokens.bottomNavClearance + AppTokens.space48,
          ),
          children: isMasterDetail
              ? <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[daySelector],
                        ),
                      ),
                      const SizedBox(width: AppTokens.space24),
                      Expanded(flex: 3, child: Column(children: detailContent)),
                    ],
                  ),
                ]
              : <Widget>[
                  daySelector,
                  const SizedBox(height: AppTokens.space16),
                  ...detailContent,
                ],
        ),
      ),
    );
  }
}
