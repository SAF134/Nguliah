import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';

/// Pemilih 7 chip indeks nilai (A, AB, B, BC, C, D, E) sesuai DESIGN.md bagian 7.
class GradeSelector extends StatelessWidget {
  const GradeSelector({
    required this.selectedIndex,
    required this.onSelected,
    super.key,
    this.enabled = true,
  });

  final String selectedIndex;
  final ValueChanged<String> onSelected;
  final bool enabled;

  void _handleKey(int delta) {
    if (!enabled) return;
    const indices = GradeConversionConfig.orderedIndices;
    final currentPos = indices.indexOf(selectedIndex.trim().toUpperCase());
    final nextPos = ((currentPos < 0 ? 0 : currentPos) + delta).clamp(
      0,
      indices.length - 1,
    );
    onSelected(indices[nextPos]);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final normalizedSelected = selectedIndex.trim().toUpperCase();

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
            _handleKey(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
            _handleKey(1),
      },
      child: Focus(
        child: Wrap(
          spacing: AppTokens.space8,
          runSpacing: AppTokens.space8,
          children: GradeConversionConfig.orderedIndices.map((index) {
            final isSelected = index == normalizedSelected;
            final gradeColor = AppTokens.colorForGrade(index);

            return Semantics(
              button: true,
              selected: isSelected,
              enabled: enabled,
              label: l10n.semanticsGradeIndexOption(index),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                onTap: enabled ? () => onSelected(index) : null,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: AppTokens.minTouchTarget,
                    minHeight: AppTokens.minTouchTarget,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTokens.space12,
                    vertical: AppTokens.space8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? gradeColor : palette.surface,
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                    border: Border.all(
                      color: isSelected ? gradeColor : palette.border,
                      width: isSelected ? AppTokens.focusRingWidth : 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    index,
                    style: AppTypography.title(
                      isSelected ? AppTokens.lightSurface : palette.text900,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Banner saran tautan "Mengulang dari" saat nama mata kuliah sama.
class RetakeSuggestionBanner extends StatelessWidget {
  const RetakeSuggestionBanner({
    required this.suggestion,
    required this.onLink,
    super.key,
  });

  final CourseGrade suggestion;
  final VoidCallback onLink;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppTokens.space12),
      decoration: BoxDecoration(
        color: palette.primarySoft,
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.replay_rounded, color: palette.primary),
          const SizedBox(width: AppTokens.space8),
          Expanded(
            child: Text(
              l10n.gradeRetakeSuggestionBanner(
                suggestion.courseName,
                suggestion.semester,
                suggestion.gradeIndex,
              ),
              style: AppTypography.caption(palette.text900),
            ),
          ),
          SecondaryButton(
            label: l10n.gradeRetakeLinkAction,
            variant: SecondaryButtonVariant.text,
            onPressed: onLink,
          ),
        ],
      ),
    );
  }
}
