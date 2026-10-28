import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';

/// Ubin editor indeks nilai dan bobot dalam bottom sheet konversi nilai.
class GradeConversionTile extends StatelessWidget {
  const GradeConversionTile({
    required this.indexController,
    required this.weightController,
    required this.onDelete,
    super.key,
  });

  final TextEditingController indexController;
  final TextEditingController weightController;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space12,
          vertical: AppTokens.space8,
        ),
        borderColor: palette.primary.withValues(alpha: 0.2),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: indexController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: l10n.gradeFieldIndexLabel,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppTokens.space12),
            Expanded(
              flex: 4,
              child: TextFormField(
                controller: weightController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  labelText: l10n.settingsGradeWeightLabel,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, size: 20),
              color: palette.error,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

/// Dialog untuk menambah indeks nilai baru beserta bobotnya.
class AddGradeIndexDialog extends StatefulWidget {
  const AddGradeIndexDialog({required this.onAdd, super.key});

  final void Function(String key, double value) onAdd;

  static Future<void> show(
    BuildContext context, {
    required void Function(String key, double value) onAdd,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => AddGradeIndexDialog(onAdd: onAdd),
    );
  }

  @override
  State<AddGradeIndexDialog> createState() => _AddGradeIndexDialogState();
}

class _AddGradeIndexDialogState extends State<AddGradeIndexDialog> {
  late final TextEditingController _indexController;
  late final TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _indexController = TextEditingController();
    _weightController = TextEditingController(text: '3.0');
  }

  @override
  void dispose() {
    _indexController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;

    return AlertDialog(
      backgroundColor: palette.surface,
      title: Text(l10n.gradeFormAddTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppTextField(
            label: l10n.gradeFieldIndexLabel,
            hintText: 'Contoh: A-',
            controller: _indexController,
          ),
          const SizedBox(height: AppTokens.space12),
          AppTextField(
            label: 'Bobot',
            hintText: 'Contoh: 400',
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppTokens.space16,
        0,
        AppTokens.space16,
        AppTokens.space16,
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: SecondaryButton(
                label: l10n.actionCancel,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(width: AppTokens.space12),
            Expanded(
              child: PrimaryButton(
                label: l10n.actionSave,
                onPressed: () {
                  final key = _indexController.text.trim().toUpperCase();
                  final val =
                      double.tryParse(
                        _weightController.text.trim().replaceAll(',', '.'),
                      ) ??
                      0.0;
                  if (key.isNotEmpty) {
                    widget.onAdd(key, val);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
