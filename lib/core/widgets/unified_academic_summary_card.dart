import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';
import 'package:nguliah/features/grades/application/grade_providers.dart';

/// Kartu ringkasan akademik terpadu (IPK, SKS Selesai, dan MK Selesai).
/// Digunakan pada Halaman Beranda dan Halaman Nilai.
/// Mendukung fitur sembunyikan nilai (sensor bintang *) dan ukuran IPK/IPS serasi.
class UnifiedAcademicSummaryCard extends ConsumerWidget {
  const UnifiedAcademicSummaryCard({
    required this.ipk,
    required this.completedSks,
    required this.completedCoursesCount,
    super.key,
    this.ips,
    this.activeSemester,
    this.isCensored,
  });

  factory UnifiedAcademicSummaryCard.fromSummary({
    required AcademicSummaryResult summary,
    int? activeSemester,
    int? totalCoursesCount,
    bool? isCensored,
    Key? key,
  }) {
    final effectiveCoursesCount =
        totalCoursesCount != null &&
            totalCoursesCount > summary.completedCoursesCount
        ? totalCoursesCount
        : summary.completedCoursesCount;

    return UnifiedAcademicSummaryCard(
      key: key,
      ipk: summary.formattedIpk,
      ips: activeSemester != null
          ? summary.formattedIpsFor(activeSemester)
          : null,
      completedSks: summary.completedSks,
      completedCoursesCount: effectiveCoursesCount,
      activeSemester: activeSemester,
      isCensored: isCensored,
    );
  }

  final String ipk;
  final String? ips;
  final int completedSks;
  final int completedCoursesCount;
  final int? activeSemester;
  final bool? isCensored;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final l10n = context.l10n;
    final isHidden =
        isCensored == true || ref.watch(hideAcademicScoresProvider) == true;

    final displayIpk = isHidden ? '***' : ipk;
    final displayIps = isHidden ? '***' : ips;
    final displaySks = isHidden ? '*** SKS' : '$completedSks SKS';
    final displayCourses = isHidden ? '*** MK' : '$completedCoursesCount MK';

    return GlassCard(
      borderColor: palette.primary,
      borderWidth: 1.5,
      padding: const EdgeInsets.all(AppTokens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Icon Header
              Container(
                padding: const EdgeInsets.all(AppTokens.space8),
                decoration: BoxDecoration(
                  gradient: AppTokens.gradientPrimary,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: palette.primary.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: AppTokens.lightSurface,
                  size: AppTokens.space20,
                ),
              ),
              const SizedBox(width: AppTokens.space8),

              // Judul Semester / IPK mengisi ruang tengah
              Expanded(
                child: Text(
                  activeSemester == null
                      ? l10n.gradesIpkTitle
                      : l10n.statIpsSemesterLabel(activeSemester!),
                  style: AppTypography.title(palette.text900),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppTokens.space8),

              // Nilai IPK & IPS di pojok kanan paling tepi (tahan overflow layar 320dp & font 200%)
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (displayIps != null) ...<Widget>[
                          _buildScoreBadge(
                            context: context,
                            prefix: l10n.shortIpsLabel,
                            score: displayIps,
                            textStyle: AppTypography.title(palette.primary),
                          ),
                          const SizedBox(height: AppTokens.space4),
                        ],
                        _buildScoreBadge(
                          context: context,
                          prefix: displayIps != null
                              ? l10n.shortIpkLabel
                              : null,
                          score: displayIpk,
                          textStyle: (displayIps != null
                              ? AppTypography.title(palette.primary)
                              : AppTypography.h1(palette.primary)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space16),
          const Divider(height: 1),
          const SizedBox(height: AppTokens.space12),
          LayoutBuilder(
            builder: (context, constraints) {
              final sksBox = _buildStatBox(
                context: context,
                icon: Icons.verified_rounded,
                iconColor: palette.success,
                title: l10n.gradesCompletedSksTitle,
                value: displaySks,
              );
              final coursesBox = _buildStatBox(
                context: context,
                icon: Icons.auto_stories_rounded,
                iconColor: palette.primary,
                title: l10n.gradesCompletedCoursesTitle,
                value: displayCourses,
              );

              if (constraints.maxWidth < 240) {
                return Column(
                  children: <Widget>[
                    sksBox,
                    const SizedBox(height: AppTokens.space8),
                    coursesBox,
                  ],
                );
              }
              return Row(
                children: <Widget>[
                  Expanded(child: sksBox),
                  const SizedBox(width: AppTokens.space12),
                  Expanded(child: coursesBox),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBadge({
    required BuildContext context,
    required String? prefix,
    required String score,
    required TextStyle textStyle,
  }) {
    final palette = context.palette;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (prefix != null)
          Text(
            '$prefix: ',
            style: AppTypography.caption(palette.text600)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space12,
            vertical: AppTokens.space4,
          ),
          decoration: BoxDecoration(
            color: palette.primarySoft,
            borderRadius: BorderRadius.circular(AppTokens.radiusFull),
            border: Border.all(color: palette.primary, width: 1.5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: palette.primary.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            score,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.all(AppTokens.space12),
      decoration: BoxDecoration(
        color: palette.primarySoft.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        border: Border.all(color: palette.border),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: iconColor, size: AppTokens.space24),
          const SizedBox(width: AppTokens.space8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption(palette.text600),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(value, style: AppTypography.h2(palette.text900)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
