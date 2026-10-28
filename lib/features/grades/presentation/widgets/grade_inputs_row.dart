import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';

/// Baris sejajar untuk input semester (1-14), SKS, dan indeks nilai.
class GradeInputsRow extends StatelessWidget {
  const GradeInputsRow({
    required this.semesterController,
    required this.sksController,
    required this.gradeIndex,
    required this.isSemesterValid,
    required this.isSksValid,
    required this.submitted,
    required this.onSemesterChanged,
    required this.onSksChanged,
    required this.onGradeIndexChanged,
    super.key,
  });

  final TextEditingController semesterController;
  final TextEditingController sksController;
  final String gradeIndex;
  final bool isSemesterValid;
  final bool isSksValid;
  final bool submitted;
  final ValueChanged<String> onSemesterChanged;
  final ValueChanged<String> onSksChanged;
  final ValueChanged<String> onGradeIndexChanged;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: AppTextField(
            label: l10n.gradeFieldSemesterLabel,
            hintText: '1-14',
            controller: semesterController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            errorText: submitted && !isSemesterValid
                ? l10n.fieldRequired
                : null,
            onChanged: onSemesterChanged,
          ),
        ),
        const SizedBox(width: AppTokens.space8),
        Expanded(
          flex: 3,
          child: AppTextField(
            label: l10n.gradeFieldSksLabel,
            hintText: l10n.gradeFieldSksHint,
            controller: sksController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            errorText: submitted && !isSksValid
                ? l10n.gradeFieldSksError
                : null,
            onChanged: onSksChanged,
          ),
        ),
        const SizedBox(width: AppTokens.space8),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                l10n.gradeFieldIndexLabel,
                style: AppTypography.caption(palette.text700),
              ),
              const SizedBox(height: AppTokens.space8),
              DropdownButtonFormField<String>(
                key: ValueKey<String>(gradeIndex),
                initialValue: gradeIndex,
                isExpanded: true,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppTokens.space12,
                    vertical: AppTokens.space12,
                  ),
                ),
                items: GradeConversionConfig.orderedIndices
                    .map(
                      (idx) => DropdownMenuItem<String>(
                        value: idx,
                        child: Text(idx),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) onGradeIndexChanged(val);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
