import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class _PortfolioAppState extends State<PortfolioApp>
    with WidgetsBindingObserver {
  static const _themeKey = 'portfolio_theme_mode';
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final value = prefs.getString(_themeKey);
    setState(
      () => _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.name == value,
        orElse: () => ThemeMode.system,
      ),
    );
  }

  Future<void> _setTheme(ThemeMode mode) async {
    setState(() => _themeMode = mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  @override
  void didChangePlatformBrightness() => setState(() {});

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        _themeMode == ThemeMode.dark ||
        (_themeMode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);
    Brand.isDark = isDark;
    return MaterialApp(
      title: 'Haya Obaid | Mobile Application Developer',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: HomeScreen(
        isDark: isDark,
        onThemeChanged: _setTheme,
      ),
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
