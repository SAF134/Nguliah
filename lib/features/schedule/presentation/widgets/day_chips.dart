import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';

/// Helper lokalisasi nama hari lengkap (1 = Senin .. 7 = Minggu).
String dayNameOf(BuildContext context, int dayOfWeek) {
  final l10n = context.l10n;
  return switch (dayOfWeek) {
    1 => l10n.dayMonday,
    2 => l10n.dayTuesday,
    3 => l10n.dayWednesday,
    4 => l10n.dayThursday,
    5 => l10n.dayFriday,
    6 => l10n.daySaturday,
    7 => l10n.daySunday,
    _ => l10n.dayMonday,
  };
}

/// Helper lokalisasi singkatan nama hari (1 = Sen .. 7 = Min).
String shortDayNameOf(BuildContext context, int dayOfWeek) {
  final l10n = context.l10n;
  return switch (dayOfWeek) {
    1 => l10n.dayShortMon,
    2 => l10n.dayShortTue,
    3 => l10n.dayShortWed,
    4 => l10n.dayShortThu,
    5 => l10n.dayShortFri,
    6 => l10n.dayShortSat,
    7 => l10n.dayShortSun,
    _ => l10n.dayShortMon,
  };
}

/// Pemilih hari kuliah (Semua + Sen–Min) sesuai DESIGN.md bagian 6 & 7.
class DayChips extends StatelessWidget {
  const DayChips({
    required this.selectedDay,
    required this.onSelected,
    super.key,
  });

  final int? selectedDay;
  final ValueChanged<int?> onSelected;

  void _moveDay(int delta) {
    const options = <int?>[null, 1, 2, 3, 4, 5, 6, 7];
    final currentPos = options.indexOf(selectedDay);
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
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _moveDay(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _moveDay(1),
      },
      child: Focus(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _DayChipOption(
                label: l10n.dayAll,
                semanticLabel: l10n.dayAll,
                isSelected: selectedDay == null,
                onTap: () => onSelected(null),
              ),
              ...List<int>.generate(7, (i) => i + 1).map((day) {
                return Padding(
                  padding: const EdgeInsets.only(left: AppTokens.space8),
                  child: _DayChipOption(
                    label: shortDayNameOf(context, day),
                    semanticLabel: dayNameOf(context, day),
                    isSelected: selectedDay == day,
                    onTap: () => onSelected(day),
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

class _DayChipOption extends StatelessWidget {
  const _DayChipOption({
    required this.label,
    required this.semanticLabel,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String semanticLabel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Semantics(
      button: true,
      selected: isSelected,
      label: semanticLabel,
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
              color: isSelected ? Colors.transparent : palette.border,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.caption(
              isSelected ? AppTokens.lightSurface : palette.text700,
            ),
          ),
        ),
      ),
    );
  }
}
