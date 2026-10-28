import 'package:flutter/material.dart';

/// Token desain terpusat sesuai DESIGN.md bagian 3.
abstract final class AppTokens {
  // --- Warna Terang ---
  static const Color lightBg = Color(0xFFF1F5FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightGlass = Color(0xB3FFFFFF); // 70%
  static const Color lightGlassBorder = Color(0x99FFFFFF); // 60%
  static const Color primary600 = Color(0xFF2563EB);
  static const Color primary500 = Color(0xFF3B82F6);
  static const Color primaryGradientEnd = Color(0xFF5B8DEF);
  static const Color primary100 = Color(0xFFDBEAFE);
  static const Color lightText900 = Color(0xFF0F172A);
  static const Color lightText700 = Color(0xFF334155);
  static const Color lightText600 = Color(0xFF475569);
  static const Color lightText500 = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFCBD5E1);
  static const Color lightSuccess = Color(0xFF15803D);
  static const Color lightWarning = Color(0xFFB45309);
  static const Color lightError = Color(0xFFDC2626);
  static const Color accent = Color(0xFFEC4899);

  // --- Warna Gelap ---
  static const Color darkBg = Color(0xFF0B1220);
  static const Color darkSurface = Color(0xFF111B2E);
  static const Color darkGlass = Color(0xB31E293B); // 70%
  static const Color darkGlassBorder = Color(0x99334155); // 60%
  static const Color darkPrimary = Color(0xFF60A5FA);
  static const Color darkOnPrimary = Color(0xFF0B1220);
  static const Color darkPrimaryContainer = Color(0xFF1E3A8A);
  static const Color darkText900 = Color(0xFFF1F5F9);
  static const Color darkText700 = Color(0xFFE2E8F0);
  static const Color darkText600 = Color(0xFFCBD5E1);
  static const Color darkText500 = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkSuccess = Color(0xFF4ADE80);
  static const Color darkWarning = Color(0xFFFBBF24);
  static const Color darkError = Color(0xFFF87171);

  // --- Warna Nilai (Grafik, selalu disertai label huruf) ---
  static const Color gradeA = Color(0xFF2563EB);
  static const Color gradeAB = Color(0xFF0EA5E9);
  static const Color gradeB = Color(0xFF14B8A6);
  static const Color gradeBC = Color(0xFF84CC16);
  static const Color gradeC = Color(0xFFF59E0B);
  static const Color gradeD = Color(0xFFF97316);
  static const Color gradeE = Color(0xFFDC2626);

  // --- Gradien Utama ---
  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[primary600, primaryGradientEnd],
  );

  // --- Spacing (kelipatan 4) ---
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space40 = 40;
  static const double space48 = 48;

  static const double screenMargin = 16;
  static const double screenMarginCompact = 12;
  static const double cardGap = 12;
  static const double cardPadding = 16;
  static const double bottomNavClearance = 96;
  static const double minTouchTarget = 48;
  static const double focusRingWidth = 2;

  // --- Breakpoint Responsif (DESIGN.md Bagian 9) ---
  static const double compactPhoneBreakpoint = 360;
  static const double tabletMinBreakpoint = 600;
  static const double tabletMaxBreakpoint = 840;
  static const double tabletContentMaxWidth = 640;

  // --- Radius ---
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radius2xl = 28;
  static const double radiusFull = 999;

  // --- Blur Kaca ---
  static const double glassBlurSigma = 20;

  // --- Shadow ---
  static const List<BoxShadow> shadowSm = <BoxShadow>[
    BoxShadow(
      color: Color(0x0F2563EB), // rgba(37,99,235,0.06)
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> shadowMd = <BoxShadow>[
    BoxShadow(
      color: Color(0x1A1E40AF), // rgba(30,64,175,0.10)
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  static const List<BoxShadow> shadowLg = <BoxShadow>[
    BoxShadow(
      color: Color(0x291E40AF), // rgba(30,64,175,0.16)
      offset: Offset(0, 16),
      blurRadius: 40,
    ),
  ];

  // --- Gerak ---
  static const Duration durationMicro = Duration(milliseconds: 150);
  static const Duration durationTransition = Duration(milliseconds: 250);
  static const Duration durationSplash = Duration(milliseconds: 400);
  static const Curve curveDefault = Curves.easeOutCubic;

  /// Mengembalikan warna indeks nilai sesuai token DESIGN.md.
  static Color colorForGrade(String gradeIndex) {
    switch (gradeIndex.toUpperCase()) {
      case 'A':
        return gradeA;
      case 'AB':
        return gradeAB;
      case 'B':
        return gradeB;
      case 'BC':
        return gradeBC;
      case 'C':
        return gradeC;
      case 'D':
        return gradeD;
      case 'E':
      default:
        return gradeE;
    }
  }
}

/// Palet warna adaptif terang/gelap yang ditempelkan pada ThemeData.
@immutable
class NguliahPalette extends ThemeExtension<NguliahPalette> {
  const NguliahPalette({
    required this.bg,
    required this.surface,
    required this.glass,
    required this.glassBorder,
    required this.primary,
    required this.onPrimary,
    required this.primarySoft,
    required this.text900,
    required this.text700,
    required this.text600,
    required this.text500,
    required this.border,
    required this.success,
    required this.warning,
    required this.error,
    required this.accent,
  });

  final Color bg;
  final Color surface;
  final Color glass;
  final Color glassBorder;
  final Color primary;
  final Color onPrimary;
  final Color primarySoft;
  final Color text900;
  final Color text700;
  final Color text600;
  final Color text500;
  final Color border;
  final Color success;
  final Color warning;
  final Color error;
  final Color accent;

  static const NguliahPalette light = NguliahPalette(
    bg: AppTokens.lightBg,
    surface: AppTokens.lightSurface,
    glass: AppTokens.lightGlass,
    glassBorder: AppTokens.lightGlassBorder,
    primary: AppTokens.primary600,
    onPrimary: AppTokens.lightSurface,
    primarySoft: AppTokens.primary100,
    text900: AppTokens.lightText900,
    text700: AppTokens.lightText700,
    text600: AppTokens.lightText600,
    text500: AppTokens.lightText500,
    border: AppTokens.lightBorder,
    success: AppTokens.lightSuccess,
    warning: AppTokens.lightWarning,
    error: AppTokens.lightError,
    accent: AppTokens.accent,
  );

  static const NguliahPalette dark = NguliahPalette(
    bg: AppTokens.darkBg,
    surface: AppTokens.darkSurface,
    glass: AppTokens.darkGlass,
    glassBorder: AppTokens.darkGlassBorder,
    primary: AppTokens.darkPrimary,
    onPrimary: AppTokens.darkOnPrimary,
    primarySoft: AppTokens.darkPrimaryContainer,
    text900: AppTokens.darkText900,
    text700: AppTokens.darkText700,
    text600: AppTokens.darkText600,
    text500: AppTokens.darkText500,
    border: AppTokens.darkBorder,
    success: AppTokens.darkSuccess,
    warning: AppTokens.darkWarning,
    error: AppTokens.darkError,
    accent: AppTokens.accent,
  );

  @override
  NguliahPalette copyWith({
    Color? bg,
    Color? surface,
    Color? glass,
    Color? glassBorder,
    Color? primary,
    Color? onPrimary,
    Color? primarySoft,
    Color? text900,
    Color? text700,
    Color? text600,
    Color? text500,
    Color? border,
    Color? success,
    Color? warning,
    Color? error,
    Color? accent,
  }) {
    return NguliahPalette(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      glass: glass ?? this.glass,
      glassBorder: glassBorder ?? this.glassBorder,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primarySoft: primarySoft ?? this.primarySoft,
      text900: text900 ?? this.text900,
      text700: text700 ?? this.text700,
      text600: text600 ?? this.text600,
      text500: text500 ?? this.text500,
      border: border ?? this.border,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      accent: accent ?? this.accent,
    );
  }

  @override
  NguliahPalette lerp(ThemeExtension<NguliahPalette>? other, double t) {
    if (other is! NguliahPalette) return this;
    return NguliahPalette(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      text900: Color.lerp(text900, other.text900, t)!,
      text700: Color.lerp(text700, other.text700, t)!,
      text600: Color.lerp(text600, other.text600, t)!,
      text500: Color.lerp(text500, other.text500, t)!,
      border: Color.lerp(border, other.border, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }
}

extension NguliahThemeX on BuildContext {
  NguliahPalette get palette =>
      Theme.of(this).extension<NguliahPalette>() ?? NguliahPalette.light;
}
