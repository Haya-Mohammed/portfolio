import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg       = Color(0xFF0C0B09);
  static const bg2      = Color(0xFF131210);
  static const bg3      = Color(0xFF1A1814);
  static const gold     = Color(0xFFC9A84C);
  static const goldLight= Color(0xFFE8C97A);
  static const goldDim  = Color(0xFF7A6430);
  static const cream    = Color(0xFFF0E8D8);
  static const textMain = Color(0xFFD4CFC6);
  static const muted    = Color(0xFF7A7570);
  static const border   = Color(0x26C9A84C); // ~15% gold
}

class AppFonts {
  static TextStyle serif({
    double size = 16,
    FontWeight weight = FontWeight.w300,
    Color color = AppColors.cream,
    FontStyle style = FontStyle.normal,
    double? height,
    double letterSpacing = -0.01,
  }) =>
      GoogleFonts.cormorantGaramond(
        fontSize: size,
        fontWeight: weight,
        color: color,
        fontStyle: style,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle mono({
    double size = 11,
    FontWeight weight = FontWeight.w300,
    Color color = AppColors.muted,
    double letterSpacing = 0.15,
  }) =>
      GoogleFonts.dmMono(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle sans({
    double size = 16,
    FontWeight weight = FontWeight.w300,
    Color color = AppColors.textMain,
    double height = 1.8,
  }) =>
      GoogleFonts.outfit(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );
}

ThemeData buildTheme() => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.bg,
  colorScheme: const ColorScheme.dark(
    surface: AppColors.bg,
    primary: AppColors.gold,
  ),
  textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
);