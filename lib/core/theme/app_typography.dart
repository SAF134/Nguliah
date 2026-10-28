import 'package:flutter/material.dart';
import 'package:nguliah/core/theme/app_tokens.dart';

/// Tipografi Plus Jakarta Sans (cadangan: Roboto) sesuai DESIGN.md bagian 3.
abstract final class AppTypography {
  static const String fontFamily = 'PlusJakartaSans';
  static const List<String> fontFamilyFallback = <String>['Roboto'];

  static TextStyle display(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle numberXl(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 40,
    height: 44 / 40,
    fontWeight: FontWeight.w700,
    color: color,
    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
  );

  static TextStyle h1(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle h2(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle title(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle body(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle caption(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextTheme buildTextTheme(NguliahPalette palette) {
    return TextTheme(
      displayLarge: numberXl(palette.text900),
      displayMedium: display(palette.text900),
      headlineLarge: h1(palette.text900),
      headlineMedium: h2(palette.text900),
      titleMedium: title(palette.text900),
      bodyMedium: body(palette.text700),
      bodySmall: caption(palette.text600),
      labelSmall: caption(palette.text500),
    );
  }
}
