import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';

enum SkeletonVariant { card, list }

/// Komponen Skeleton pemuatan (varian kartu & daftar) sesuai DESIGN.md bagian 7.
/// Menghormati pengaturan "hapus animasi" sistem.
class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    this.variant = SkeletonVariant.card,
    this.height = 96,
    this.width = double.infinity,
    this.itemCount = 3,
    this.borderRadius = AppTokens.radiusXl,
  });

  final SkeletonVariant variant;
  final double height;
  final double width;
  final int itemCount;
  final double borderRadius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    Widget buildBox(double boxHeight) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = disableAnimations ? 0.5 : _controller.value;
          final color = Color.lerp(
            palette.border.withValues(alpha: 0.35),
            palette.border.withValues(alpha: 0.75),
            t,
          );
          return Container(
            width: widget.width,
            height: boxHeight,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          );
        },
      );
    }

    final content = widget.variant == SkeletonVariant.card
        ? buildBox(widget.height)
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(widget.itemCount, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == widget.itemCount - 1 ? 0 : AppTokens.cardGap,
                ),
                child: buildBox(widget.height),
              );
            }),
          );

    return Semantics(label: context.l10n.semanticsLoading, child: content);
  }
}
