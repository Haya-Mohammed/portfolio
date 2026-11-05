import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';

class AppFonts {
  static TextStyle display({double size = 32, double height = 1.12}) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: FontWeight.w600,
        height: height,
        color: AppColors.charcoal,
      );

  static TextStyle body({
    double size = 16,
    FontWeight weight = FontWeight.w500,
    Color? color,
    double height = 1.5,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    color: color ?? AppColors.charcoal,
    height: height,
  );

  static TextStyle mono({double size = 12, Color? color}) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.deepMustard,
        letterSpacing: 1.3,
      );
}
