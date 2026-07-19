import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const NavItem(this.label, this.onTap);

  @override
  State<NavItem> createState() => NavItemState();
}

class NavItemState extends State<NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: AppFonts.mono(
                size: 10,
                weight: FontWeight.w500,
                letterSpacing: 0.14,
                color: _hovered ? AppColors.gold : AppColors.muted,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 1,
              width: _hovered ? 40 : 0,
              color: AppColors.gold,
            ),
          ],
        ),
      ),
    );
  }
}
