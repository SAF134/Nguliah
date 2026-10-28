import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/services/export_service.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/export_format_button.dart';
import 'package:nguliah/core/widgets/export_preview_card.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/repositories/attendance_repository.dart';
import 'package:nguliah/data/repositories/grade_repository.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/schedule_repository.dart';
import 'package:nguliah/features/grades/application/grade_providers.dart';
import 'package:nguliah/features/schedule/application/schedule_providers.dart';

/// Bottom sheet pemilihan cakupan dan format ekspor (PDF / PNG / JPG).
class ExportSheet extends ConsumerStatefulWidget {
  const ExportSheet({this.initialScope = ExportScope.allGrades, super.key});

  final ExportScope initialScope;

  static Future<void> show(
    BuildContext context, {
    ExportScope initialScope = ExportScope.allGrades,
  }) async {
    final palette = context.palette;
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTokens.radius2xl),
        ),
      ),
      builder: (_) => ExportSheet(initialScope: initialScope),
    );
  }

  @override
  ConsumerState<ExportSheet> createState() => _ExportSheetState();
}

class _ExportSheetState extends ConsumerState<ExportSheet> {
  final GlobalKey _previewKey = GlobalKey();
  late ExportScope _scope;
  ExportFormat _format = ExportFormat.pdf;
  int? _semesterFilter;
  bool _isGenerating = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _scope = widget.initialScope;
  }

  Future<void> _handleExport() async {
    final l10n = context.l10n;
    setState(() {
      _isGenerating = true;
      _errorMessage = null;
    });
    try {
      final profile = await ref.read(profileRepositoryProvider).getProfile();
      final summary = ref.read(academicSummaryProvider);
      final grades = await ref.read(gradeRepositoryProvider).getAllGrades();
      final schedules = await ref
          .read(scheduleRepositoryProvider)
          .getAllSchedules();
      final attendances = await ref
          .read(attendanceRepositoryProvider)
          .watchAllAttendance()
          .first;
      final boundaryBytes = _format == ExportFormat.pdf
          ? null
          : await ExportPreviewCard.capturePngBytes(_previewKey);

      await ref
          .read(exportServiceProvider)
          .exportAndShare(
            scope: _scope,
            format: _format,
            profile: profile,
            summary: summary,
            grades: grades,
            schedules: schedules,
            attendances: attendances,
            semesterFilter: _scope == ExportScope.allGrades
                ? _semesterFilter
                : null,
            preRenderedImageBytes: boundaryBytes,
          );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.toastExportSuccess)));
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          _errorMessage = l10n.errorExportFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final summary = ref.watch(academicSummaryProvider);
    final grades =
        ref.watch(allGradesStreamProvider).value ?? const <CourseGrade>[];
    final schedules =
        ref.watch(allSchedulesStreamProvider).value ?? const <CourseSchedule>[];
    final semesters = summary.ipsBySemester.keys.toList()..sort();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTokens.screenMargin,
        AppTokens.space20,
        AppTokens.screenMargin,
        AppTokens.space24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              l10n.exportSheetTitle,
              style: AppTypography.h2(palette.text900),
            ),
            const SizedBox(height: AppTokens.space16),
            Text(
              l10n.exportScopeLabel,
              style: AppTypography.caption(palette.text700),
            ),
            const SizedBox(height: AppTokens.space8),
            ExportScopeOptionTile(
              label: l10n.exportScopeAllGrades,
              isSelected: _scope == ExportScope.allGrades,
              onTap: () => setState(() => _scope = ExportScope.allGrades),
            ),
            const SizedBox(height: AppTokens.space8),
            ExportScopeOptionTile(
              label: l10n.exportScopeScheduleAttendance,
              isSelected: _scope == ExportScope.scheduleAttendance,
              onTap: () =>
                  setState(() => _scope = ExportScope.scheduleAttendance),
            ),
            if (_scope == ExportScope.allGrades &&
                semesters.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppTokens.space12),
              Wrap(
                spacing: AppTokens.space8,
                runSpacing: AppTokens.space8,
                children: <Widget>[
                  ChoiceChip(
                    label: Text(l10n.filterAllSemesters),
                    selected: _semesterFilter == null,
                    onSelected: (_) => setState(() => _semesterFilter = null),
                  ),
                  for (final s in semesters)
                    ChoiceChip(
                      label: Text(l10n.semesterShortLabel(s)),
                      selected: _semesterFilter == s,
                      onSelected: (_) => setState(() => _semesterFilter = s),
                    ),
                ],
              ),
            ],
            const SizedBox(height: AppTokens.space16),
            Text(
              l10n.exportFormatLabel,
              style: AppTypography.caption(palette.text700),
            ),
            const SizedBox(height: AppTokens.space8),
            Row(
              children: <Widget>[
                Expanded(
                  child: ExportFormatButton(
                    label: l10n.exportFormatPdf,
                    icon: Icons.picture_as_pdf_rounded,
                    iconColor: palette.error,
                    isSelected: _format == ExportFormat.pdf,
                    onTap: () => setState(() => _format = ExportFormat.pdf),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: ExportFormatButton(
                    label: l10n.exportFormatJpg,
                    icon: Icons.image_rounded,
                    iconColor: palette.accent,
                    isSelected: _format == ExportFormat.jpg,
                    onTap: () => setState(() => _format = ExportFormat.jpg),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.space16),
            ExportPreviewCard(
              boundaryKey: _previewKey,
              scope: _scope,
              summary: summary,
              grades: grades,
              schedules: schedules,
              semesterFilter: _scope == ExportScope.allGrades
                  ? _semesterFilter
                  : null,
            ),
            if (_isGenerating) ...<Widget>[
              const SizedBox(height: AppTokens.space12),
              Semantics(
                liveRegion: true,
                child: Text(
                  l10n.exportProgressLoading,
                  style: AppTypography.caption(palette.text600),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            if (_errorMessage != null) ...<Widget>[
              const SizedBox(height: AppTokens.space12),
              Semantics(
                liveRegion: true,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: AppTypography.caption(palette.error),
                      ),
                    ),
                    TextButton(
                      onPressed: _handleExport,
                      child: Text(l10n.actionRetry),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppTokens.space16),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: l10n.actionCancel,
                    onPressed: _isGenerating
                        ? null
                        : () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: PrimaryButton(
                    label: l10n.exportGenerateAndShare,
                    isLoading: _isGenerating,
                    onPressed: _handleExport,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
