import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';

enum SlideToConfirmVariant { start, restore }

/// Komponen geser-untuk-konfirmasi sesuai DESIGN.md bagian 7 & 10.
/// Menyediakan aksi semantik "Konfirmasi" dan tombol alternatif tanpa geser.
class SlideToConfirm extends StatefulWidget {
  const SlideToConfirm({
    required this.label,
    required this.onConfirmed,
    super.key,
    this.variant = SlideToConfirmVariant.start,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onConfirmed;
  final SlideToConfirmVariant variant;
  final bool enabled;

  @override
  State<SlideToConfirm> createState() => _SlideToConfirmState();
}

class _SlideToConfirmState extends State<SlideToConfirm> {
  double _dragFraction = 0.0;
  bool _isDragging = false;
  bool _isCompleted = false;
  bool _isFocused = false;

  void _triggerComplete() {
    if (!widget.enabled || _isCompleted) return;
    setState(() {
      _dragFraction = 1.0;
      _isDragging = false;
      _isCompleted = true;
    });
    widget.onConfirmed();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final isRestore = widget.variant == SlideToConfirmVariant.restore;
    final thumbColor = isRestore ? palette.error : palette.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Semantics(
          container: true,
          button: true,
          enabled: widget.enabled && !_isCompleted,
          label: widget.label,
          hint: l10n.slideToConfirmAction,
          customSemanticsActions: <CustomSemanticsAction, VoidCallback>{
            CustomSemanticsAction(label: l10n.actionConfirm): _triggerComplete,
          },
          child: FocusableActionDetector(
            enabled: widget.enabled && !_isCompleted,
            onShowFocusHighlight: (f) => setState(() => _isFocused = f),
            actions: <Type, Action<Intent>>{
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (_) {
                  _triggerComplete();
                  return null;
                },
              ),
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                const trackHeight = AppTokens.minTouchTarget + AppTokens.space8;
                const thumbSize = AppTokens.minTouchTarget;
                const padding = AppTokens.space4;
                final maxDrag =
                    (constraints.maxWidth - thumbSize - (padding * 2)).clamp(
                      1.0,
                      double.infinity,
                    );
                final thumbOffset = _dragFraction * maxDrag;

                return Container(
                  height: trackHeight,
                  padding: const EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: palette.primarySoft,
                    borderRadius: BorderRadius.circular(AppTokens.radiusFull),
                    border: Border.all(
                      color: _isFocused ? palette.primary : palette.border,
                      width: _isFocused ? AppTokens.focusRingWidth : 1,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: thumbSize,
                          ),
                          child: Text(
                            widget.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.title(palette.text900),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: _isDragging || disableAnimations
                            ? Duration.zero
                            : AppTokens.durationTransition,
                        curve: AppTokens.curveDefault,
                        left: thumbOffset,
                        child: GestureDetector(
                          onHorizontalDragStart: widget.enabled && !_isCompleted
                              ? (_) => setState(() => _isDragging = true)
                              : null,
                          onHorizontalDragUpdate:
                              widget.enabled && !_isCompleted
                              ? (details) {
                                  setState(() {
                                    final next =
                                        (_dragFraction * maxDrag +
                                            details.delta.dx) /
                                        maxDrag;
                                    _dragFraction = next.clamp(0.0, 1.0);
                                  });
                                }
                              : null,
                          onHorizontalDragEnd: widget.enabled && !_isCompleted
                              ? (_) {
                                  if (_dragFraction >= 0.8) {
                                    _triggerComplete();
                                  } else {
                                    setState(() {
                                      _isDragging = false;
                                      _dragFraction = 0.0;
                                    });
                                  }
                                }
                              : null,
                          child: Container(
                            width: thumbSize,
                            height: thumbSize,
                            decoration: BoxDecoration(
                              gradient: isRestore
                                  ? null
                                  : AppTokens.gradientPrimary,
                              color: isRestore ? thumbColor : null,
                              shape: BoxShape.circle,
                              boxShadow: AppTokens.shadowSm,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              _isCompleted
                                  ? Icons.check_rounded
                                  : Icons.arrow_forward_rounded,
                              color: AppTokens.lightSurface,
                              size: AppTokens.space24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
