import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';

enum GlassCardVariant { standard, tappable, highlight }

/// Kartu bergaya soft glass sesuai DESIGN.md bagian 3 & 7.
/// Otomatis turun ke surface solid apabila animasi sistem dinonaktifkan
/// atau [useSolidFallback] bernilai true.
class GlassCard extends StatefulWidget {
  const GlassCard({
    required this.child,
    super.key,
    this.variant = GlassCardVariant.standard,
    this.padding = const EdgeInsets.all(AppTokens.cardPadding),
    this.borderRadius = AppTokens.radiusXl,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.enabled = true,
    this.useSolidFallback = false,
    this.semanticLabel,
  });

  final Widget child;
  final GlassCardVariant variant;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final bool enabled;
  final bool useSolidFallback;
  final String? semanticLabel;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isPressed = false;

  bool get _isInteractive =>
      widget.enabled &&
      (widget.onTap != null || widget.variant == GlassCardVariant.tappable);

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final useSolid = widget.useSolidFallback || disableAnimations;

    final effectiveBorderColor =
        widget.borderColor ??
        switch (widget.variant) {
          GlassCardVariant.highlight => palette.primary,
          _ => useSolid ? palette.border : palette.glassBorder,
        };

    final effectiveBorderWidth =
        widget.borderWidth ??
        (widget.borderColor != null ||
                widget.variant == GlassCardVariant.highlight
            ? 1.5
            : 1.0);

    final backgroundColor = useSolid ? palette.surface : palette.glass;
    final radius = BorderRadius.circular(widget.borderRadius);

    Widget content = AnimatedContainer(
      duration: disableAnimations ? Duration.zero : AppTokens.durationMicro,
      curve: AppTokens.curveDefault,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: radius,
        border: Border.all(
          color: effectiveBorderColor,
          width: effectiveBorderWidth,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (widget.borderColor ?? palette.primary).withValues(
              alpha: _isPressed ? 0.08 : 0.12,
            ),
            offset: const Offset(0, 4),
            blurRadius: _isPressed ? 8 : 18,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Opacity(opacity: widget.enabled ? 1.0 : 0.5, child: widget.child),
    );

    if (!useSolid) {
      content = ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppTokens.glassBlurSigma,
            sigmaY: AppTokens.glassBlurSigma,
          ),
          child: content,
        ),
      );
    }

    if (_isInteractive) {
      content = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: content,
      );
    }

    return Semantics(
      container: true,
      button: _isInteractive,
      enabled: widget.enabled,
      label: widget.semanticLabel,
      child: content,
    );
  }
}
