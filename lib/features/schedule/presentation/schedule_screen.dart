import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_fixed_top_header.dart';
import 'package:nguliah/core/widgets/confirm_dialog.dart';
import 'package:nguliah/core/widgets/empty_state.dart';
import 'package:nguliah/core/widgets/skeleton.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/repositories/attendance_repository.dart';
import 'package:nguliah/data/repositories/schedule_repository.dart';
import 'package:nguliah/features/schedule/application/schedule_providers.dart';
import 'package:nguliah/features/schedule/presentation/widgets/attendance_sheet.dart';
import 'package:nguliah/features/schedule/presentation/widgets/day_chips.dart';
import 'package:nguliah/features/schedule/presentation/widgets/schedule_content_list.dart';
import 'package:nguliah/features/schedule/presentation/widgets/schedule_form_sheet.dart';

/// Layar Jadwal Kuliah & Presensi sesuai PRD.md & DESIGN.md bagian 6 & 8.
class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  Future<void> _openScheduleForm(
    BuildContext context,
    WidgetRef ref, {
    required List<CourseSchedule> existingSchedules,
    CourseSchedule? initialSchedule,
    int? activeDay,
  }) async {
    final l10n = context.l10n;
    final result = await ScheduleFormSheet.show(
      context,
      existingSchedules: existingSchedules,
      initialSchedule: initialSchedule,
      initialDay: activeDay ?? DateTime.now().weekday,
    );
    if (result == null || !context.mounted) return;

    await ref.read(scheduleRepositoryProvider).saveSchedule(result);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Semantics(
            liveRegion: true,
            child: Text(l10n.toastScheduleSaved),
          ),
        ),
      );
  }

  Future<void> _openAttendanceSheet(
    BuildContext context,
    WidgetRef ref, {
    required CourseSchedule schedule,
    required List<AttendanceRecord> existingRecords,
  }) async {
    final l10n = context.l10n;
    final result = await AttendanceSheet.show(
      context,
      schedule: schedule,
      existingRecords: existingRecords,
    );
    if (result == null || !context.mounted) return;

    await ref.read(attendanceRepositoryProvider).saveAttendance(result);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Semantics(
            liveRegion: true,
            child: Text(l10n.toastAttendanceSaved),
          ),
        ),
      );
  }

  Future<void> _confirmAndDelete(
    BuildContext context,
    WidgetRef ref,
    CourseSchedule schedule,
  ) async {
    final l10n = context.l10n;
    final dayName = dayNameOf(context, schedule.dayOfWeek);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.scheduleDeleteDialogTitle,
      message: l10n.scheduleDeleteDialogMessage(schedule.courseName, dayName),
      confirmLabel: l10n.actionDelete,
    );
    if (!confirmed || !context.mounted) return;

    final repo = ref.read(scheduleRepositoryProvider);
    await repo.deleteSchedule(schedule.id);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Semantics(
            liveRegion: true,
            child: Text(l10n.toastScheduleDeleted),
          ),
          action: SnackBarAction(
            label: l10n.actionUndo,
            onPressed: () => repo.saveSchedule(schedule),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final schedulesAsync = ref.watch(allSchedulesStreamProvider);
    final attendanceRecords =
        ref.watch(allAttendanceStreamProvider).value ??
        const <AttendanceRecord>[];
    final recapSummaries = ref.watch(courseAttendanceRecapProvider);
    final selectedDay = ref.watch(selectedScheduleDayProvider);
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = width < AppTokens.compactPhoneBreakpoint;
    final isMasterDetail = width >= AppTokens.tabletMaxBreakpoint;
    final margin = isCompact
        ? AppTokens.screenMarginCompact
        : AppTokens.screenMargin;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            const AppFixedTopHeader(),
            Expanded(
              child: schedulesAsync.when(
                loading: () => Padding(
                  padding: EdgeInsets.all(margin),
                  child: const Skeleton(
                    variant: SkeletonVariant.list,
                    itemCount: 4,
                  ),
                ),
                error: (_, _) => Padding(
                  padding: EdgeInsets.all(margin),
                  child: EmptyState(
                    icon: Icons.error_outline_rounded,
                    title: l10n.errorLoadData,
                    description: l10n.emptyScheduleDescription,
                    actionLabel: l10n.actionRetry,
                    onAction: () => ref.invalidate(allSchedulesStreamProvider),
                  ),
                ),
                data: (allSchedules) {
                  final visibleSchedules = selectedDay == null
                      ? allSchedules
                      : allSchedules
                            .where((s) => s.dayOfWeek == selectedDay)
                            .toList();

                  return ScheduleContentList(
                    allSchedules: allSchedules,
                    visibleSchedules: visibleSchedules,
                    attendanceRecords: attendanceRecords,
                    recapSummaries: recapSummaries,
                    selectedDay: selectedDay,
                    onSelectDay: (day) => ref
                        .read(selectedScheduleDayProvider.notifier)
                        .select(day),
                    onAddSchedule: () => _openScheduleForm(
                      context,
                      ref,
                      existingSchedules: allSchedules,
                      activeDay: selectedDay,
                    ),
                    onOpenAttendance: (schedule) => _openAttendanceSheet(
                      context,
                      ref,
                      schedule: schedule,
                      existingRecords: attendanceRecords,
                    ),
                    onEditSchedule: (schedule) => _openScheduleForm(
                      context,
                      ref,
                      existingSchedules: allSchedules,
                      initialSchedule: schedule,
                    ),
                    onDeleteSchedule: (schedule) =>
                        _confirmAndDelete(context, ref, schedule),
                    onUpdateAttendanceRecord: (r) => ref
                        .read(attendanceRepositoryProvider)
                        .saveAttendance(r),
                    isMasterDetail: isMasterDetail,
                    margin: margin,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
