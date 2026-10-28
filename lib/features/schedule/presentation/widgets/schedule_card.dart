import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';
import 'package:nguliah/features/schedule/presentation/widgets/day_chips.dart';

/// Kartu jadwal kuliah yang ditingkatkan desainnya tanpa badge presensi sesuai revisi user.
class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    required this.schedule,
    required this.onTapAttendance,
    required this.onEdit,
    required this.onDelete,
    super.key,
    this.latestAttendance,
  });

  final CourseSchedule schedule;
  final AttendanceRecord? latestAttendance;
  final VoidCallback onTapAttendance;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final dayName = dayNameOf(context, schedule.dayOfWeek);
    final timeRange = ScheduleCalculator.formatTimeRange(
      schedule.startTimeMinutes,
      schedule.endTimeMinutes,
    );

    return GlassCard(
      variant: GlassCardVariant.standard,
      borderColor: palette.primary.withValues(alpha: 0.35),
      borderWidth: 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: palette.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                ),
                child: Icon(
                  Icons.calendar_today_rounded,
                  color: palette.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppTokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$dayName · $timeRange',
                      style: AppTypography.caption(palette.primary),
                    ),
                    const SizedBox(height: AppTokens.space4),
                    Text(
                      schedule.courseName,
                      style: AppTypography.title(palette.text900),
                    ),
                    const SizedBox(height: AppTokens.space4),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          size: AppTokens.space16,
                          color: palette.text500,
                        ),
                        const SizedBox(width: AppTokens.space4),
                        Expanded(
                          child: Text(
                            schedule.room,
                            style: AppTypography.caption(palette.text600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space12),
          const Divider(height: 1),
          const SizedBox(height: AppTokens.space8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: SecondaryButton(
                  label: l10n.actionRecordAttendance,
                  icon: Icons.fact_check_outlined,
                  onPressed: onTapAttendance,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Semantics(
                    button: true,
                    label: '${l10n.actionEdit} ${schedule.courseName}',
                    child: IconButton(
                      constraints: const BoxConstraints(
                        minWidth: AppTokens.minTouchTarget,
                        minHeight: AppTokens.minTouchTarget,
                      ),
                      icon: Icon(
                        Icons.edit_outlined,
                        size: AppTokens.space20,
                        color: palette.text600,
                      ),
                      onPressed: onEdit,
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: '${l10n.actionDelete} ${schedule.courseName}',
                    child: IconButton(
                      constraints: const BoxConstraints(
                        minWidth: AppTokens.minTouchTarget,
                        minHeight: AppTokens.minTouchTarget,
                      ),
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        size: AppTokens.space20,
                        color: palette.error,
                      ),
                      onPressed: onDelete,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
