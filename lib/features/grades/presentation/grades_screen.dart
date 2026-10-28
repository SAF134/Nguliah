import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_fixed_top_header.dart';
import 'package:nguliah/core/widgets/confirm_dialog.dart';
import 'package:nguliah/core/widgets/empty_state.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/skeleton.dart';
import 'package:nguliah/core/widgets/unified_academic_summary_card.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/repositories/grade_repository.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';
import 'package:nguliah/features/grades/application/grade_providers.dart';
import 'package:nguliah/features/grades/presentation/widgets/course_grade_card.dart';
import 'package:nguliah/features/grades/presentation/widgets/grade_form_sheet.dart';
import 'package:nguliah/features/grades/presentation/widgets/semester_chips.dart';

/// Layar Nilai Akademik (CRUD Nilai, IPS/IPK, riwayat mengulang) sesuai PRD.md & DESIGN.md.
class GradesScreen extends ConsumerWidget {
  const GradesScreen({super.key});

  Future<void> _openFormSheet(
    BuildContext context,
    WidgetRef ref, {
    required List<CourseGrade> existingGrades,
    CourseGrade? initialEntry,
    CourseGrade? presetRetakeTarget,
    int? activeSemester,
  }) async {
    final l10n = context.l10n;
    final result = await GradeFormSheet.show(
      context,
      existingGrades: existingGrades,
      initialEntry: initialEntry,
      presetRetakeTarget: presetRetakeTarget,
      initialSemester: activeSemester ?? 1,
    );
    if (result == null || !context.mounted) return;
    await ref.read(gradeRepositoryProvider).saveGrade(result);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Semantics(
            liveRegion: true,
            child: Text(l10n.toastGradeSaved),
          ),
        ),
      );
  }

  Future<void> _confirmAndDelete(
    BuildContext context,
    WidgetRef ref,
    CourseGrade entry,
  ) async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.gradeDeleteDialogTitle,
      message: l10n.gradeDeleteDialogMessage(entry.courseName, entry.semester),
    );
    if (!confirmed || !context.mounted) return;
    final repo = ref.read(gradeRepositoryProvider);
    await repo.deleteGrade(entry.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Text(l10n.toastGradeDeleted),
          action: SnackBarAction(
            label: l10n.actionUndo,
            onPressed: () => repo.saveGrade(entry),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final gradesAsync = ref.watch(allGradesStreamProvider);
    final summary = ref.watch(academicSummaryProvider);
    final selectedSemester = ref.watch(selectedSemesterFilterProvider);
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
              child: gradesAsync.when(
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
                    description: l10n.emptyGradesDescription,
                    actionLabel: l10n.actionRetry,
                    onAction: () => ref.invalidate(allGradesStreamProvider),
                  ),
                ),
                data: (allGrades) {
                  if (allGrades.isEmpty) {
                    return ListView(
                      padding: EdgeInsets.fromLTRB(
                        margin,
                        AppTokens.space16,
                        margin,
                        AppTokens.bottomNavClearance,
                      ),
                      children: <Widget>[
                        EmptyState(
                          icon: Icons.workspace_premium_outlined,
                          title: l10n.emptyGradesTitle,
                          description: l10n.emptyGradesDescription,
                          actionLabel: l10n.actionAddFirstGrade,
                          onAction: () => _openFormSheet(
                            context,
                            ref,
                            existingGrades: allGrades,
                          ),
                        ),
                      ],
                    );
                  }

                  final semesters = List<int>.generate(14, (i) => i + 1);
                  final activeSemester = selectedSemester;
                  final visibleGrades = activeSemester == null
                      ? allGrades
                      : allGrades
                            .where((g) => g.semester == activeSemester)
                            .toList();
                  final byId = <int, CourseGrade>{
                    for (final g in allGrades) g.id: g,
                  };
                  final groupByEntryId = <int, CourseGroupEvaluation>{
                    for (final group in summary.courseGroups)
                      for (final e in group.entries) e.id: group,
                  };

                  final masterWidgets = <Widget>[
                    UnifiedAcademicSummaryCard.fromSummary(
                      summary: summary,
                      activeSemester: activeSemester,
                      totalCoursesCount: allGrades.length,
                    ),
                    const SizedBox(height: AppTokens.space16),
                    SemesterChips(
                      semesters: semesters,
                      selectedSemester: activeSemester,
                      onSelected: (sem) => ref
                          .read(selectedSemesterFilterProvider.notifier)
                          .select(sem),
                    ),
                  ];

                  final detailWidgets = visibleGrades.isEmpty
                      ? <Widget>[
                          EmptyState(
                            icon: Icons.workspace_premium_outlined,
                            title: l10n.emptyGradesTitle,
                            description: l10n.emptyGradesDescription,
                            actionLabel: l10n.actionAddGrade,
                            onAction: () => _openFormSheet(
                              context,
                              ref,
                              existingGrades: allGrades,
                              activeSemester: activeSemester,
                            ),
                          ),
                        ]
                      : <Widget>[
                          ...visibleGrades.map((entry) {
                            final group = groupByEntryId[entry.id];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppTokens.cardGap,
                              ),
                              child: CourseGradeCard(
                                entry: entry,
                                retakeTargetEntry: entry.retakeOfId != null
                                    ? byId[entry.retakeOfId!]
                                    : null,
                                isEffectiveInIpk:
                                    group?.effectiveEntry.id == entry.id,
                                needsRetake: group?.needsRetake ?? false,
                                hasGroupHistory:
                                    (group?.entries.length ?? 1) > 1,
                                onEdit: () => _openFormSheet(
                                  context,
                                  ref,
                                  existingGrades: allGrades,
                                  initialEntry: entry,
                                ),
                                onDelete: () =>
                                    _confirmAndDelete(context, ref, entry),
                                onRetake: () => _openFormSheet(
                                  context,
                                  ref,
                                  existingGrades: allGrades,
                                  presetRetakeTarget: entry,
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: AppTokens.space8),
                          PrimaryButton(
                            label: l10n.actionAddGrade,
                            icon: Icons.add_rounded,
                            onPressed: () => _openFormSheet(
                              context,
                              ref,
                              existingGrades: allGrades,
                              activeSemester: activeSemester ?? semesters.last,
                            ),
                          ),
                        ];

                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:
                            !isMasterDetail &&
                                width >= AppTokens.tabletMinBreakpoint
                            ? AppTokens.tabletContentMaxWidth
                            : double.infinity,
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
                                      child: Column(children: masterWidgets),
                                    ),
                                    const SizedBox(width: AppTokens.space24),
                                    Expanded(
                                      flex: 3,
                                      child: Column(children: detailWidgets),
                                    ),
                                  ],
                                ),
                              ]
                            : <Widget>[
                                ...masterWidgets,
                                const SizedBox(height: AppTokens.space16),
                                ...detailWidgets,
                              ],
                      ),
                    ),
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
