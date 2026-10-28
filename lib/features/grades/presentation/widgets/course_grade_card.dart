import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/features/grades/presentation/widgets/grade_badge.dart';

/// Kartu mata kuliah & nilai sesuai DESIGN.md bagian 6, 7, & 10.
/// Semantics dibaca: "{courseName}, {sks} SKS, nilai {gradeIndex}, semester {semester}".
class CourseGradeCard extends StatelessWidget {
  const CourseGradeCard({
    required this.entry,
    required this.isEffectiveInIpk,
    required this.needsRetake,
    required this.onEdit,
    required this.onDelete,
    super.key,
    this.retakeTargetEntry,
    this.hasGroupHistory = false,
    this.onRetake,
  });

  final CourseGrade entry;
  final CourseGrade? retakeTargetEntry;
  final bool isEffectiveInIpk;
  final bool needsRetake;
  final bool hasGroupHistory;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onRetake;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final isGradeE = entry.gradeIndex.trim().toUpperCase() == 'E';
    final showNeedsRetake = isGradeE && needsRetake;

    final gradeColor = AppTokens.colorForGrade(entry.gradeIndex);

    return GlassCard(
      borderColor: showNeedsRetake
          ? palette.error
          : gradeColor.withValues(alpha: 0.8),
      borderWidth: 1.5,
      variant: showNeedsRetake
          ? GlassCardVariant.highlight
          : GlassCardVariant.standard,
      semanticLabel: l10n.semanticsCourseGradeCard(
        entry.courseName,
        entry.sks,
        entry.gradeIndex,
        entry.semester,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      entry.courseName,
                      style: AppTypography.title(palette.text900),
                    ),
                    const SizedBox(height: AppTokens.space4),
                    Text(
                      '${l10n.semesterLabel(entry.semester)} · ${l10n.sksUnit(entry.sks)}',
                      style: AppTypography.caption(palette.text600),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTokens.space8),
              GradeBadge(
                gradeIndex: entry.gradeIndex,
                showNeedsRetake: showNeedsRetake,
                isRetakeEntry: entry.retakeOfId != null,
              ),
            ],
          ),
          if (retakeTargetEntry != null || hasGroupHistory) ...<Widget>[
            const SizedBox(height: AppTokens.space8),
            Wrap(
              spacing: AppTokens.space8,
              runSpacing: AppTokens.space4,
              children: <Widget>[
                if (retakeTargetEntry != null)
                  Text(
                    l10n.gradeRetakeOfInfo(
                      retakeTargetEntry!.semester,
                      retakeTargetEntry!.gradeIndex,
                    ),
                    style: AppTypography.caption(palette.text600),
                  ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      isEffectiveInIpk
                          ? Icons.check_circle_outline_rounded
                          : Icons.history_rounded,
                      size: AppTokens.space16,
                      color: isEffectiveInIpk
                          ? palette.success
                          : palette.text500,
                    ),
                    const SizedBox(width: AppTokens.space4),
                    Flexible(
                      child: Text(
                        isEffectiveInIpk
                            ? l10n.gradeUsedInIpk
                            : l10n.gradeNotUsedInIpk,
                        style: AppTypography.caption(
                          isEffectiveInIpk ? palette.success : palette.text500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          const SizedBox(height: AppTokens.space8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (showNeedsRetake && onRetake != null)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppTokens.space8),
                    child: SecondaryButton(
                      label: l10n.actionRetake,
                      icon: Icons.replay_rounded,
                      onPressed: onRetake,
                    ),
                  ),
                ),
              Semantics(
                button: true,
                label: '${l10n.actionEdit} ${entry.courseName}',
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
                label: '${l10n.actionDelete} ${entry.courseName}',
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
    );
  }
}
