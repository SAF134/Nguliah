import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';

/// Deretan kartu tombol filter semester ("Semua" dan Semester 1..14).
/// Dilengkapi garis border frame dan shader/shadow halus.
class SemesterChips extends StatelessWidget {
  const SemesterChips({
    required this.semesters,
    required this.selectedSemester,
    required this.onSelected,
    super.key,
  });

  final List<int> semesters;
  final int? selectedSemester;
  final ValueChanged<int?> onSelected;

  void _moveSelection(int delta) {
    final options = <int?>[null, ...semesters];
    final currentPos = options.indexOf(selectedSemester);
    final nextPos = ((currentPos < 0 ? 0 : currentPos) + delta).clamp(
      0,
      options.length - 1,
    );
    onSelected(options[nextPos]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
            _moveSelection(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
            _moveSelection(1),
      },
      child: Focus(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _ChipOption(
                label: l10n.filterAllSemesters,
                isSelected: selectedSemester == null,
                onTap: () => onSelected(null),
              ),
              ...semesters.map((semester) {
                return Padding(
                  padding: const EdgeInsets.only(left: AppTokens.space8),
                  child: _ChipOption(
                    label: l10n.semesterLabel(semester),
                    isSelected: selectedSemester == semester,
                    onTap: () => onSelected(semester),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChipOption extends StatelessWidget {
  const _ChipOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTokens.radiusFull),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: AppTokens.minTouchTarget,
            minWidth: AppTokens.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space16,
            vertical: AppTokens.space8,
          ),
          decoration: BoxDecoration(
            gradient: isSelected ? AppTokens.gradientPrimary : null,
            color: isSelected ? null : palette.surface,
            borderRadius: BorderRadius.circular(AppTokens.radiusFull),
            border: Border.all(
              color: isSelected ? palette.primary : palette.border,
              width: 1.5,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: (isSelected ? palette.primary : palette.border)
                    .withValues(alpha: 0.15),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.caption(
              isSelected ? AppTokens.lightSurface : palette.text700,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
