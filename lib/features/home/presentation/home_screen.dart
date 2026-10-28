import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nguliah/core/router/app_routes.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_fixed_top_header.dart';
import 'package:nguliah/core/widgets/empty_state.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/core/widgets/skeleton.dart';
import 'package:nguliah/core/widgets/unified_academic_summary_card.dart';
import 'package:nguliah/features/events/application/event_providers.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';
import 'package:nguliah/features/grades/application/grade_providers.dart';
import 'package:nguliah/features/home/application/home_providers.dart';
import 'package:nguliah/features/home/presentation/widgets/grade_bar_chart_card.dart';
import 'package:nguliah/features/home/presentation/widgets/home_section_cards.dart';
import 'package:nguliah/features/home/presentation/widgets/ips_line_chart_card.dart';
import 'package:nguliah/features/schedule/application/schedule_providers.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';

/// Layar Beranda lengkap sesuai revisi: Header paten, 1 kartu metrik terpadu,
/// kartu jadwal, tugas, acara mendatang, grafik batang IPS, dan sebaran nilai (bar/pie).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final palette = context.palette;
    final summary = ref.watch(academicSummaryProvider);
    final gradesAsync = ref.watch(allGradesStreamProvider);
    final schedulesAsync = ref.watch(allSchedulesStreamProvider);
    final tasksAsync = ref.watch(tasksStreamProvider);
    final eventsAsync = ref.watch(eventsStreamProvider);

    final allGrades = gradesAsync.value ?? const [];
    final allSchedules = schedulesAsync.value ?? const [];
    final allTasks = tasksAsync.value ?? const [];
    final allEvents = eventsAsync.value ?? const [];

    final todaySchedules = ref.watch(todaySchedulesProvider);
    final upcomingTasks = ref.watch(weekUpcomingTasksProvider);
    final upcomingEvents = ref.watch(weekUpcomingEventsProvider);

    final isLoading =
        (gradesAsync.isLoading && !gradesAsync.hasValue) ||
        (schedulesAsync.isLoading && !schedulesAsync.hasValue) ||
        (tasksAsync.isLoading && !tasksAsync.hasValue) ||
        (eventsAsync.isLoading && !eventsAsync.hasValue);

    final hasError =
        gradesAsync.hasError ||
        schedulesAsync.hasError ||
        tasksAsync.hasError ||
        eventsAsync.hasError;

    final isCompletelyEmpty =
        allGrades.isEmpty &&
        allSchedules.isEmpty &&
        allTasks.isEmpty &&
        allEvents.isEmpty;

    return Scaffold(
      backgroundColor: palette.bg,
      body: Column(
        children: <Widget>[
          // Header Paten di Atas (tidak bergulir)
          const AppFixedTopHeader(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isTablet =
                    constraints.maxWidth >= AppTokens.tabletMinBreakpoint;
                final isCompact =
                    constraints.maxWidth < AppTokens.compactPhoneBreakpoint;
                final margin = isCompact
                    ? AppTokens.screenMarginCompact
                    : AppTokens.screenMargin;

                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet
                          ? AppTokens.tabletMaxBreakpoint
                          : double.infinity,
                    ),
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                        margin,
                        AppTokens.space16,
                        margin,
                        AppTokens.bottomNavClearance,
                      ),
                      children: <Widget>[
                        if (isLoading)
                          const Skeleton(
                            variant: SkeletonVariant.list,
                            itemCount: 3,
                          )
                        else if (hasError)
                          EmptyState(
                            icon: Icons.error_outline_rounded,
                            title: l10n.errorLoadData,
                            description: l10n.emptyHomeDescription,
                            actionLabel: l10n.actionRetry,
                            onAction: () {
                              ref.invalidate(allGradesStreamProvider);
                              ref.invalidate(allSchedulesStreamProvider);
                              ref.invalidate(tasksStreamProvider);
                              ref.invalidate(eventsStreamProvider);
                            },
                          )
                        else if (isCompletelyEmpty) ...<Widget>[
                          EmptyState(
                            icon: Icons.insights_rounded,
                            title: l10n.emptyHomeTitle,
                            description: l10n.emptyHomeDescription,
                            actionLabel: l10n.actionAddFirstGrade,
                            onAction: () => context.go(AppRoutes.grades),
                          ),
                          const SizedBox(height: AppTokens.space12),
                          SecondaryButton(
                            label: l10n.actionAddSchedule,
                            icon: Icons.calendar_today_outlined,
                            onPressed: () => context.go(AppRoutes.schedule),
                          ),
                        ] else ...<Widget>[
                          // Kartu Terpadu: IPK, SKS Selesai, dan MK Selesai dalam satu kartu
                          UnifiedAcademicSummaryCard(
                            ipk: summary.formattedIpk,
                            completedSks: summary.completedSks,
                            completedCoursesCount:
                                allGrades.length > summary.completedCoursesCount
                                ? allGrades.length
                                : summary.completedCoursesCount,
                          ),
                          const SizedBox(height: AppTokens.cardGap),
                          // Jadwal Kuliah Hari Ini
                          HomeTodaySchedulesCard(schedules: todaySchedules),
                          const SizedBox(height: AppTokens.cardGap),
                          // Tugas 7 Hari ke Depan
                          HomeUpcomingTasksCard(tasks: upcomingTasks),
                          const SizedBox(height: AppTokens.cardGap),
                          // Acara Kampus 7 Hari ke Depan
                          HomeUpcomingEventsCard(events: upcomingEvents),
                          const SizedBox(height: AppTokens.cardGap),
                          // Grafik Batang Tren IPS per Semester
                          IpsLineChartCard(
                            ipsBySemester: summary.ipsBySemester,
                          ),
                          const SizedBox(height: AppTokens.cardGap),
                          // Sebaran Nilai (Bar / Pie Chart toggle)
                          GradeBarChartCard(
                            gradeDistribution: () {
                              final dist = <String, int>{
                                for (final idx
                                    in GradeConversionConfig.orderedIndices)
                                  idx: 0,
                              };
                              for (final g in allGrades) {
                                final idx = g.gradeIndex.trim().toUpperCase();
                                dist[idx] = (dist[idx] ?? 0) + 1;
                              }
                              return allGrades.isNotEmpty
                                  ? dist
                                  : summary.gradeDistribution;
                            }(),
                          ),
                        ],
                      ],
                    ),
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
