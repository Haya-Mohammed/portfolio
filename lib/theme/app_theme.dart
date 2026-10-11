import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Brand {
  static bool isDark = false;

  static Color get charcoal =>
      isDark ? const Color(0xFFF1ECE4) : const Color(0xFF272727);
  static const mustard = Color(0xFFDCA028);
  static Color get deepMustard => isDark ? mustard : const Color(0xFF7A5C0E);
  static Color get ivory =>
      isDark ? const Color(0xFF1F1E1B) : const Color(0xFFF1ECE4);
  static Color get paper =>
      isDark ? const Color(0xFF2A2926) : const Color(0xFFFAF8F3);
  static Color get oatmeal =>
      isDark ? const Color(0xFF35332F) : const Color(0xFFE3DCD2);
  static Color get warmGray =>
      isDark ? const Color(0xFF625C53) : const Color(0xFFCDC6BD);
  static Color get muted =>
      isDark ? const Color(0xFFC8BEB2) : const Color(0xFF59534D);
  static const footer = Color(0xFF272727);
  static const footerText = Color(0xFFF1ECE4);
}

class AppFonts {
  static TextStyle display({double size = 32, double height = 1.12}) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: FontWeight.w600,
        height: height,
        color: Brand.charcoal,
      );

  static TextStyle body({
    double size = 16,
    FontWeight weight = FontWeight.w500,
    Color? color,
    double height = 1.5,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    color: color ?? Brand.charcoal,
    height: height,
  );

  static TextStyle mono({double size = 12, Color? color}) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: color ?? Brand.deepMustard,
        letterSpacing: 1.3,
      );
}

ThemeData buildTheme() {
  final base = Brand.isDark ? ThemeData.dark() : ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: Brand.ivory,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Brand.mustard,
      brightness: Brand.isDark ? Brightness.dark : Brightness.light,
      primary: Brand.charcoal,
      onPrimary: Brand.ivory,
      surface: Brand.paper,
      onSurface: Brand.charcoal,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Brand.charcoal,
        foregroundColor: Brand.ivory,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Brand.charcoal,
        minimumSize: const Size(0, 48),
        side: BorderSide(color: Brand.charcoal),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
