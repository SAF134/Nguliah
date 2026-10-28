import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/academic_task_model.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';

/// Bottom sheet formulir tambah/ubah tugas kuliah.
class TaskFormSheet extends StatefulWidget {
  const TaskFormSheet({
    required this.onSave,
    this.initialTask,
    this.initialSelectedDate,
    super.key,
  });

  final AcademicTask? initialTask;
  final DateTime? initialSelectedDate;
  final Future<void> Function(AcademicTask task) onSave;

  @override
  State<TaskFormSheet> createState() => _TaskFormSheetState();
}

class _TaskFormSheetState extends State<TaskFormSheet> {
  late final TextEditingController _courseController;
  late final TextEditingController _descController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;

  String? _courseError;
  String? _descError;
  String? _dateError;
  String? _timeError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialTask;
    final defaultDate =
        initial?.dueDate ??
        widget.initialSelectedDate ??
        DateTime.now().add(const Duration(days: 1));

    _courseController = TextEditingController(text: initial?.courseName ?? '');
    _descController = TextEditingController(text: initial?.description ?? '');
    _dateController = TextEditingController(
      text: TaskDateUtils.formatIsoDate(defaultDate),
    );
    _timeController = TextEditingController(
      text: initial != null
          ? TaskDateUtils.formatTimeHm(
              initial.dueDate.hour,
              initial.dueDate.minute,
            )
          : '23:59',
    );
  }

  @override
  void dispose() {
    _courseController.dispose();
    _descController.dispose();
    _dateController.dispose();
    _timeController.dispose();
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

  Future<void> _pickTime() async {
    final parsedMinutes =
        TaskDateUtils.tryParseTimeMinutes(_timeController.text) ??
        (23 * 60 + 59);
    final initialTime = TimeOfDay(
      hour: parsedMinutes ~/ 60,
      minute: parsedMinutes % 60,
    );
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null && mounted) {
      setState(() {
        _timeController.text = TaskDateUtils.formatTimeHm(
          picked.hour,
          picked.minute,
        );
        _timeError = null;
      });
    }
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final courseName = _courseController.text.trim();
    final description = _descController.text.trim();
    final parsedDate = TaskDateUtils.tryParseIsoDate(_dateController.text);
    final parsedMinutes = TaskDateUtils.tryParseTimeMinutes(
      _timeController.text,
    );

    setState(() {
      _courseError = courseName.isEmpty ? l10n.gradeFieldCourseNameError : null;
      _descError = description.isEmpty ? l10n.taskFieldDescriptionError : null;
      _dateError = parsedDate == null ? l10n.taskFieldDueDateError : null;
      _timeError = parsedMinutes == null
          ? l10n.scheduleFieldTimeFormatError
          : null;
    });

    if (_courseError != null ||
        _descError != null ||
        _dateError != null ||
        _timeError != null ||
        parsedDate == null ||
        parsedMinutes == null) {
      return;
    }

    setState(() => _isSaving = true);
    final now = DateTime.now();
    final dueDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedMinutes ~/ 60,
      parsedMinutes % 60,
    );

    final existing = widget.initialTask;
    final task = AcademicTask(
      courseName: courseName,
      description: description,
      dueDate: dueDateTime,
      isCompleted: existing?.isCompleted ?? false,
      completedAt: existing?.completedAt,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    if (existing != null) {
      task.id = existing.id;
    }

    await widget.onSave(task);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final isEditing = widget.initialTask != null;
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return Padding(
      padding: EdgeInsets.only(
        left: AppTokens.screenMargin,
        right: AppTokens.screenMargin,
        top: AppTokens.space20,
        bottom: viewInsets.bottom + AppTokens.space24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              isEditing ? l10n.taskFormEditTitle : l10n.taskFormAddTitle,
              style: AppTypography.h2(palette.text900),
            ),
            const SizedBox(height: AppTokens.space16),
            AppTextField(
              label: l10n.gradeFieldCourseNameLabel,
              hintText: l10n.gradeFieldCourseNameHint,
              controller: _courseController,
              errorText: _courseError,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppTokens.space12),
            AppTextField(
              label: l10n.taskFieldDescriptionLabel,
              hintText: l10n.taskFieldDescriptionHint,
              controller: _descController,
              errorText: _descError,
              maxLines: 3,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppTokens.space12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: AppTextField(
                    label: l10n.taskFieldDueDateLabel,
                    hintText: l10n.taskFieldDueDateHint,
                    controller: _dateController,
                    errorText: _dateError,
                    keyboardType: TextInputType.datetime,
                    suffixIcon: IconButton(
                      tooltip: l10n.taskFieldDueDateLabel,
                      onPressed: _pickDate,
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                        color: palette.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: AppTextField(
                    label: l10n.taskFieldDueTimeLabel,
                    hintText: l10n.taskFieldDueTimeHint,
                    controller: _timeController,
                    errorText: _timeError,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    suffixIcon: IconButton(
                      tooltip: l10n.taskFieldDueTimeLabel,
                      onPressed: _pickTime,
                      icon: Icon(
                        Icons.access_time_rounded,
                        size: 18,
                        color: palette.primary,
                      ),
                    ),
                  ),
                ),
              ],
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
