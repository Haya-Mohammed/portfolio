import 'package:flutter/material.dart';

class AppColors {
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
  static Color get deviceFrame =>
      isDark ? const Color(0xFF151513) : const Color(0xFFE5DDD1);
  static Color get deviceDetail =>
      isDark ? const Color(0xFF8A8985) : const Color(0xFF998F82);
}
