import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';

/// Tombol aksi utama bergradien sesuai DESIGN.md bagian 7 & 10.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool enabled;
  final bool fullWidth;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _canTap =>
      widget.enabled && !widget.isLoading && widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final radius = BorderRadius.circular(AppTokens.radiusLg);

    final child = widget.isLoading
        ? SizedBox(
            width: AppTokens.space20,
            height: AppTokens.space20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(palette.onPrimary),
            ),
          )
        : Row(
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
          );

    return Semantics(
      button: true,
      enabled: _canTap,
      label: widget.isLoading ? context.l10n.semanticsLoading : widget.label,
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
              horizontal: AppTokens.space20,
              vertical: AppTokens.space12,
            ),
            decoration: BoxDecoration(
              gradient: _canTap ? AppTokens.gradientPrimary : null,
              color: _canTap ? null : palette.border,
              borderRadius: radius,
              border: _isFocused
                  ? Border.all(
                      color: palette.text900,
                      width: AppTokens.focusRingWidth,
                    )
                  : null,
              boxShadow: _canTap && !_isPressed
                  ? AppTokens.shadowMd
                  : const <BoxShadow>[],
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
