import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/countdown_formatter.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/features/events/application/event_providers.dart';

/// Kartu item acara kampus dengan countdown teks dan lokasi.
class EventCard extends StatelessWidget {
  const EventCard({
    required this.event,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final AcademicEvent event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final formattedDate = DateFormat.yMMMd(localeName).format(event.eventDate);
    final timeRange = EventTimeUtils.formatRange(
      event.startTimeMinutes,
      event.endTimeMinutes,
    );

    final eventDateTime = DateTime(
      event.eventDate.year,
      event.eventDate.month,
      event.eventDate.day,
      event.startTimeMinutes ~/ 60,
      event.startTimeMinutes % 60,
    );
    final countdown = CountdownFormatter.formatCountdown(eventDateTime);

    final isPast = EventTimeUtils.isPastEvent(event);

    final borderColor = isPast
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
                  color: isPast
                      ? palette.success.withValues(alpha: 0.14)
                      : palette.primarySoft,
                  borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                ),
                alignment: Alignment.center,
                child: Icon(
                  isPast
                      ? Icons.event_available_rounded
                      : Icons.event_note_rounded,
                  color: isPast ? palette.success : palette.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      event.name,
                      style: AppTypography.title(palette.text900).copyWith(
                        decoration: isPast ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (event.description.isNotEmpty) ...<Widget>[
                      const SizedBox(height: AppTokens.space4),
                      Text(
                        event.description,
                        style: AppTypography.body(palette.text700),
                      ),
                    ],
                    if (event.location.isNotEmpty) ...<Widget>[
                      const SizedBox(height: AppTokens.space4),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: palette.text500,
                          ),
                          const SizedBox(width: AppTokens.space4),
                          Expanded(
                            child: Text(
                              event.location,
                              style: AppTypography.caption(palette.text600),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppTokens.space8),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 14,
                          color: palette.text500,
                        ),
                        const SizedBox(width: AppTokens.space4),
                        Expanded(
                          child: Text(
                            '$formattedDate · $timeRange',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption(palette.text600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isPast)
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
            ],
          ),
          const SizedBox(height: AppTokens.space8),
          const Divider(height: 1),
          const SizedBox(height: AppTokens.space8),
          if (!isPast)
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
          else
            Row(
              children: <Widget>[
                Icon(Icons.verified_rounded, size: 14, color: palette.success),
                const SizedBox(width: AppTokens.space4),
                Text(
                  l10n.taskTabCompleted,
                  style: AppTypography.caption(palette.success)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
