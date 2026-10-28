import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/data/models/attendance_record_model.dart';
import 'package:nguliah/data/models/course_grade_model.dart';
import 'package:nguliah/data/models/course_schedule_model.dart';
import 'package:nguliah/data/models/user_profile_model.dart';
import 'package:nguliah/features/events/application/event_providers.dart';
import 'package:nguliah/features/grades/application/grade_calculator.dart';
import 'package:nguliah/features/schedule/application/schedule_calculator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// Cakupan data yang diekspor sesuai PRD.md.
enum ExportScope { homeStats, allGrades, scheduleAttendance }

/// Format berkas ekspor sesuai PRD.md.
enum ExportFormat { pdf, png, jpg }

/// Layanan pembuat dokumen PDF / gambar PNG & JPG untuk Beranda, Nilai, dan Jadwal.
class ExportService {
  const ExportService();

  /// Membuat bytes PDF berdasarkan cakupan data akademik (termasuk filter semester opsional).
  static Future<Uint8List> buildPdfBytes({
    required ExportScope scope,
    required UserProfile? profile,
    required AcademicSummaryResult summary,
    required List<CourseGrade> grades,
    required List<CourseSchedule> schedules,
    required List<AttendanceRecord> attendances,
    int? semesterFilter,
  }) async {
    final doc = pw.Document();
    final studentInfo = profile != null
        ? '${profile.name} · ${profile.major} (${profile.university})'
        : 'Nguliah Academic Summary';

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          switch (scope) {
            case ExportScope.homeStats:
              return _buildHomeStatsPdf(studentInfo, summary);
            case ExportScope.allGrades:
              return _buildGradesTranscriptPdf(
                studentInfo,
                summary,
                grades,
                semesterFilter: semesterFilter,
              );
            case ExportScope.scheduleAttendance:
              return _buildScheduleAttendancePdf(
                studentInfo,
                schedules,
                attendances,
              );
          }
        },
      ),
    );

    return doc.save();
  }

  static List<pw.Widget> _buildHomeStatsPdf(
    String studentInfo,
    AcademicSummaryResult summary,
  ) {
    return <pw.Widget>[
      pw.Text(
        'Nguliah - Ringkasan Statistik Akademik',
        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 4),
      pw.Text(studentInfo, style: const pw.TextStyle(fontSize: 11)),
      pw.Divider(),
      pw.SizedBox(height: 8),
      pw.Text(
        'IPK Kumulatif: ${summary.formattedIpk} | '
        'SKS Selesai: ${summary.completedSks} | '
        'MK Selesai: ${summary.completedCoursesCount}',
        style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 16),
      pw.Text(
        'Tren IPS per Semester:',
        style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 6),
      pw.TableHelper.fromTextArray(
        headers: const <String>['Semester', 'IPS'],
        data: summary.ipsBySemester.entries
            .map(
              (e) => <String>[
                'Semester ${e.key}',
                GradeCalculator.formatScore(e.value),
              ],
            )
            .toList(),
      ),
      pw.SizedBox(height: 16),
      pw.Text(
        'Sebaran Nilai:',
        style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 6),
      pw.TableHelper.fromTextArray(
        headers: const <String>['Indeks', 'Jumlah MK'],
        data: summary.gradeDistribution.entries
            .map((e) => <String>[e.key, '${e.value}'])
            .toList(),
      ),
    ];
  }

  static List<pw.Widget> _buildGradesTranscriptPdf(
    String studentInfo,
    AcademicSummaryResult summary,
    List<CourseGrade> grades, {
    int? semesterFilter,
  }) {
    final visibleGrades = semesterFilter == null
        ? grades
        : grades.where((g) => g.semester == semesterFilter).toList();
    final headerMetric = semesterFilter == null
        ? 'IPK Kumulatif: ${summary.formattedIpk} '
              '(SKS Selesai: ${summary.completedSks}, MK Selesai: ${summary.completedCoursesCount})'
        : 'IPS $semesterFilter: ${summary.formattedIpsFor(semesterFilter)}';

    return <pw.Widget>[
      pw.Text(
        'Nguliah - Transkrip Nilai Akademik',
        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 4),
      pw.Text(studentInfo, style: const pw.TextStyle(fontSize: 11)),
      pw.Divider(),
      pw.Text(
        headerMetric,
        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 12),
      pw.TableHelper.fromTextArray(
        headers: const <String>['Semester', 'Mata Kuliah', 'SKS', 'Nilai'],
        data: visibleGrades
            .map(
              (g) => <String>[
                'Sem ${g.semester}',
                g.courseName,
                '${g.sks}',
                g.gradeIndex,
              ],
            )
            .toList(),
      ),
    ];
  }

  static List<pw.Widget> _buildScheduleAttendancePdf(
    String studentInfo,
    List<CourseSchedule> schedules,
    List<AttendanceRecord> attendances,
  ) {
    final recaps = ScheduleCalculator.buildAttendanceRecap(
      schedules,
      attendances,
    );
    return <pw.Widget>[
      pw.Text(
        'Nguliah - Jadwal Kuliah & Rekap Presensi',
        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 4),
      pw.Text(studentInfo, style: const pw.TextStyle(fontSize: 11)),
      pw.Divider(),
      pw.SizedBox(height: 8),
      pw.Text(
        'Jadwal Mingguan:',
        style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 6),
      pw.TableHelper.fromTextArray(
        headers: const <String>['Hari', 'Jam', 'Mata Kuliah', 'Ruangan'],
        data: schedules
            .map(
              (s) => <String>[
                'Hari ke-${s.dayOfWeek}',
                EventTimeUtils.formatRange(
                  s.startTimeMinutes,
                  s.endTimeMinutes,
                ),
                s.courseName,
                s.room,
              ],
            )
            .toList(),
      ),
      pw.SizedBox(height: 16),
      pw.Text(
        'Rekap Kehadiran per MK:',
        style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 6),
      pw.TableHelper.fromTextArray(
        headers: const <String>[
          'Mata Kuliah',
          'Hadir',
          'Sakit',
          'Izin',
          'Alpa',
          '%',
        ],
        data: recaps
            .map(
              (r) => <String>[
                r.courseName,
                '${r.presentCount}',
                '${r.sickCount}',
                '${r.permissionCount}',
                '${r.absentCount}',
                '${r.formattedPercentage}%',
              ],
            )
            .toList(),
      ),
    ];
  }

  /// Mengekspor dokumen/gambar ke berkas lokal dan membuka sheet berbagi sistem.
  Future<File> exportAndShare({
    required ExportScope scope,
    required ExportFormat format,
    required UserProfile? profile,
    required AcademicSummaryResult summary,
    required List<CourseGrade> grades,
    required List<CourseSchedule> schedules,
    required List<AttendanceRecord> attendances,
    int? semesterFilter,
    Uint8List? preRenderedImageBytes,
    bool shareFile = true,
  }) async {
    final pdfBytes = await buildPdfBytes(
      scope: scope,
      profile: profile,
      summary: summary,
      grades: grades,
      schedules: schedules,
      attendances: attendances,
      semesterFilter: semesterFilter,
    );

    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().millisecondsSinceEpoch;
    late final File outputFile;

    if (format == ExportFormat.pdf) {
      outputFile = File('${dir.path}/nguliah_${scope.name}_$stamp.pdf');
      await outputFile.writeAsBytes(pdfBytes);
    } else {
      final ext = format == ExportFormat.png ? 'png' : 'jpg';
      outputFile = File('${dir.path}/nguliah_${scope.name}_$stamp.$ext');
      Uint8List? imageBytes = preRenderedImageBytes;
      if (imageBytes == null) {
        try {
          await for (final page in Printing.raster(
            pdfBytes,
            pages: const [0],
          )) {
            imageBytes = await page.toPng();
            break;
          }
        } catch (_) {
          imageBytes = pdfBytes;
        }
      }
      await outputFile.writeAsBytes(imageBytes ?? pdfBytes);
    }

    if (shareFile) {
      await SharePlus.instance.share(
        ShareParams(files: <XFile>[XFile(outputFile.path)]),
      );
    }
    return outputFile;
  }
}

final exportServiceProvider = Provider<ExportService>((ref) {
  return const ExportService();
});
