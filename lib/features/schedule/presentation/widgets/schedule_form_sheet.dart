import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';
import 'package:nguliah/features/schedule/presentation/widgets/schedule_form_fields.dart';

/// BottomSheet form tambah/ubah jadwal kuliah beserta pemilih waktu dan deteksi bentrok.
class ScheduleFormSheet extends StatefulWidget {
  const ScheduleFormSheet({
    required this.existingSchedules,
    super.key,
    this.initialSchedule,
    this.initialDay = 1,
  });

  final List<CourseSchedule> existingSchedules;
  final CourseSchedule? initialSchedule;
  final int initialDay;

  static Future<CourseSchedule?> show(
    BuildContext context, {
    required List<CourseSchedule> existingSchedules,
    CourseSchedule? initialSchedule,
    int initialDay = 1,
  }) {
    return showModalBottomSheet<CourseSchedule>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ScheduleFormSheet(
        existingSchedules: existingSchedules,
        initialSchedule: initialSchedule,
        initialDay: initialDay,
      ),
    );
  }

  @override
  State<ScheduleFormSheet> createState() => _ScheduleFormSheetState();
}

class _ScheduleFormSheetState extends State<ScheduleFormSheet> {
  late final TextEditingController _courseController;
  late final TextEditingController _roomController;
  late int _startMinutes;
  late int _endMinutes;
  late int _dayOfWeek;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    final editing = widget.initialSchedule;
    _courseController = TextEditingController(text: editing?.courseName ?? '');
    _roomController = TextEditingController(text: editing?.room ?? '');
    final now = DateTime.now();
    final curMinutes = now.hour * 60 + now.minute;
    _startMinutes =
        editing?.startTimeMinutes ?? (curMinutes >= 30 ? curMinutes - 30 : 0);
    _endMinutes =
        editing?.endTimeMinutes ??
        ((_startMinutes + 100).clamp(0, 23 * 60 + 59));
    _dayOfWeek = editing?.dayOfWeek ?? widget.initialDay.clamp(1, 7);
  }

  @override
  void dispose() {
    _courseController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  bool get _isCourseValid => _courseController.text.trim().isNotEmpty;
  bool get _isRoomValid => _roomController.text.trim().isNotEmpty;
  bool get _isTimeOrderValid => _endMinutes > _startMinutes;

  List<CourseSchedule> get _conflicts {
    if (_endMinutes <= _startMinutes) return const <CourseSchedule>[];
    return ScheduleCalculator.findConflictingSchedules(
      widget.existingSchedules,
      dayOfWeek: _dayOfWeek,
      startTimeMinutes: _startMinutes,
      endTimeMinutes: _endMinutes,
      excludeId: widget.initialSchedule?.id,
    );
  }

  Future<void> _pickTime({required bool isStart}) async {
    final currentMinutes = isStart ? _startMinutes : _endMinutes;
    final initialTime = TimeOfDay(
      hour: currentMinutes ~/ 60,
      minute: currentMinutes % 60,
    );
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked == null) return;
    final minutes = picked.hour * 60 + picked.minute;
    setState(() {
      if (isStart) {
        _startMinutes = minutes;
      } else {
        _endMinutes = minutes;
      }
    });
  }

  void _handleSave() {
    setState(() => _submitted = true);
    if (!_isCourseValid || !_isRoomValid || !_isTimeOrderValid) return;

    final now = DateTime.now();
    final editing = widget.initialSchedule;
    final schedule = CourseSchedule(
      courseName: _courseController.text.trim(),
      dayOfWeek: _dayOfWeek,
      startTimeMinutes: _startMinutes,
      endTimeMinutes: _endMinutes,
      room: _roomController.text.trim(),
      createdAt: editing?.createdAt ?? now,
      updatedAt: now,
    );
    if (editing != null) schedule.id = editing.id;
    Navigator.of(context).pop(schedule);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final conflicts = _conflicts;

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
                widget.initialSchedule != null
                    ? l10n.scheduleFormEditTitle
                    : l10n.scheduleFormAddTitle,
                style: AppTypography.h2(palette.text900),
              ),
            ),
            const SizedBox(height: AppTokens.space16),
            AppTextField(
              label: l10n.gradeFieldCourseNameLabel,
              hintText: l10n.gradeFieldCourseNameHint,
              controller: _courseController,
              errorText: _submitted && !_isCourseValid
                  ? l10n.gradeFieldCourseNameError
                  : null,
              onChanged: (_) => _submitted ? setState(() {}) : null,
            ),
            const SizedBox(height: AppTokens.space16),
            ScheduleDayTimeRow(
              dayOfWeek: _dayOfWeek,
              startMinutes: _startMinutes,
              endMinutes: _endMinutes,
              isTimeOrderValid: _isTimeOrderValid,
              submitted: _submitted,
              onDayChanged: (val) => setState(() => _dayOfWeek = val),
              onPickStartTime: () => _pickTime(isStart: true),
              onPickEndTime: () => _pickTime(isStart: false),
            ),
            ScheduleConflictBanner(conflicts: conflicts),
            const SizedBox(height: AppTokens.space16),
            AppTextField(
              label: l10n.scheduleFieldRoomLabel,
              hintText: l10n.scheduleFieldRoomHint,
              controller: _roomController,
              textInputAction: TextInputAction.done,
              errorText: _submitted && !_isRoomValid
                  ? l10n.scheduleFieldRoomError
                  : null,
              onChanged: (_) => _submitted ? setState(() {}) : null,
              onSubmitted: (_) => _handleSave(),
            ),
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
                    onPressed: _handleSave,
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
