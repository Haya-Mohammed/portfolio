import 'dart:ui';

import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _isDark = false;

  void _toggleTheme() => setState(() => _isDark = !_isDark);

  @override
  Widget build(BuildContext context) {
    Brand.isDark = _isDark;
    return MaterialApp(
      title: 'Haya Obaid | Mobile Application Developer',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: HomeScreen(isDark: _isDark, onToggleTheme: _toggleTheme),
      scrollBehavior: _SmoothScrollBehavior(),
    );
  }
}

class _SmoothScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
  };
}
