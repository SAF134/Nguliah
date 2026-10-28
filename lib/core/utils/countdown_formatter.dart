/// Utilitas pemformat hitung mundur waktu tersisa dan selisih penyelesaian.
abstract final class CountdownFormatter {
  /// Memformat sisa waktu menuju [target] secara dinamis:
  /// - >= 1 hari: "X hari lagi"
  /// - 1 jam - 23 jam: "X jam lagi"
  /// - 1 menit - 59 menit: "X menit lagi" (realtime)
  /// - < 1 menit / sudah lewat: status sesuai kondisi
  static String formatRemaining(
    DateTime target, {
    DateTime? now,
    bool isEnglish = false,
  }) {
    final current = now ?? DateTime.now();
    final diff = target.difference(current);

    if (diff.isNegative) {
      return isEnglish ? 'Overdue' : 'Terlambat';
    }

    if (diff.inDays >= 1) {
      final days = diff.inDays;
      return isEnglish
          ? '$days ${days == 1 ? "day" : "days"} left'
          : '$days hari lagi';
    }

    if (diff.inHours >= 1) {
      final hours = diff.inHours;
      return isEnglish
          ? '$hours ${hours == 1 ? "hour" : "hours"} left'
          : '$hours jam lagi';
    }

    final minutes = diff.inMinutes;
    if (minutes >= 1) {
      return isEnglish ? '$minutes min left' : '$minutes menit lagi';
    }

    return isEnglish ? '< 1 min left' : '< 1 menit lagi';
  }

  /// Alias pemformat hitung mundur waktu tersisa.
  static String formatCountdown(
    DateTime target, {
    DateTime? now,
    bool isEnglish = false,
  }) {
    return formatRemaining(target, now: now, isEnglish: isEnglish);
  }

  /// Memformat hitung mundur menuju jam perkuliahan hari ini.
  static String formatScheduleCountdown({
    required int startTimeMinutes,
    required int endTimeMinutes,
    DateTime? now,
    bool isEnglish = false,
  }) {
    final current = now ?? DateTime.now();
    final currentMinutes = current.hour * 60 + current.minute;

    if (currentMinutes >= startTimeMinutes &&
        currentMinutes <= endTimeMinutes) {
      return isEnglish ? 'Class in progress' : 'Sedang berlangsung';
    }

    if (currentMinutes > endTimeMinutes) {
      return isEnglish ? 'Class finished today' : 'Selesai hari ini';
    }

    final diff = startTimeMinutes - currentMinutes;
    if (diff >= 60) {
      final h = diff ~/ 60;
      final m = diff % 60;
      if (m > 0) {
        return isEnglish ? '$h h $m m left' : '$h jam $m menit lagi';
      }
      return isEnglish ? '$h hours left' : '$h jam lagi';
    }

    return isEnglish ? '$diff min left' : '$diff menit lagi';
  }

  /// Memformat selisih waktu penyelesaian tugas dibanding tenggat waktu:
  /// - Terlambat: "Terlambat X hari Y jam" / "Terlambat X jam Y menit"
  /// - Lebih awal: "Selesai X hari Y jam lebih awal" / "Selesai tepat waktu"
  static String formatCompletionOffset(
    DateTime deadline,
    DateTime completedAt, {
    bool isEnglish = false,
  }) {
    final diff = completedAt.difference(deadline);

    if (diff.inMinutes.abs() < 1) {
      return isEnglish ? 'Completed on time' : 'Selesai tepat waktu';
    }

    final isLate = diff.isNegative == false;
    final absDiff = diff.abs();

    final parts = <String>[];
    if (absDiff.inDays > 0) {
      parts.add(isEnglish ? '${absDiff.inDays} d' : '${absDiff.inDays} hari');
    }
    final remainingHours = absDiff.inHours % 24;
    if (remainingHours > 0) {
      parts.add(isEnglish ? '$remainingHours h' : '$remainingHours jam');
    }
    final remainingMinutes = absDiff.inMinutes % 60;
    if (absDiff.inDays == 0 && remainingMinutes > 0) {
      parts.add(isEnglish ? '$remainingMinutes m' : '$remainingMinutes menit');
    }

    final durationStr = parts.isEmpty
        ? (isEnglish ? '1 min' : '1 menit')
        : parts.join(' ');

    if (isLate) {
      return isEnglish ? 'Late by $durationStr' : 'Terlambat $durationStr';
    } else {
      return isEnglish
          ? 'Completed $durationStr early'
          : 'Selesai $durationStr lebih awal';
    }
  }
}
