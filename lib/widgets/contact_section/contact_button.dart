import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButton extends StatefulWidget {
  @override
  State<ContactButton> createState() => ContactButtonState();
}

class ContactButtonState extends State<ContactButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse('mailto:${AppConstants.email}')),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          color: _hovered ? AppColors.goldLight : AppColors.gold,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          child: Text(
            'SAY HELLO  →',
            style: AppFonts.mono(size: 11, color: AppColors.bg, letterSpacing: 0.18),
          ),
        ),
      ),
    );
  }
}
