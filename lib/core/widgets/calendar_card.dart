import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:table_calendar/table_calendar.dart';

/// Kartu kalender bulanan/mingguan dengan titik penanda tugas/acara dan aksesibilitas penuh.
class CalendarCard extends StatelessWidget {
  const CalendarCard({
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.markerCountForDay,
    this.onClearSelection,
    this.calendarFormat = CalendarFormat.month,
    this.markerColor,
    super.key,
  });

  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final ValueChanged<DateTime> onPageChanged;
  final int Function(DateTime day) markerCountForDay;
  final VoidCallback? onClearSelection;
  final CalendarFormat calendarFormat;
  final Color? markerColor;

  void _moveDay(int deltaDays) {
    final base = selectedDay ?? focusedDay;
    final next = DateTime(base.year, base.month, base.day + deltaDays);
    onDaySelected(next, next);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final monthTitle = DateFormat.yMMMM(localeName).format(focusedDay);
    final effectiveMarkerColor = markerColor ?? palette.accent;

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _moveDay(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _moveDay(1),
        const SingleActivator(LogicalKeyboardKey.arrowUp): () => _moveDay(-7),
        const SingleActivator(LogicalKeyboardKey.arrowDown): () => _moveDay(7),
      },
      child: Focus(
        child: GlassCard(
          borderColor: palette.primary,
          borderWidth: 1.5,
          padding: const EdgeInsets.all(AppTokens.space12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Semantics(
                    button: true,
                    label: l10n.calendarPrevMonth,
                    child: IconButton(
                      constraints: const BoxConstraints(
                        minWidth: AppTokens.minTouchTarget,
                        minHeight: AppTokens.minTouchTarget,
                      ),
                      tooltip: l10n.calendarPrevMonth,
                      onPressed: () {
                        final prevMonth = DateTime(
                          focusedDay.year,
                          focusedDay.month - 1,
                          1,
                        );
                        onPageChanged(prevMonth);
                      },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: palette.text900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      monthTitle,
                      textAlign: TextAlign.center,
                      style: AppTypography.title(palette.text900),
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: l10n.calendarNextMonth,
                    child: IconButton(
                      constraints: const BoxConstraints(
                        minWidth: AppTokens.minTouchTarget,
                        minHeight: AppTokens.minTouchTarget,
                      ),
                      tooltip: l10n.calendarNextMonth,
                      onPressed: () {
                        final nextMonth = DateTime(
                          focusedDay.year,
                          focusedDay.month + 1,
                          1,
                        );
                        onPageChanged(nextMonth);
                      },
                      icon: Icon(
                        Icons.chevron_right_rounded,
                        color: palette.text900,
                      ),
                    ),
                  ),
                ],
              ),
              TableCalendar<int>(
                locale: localeName,
                firstDay: DateTime(2020, 1, 1),
                lastDay: DateTime(2035, 12, 31),
                focusedDay: focusedDay,
                calendarFormat: calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerVisible: false,
                daysOfWeekHeight: AppTokens.space24,
                rowHeight: AppTokens.space40,
                selectedDayPredicate: (day) =>
                    selectedDay != null && isSameDay(selectedDay, day),
                onDaySelected: onDaySelected,
                onPageChanged: onPageChanged,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: AppTypography.caption(palette.text600),
                  weekendStyle: AppTypography.caption(palette.text500),
                ),
                calendarBuilders: CalendarBuilders<int>(
                  defaultBuilder: (context, day, focused) => _buildDayCell(
                    context: context,
                    day: day,
                    isSelected: false,
                    isToday: false,
                    isOutside: false,
                    markerColor: effectiveMarkerColor,
                  ),
                  todayBuilder: (context, day, focused) => _buildDayCell(
                    context: context,
                    day: day,
                    isSelected: false,
                    isToday: true,
                    isOutside: false,
                    markerColor: effectiveMarkerColor,
                  ),
                  selectedBuilder: (context, day, focused) => _buildDayCell(
                    context: context,
                    day: day,
                    isSelected: true,
                    isToday: isSameDay(day, DateTime.now()),
                    isOutside: false,
                    markerColor: effectiveMarkerColor,
                  ),
                  outsideBuilder: (context, day, focused) => _buildDayCell(
                    context: context,
                    day: day,
                    isSelected: false,
                    isToday: false,
                    isOutside: true,
                    markerColor: effectiveMarkerColor,
                  ),
                ),
              ),
              if (selectedDay != null && onClearSelection != null) ...<Widget>[
                const SizedBox(height: AppTokens.space8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(
                        AppTokens.minTouchTarget,
                        AppTokens.minTouchTarget,
                      ),
                    ),
                    onPressed: onClearSelection,
                    icon: Icon(
                      Icons.filter_alt_off_rounded,
                      size: 16,
                      color: palette.primary,
                    ),
                    label: Text(
                      l10n.calendarClearDateFilter,
                      style: AppTypography.caption(palette.primary),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayCell({
    required BuildContext context,
    required DateTime day,
    required bool isSelected,
    required bool isToday,
    required bool isOutside,
    required Color markerColor,
  }) {
    final palette = context.palette;
    final l10n = context.l10n;
    final markerCount = markerCountForDay(day);

    final Color textColor;
    if (isSelected) {
      textColor = palette.onPrimary;
    } else if (isOutside) {
      textColor = palette.text500;
    } else if (isToday) {
      textColor = palette.primary;
    } else {
      textColor = palette.text900;
    }

    return Semantics(
      button: true,
      selected: isSelected,
      label: l10n.semanticsCalendarDayMarkers(
        day.day,
        day.month,
        day.year,
        markerCount,
      ),
      excludeSemantics: true,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected
              ? palette.primary
              : (isToday ? palette.primarySoft : Colors.transparent),
          borderRadius: BorderRadius.circular(AppTokens.radiusSm),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${day.day}',
              style: AppTypography.caption(textColor).copyWith(
                fontWeight: isSelected || isToday
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
            if (markerCount > 0) ...<Widget>[
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  markerCount > 3 ? 3 : markerCount,
                  (_) => Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: isSelected ? palette.onPrimary : markerColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
