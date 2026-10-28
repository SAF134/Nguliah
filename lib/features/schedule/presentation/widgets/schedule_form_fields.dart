import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';
import 'package:nguliah/features/schedule/presentation/widgets/day_chips.dart';

/// Baris pemilih hari, jam mulai, dan jam selesai yang sejajar.
class ScheduleDayTimeRow extends StatelessWidget {
  const ScheduleDayTimeRow({
    required this.dayOfWeek,
    required this.startMinutes,
    required this.endMinutes,
    required this.isTimeOrderValid,
    required this.submitted,
    required this.onDayChanged,
    required this.onPickStartTime,
    required this.onPickEndTime,
    super.key,
  });

  final int dayOfWeek;
  final int startMinutes;
  final int endMinutes;
  final bool isTimeOrderValid;
  final bool submitted;
  final ValueChanged<int> onDayChanged;
  final VoidCallback onPickStartTime;
  final VoidCallback onPickEndTime;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                l10n.scheduleFieldDayLabel,
                style: AppTypography.caption(palette.text700),
              ),
              const SizedBox(height: AppTokens.space8),
              DropdownButtonFormField<int>(
                key: ValueKey<int>(dayOfWeek),
                initialValue: dayOfWeek,
                isExpanded: true,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppTokens.space8,
                    vertical: AppTokens.space12,
                  ),
                ),
                items: List<int>.generate(7, (i) => i + 1)
                    .map(
                      (day) => DropdownMenuItem<int>(
                        value: day,
                        child: Text(
                          dayNameOf(context, day),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) onDayChanged(value);
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: AppTokens.space8),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                l10n.scheduleFieldStartTimeLabel,
                style: AppTypography.caption(palette.text700),
              ),
              const SizedBox(height: AppTokens.space8),
              InkWell(
                borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                onTap: onPickStartTime,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppTokens.space12,
                      vertical: AppTokens.space12,
                    ),
                    suffixIcon: Icon(Icons.access_time_rounded, size: 18),
                  ),
                  child: Text(
                    ScheduleCalculator.formatTimeMinutes(startMinutes),
                    style: AppTypography.body(palette.text900),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppTokens.space8),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                l10n.scheduleFieldEndTimeLabel,
                style: AppTypography.caption(palette.text700),
              ),
              const SizedBox(height: AppTokens.space8),
              InkWell(
                borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                onTap: onPickEndTime,
                child: InputDecorator(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.space12,
                      vertical: AppTokens.space12,
                    ),
                    errorText: submitted && !isTimeOrderValid ? '!' : null,
                    suffixIcon: const Icon(Icons.access_time_rounded, size: 18),
                  ),
                  child: Text(
                    ScheduleCalculator.formatTimeMinutes(endMinutes),
                    style: AppTypography.body(palette.text900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Spanduk peringatan bentrok jadwal kuliah.
class ScheduleConflictBanner extends StatelessWidget {
  const ScheduleConflictBanner({required this.conflicts, super.key});

  final List<CourseSchedule> conflicts;

  @override
  Widget build(BuildContext context) {
    if (conflicts.isEmpty) return const SizedBox.shrink();

    final palette = context.palette;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(top: AppTokens.space12),
      child: Semantics(
        liveRegion: true,
        child: Container(
          padding: const EdgeInsets.all(AppTokens.space12),
          decoration: BoxDecoration(
            color: palette.warning.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
            border: Border.all(color: palette.warning),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.warning_amber_rounded, color: palette.warning),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Text(
                  l10n.scheduleConflictWarning(
                    conflicts.first.courseName,
                    ScheduleCalculator.formatTimeRange(
                      conflicts.first.startTimeMinutes,
                      conflicts.first.endTimeMinutes,
                    ),
                  ),
                  style: AppTypography.caption(palette.warning),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
