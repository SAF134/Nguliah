import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';

/// Komponen Avatar mahasiswa sesuai DESIGN.md bagian 7 & 8:
/// menampilkan foto lokal jika tersedia, atau otomatis jatuh ke inisial nama
/// jika tanpa foto maupun saat berkas foto gagal dimuat/rusak.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.name,
    this.photoPath,
    this.radius = AppTokens.space24,
    super.key,
  });

  final String name;
  final String? photoPath;
  final double radius;

  static String initialsFromName(String rawName) {
    final parts = rawName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'M';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final diameter = radius * 2;
    final initials = initialsFromName(name);
    final hasFile =
        photoPath != null &&
        photoPath!.trim().isNotEmpty &&
        File(photoPath!).existsSync();

    Widget fallbackInitials() {
      return Center(
        child: Text(initials, style: AppTypography.title(palette.primary)),
      );
    }

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: palette.primarySoft,
        shape: BoxShape.circle,
        border: Border.all(color: palette.primary, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette.primary.withValues(alpha: 0.22),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: hasFile
          ? Image.file(
              File(photoPath!),
              width: diameter,
              height: diameter,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => fallbackInitials(),
            )
          : fallbackInitials(),
    );
  }
}
