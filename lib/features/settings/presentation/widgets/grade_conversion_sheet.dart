import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/confirm_dialog.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/app_settings_model.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';
import 'package:nguliah/features/settings/presentation/widgets/grade_conversion_tile.dart';

/// Bottom sheet Konversi Nilai dengan CRUD Indeks & Bobot.
class GradeConversionSheet extends StatefulWidget {
  const GradeConversionSheet({
    required this.initialSettings,
    required this.onSave,
    super.key,
  });

  final AppSettings initialSettings;
  final Future<void> Function(AppSettings updated) onSave;

  @override
  State<GradeConversionSheet> createState() => _GradeConversionSheetState();
}

class _GradeConversionEntry {
  _GradeConversionEntry(String index, double weight)
    : indexController = TextEditingController(text: index),
      weightController = TextEditingController(text: weight.toString());

  final TextEditingController indexController;
  final TextEditingController weightController;

  void dispose() {
    indexController.dispose();
    weightController.dispose();
  }
}

class _GradeConversionSheetState extends State<GradeConversionSheet> {
  final List<_GradeConversionEntry> _items = <_GradeConversionEntry>[];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    final s = widget.initialSettings;
    Map<String, double> weights;
    if (s.customGradeWeightsJson.isNotEmpty) {
      try {
        final decoded =
            jsonDecode(s.customGradeWeightsJson) as Map<String, dynamic>;
        weights = decoded.map((k, v) => MapEntry(k, (v as num).toDouble()));
      } catch (_) {
        weights = GradeConversionConfig.defaultWeights;
      }
    } else {
      weights = <String, double>{
        'A': s.weightA,
        'AB': s.weightAB,
        'B': s.weightB,
        'BC': s.weightBC,
        'C': s.weightC,
        'D': s.weightD,
        'E': s.weightE,
      };
    }

    for (final item in _items) {
      item.dispose();
    }
    _items.clear();
    for (final e in weights.entries) {
      _items.add(_GradeConversionEntry(e.key, e.value));
    }
  }

  @override
  void dispose() {
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  void _resetToDefault() {
    setState(() {
      for (final item in _items) {
        item.dispose();
      }
      _items.clear();
      for (final e in GradeConversionConfig.defaultWeights.entries) {
        _items.add(_GradeConversionEntry(e.key, e.value));
      }
    });
  }

  void _addNewGradeIndex() {
    AddGradeIndexDialog.show(
      context,
      onAdd: (key, val) {
        setState(() {
          _items.add(_GradeConversionEntry(key, val));
        });
      },
    );
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.settingsConfirmSaveConversionTitle,
      message: l10n.settingsConfirmSaveConversionMessage,
      confirmLabel: l10n.actionSave,
      cancelLabel: l10n.actionCancel,
    );
    if (!confirmed || !mounted) return;

    setState(() => _isSaving = true);
    final map = <String, double>{};
    for (final item in _items) {
      final key = item.indexController.text.trim().toUpperCase();
      final val =
          double.tryParse(
            item.weightController.text.trim().replaceAll(',', '.'),
          ) ??
          0.0;
      if (key.isNotEmpty) {
        map[key] = val;
      }
    }

    final base = widget.initialSettings;
    final updated = AppSettings(
      id: 1,
      localeCode: base.localeCode,
      themeMode: base.themeMode,
      customGradeWeightsJson: jsonEncode(map),
      onboardingCompleted: base.onboardingCompleted,
      weightA: map['A'] ?? 4.0,
      weightAB: map['AB'] ?? 3.5,
      weightB: map['B'] ?? 3.0,
      weightBC: map['BC'] ?? 2.5,
      weightC: map['C'] ?? 2.0,
      weightD: map['D'] ?? 1.0,
      weightE: map['E'] ?? 0.0,
      minPassingGrade: 'D',
      retakeRule: RetakeRule.latest,
      scheduleNotificationEnabled: base.scheduleNotificationEnabled,
      scheduleReminderOffsetMinutes: base.scheduleReminderOffsetMinutes,
      taskNotificationEnabled: base.taskNotificationEnabled,
      taskReminderOffsetMinutes: base.taskReminderOffsetMinutes,
      eventNotificationEnabled: base.eventNotificationEnabled,
      eventReminderOffsetMinutes: base.eventReminderOffsetMinutes,
      hideAcademicScores: base.hideAcademicScores,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  l10n.settingsConversionTitle,
                  style: AppTypography.h2(palette.text900),
                ),
                SecondaryButton(
                  label: l10n.actionReset,
                  variant: SecondaryButtonVariant.text,
                  icon: Icons.refresh_rounded,
                  onPressed: _resetToDefault,
                ),
              ],
            ),
            const SizedBox(height: AppTokens.space12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              itemBuilder: (context, i) {
                final item = _items[i];
                return GradeConversionTile(
                  indexController: item.indexController,
                  weightController: item.weightController,
                  onDelete: _items.length <= 1
                      ? null
                      : () async {
                          final confirmed = await ConfirmDialog.show(
                            context,
                            title: l10n.settingsConfirmDeleteConversionTitle,
                            message:
                                l10n.settingsConfirmDeleteConversionMessage,
                            confirmLabel: l10n.actionDelete,
                            cancelLabel: l10n.actionCancel,
                          );
                          if (confirmed && mounted) {
                            setState(() {
                              _items.removeAt(i).dispose();
                            });
                          }
                        },
                );
              },
            ),
            const SizedBox(height: AppTokens.space8),
            SecondaryButton(
              label: l10n.settingsAddGradeConversion,
              icon: Icons.add_rounded,
              onPressed: _addNewGradeIndex,
            ),
            const SizedBox(height: AppTokens.space20),
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
