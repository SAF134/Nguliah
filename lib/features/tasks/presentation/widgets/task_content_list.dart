import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/calendar_card.dart';
import 'package:nguliah/core/widgets/empty_state.dart';
import 'package:nguliah/core/widgets/notification_permission_banner.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';
import 'package:nguliah/features/tasks/presentation/widgets/task_card.dart';

/// Komponen daftar tugas dengan kalender tenggat, filter tab, dan daftar kartu tugas.
class TaskContentList extends StatelessWidget {
  const TaskContentList({
    required this.allTasks,
    required this.filteredTasks,
    required this.selectedTab,
    required this.selectedDate,
    required this.focusedMonth,
    required this.permissionDenied,
    required this.margin,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.onClearSelection,
    required this.onSelectTab,
    required this.onAddTask,
    required this.onToggleComplete,
    required this.onEditTask,
    required this.onDeleteTask,
    super.key,
  });

  final List<AcademicTask> allTasks;
  final List<AcademicTask> filteredTasks;
  final TaskFilterTab selectedTab;
  final DateTime? selectedDate;
  final DateTime focusedMonth;
  final bool permissionDenied;
  final double margin;
  final void Function(DateTime day, DateTime focused) onDaySelected;
  final ValueChanged<DateTime> onPageChanged;
  final VoidCallback onClearSelection;
  final ValueChanged<TaskFilterTab> onSelectTab;
  final VoidCallback onAddTask;
  final ValueChanged<AcademicTask> onToggleComplete;
  final ValueChanged<AcademicTask> onEditTask;
  final ValueChanged<AcademicTask> onDeleteTask;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final activeCount = allTasks.where((t) => !t.isCompleted).length;
    final completedCount = allTasks.where((t) => t.isCompleted).length;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        margin,
        AppTokens.space8,
        margin,
        AppTokens.bottomNavClearance + AppTokens.space48,
      ),
      children: <Widget>[
        if (permissionDenied) ...<Widget>[
          const NotificationPermissionBanner(),
          const SizedBox(height: AppTokens.space12),
        ],
        CalendarCard(
          focusedDay: focusedMonth,
          selectedDay: selectedDate,
          onDaySelected: onDaySelected,
          onPageChanged: onPageChanged,
          onClearSelection: onClearSelection,
          markerCountForDay: (day) =>
              TaskDateUtils.countTasksOnDay(allTasks, day),
        ),
        const SizedBox(height: AppTokens.space16),
        Row(
          children: <Widget>[
            Expanded(
              child: TaskTabChip(
                label: '${l10n.taskTabActive} ($activeCount)',
                isSelected: selectedTab == TaskFilterTab.active,
                onTap: () => onSelectTab(TaskFilterTab.active),
              ),
            ),
            const SizedBox(width: AppTokens.space8),
            Expanded(
              child: TaskTabChip(
                label: '${l10n.taskTabCompleted} ($completedCount)',
                isSelected: selectedTab == TaskFilterTab.completed,
                onTap: () => onSelectTab(TaskFilterTab.completed),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTokens.space16),
        if (filteredTasks.isEmpty)
          EmptyState(
            icon: selectedTab == TaskFilterTab.active
                ? Icons.assignment_turned_in_outlined
                : Icons.history_edu_rounded,
            title: selectedTab == TaskFilterTab.active
                ? l10n.emptyTasksTitle
                : l10n.emptyCompletedTasksTitle,
            description: selectedTab == TaskFilterTab.active
                ? l10n.emptyTasksDescription
                : l10n.emptyCompletedTasksDescription,
            actionLabel: selectedTab == TaskFilterTab.active
                ? l10n.actionAddTask
                : null,
            onAction: selectedTab == TaskFilterTab.active ? onAddTask : null,
          )
        else ...<Widget>[
          for (final task in filteredTasks) ...<Widget>[
            TaskCard(
              task: task,
              onToggleComplete: () => onToggleComplete(task),
              onEdit: () => onEditTask(task),
              onDelete: () => onDeleteTask(task),
            ),
            const SizedBox(height: AppTokens.cardGap),
          ],
          if (selectedTab == TaskFilterTab.active) ...<Widget>[
            const SizedBox(height: AppTokens.space12),
            PrimaryButton(
              label: l10n.actionAddTask,
              icon: Icons.add_rounded,
              onPressed: onAddTask,
            ),
          ],
        ],
      ],
    );
  }
}
