import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/countdown_formatter.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/features/events/application/event_providers.dart';

/// Kartu daftar acara kampus 7 hari ke depan di Beranda.
class HomeUpcomingEventsCard extends StatelessWidget {
  const HomeUpcomingEventsCard({required this.events, super.key});

  final List<AcademicEvent> events;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    final locale = Localizations.localeOf(context).toLanguageTag();

    return GlassCard(
      borderColor: palette.primary,
      borderWidth: 1.5,
      padding: const EdgeInsets.all(AppTokens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.event_note_rounded, size: 20, color: palette.primary),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Text(
                  l10n.homeUpcomingEventsTitle,
                  style: AppTypography.title(palette.text900),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space12),
          if (events.isEmpty)
            Text(
              l10n.homeUpcomingEventsEmpty,
              style: AppTypography.body(palette.text600),
            )
          else
            Column(
              children: events.take(4).map((e) {
                final eventDateTime = DateTime(
                  e.eventDate.year,
                  e.eventDate.month,
                  e.eventDate.day,
                  e.startTimeMinutes ~/ 60,
                  e.startTimeMinutes % 60,
                );
                final countdown = CountdownFormatter.formatRemaining(
                  eventDateTime,
                  isEnglish: isEn,
                );
                return Container(
                  margin: const EdgeInsets.only(bottom: AppTokens.space8),
                  padding: const EdgeInsets.all(AppTokens.space12),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                    border: Border.all(color: palette.border),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              e.name,
                              style: AppTypography.title(palette.text900),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${DateFormat.MMMd(locale).format(e.eventDate)} · ${EventTimeUtils.formatRange(e.startTimeMinutes, e.endTimeMinutes)}${e.location.isNotEmpty ? " · ${e.location}" : ""}',
                              style: AppTypography.caption(palette.text600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppTokens.space8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTokens.space8,
                          vertical: AppTokens.space4,
                        ),
                        decoration: BoxDecoration(
                          color: palette.success.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(
                            AppTokens.radiusSm,
                          ),
                        ),
                        child: Text(
                          countdown,
                          style: AppTypography.caption(palette.success)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
