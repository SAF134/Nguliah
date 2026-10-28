import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';

@immutable
class BottomNavPillItem {
  const BottomNavPillItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// Navigasi bawah berbentuk pil melayang 5 tab sesuai DESIGN.md bagian 4 & 7.
class BottomNavPill extends StatelessWidget {
  const BottomNavPill({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  }) : assert(items.length == 5, 'BottomNavPill wajib memiliki 5 tab utama.');

  final List<BottomNavPillItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final radius = BorderRadius.circular(AppTokens.radiusFull);

    Widget pill = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.space8,
        vertical: AppTokens.space8,
      ),
      decoration: BoxDecoration(
        color: disableAnimations ? palette.surface : palette.glass,
        borderRadius: radius,
        border: Border.all(color: palette.primary, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette.primary.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          ...AppTokens.shadowLg,
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;
          return Expanded(
            child: _NavPillTab(
              item: item,
              isSelected: isSelected,
              disableAnimations: disableAnimations,
              onTap: () => onTap(index),
            ),
          );
        }),
      ),
    );

    if (!disableAnimations) {
      pill = ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppTokens.glassBlurSigma,
            sigmaY: AppTokens.glassBlurSigma,
          ),
          child: pill,
        ),
      );
    }

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(
        AppTokens.screenMargin,
        0,
        AppTokens.screenMargin,
        AppTokens.space16,
      ),
      child: pill,
    );
  }
}

class _NavPillTab extends StatelessWidget {
  const _NavPillTab({
    required this.item,
    required this.isSelected,
    required this.disableAnimations,
    required this.onTap,
  });

  final BottomNavPillItem item;
  final bool isSelected;
  final bool disableAnimations;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final fgColor = isSelected ? AppTokens.lightSurface : palette.text600;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTokens.radiusFull),
        onTap: onTap,
        child: AnimatedContainer(
          duration: disableAnimations
              ? Duration.zero
              : AppTokens.durationTransition,
          curve: AppTokens.curveDefault,
          constraints: const BoxConstraints(
            minHeight: AppTokens.minTouchTarget,
            minWidth: AppTokens.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space4,
            vertical: AppTokens.space8,
          ),
          decoration: BoxDecoration(
            gradient: isSelected ? AppTokens.gradientPrimary : null,
            borderRadius: BorderRadius.circular(AppTokens.radiusFull),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                isSelected ? item.activeIcon : item.icon,
                size: AppTokens.space20,
                color: fgColor,
              ),
              const SizedBox(height: AppTokens.space4),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption(fgColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
