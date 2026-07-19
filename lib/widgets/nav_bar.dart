import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/nav_item.dart';

import '../theme/app_theme.dart';

class PortfolioNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const PortfolioNavBar({super.key, required this.scrollController, required this.sectionKeys});

  @override
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isScrolled = widget.scrollController.offset > 60;
    if (isScrolled != _scrolled) setState(() => _scrolled = isScrolled);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _scrollTo(String section) {
    final key = widget.sectionKeys[section];
    if (key?.currentContext == null) return;
    Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: _scrolled ? AppColors.bg.withOpacity(0.92) : Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Logo
                GestureDetector(
                  onTap: () => widget.scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                  ),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'Haya Obaid',
                      style: GoogleFontsSerifStyle(
                        size: 20,
                        color: AppColors.gold,
                        letterSpacing: 0.04,
                      ),
                    ),
                  ),
                ),
                // Nav links
                Row(
                  children: [
                    NavItem('About', () => _scrollTo('about')),
                    const SizedBox(width: 36),
                    NavItem('Skills', () => _scrollTo('skills')),
                    const SizedBox(width: 36),
                    NavItem('Projects', () => _scrollTo('projects')),
                    const SizedBox(width: 36),
                    NavItem('Contact', () => _scrollTo('contact')),
                  ],
                ),
              ],
            ),
          ),
          if (_scrolled) Container(height: 1, color: AppColors.border),
        ],
      ),
    );
  }
}

TextStyle GoogleFontsSerifStyle({
  required double size,
  required Color color,
  double letterSpacing = -0.01,
  FontWeight weight = FontWeight.w300,
}) => AppFonts.serif(size: size, color: color, letterSpacing: letterSpacing, weight: weight);
