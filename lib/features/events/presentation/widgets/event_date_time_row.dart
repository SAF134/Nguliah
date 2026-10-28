import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';

/// Baris sejajar pemilih tanggal, jam mulai, dan jam selesai pada form acara kampus.
class EventDateTimeRow extends StatelessWidget {
  const EventDateTimeRow({
    required this.dateController,
    required this.startController,
    required this.endController,
    required this.dateError,
    required this.startError,
    required this.endError,
    required this.onPickDate,
    required this.onPickStartTime,
    required this.onPickEndTime,
    super.key,
  });

  final TextEditingController dateController;
  final TextEditingController startController;
  final TextEditingController endController;
  final String? dateError;
  final String? startError;
  final String? endError;
  final VoidCallback onPickDate;
  final VoidCallback onPickStartTime;
  final VoidCallback onPickEndTime;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: AppTextField(
            label: l10n.eventFieldDateLabel,
            hintText: 'YYYY-MM-DD',
            controller: dateController,
            errorText: dateError,
            suffixIcon: IconButton(
              tooltip: l10n.eventFieldDateLabel,
              onPressed: onPickDate,
              icon: Icon(
                Icons.calendar_today_rounded,
                color: palette.primary,
                size: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppTokens.space8),
        Expanded(
          flex: 3,
          child: AppTextField(
            label: l10n.scheduleFieldStartTimeLabel,
            hintText: '09:00',
            controller: startController,
            errorText: startError,
            suffixIcon: IconButton(
              tooltip: l10n.scheduleFieldStartTimeLabel,
              onPressed: onPickStartTime,
              icon: Icon(
                Icons.access_time_rounded,
                color: palette.primary,
                size: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppTokens.space8),
        Expanded(
          flex: 3,
          child: AppTextField(
            label: l10n.scheduleFieldEndTimeLabel,
            hintText: '11:00',
            controller: endController,
            errorText: endError,
            suffixIcon: IconButton(
              tooltip: l10n.scheduleFieldEndTimeLabel,
              onPressed: onPickEndTime,
              icon: Icon(
                Icons.access_time_rounded,
                color: palette.primary,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
