import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/features/events/application/event_providers.dart';
import 'package:nguliah/features/events/presentation/widgets/event_date_time_row.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';

/// Bottom sheet formulir tambah/ubah acara kampus beserta lokasi dan baris sejajar tanggal/jam.
class EventFormSheet extends StatefulWidget {
  const EventFormSheet({
    required this.onSave,
    this.initialEvent,
    this.initialSelectedDate,
    super.key,
  });

  final AcademicEvent? initialEvent;
  final DateTime? initialSelectedDate;
  final Future<void> Function(AcademicEvent event) onSave;

  @override
  State<EventFormSheet> createState() => _EventFormSheetState();
}

class _EventFormSheetState extends State<EventFormSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _locationController;
  late final TextEditingController _dateController;
  late final TextEditingController _startController;
  late final TextEditingController _endController;

  String? _nameError;
  String? _descError;
  String? _dateError;
  String? _startError;
  String? _endError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialEvent;
    final now = DateTime.now();
    final defaultDate = initial?.eventDate ?? widget.initialSelectedDate ?? now;
    final isToday = TaskDateUtils.isSameCalendarDay(defaultDate, now);
    final curMinutes = now.hour * 60 + now.minute;
    final defaultStart = isToday
        ? ((curMinutes + 60).clamp(0, 22 * 60))
        : 9 * 60;
    final defaultEnd = isToday
        ? ((defaultStart + 60).clamp(60, 23 * 60 + 59))
        : 11 * 60;

    _nameController = TextEditingController(text: initial?.name ?? '');
    _descController = TextEditingController(text: initial?.description ?? '');
    _locationController = TextEditingController(text: initial?.location ?? '');
    _dateController = TextEditingController(
      text: TaskDateUtils.formatIsoDate(defaultDate),
    );
    _startController = TextEditingController(
      text: initial != null
          ? EventTimeUtils.formatMinutes(initial.startTimeMinutes)
          : EventTimeUtils.formatMinutes(defaultStart),
    );
    _endController = TextEditingController(
      text: initial != null
          ? EventTimeUtils.formatMinutes(initial.endTimeMinutes)
          : EventTimeUtils.formatMinutes(defaultEnd),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final parsed =
        TaskDateUtils.tryParseIsoDate(_dateController.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: parsed,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2035, 12, 31),
    );
    if (picked != null && mounted) {
      setState(() {
        _dateController.text = TaskDateUtils.formatIsoDate(picked);
        _dateError = null;
      });
    }
  }

  Future<void> _pickTime({required bool isStart}) async {
    final controller = isStart ? _startController : _endController;
    final fallback = isStart ? 9 * 60 : 11 * 60;
    final parsedMinutes =
        TaskDateUtils.tryParseTimeMinutes(controller.text) ?? fallback;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: parsedMinutes ~/ 60,
        minute: parsedMinutes % 60,
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        controller.text = TaskDateUtils.formatTimeHm(
          picked.hour,
          picked.minute,
        );
        if (isStart) {
          _startError = null;
        } else {
          _endError = null;
        }
      });
    }
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final name = _nameController.text.trim();
    final desc = _descController.text.trim();
    final location = _locationController.text.trim();
    final parsedDate = TaskDateUtils.tryParseIsoDate(_dateController.text);
    final startMin = TaskDateUtils.tryParseTimeMinutes(_startController.text);
    final endMin = TaskDateUtils.tryParseTimeMinutes(_endController.text);

    String? endError;
    if (endMin == null) {
      endError = l10n.scheduleFieldTimeFormatError;
    } else if (startMin != null && endMin <= startMin) {
      endError = l10n.scheduleFieldEndTimeError;
    }

    setState(() {
      _nameError = name.isEmpty ? l10n.eventFieldNameError : null;
      _descError = desc.isEmpty ? l10n.eventFieldDescriptionError : null;
      _dateError = parsedDate == null ? l10n.taskFieldDueDateError : null;
      _startError = startMin == null ? l10n.scheduleFieldTimeFormatError : null;
      _endError = endError;
    });

    if (_nameError != null ||
        _descError != null ||
        _dateError != null ||
        _startError != null ||
        _endError != null ||
        parsedDate == null ||
        startMin == null ||
        endMin == null) {
      return;
    }

    setState(() => _isSaving = true);
    final now = DateTime.now();
    final existing = widget.initialEvent;
    final event = AcademicEvent(
      name: name,
      description: desc,
      location: location,
      isCompleted: existing?.isCompleted ?? false,
      eventDate: DateTime(parsedDate.year, parsedDate.month, parsedDate.day),
      startTimeMinutes: startMin,
      endTimeMinutes: endMin,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    if (existing != null) event.id = existing.id;

    await widget.onSave(event);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final isEditing = widget.initialEvent != null;
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppTokens.screenMargin,
        AppTokens.space20,
        AppTokens.screenMargin,
        viewInsets.bottom + AppTokens.space24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              isEditing ? l10n.eventFormEditTitle : l10n.eventFormAddTitle,
              style: AppTypography.h2(palette.text900),
            ),
            const SizedBox(height: AppTokens.space16),
            AppTextField(
              label: l10n.eventFieldNameLabel,
              hintText: l10n.eventFieldNameHint,
              controller: _nameController,
              errorText: _nameError,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppTokens.space12),
            AppTextField(
              label: l10n.eventFieldDescriptionLabel,
              hintText: l10n.eventFieldDescriptionHint,
              controller: _descController,
              errorText: _descError,
              maxLines: 2,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppTokens.space12),
            AppTextField(
              label: l10n.eventFieldLocationLabel,
              hintText: l10n.eventFieldLocationHint,
              controller: _locationController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppTokens.space12),
            EventDateTimeRow(
              dateController: _dateController,
              startController: _startController,
              endController: _endController,
              dateError: _dateError,
              startError: _startError,
              endError: _endError,
              onPickDate: _pickDate,
              onPickStartTime: () => _pickTime(isStart: true),
              onPickEndTime: () => _pickTime(isStart: false),
            ),
            const SizedBox(height: AppTokens.space24),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: l10n.actionCancel,
                    onPressed: _isSaving
                        ? null
                        : () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: PrimaryButton(
                    label: l10n.actionSave,
                    isLoading: _isSaving,
                    onPressed: _submit,
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
