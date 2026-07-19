import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLink extends StatefulWidget {
  final String label, url;
  const SocialLink({required this.label, required this.url});

  @override
  State<SocialLink> createState() => SocialLinkState();
}

class SocialLinkState extends State<SocialLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: Text(
          widget.label.toUpperCase(),
          style: AppFonts.mono(
            size: 9,
            letterSpacing: 0.15,
            color: _hovered ? AppColors.gold : AppColors.muted,
          ),
        ),
      ),
    );
  }
}
