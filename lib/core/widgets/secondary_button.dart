import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';

enum SecondaryButtonVariant { outline, text, danger }

/// Tombol sekunder (outline / teks) sesuai DESIGN.md bagian 7 & 10.
class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = SecondaryButtonVariant.outline,
    this.icon,
    this.enabled = true,
    this.fullWidth = false,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final SecondaryButtonVariant variant;
  final IconData? icon;
  final bool enabled;
  final bool fullWidth;
  final String? semanticLabel;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _canTap => widget.enabled && widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final isDanger = widget.variant == SecondaryButtonVariant.danger;
    final fgColor = _canTap
        ? (isDanger ? palette.error : palette.primary)
        : palette.text500;
    final isOutline = widget.variant == SecondaryButtonVariant.outline;

    return Semantics(
      button: true,
      enabled: _canTap,
      label: widget.semanticLabel ?? widget.label,
      child: FocusableActionDetector(
        enabled: _canTap,
        onShowFocusHighlight: (focused) => setState(() => _isFocused = focused),
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              if (_canTap) widget.onPressed?.call();
              return null;
            },
          ),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _canTap ? (_) => setState(() => _isPressed = true) : null,
          onTapUp: _canTap ? (_) => setState(() => _isPressed = false) : null,
          onTapCancel: _canTap
              ? () => setState(() => _isPressed = false)
              : null,
          onTap: _canTap ? widget.onPressed : null,
          child: AnimatedContainer(
            duration: disableAnimations
                ? Duration.zero
                : AppTokens.durationMicro,
            curve: AppTokens.curveDefault,
            constraints: const BoxConstraints(
              minHeight: AppTokens.minTouchTarget,
              minWidth: AppTokens.minTouchTarget,
            ),
            width: widget.fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.space16,
              vertical: AppTokens.space12,
            ),
            decoration: BoxDecoration(
              color: isDanger
                  ? palette.error.withValues(alpha: _isPressed ? 0.2 : 0.08)
                  : (_isPressed
                        ? palette.primarySoft.withValues(alpha: 0.5)
                        : Colors.transparent),
              borderRadius: BorderRadius.circular(AppTokens.radiusLg),
              border: _isFocused
                  ? Border.all(
                      color: isDanger ? palette.error : palette.primary,
                      width: AppTokens.focusRingWidth,
                    )
                  : isDanger
                  ? Border.all(color: palette.error, width: 1.5)
                  : isOutline
                  ? Border.all(color: _canTap ? palette.border : palette.border)
                  : null,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: widget.fullWidth
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.icon != null) ...<Widget>[
                  Icon(widget.icon, size: AppTokens.space20, color: fgColor),
                  const SizedBox(width: AppTokens.space8),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.title(fgColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
