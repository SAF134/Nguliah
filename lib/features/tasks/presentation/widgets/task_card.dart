import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/countdown_formatter.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/data/models/academic_task_model.dart';

export 'package:nguliah/features/tasks/presentation/widgets/task_tab_chip.dart';

/// Kartu item tugas kuliah dengan countdown teks dan rekap selisih waktu.
class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    required this.onToggleComplete,
    required this.onEdit,
    required this.onDelete,
    this.referenceTime,
    super.key,
  });

  final AcademicTask task;
  final VoidCallback onToggleComplete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final DateTime? referenceTime;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final dueFormatted = DateFormat.yMMMd(localeName)
        .add_Hm()
        .format(task.dueDate);
    final countdown = CountdownFormatter.formatCountdown(
      task.dueDate,
      now: referenceTime,
    );
    final completionOffset = task.isCompleted
        ? CountdownFormatter.formatCompletionOffset(
            task.dueDate,
            task.completedAt ?? task.updatedAt,
          )
        : null;

    final borderColor = task.isCompleted
        ? palette.success.withValues(alpha: 0.35)
        : palette.primary.withValues(alpha: 0.35);

    return GlassCard(
      borderColor: borderColor,
      borderWidth: 1.5,
      padding: const EdgeInsets.all(AppTokens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: AppTokens.space40,
                height: AppTokens.space40,
                decoration: BoxDecoration(
                  color: task.isCompleted
                      ? palette.success.withValues(alpha: 0.14)
                      : palette.primarySoft,
                  borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                ),
                alignment: Alignment.center,
                child: Icon(
                  task.isCompleted
                      ? Icons.task_alt_rounded
                      : Icons.assignment_outlined,
                  color: task.isCompleted ? palette.success : palette.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      task.courseName,
                      style: AppTypography.title(palette.text900).copyWith(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: AppTokens.space4),
                    Text(
                      task.description,
                      style: AppTypography.body(palette.text700),
                    ),
                    const SizedBox(height: AppTokens.space8),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.event_rounded,
                          size: 14,
                          color: palette.text500,
                        ),
                        const SizedBox(width: AppTokens.space4),
                        Expanded(
                          child: Text(
                            dueFormatted,
                            style: AppTypography.caption(palette.text600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!task.isCompleted) ...<Widget>[
                Semantics(
                  button: true,
                  label: l10n.taskMarkComplete,
                  child: IconButton(
                    constraints: const BoxConstraints(
                      minWidth: AppTokens.minTouchTarget,
                      minHeight: AppTokens.minTouchTarget,
                    ),
                    tooltip: l10n.taskMarkComplete,
                    onPressed: onToggleComplete,
                    icon: Icon(
                      Icons.check_circle_outline_rounded,
                      size: 22,
                      color: palette.success,
                    ),
                  ),
                ),
                Semantics(
                  button: true,
                  label: l10n.actionEdit,
                  child: IconButton(
                    constraints: const BoxConstraints(
                      minWidth: AppTokens.minTouchTarget,
                      minHeight: AppTokens.minTouchTarget,
                    ),
                    tooltip: l10n.actionEdit,
                    onPressed: onEdit,
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: palette.text600,
                    ),
                  ),
                ),
                Semantics(
                  button: true,
                  label: l10n.actionDelete,
                  child: IconButton(
                    constraints: const BoxConstraints(
                      minWidth: AppTokens.minTouchTarget,
                      minHeight: AppTokens.minTouchTarget,
                    ),
                    tooltip: l10n.actionDelete,
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: palette.error,
                    ),
                  ),
                ),
              ] else
                Semantics(
                  button: true,
                  label: l10n.taskActionUncomplete,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: palette.warning,
                      backgroundColor: palette.warning.withValues(alpha: 0.1),
                      side: BorderSide(color: palette.warning, width: 1.5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTokens.space12,
                        vertical: AppTokens.space8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppTokens.radiusFull,
                        ),
                      ),
                    ),
                    onPressed: onToggleComplete,
                    icon: const Icon(Icons.undo_rounded, size: 16),
                    label: Text(
                      l10n.taskActionUncomplete,
                      style: AppTypography.caption(palette.warning)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppTokens.space8),
          const Divider(height: 1),
          const SizedBox(height: AppTokens.space8),
          if (!task.isCompleted)
            Row(
              children: <Widget>[
                Icon(Icons.timer_outlined, size: 14, color: palette.primary),
                const SizedBox(width: AppTokens.space8),
                Text(
                  countdown,
                  style: AppTypography.caption(palette.primary)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            )
          else ...<Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.verified_rounded, size: 14, color: palette.success),
                const SizedBox(width: AppTokens.space4),
                Expanded(
                  child: Text(
                    '${l10n.taskTabCompleted}: ${DateFormat.yMMMd(localeName).add_Hm().format(task.completedAt ?? task.updatedAt)}',
                    style: AppTypography.caption(palette.success),
                  ),
                ),
              ],
            ),
            if (completionOffset != null) ...<Widget>[
              const SizedBox(height: AppTokens.space4),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.history_rounded,
                    size: 14,
                    color: completionOffset.contains('Terlambat')
                        ? palette.error
                        : palette.primary,
                  ),
                  const SizedBox(width: AppTokens.space4),
                  Expanded(
                    child: Text(
                      completionOffset,
                      style: AppTypography.caption(
                        completionOffset.contains('Terlambat')
                            ? palette.error
                            : palette.primary,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}
