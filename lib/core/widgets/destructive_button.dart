import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';

/// Tombol aksi destruktif berwarna error sesuai DESIGN.md bagian 7 & 10.
class DestructiveButton extends StatefulWidget {
  const DestructiveButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.enabled = true,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;
  final bool fullWidth;

  @override
  State<DestructiveButton> createState() => _DestructiveButtonState();
}

class _DestructiveButtonState extends State<DestructiveButton> {
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _canTap => widget.enabled && widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    return Semantics(
      button: true,
      enabled: _canTap,
      label: widget.label,
      child: FocusableActionDetector(
        enabled: _canTap,
        onShowFocusHighlight: (f) => setState(() => _isFocused = f),
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
              color: _canTap
                  ? (_isPressed
                        ? palette.error.withValues(alpha: 0.85)
                        : palette.error)
                  : palette.border,
              borderRadius: BorderRadius.circular(AppTokens.radiusLg),
              border: _isFocused
                  ? Border.all(
                      color: palette.text900,
                      width: AppTokens.focusRingWidth,
                    )
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
                  Icon(
                    widget.icon,
                    size: AppTokens.space20,
                    color: AppTokens.lightSurface,
                  ),
                  const SizedBox(width: AppTokens.space8),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.title(AppTokens.lightSurface),
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
