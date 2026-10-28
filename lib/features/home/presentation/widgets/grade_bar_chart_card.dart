import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';

/// Kartu sebaran nilai dengan dua opsi tampilan: Diagram Batang & Pie Chart (%).
class GradeBarChartCard extends StatefulWidget {
  const GradeBarChartCard({required this.gradeDistribution, super.key});

  final Map<String, int> gradeDistribution;

  @override
  State<GradeBarChartCard> createState() => _GradeBarChartCardState();
}

class _GradeBarChartCardState extends State<GradeBarChartCard> {
  bool _isPieChart = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    const indices = GradeConversionConfig.orderedIndices;
    final totalCount = widget.gradeDistribution.values.fold<int>(
      0,
      (prev, curr) => prev + curr,
    );

    return GlassCard(
      borderColor: palette.primary,
      borderWidth: 1.5,
      padding: const EdgeInsets.all(AppTokens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.pie_chart_outline_rounded, color: palette.primary),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Text(
                  l10n.homeGradeDistributionTitle,
                  style: AppTypography.title(palette.text900),
                ),
              ),
              // Segmented Toggle Opsi Bar Chart / Pie Chart
              Container(
                decoration: BoxDecoration(
                  color: palette.primarySoft,
                  borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                  border: Border.all(color: palette.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      padding: EdgeInsets.zero,
                      tooltip: l10n.homeChartToggleBar,
                      icon: Icon(
                        Icons.bar_chart_rounded,
                        size: 20,
                        color: !_isPieChart ? palette.primary : palette.text500,
                      ),
                      onPressed: () => setState(() => _isPieChart = false),
                    ),
                    IconButton(
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      padding: EdgeInsets.zero,
                      tooltip: l10n.homeChartTogglePie,
                      icon: Icon(
                        Icons.pie_chart_rounded,
                        size: 20,
                        color: _isPieChart ? palette.primary : palette.text500,
                      ),
                      onPressed: () => setState(() => _isPieChart = true),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space16),
          if (totalCount == 0)
            Text(
              l10n.homeGradeDistributionEmpty,
              style: AppTypography.body(palette.text600),
            )
          else ...<Widget>[
            if (!_isPieChart)
              SizedBox(
                height: 160,
                child: BarChart(
                  BarChartData(
                    maxY:
                        (widget.gradeDistribution.values.fold<int>(
                                  0,
                                  (p, c) => c > p ? c : p,
                                ) +
                                1)
                            .toDouble(),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (val, _) {
                            final idx = val.toInt();
                            if (idx < 0 || idx >= indices.length) {
                              return const SizedBox.shrink();
                            }
                            final grade = indices[idx];
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: AppTokens.space4,
                              ),
                              child: Text(
                                grade,
                                style: AppTypography.caption(palette.text900)
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: List<BarChartGroupData>.generate(
                      indices.length,
                      (i) {
                        final grade = indices[i];
                        final count = widget.gradeDistribution[grade] ?? 0;
                        return BarChartGroupData(
                          x: i,
                          barRods: <BarChartRodData>[
                            BarChartRodData(
                              toY: count.toDouble(),
                              color: AppTokens.colorForGrade(grade),
                              width: 18,
                              borderRadius: BorderRadius.circular(
                                AppTokens.radiusSm,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            else
              SizedBox(
                height: 160,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 36,
                    sections: indices
                        .where((g) => (widget.gradeDistribution[g] ?? 0) > 0)
                        .map((g) {
                          final count = widget.gradeDistribution[g]!;
                          final pct = (count / totalCount) * 100;
                          return PieChartSectionData(
                            color: AppTokens.colorForGrade(g),
                            value: count.toDouble(),
                            title: '$g\n${pct.toStringAsFixed(0)}%',
                            radius: 46,
                            titleStyle: AppTypography.caption(
                              AppTokens.lightSurface,
                            ).copyWith(fontWeight: FontWeight.bold),
                          );
                        })
                        .toList(),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
