import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';

/// Kartu grafik diagram batang tren IPS per semester (dibulatkan 2 digit desimal).
class IpsLineChartCard extends StatelessWidget {
  const IpsLineChartCard({required this.ipsBySemester, super.key});

  final Map<int, double> ipsBySemester;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final entries = ipsBySemester.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return GlassCard(
      borderColor: palette.primary,
      borderWidth: 1.5,
      padding: const EdgeInsets.all(AppTokens.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.bar_chart_rounded, color: palette.primary),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Text(
                  l10n.homeIpsTrendTitle,
                  style: AppTypography.title(palette.text900),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space16),
          if (entries.isEmpty)
            Text(
              l10n.homeIpsTrendEmpty,
              style: AppTypography.body(palette.text600),
            )
          else
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: 4.0,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => palette.surface,
                      tooltipBorder: BorderSide(color: palette.border),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          'Semester ${group.x.toInt()}\n',
                          AppTypography.caption(palette.text600),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${l10n.shortIpsLabel}: ${rod.toY.toStringAsFixed(2)}',
                              style: AppTypography.title(palette.primary),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 1.0,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: palette.border.withValues(alpha: 0.35),
                      strokeWidth: 1,
                    ),
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1.0,
                        getTitlesWidget: (val, _) => Text(
                          val.toStringAsFixed(0),
                          style: AppTypography.caption(palette.text500),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (val, _) {
                          final sem = val.toInt();
                          if (!ipsBySemester.containsKey(sem)) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: AppTokens.space8,
                            ),
                            child: Text(
                              'S$sem',
                              style: AppTypography.caption(palette.text700),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: entries.map((e) {
                    return BarChartGroupData(
                      x: e.key,
                      barRods: <BarChartRodData>[
                        BarChartRodData(
                          toY: double.parse(e.value.toStringAsFixed(2)),
                          color: palette.primary,
                          width: 18,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(AppTokens.radiusSm),
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 4.0,
                            color: palette.primarySoft.withValues(alpha: 0.3),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
