import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nguliah/core/services/export_service.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';

/// Kartu pratinjau ekspor terbungkus [RepaintBoundary] untuk tangkapan PNG/JPG
/// dan pratinjau sebelum menyimpan/membagikan sesuai PRD.md & DESIGN.md.
class ExportPreviewCard extends StatelessWidget {
  const ExportPreviewCard({
    required this.boundaryKey,
    required this.scope,
    required this.summary,
    required this.grades,
    required this.schedules,
    this.semesterFilter,
    super.key,
  });

  final GlobalKey boundaryKey;
  final ExportScope scope;
  final AcademicSummaryResult summary;
  final List<CourseGrade> grades;
  final List<CourseSchedule> schedules;
  final int? semesterFilter;

  /// Menangkap gambar PNG dari [RepaintBoundary] jika tersedia di widget tree.
  static Future<Uint8List?> capturePngBytes(GlobalKey key) async {
    try {
      final context = key.currentContext;
      if (context == null) return null;
      final boundary = context.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;

    final String title;
    final String detail;
    switch (scope) {
      case ExportScope.homeStats:
        title = l10n.exportScopeHomeStats;
        detail =
            '${l10n.statIpkLabel}: ${summary.formattedIpk} · '
            '${l10n.statCompletedSksLabel}: ${summary.completedSks} · '
            '${l10n.statCompletedCoursesLabel}: ${summary.completedCoursesCount}';
      case ExportScope.allGrades:
        title = semesterFilter == null
            ? l10n.exportScopeAllGrades
            : l10n.statIpsSemesterLabel(semesterFilter!);
        final count = semesterFilter == null
            ? grades.length
            : grades.where((g) => g.semester == semesterFilter).length;
        final score = semesterFilter == null
            ? '${l10n.statIpkLabel}: ${summary.formattedIpk}'
            : '${l10n.statIpsSemesterLabel(semesterFilter!)}: '
                  '${summary.formattedIpsFor(semesterFilter!)}';
        detail = '$score ($count MK)';
      case ExportScope.scheduleAttendance:
        title = l10n.exportScopeScheduleAttendance;
        detail = '${l10n.screenScheduleTitle}: ${schedules.length}';
    }

    return RepaintBoundary(
      key: boundaryKey,
      child: Container(
        padding: const EdgeInsets.all(AppTokens.space12),
        decoration: BoxDecoration(
          color: palette.bg,
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          border: Border.all(color: palette.border),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.preview_outlined,
              color: palette.primary,
              size: AppTokens.space20,
            ),
            const SizedBox(width: AppTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: AppTypography.caption(palette.text900)),
                  const SizedBox(height: AppTokens.space4),
                  Text(detail, style: AppTypography.caption(palette.text600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Baris pilihan cakupan ekspor pada [ExportSheet].
class ExportScopeOptionTile extends StatelessWidget {
  const ExportScopeOptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: AppTokens.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space12,
            vertical: AppTokens.space8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? palette.primarySoft : palette.bg,
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
            border: Border.all(
              color: isSelected ? palette.primary : palette.border,
              width: isSelected ? AppTokens.focusRingWidth : 1,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: 20,
                color: isSelected ? palette.primary : palette.text500,
              ),
              const SizedBox(width: AppTokens.space12),
              Expanded(
                child: Text(label, style: AppTypography.body(palette.text900)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
