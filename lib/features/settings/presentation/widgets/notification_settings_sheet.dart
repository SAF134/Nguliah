import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nguliah/core/services/notification_service.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/app_settings_model.dart';

/// Bottom sheet pengaturan pengingat & integrasi notifikasi perangkat.
class NotificationSettingsSheet extends StatefulWidget {
  const NotificationSettingsSheet({
    required this.initialSettings,
    required this.onSave,
    super.key,
  });

  final AppSettings initialSettings;
  final Future<void> Function(AppSettings updated) onSave;

  @override
  State<NotificationSettingsSheet> createState() =>
      _NotificationSettingsSheetState();
}

class _NotificationSettingsSheetState extends State<NotificationSettingsSheet> {
  bool _devicePermissionEnabled = true;
  late bool _scheduleEnabled;
  late final TextEditingController _scheduleOffsetController;
  late bool _taskEnabled;
  late final TextEditingController _taskOffsetController;
  late bool _eventEnabled;
  late final TextEditingController _eventOffsetController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final s = widget.initialSettings;
    _scheduleEnabled = s.scheduleNotificationEnabled;
    _scheduleOffsetController = TextEditingController(
      text: '${s.scheduleReminderOffsetMinutes}',
    );
    _taskEnabled = s.taskNotificationEnabled;
    _taskOffsetController = TextEditingController(
      text: '${s.taskReminderOffsetMinutes}',
    );
    _eventEnabled = s.eventNotificationEnabled;
    _eventOffsetController = TextEditingController(
      text: '${s.eventReminderOffsetMinutes}',
    );
  }

  @override
  void dispose() {
    _scheduleOffsetController.dispose();
    _taskOffsetController.dispose();
    _eventOffsetController.dispose();
    super.dispose();
  }

  Future<void> _requestDevicePermission() async {
    final granted = await NotificationService()
        .initializeAndRequestPermission();
    if (!mounted) return;
    final l10n = context.l10n;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            granted
                ? l10n.toastDeviceNotificationActive
                : l10n.toastDeviceNotificationDenied,
          ),
        ),
      );
  }

  Future<void> _submit() async {
    setState(() => _isSaving = true);
    final base = widget.initialSettings;
    final scheduleOffset =
        int.tryParse(_scheduleOffsetController.text.trim()) ?? 30;
    final taskOffset = int.tryParse(_taskOffsetController.text.trim()) ?? 60;
    final eventOffset = int.tryParse(_eventOffsetController.text.trim()) ?? 60;

    final updated = AppSettings(
      id: 1,
      localeCode: base.localeCode,
      themeMode: base.themeMode,
      customGradeWeightsJson: base.customGradeWeightsJson,
      onboardingCompleted: base.onboardingCompleted,
      weightA: base.weightA,
      weightAB: base.weightAB,
      weightB: base.weightB,
      weightBC: base.weightBC,
      weightC: base.weightC,
      weightD: base.weightD,
      weightE: base.weightE,
      minPassingGrade: base.minPassingGrade,
      retakeRule: base.retakeRule,
      scheduleNotificationEnabled: _scheduleEnabled,
      scheduleReminderOffsetMinutes: scheduleOffset.clamp(1, 10080),
      taskNotificationEnabled: _taskEnabled,
      taskReminderOffsetMinutes: taskOffset.clamp(1, 10080),
      eventNotificationEnabled: _eventEnabled,
      eventReminderOffsetMinutes: eventOffset.clamp(1, 10080),
      lastBackupAt: base.lastBackupAt,
    );
    await widget.onSave(updated);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
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
              l10n.settingsNotificationsTitle,
              style: AppTypography.h2(palette.text900),
            ),
            const SizedBox(height: AppTokens.space12),
            GlassCard(
              borderColor: palette.primary.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.space16,
                vertical: AppTokens.space12,
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.notifications_active_rounded,
                    color: _devicePermissionEnabled
                        ? palette.primary
                        : palette.text500,
                  ),
                  const SizedBox(width: AppTokens.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.settingsEnableDeviceNotification,
                          style: AppTypography.title(palette.text900),
                        ),
                        Text(
                          l10n.settingsEnableDeviceNotificationSubtitle,
                          style: AppTypography.caption(palette.text600),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _devicePermissionEnabled,
                    onChanged: (val) async {
                      setState(() => _devicePermissionEnabled = val);
                      if (val) {
                        await _requestDevicePermission();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.space16),
            _NotificationRow(
              title: l10n.settingsNotifyScheduleLabel,
              enabled: _scheduleEnabled,
              controller: _scheduleOffsetController,
              onToggle: (v) => setState(() => _scheduleEnabled = v),
            ),
            const SizedBox(height: AppTokens.space12),
            _NotificationRow(
              title: l10n.settingsNotifyTaskLabel,
              enabled: _taskEnabled,
              controller: _taskOffsetController,
              onToggle: (v) => setState(() => _taskEnabled = v),
            ),
            const SizedBox(height: AppTokens.space12),
            _NotificationRow(
              title: l10n.settingsNotifyEventLabel,
              enabled: _eventEnabled,
              controller: _eventOffsetController,
              onToggle: (v) => setState(() => _eventEnabled = v),
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

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({
    required this.title,
    required this.enabled,
    required this.controller,
    required this.onToggle,
  });

  final String title;
  final bool enabled;
  final TextEditingController controller;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return GlassCard(
      padding: const EdgeInsets.all(AppTokens.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(title, style: AppTypography.title(palette.text900)),
              ),
              Switch.adaptive(
                value: enabled,
                activeTrackColor: palette.primary,
                onChanged: onToggle,
              ),
            ],
          ),
          if (enabled) ...<Widget>[
            const SizedBox(height: AppTokens.space8),
            AppTextField(
              label: l10n.settingsCustomReminderMinutesLabel,
              hintText: l10n.settingsCustomReminderMinutesHint,
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ],
        ],
      ),
    );
  }
}
