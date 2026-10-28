import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';

/// Konfigurasi Tema Material 3 Terang & Gelap sesuai DESIGN.md.
abstract final class AppTheme {
  static ThemeData light() =>
      _build(brightness: Brightness.light, palette: NguliahPalette.light);

  static ThemeData dark() =>
      _build(brightness: Brightness.dark, palette: NguliahPalette.dark);

  static ThemeData _build({
    required Brightness brightness,
    required NguliahPalette palette,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      primaryContainer: palette.primarySoft,
      onPrimaryContainer: palette.text900,
      secondary: AppTokens.primary500,
      onSecondary: AppTokens.lightSurface,
      error: palette.error,
      onError: AppTokens.lightSurface,
      surface: palette.surface,
      onSurface: palette.text900,
      outline: palette.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppTypography.fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.bg,
      textTheme: AppTypography.buildTextTheme(palette),
      extensions: <ThemeExtension<dynamic>>[palette],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.h1(palette.text900),
        iconTheme: IconThemeData(color: palette.text900),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space16,
          vertical: AppTokens.space12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: palette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: palette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(
            color: palette.primary,
            width: AppTokens.focusRingWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          borderSide: BorderSide(color: palette.error),
        ),
      ),
    );
  }
}
