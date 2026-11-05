import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';

ThemeData buildTheme() {
  final base = AppColors.isDark ? ThemeData.dark() : ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.ivory,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mustard,
      brightness: AppColors.isDark ? Brightness.dark : Brightness.light,
      primary: AppColors.charcoal,
      onPrimary: AppColors.ivory,
      surface: AppColors.paper,
      onSurface: AppColors.charcoal,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.charcoal,
        foregroundColor: AppColors.ivory,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.charcoal,
        minimumSize: const Size(0, 48),
        side: BorderSide(color: AppColors.charcoal),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
