import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/countdown_formatter.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/features/events/application/event_providers.dart';

export 'package:nguliah/features/home/presentation/widgets/home_events_card.dart';

/// Kartu daftar jadwal hari ini di Beranda dengan countdown waktu perkuliahan.
class HomeTodaySchedulesCard extends StatelessWidget {
  const HomeTodaySchedulesCard({required this.schedules, super.key});

  final List<CourseSchedule> schedules;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final isEn = Localizations.localeOf(context).languageCode == 'en';

    return GlassCard(
      borderColor: palette.primary,
      borderWidth: 1.5,
      padding: const EdgeInsets.all(AppTokens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.calendar_today_rounded,
                size: 20,
                color: palette.primary,
              ),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Text(
                  l10n.homeTodayScheduleTitle,
                  style: AppTypography.title(palette.text900),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space12),
          if (schedules.isEmpty)
            Text(
              l10n.homeTodayScheduleEmpty,
              style: AppTypography.body(palette.text600),
            )
          else
            Column(
              children: schedules.map((s) {
                final countdown = CountdownFormatter.formatScheduleCountdown(
                  startTimeMinutes: s.startTimeMinutes,
                  endTimeMinutes: s.endTimeMinutes,
                  isEnglish: isEn,
                );
                return Container(
                  margin: const EdgeInsets.only(bottom: AppTokens.space8),
                  padding: const EdgeInsets.all(AppTokens.space12),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                    border: Border.all(color: palette.border),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              s.courseName,
                              style: AppTypography.title(palette.text900),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${EventTimeUtils.formatRange(s.startTimeMinutes, s.endTimeMinutes)} · ${s.room}',
                              style: AppTypography.caption(palette.text600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppTokens.space8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTokens.space8,
                          vertical: AppTokens.space4,
                        ),
                        decoration: BoxDecoration(
                          color: palette.primarySoft,
                          borderRadius: BorderRadius.circular(
                            AppTokens.radiusSm,
                          ),
                        ),
                        child: Text(
                          countdown,
                          style: AppTypography.caption(palette.primary)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

/// Kartu daftar tugas 7 hari ke depan di Beranda dengan kata sisa waktu realtime.
class HomeUpcomingTasksCard extends StatelessWidget {
  const HomeUpcomingTasksCard({required this.tasks, super.key});

  final List<AcademicTask> tasks;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final isEn = Localizations.localeOf(context).languageCode == 'en';

    return GlassCard(
      borderColor: palette.primary,
      borderWidth: 1.5,
      padding: const EdgeInsets.all(AppTokens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.assignment_outlined, size: 20, color: palette.primary),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Text(
                  l10n.homeWeekTasksTitle,
                  style: AppTypography.title(palette.text900),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space12),
          if (tasks.isEmpty)
            Text(
              l10n.homeWeekTasksEmpty,
              style: AppTypography.body(palette.text600),
            )
          else
            Column(
              children: tasks.take(4).map((t) {
                final countdown = CountdownFormatter.formatRemaining(
                  t.dueDate,
                  isEnglish: isEn,
                );
                return Container(
                  margin: const EdgeInsets.only(bottom: AppTokens.space8),
                  padding: const EdgeInsets.all(AppTokens.space12),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                    border: Border.all(color: palette.border),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              t.courseName,
                              style: AppTypography.caption(palette.primary)
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              t.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.title(palette.text900),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppTokens.space8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTokens.space8,
                          vertical: AppTokens.space4,
                        ),
                        decoration: BoxDecoration(
                          color: palette.warning.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(
                            AppTokens.radiusSm,
                          ),
                        ),
                        child: Text(
                          countdown,
                          style: AppTypography.caption(palette.warning)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
