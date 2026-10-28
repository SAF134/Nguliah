import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/services/notification_service.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_fixed_top_header.dart';
import 'package:nguliah/core/widgets/confirm_dialog.dart';
import 'package:nguliah/core/widgets/empty_state.dart';
import 'package:nguliah/core/widgets/skeleton.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/data/repositories/task_repository.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';
import 'package:nguliah/features/tasks/presentation/widgets/task_content_list.dart';
import 'package:nguliah/features/tasks/presentation/widgets/task_form_sheet.dart';

/// Layar Tugas Kuliah: kalender penanda tenggat, tab Aktif & Selesai (Rekap), CRUD penuh.
class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  Future<void> _openTaskForm(
    BuildContext context,
    WidgetRef ref, {
    AcademicTask? initialTask,
  }) async {
    final palette = context.palette;
    final l10n = context.l10n;
    final selectedDate = ref.read(selectedTaskDateProvider);

    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTokens.radiusXl),
        ),
      ),
      builder: (_) => TaskFormSheet(
        initialTask: initialTask,
        initialSelectedDate: selectedDate,
        onSave: (task) async {
          await ref.read(taskRepositoryProvider).saveTask(task);
          if (context.mounted) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(l10n.toastTaskSaved)));
          }
        },
      ),
    );
  }

  Future<void> _toggleComplete(
    BuildContext context,
    WidgetRef ref,
    AcademicTask task,
  ) async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: task.isCompleted
          ? l10n.taskCancelConfirmTitle
          : l10n.taskCompleteConfirmTitle,
      message: task.isCompleted
          ? l10n.taskCancelConfirmMessage
          : l10n.taskCompleteConfirmMessage,
      confirmLabel: l10n.actionYes,
      cancelLabel: l10n.actionNo,
    );
    if (!confirmed || !context.mounted) return;

    final now = DateTime.now();
    final updated = AcademicTask(
      id: task.id,
      courseName: task.courseName,
      description: task.description,
      dueDate: task.dueDate,
      isCompleted: !task.isCompleted,
      completedAt: !task.isCompleted ? now : null,
      createdAt: task.createdAt,
      updatedAt: now,
    );
    await ref.read(taskRepositoryProvider).saveTask(updated);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              updated.isCompleted
                  ? l10n.toastTaskCompleted
                  : l10n.toastTaskUncompleted,
            ),
          ),
        );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AcademicTask task,
  ) async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.taskDeleteDialogTitle,
      message: l10n.taskDeleteDialogMessage(task.courseName),
      confirmLabel: l10n.actionDelete,
      cancelLabel: l10n.actionCancel,
    );
    if (!confirmed || !context.mounted) return;

    final backup = AcademicTask(
      id: task.id,
      courseName: task.courseName,
      description: task.description,
      dueDate: task.dueDate,
      isCompleted: task.isCompleted,
      completedAt: task.completedAt,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
    );

    final repo = ref.read(taskRepositoryProvider);
    await repo.deleteTask(task.id);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          content: Text(l10n.toastTaskDeleted),
          action: SnackBarAction(
            label: l10n.actionUndo,
            onPressed: () => repo.saveTask(backup),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final allTasksAsync = ref.watch(tasksStreamProvider);
    final filteredTasksAsync = ref.watch(filteredTasksProvider);
    final selectedTab = ref.watch(selectedTaskTabProvider);
    final selectedDate = ref.watch(selectedTaskDateProvider);
    final focusedMonth = ref.watch(focusedTaskMonthProvider);
    final permissionDenied = ref.watch(notificationPermissionDeniedProvider);
    final isCompact =
        MediaQuery.sizeOf(context).width < AppTokens.compactPhoneBreakpoint;
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
              child: allTasksAsync.when(
                loading: () => Padding(
                  padding: EdgeInsets.all(margin),
                  child: const Skeleton(
                    variant: SkeletonVariant.list,
                    itemCount: 3,
                  ),
                ),
                error: (err, _) => EmptyState(
                  icon: Icons.error_outline_rounded,
                  title: l10n.errorLoadData,
                  description: err.toString(),
                  actionLabel: l10n.actionRetry,
                  onAction: () => ref.invalidate(tasksStreamProvider),
                ),
                data: (allTasks) {
                  final filteredTasks =
                      filteredTasksAsync.value ?? <AcademicTask>[];

                  return TaskContentList(
                    allTasks: allTasks,
                    filteredTasks: filteredTasks,
                    selectedTab: selectedTab,
                    selectedDate: selectedDate,
                    focusedMonth: focusedMonth,
                    permissionDenied: permissionDenied,
                    margin: margin,
                    onDaySelected: (day, focused) {
                      ref
                          .read(focusedTaskMonthProvider.notifier)
                          .setMonth(focused);
                      final current = ref.read(selectedTaskDateProvider);
                      final next =
                          current != null &&
                              TaskDateUtils.isSameCalendarDay(current, day)
                          ? null
                          : day;
                      ref.read(selectedTaskDateProvider.notifier).select(next);
                    },
                    onPageChanged: (focused) => ref
                        .read(focusedTaskMonthProvider.notifier)
                        .setMonth(focused),
                    onClearSelection: () => ref
                        .read(selectedTaskDateProvider.notifier)
                        .select(null),
                    onSelectTab: (tab) =>
                        ref.read(selectedTaskTabProvider.notifier).select(tab),
                    onAddTask: () => _openTaskForm(context, ref),
                    onToggleComplete: (task) =>
                        _toggleComplete(context, ref, task),
                    onEditTask: (task) =>
                        _openTaskForm(context, ref, initialTask: task),
                    onDeleteTask: (task) => _confirmDelete(context, ref, task),
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
