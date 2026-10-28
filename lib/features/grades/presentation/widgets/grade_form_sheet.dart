import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';
import 'package:nguliah/features/grades/presentation/widgets/grade_inputs_row.dart';
import 'package:nguliah/features/grades/presentation/widgets/grade_selector.dart';

/// BottomSheet form tambah/ubah nilai mata kuliah sesuai PRD.md & DESIGN.md.
class GradeFormSheet extends StatefulWidget {
  const GradeFormSheet({
    required this.existingGrades,
    super.key,
    this.initialEntry,
    this.presetRetakeTarget,
    this.initialSemester = 1,
  });

  final List<CourseGrade> existingGrades;
  final CourseGrade? initialEntry;
  final CourseGrade? presetRetakeTarget;
  final int initialSemester;

  static Future<CourseGrade?> show(
    BuildContext context, {
    required List<CourseGrade> existingGrades,
    CourseGrade? initialEntry,
    CourseGrade? presetRetakeTarget,
    int initialSemester = 1,
  }) {
    return showModalBottomSheet<CourseGrade>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GradeFormSheet(
        existingGrades: existingGrades,
        initialEntry: initialEntry,
        presetRetakeTarget: presetRetakeTarget,
        initialSemester: initialSemester,
      ),
    );
  }

  @override
  State<GradeFormSheet> createState() => _GradeFormSheetState();
}

class _GradeFormSheetState extends State<GradeFormSheet> {
  late final TextEditingController _courseNameController;
  late final TextEditingController _semesterController;
  late final TextEditingController _sksController;
  late String _gradeIndex;
  int? _retakeOfId;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    final editing = widget.initialEntry;
    final preset = widget.presetRetakeTarget;
    final initialSem =
        editing?.semester ??
        (preset != null
            ? (preset.semester + 1).clamp(1, 14)
            : widget.initialSemester.clamp(1, 14));
    _courseNameController = TextEditingController(
      text: editing?.courseName ?? preset?.courseName ?? '',
    );
    _semesterController = TextEditingController(text: '$initialSem');
    _sksController = TextEditingController(
      text: '${editing?.sks ?? preset?.sks ?? 3}',
    );
    _gradeIndex = editing?.gradeIndex ?? 'A';
    _retakeOfId = editing?.retakeOfId ?? preset?.id;
  }

  @override
  void dispose() {
    _courseNameController.dispose();
    _semesterController.dispose();
    _sksController.dispose();
    super.dispose();
  }

  bool get _isCourseNameValid => _courseNameController.text.trim().isNotEmpty;
  int? get _parsedSemester => int.tryParse(_semesterController.text.trim());
  bool get _isSemesterValid {
    final s = _parsedSemester;
    return s != null && s >= 1 && s <= 14;
  }

  int? get _parsedSks => int.tryParse(_sksController.text.trim());
  bool get _isSksValid => (_parsedSks ?? 0) > 0;

  int get _semester => _parsedSemester ?? 1;

  List<CourseGrade> get _availableRetakeTargets => widget.existingGrades
      .where(
        (g) =>
            g.id != widget.initialEntry?.id &&
            (g.semester < _semester || g.id == _retakeOfId),
      )
      .toList();

  CourseGrade? get _suggestedCandidate => _retakeOfId != null
      ? null
      : GradeCalculator.suggestRetakeCandidates(
          _availableRetakeTargets,
          _courseNameController.text,
          excludeId: widget.initialEntry?.id,
        ).lastOrNull;

  void _handleSubmit() {
    setState(() => _submitted = true);
    if (!_isCourseNameValid || !_isSksValid || !_isSemesterValid) return;

    final now = DateTime.now();
    final editing = widget.initialEntry;
    final entry = CourseGrade(
      courseName: _courseNameController.text.trim(),
      semester: _parsedSemester!,
      sks: _parsedSks!,
      gradeIndex: _gradeIndex,
      retakeOfId: _retakeOfId,
      createdAt: editing?.createdAt ?? now,
      updatedAt: now,
    );
    if (editing != null) entry.id = editing.id;
    Navigator.of(context).pop(entry);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final suggestion = _suggestedCandidate;
    final retakeOptions = _availableRetakeTargets;

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTokens.radius2xl),
        ),
        boxShadow: AppTokens.shadowLg,
      ),
      padding: EdgeInsets.fromLTRB(
        AppTokens.screenMargin,
        AppTokens.space20,
        AppTokens.screenMargin,
        bottomInset + AppTokens.space24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Semantics(
              header: true,
              child: Text(
                widget.initialEntry != null
                    ? l10n.gradeFormEditTitle
                    : l10n.gradeFormAddTitle,
                style: AppTypography.h2(palette.text900),
              ),
            ),
            const SizedBox(height: AppTokens.space16),
            AppTextField(
              label: l10n.gradeFieldCourseNameLabel,
              hintText: l10n.gradeFieldCourseNameHint,
              controller: _courseNameController,
              errorText: _submitted && !_isCourseNameValid
                  ? l10n.gradeFieldCourseNameError
                  : null,
              onChanged: (_) => setState(() {}),
            ),
            if (suggestion != null) ...<Widget>[
              const SizedBox(height: AppTokens.space8),
              RetakeSuggestionBanner(
                suggestion: suggestion,
                onLink: () => setState(() => _retakeOfId = suggestion.id),
              ),
            ],
            const SizedBox(height: AppTokens.space16),
            GradeInputsRow(
              semesterController: _semesterController,
              sksController: _sksController,
              gradeIndex: _gradeIndex,
              isSemesterValid: _isSemesterValid,
              isSksValid: _isSksValid,
              submitted: _submitted,
              onSemesterChanged: (_) => setState(() {}),
              onSksChanged: (_) => _submitted ? setState(() {}) : null,
              onGradeIndexChanged: (val) => setState(() => _gradeIndex = val),
            ),
            if (retakeOptions.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppTokens.space16),
              DropdownButtonFormField<int?>(
                key: ValueKey<int?>(_retakeOfId),
                initialValue: _retakeOfId,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: l10n.gradeFieldRetakeLabel,
                ),
                items: <DropdownMenuItem<int?>>[
                  DropdownMenuItem<int?>(
                    value: null,
                    child: Text(
                      l10n.gradeRetakeNoneOption,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ...retakeOptions.map(
                    (g) => DropdownMenuItem<int?>(
                      value: g.id,
                      child: Text(
                        '${g.courseName} · ${l10n.semesterShortLabel(g.semester)} (${g.gradeIndex})',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
                onChanged: (val) => setState(() => _retakeOfId = val),
              ),
            ],
            const SizedBox(height: AppTokens.space24),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: l10n.actionCancel,
                    fullWidth: true,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: PrimaryButton(
                    label: l10n.actionSave,
                    onPressed: _handleSubmit,
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
