import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';

/// Kolom input teks/angka standar dengan label dan pesan error aksesibel
/// sesuai DESIGN.md bagian 7 & 10.
class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    required this.controller,
    super.key,
    this.hintText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final String? errorText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label, style: AppTypography.caption(palette.text700)),
        const SizedBox(height: AppTokens.space8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: AppTypography.body(palette.text900),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTypography.body(palette.text500),
            suffixIcon: suffixIcon,
          ),
        ),
        if (hasError) ...<Widget>[
          const SizedBox(height: AppTokens.space4),
          Semantics(
            liveRegion: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.error_outline_rounded,
                  size: AppTokens.space16,
                  color: palette.error,
                ),
                const SizedBox(width: AppTokens.space4),
                Expanded(
                  child: Text(
                    errorText!,
                    style: AppTypography.caption(palette.error),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
