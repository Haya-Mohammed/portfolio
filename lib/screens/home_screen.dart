import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';
import 'package:my_portfolio/widgets/about.dart';
import 'package:my_portfolio/widgets/common/section.dart';
import 'package:my_portfolio/widgets/common/motion.dart';
import 'package:my_portfolio/widgets/common/animated_backdrop.dart';
import 'package:my_portfolio/widgets/common/floating_tech_cloud.dart';
import 'package:my_portfolio/widgets/contact.dart';
import 'package:my_portfolio/widgets/experience.dart';
import 'package:my_portfolio/widgets/projects.dart';
import 'package:my_portfolio/widgets/skills.dart';
import 'package:url_launcher/url_launcher.dart';


import '../content/portfolio_content.dart';
import 'package:my_portfolio/core/constants/cv_download_stub.dart'
    if (dart.library.html) 'package:my_portfolio/core/constants/cv_download_web.dart'
    as cv;

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final ValueChanged<ThemeMode> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scroll = ScrollController();
  final keys = <String, GlobalKey>{
    for (final name in ['work', 'skills', 'about', 'experience', 'contact'])
      name: GlobalKey(),
  };


  void go(String name) {
    final target = keys[name]?.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  Widget eyebrow(String label) =>
      Text(label, style: AppFonts.mono(size: 12, color: AppColors.deepMustard));

  Future<void> open(String url) async =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  Future<void> downloadCv() => cv.downloadCv();

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.ivory,
    bottomNavigationBar: MediaQuery.sizeOf(context).width < 600
        ? SafeArea(
            top: false,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.paper,
                border: Border(top: BorderSide(color: AppColors.warmGray)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  _mobileNavItem(Icons.apps_rounded, 'Work', 'work'),
                  _mobileNavItem(Icons.layers_outlined, 'Skills', 'skills'),
                  _mobileNavItem(Icons.person_outline, 'About', 'about'),
                  _mobileNavItem(Icons.mail_outline, 'Contact', 'contact'),
                ],
              ),
            ),
          )
        : null,
    body: LayoutBuilder(
      builder: (context, box) {
        final narrow = box.maxWidth < 900;
        return Column(
          children: [
            header(narrow),
            Expanded(
              child: Stack(
                children: [
                  const Positioned.fill(child: AnimatedBackdrop()),
                  SingleChildScrollView(
                    controller: scroll,
                    child: Column(
                      children: [
                        hero(narrow),
                        Section(
                          label: '01 / SELECTED WORK',
                          title: 'Apps shaped by real problems',
                          key: keys['work']!,
                          shaded: false,
                          revealStyle: RevealStyle.fromLeft,
                          child: ProjectsSection(),
                        ),
                        Section(
                          label: '02 / WHAT I DO',
                          title: 'Building with care',
                          key: keys['skills']!,
                          shaded: true,
                          revealStyle: RevealStyle.rise,
                          child: SkillsSection(),
                        ),
                        Section(
                          label: '03 / ABOUT',
                          title: 'A developer who cares about the details',
                          key: keys['about']!,
                          shaded: false,
                          revealStyle: RevealStyle.fromRight,
                          child: AboutSection(narrow: narrow),
                        ),
                        Section(
                          label: '04 / EXPERIENCE',
                          title: 'Where I have contributed',
                          key: keys['experience']!,
                          shaded: true,
                          revealStyle: RevealStyle.fromLeft,
                          child: ExperienceSection(),
                        ),
                        Section(
                          label: '05 / CONTACT',
                          title: 'Let’s build something thoughtful',
                          key: keys['contact']!,
                          shaded: false,
                          revealStyle: RevealStyle.scale,
                          child: ContactSection(),
                        ),
                        Container(
                          width: double.infinity,
                          color: AppColors.paper.withValues(alpha: 0.78),
                          padding: const EdgeInsets.all(28),
                          child: Text(
                            '© 2026 Haya Obaid · ${PortfolioContent.tagline}',
                            textAlign: TextAlign.center,
                            style: AppFonts.body(size: 13, color: AppColors.muted),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  Widget _mobileNavItem(IconData icon, String label, String section) =>
      Expanded(
        child: InkWell(
          onTap: () => go(section),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: AppColors.charcoal),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: AppFonts.body(size: 10, weight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      );

  Widget header(bool narrow) {
    const links = {
      'Work': 'work',
      'Skills': 'skills',
      'About': 'about',
      'Experience': 'experience',
      'Contact': 'contact',
    };
    return Column(
      children: [
        Container(
          color: AppColors.paper,
          padding: EdgeInsets.symmetric(
            horizontal: narrow ? 12 : 48,
            vertical: 10,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1220),
              child: Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () => scroll.animateTo(
                      0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    ),
                    child: Text(
                      'Haya Obaid',
                      style: AppFonts.body(size: 18, weight: FontWeight.w700),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: widget.isDark
                        ? 'Switch to light mode'
                        : 'Switch to dark mode',
                    onPressed: () => widget.onThemeChanged(
                      widget.isDark ? ThemeMode.light : ThemeMode.dark,
                    ),
                    icon: Icon(
                      widget.isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                    ),
                  ),
                  if (narrow && MediaQuery.sizeOf(context).width >= 600)
                    PopupMenuButton<String>(
                      tooltip: 'Open navigation menu',
                      icon: const Icon(Icons.menu),
                      onSelected: go,
                      itemBuilder: (_) => links.entries
                          .map(
                            (e) => PopupMenuItem(
                              value: e.value,
                              child: Text(e.key),
                            ),
                          )
                          .toList(),
                    )
                  else if (!narrow)
                    for (final e in links.entries)
                      TextButton(
                        onPressed: () => go(e.value),
                        child: Text(e.key),
                      ),
                ],
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: scroll,
          builder: (context, _) => LinearProgressIndicator(
            key: const Key('page-scroll-progress'),
            value: scroll.hasClients && scroll.position.maxScrollExtent > 0
                ? (scroll.offset / scroll.position.maxScrollExtent).clamp(
                    0.0,
                    1.0,
                  )
                : 0,
            minHeight: 3,
            backgroundColor: AppColors.warmGray.withValues(alpha: 0.45),
            valueColor: AlwaysStoppedAnimation(AppColors.deepMustard),
          ),
        ),
      ],
    );
  }

  Widget hero(bool narrow) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    Widget enter(Widget child, int delay) => child
        .animate(
          delay: reduceMotion ? Duration.zero : Duration(milliseconds: delay),
        )
        .fadeIn(
          duration: reduceMotion
              ? Duration.zero
              : const Duration(milliseconds: 550),
        )
        .slideY(
          begin: reduceMotion ? 0 : 0.12,
          end: 0,
          duration: reduceMotion
              ? Duration.zero
              : const Duration(milliseconds: 550),
          curve: Curves.easeOutCubic,
        );
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        enter(eyebrow(PortfolioContent.title.toUpperCase()), 0),
        const SizedBox(height: 22),
        enter(
          Text(
            PortfolioContent.headline,
            style: AppFonts.display(size: narrow ? 47 : 75, height: 1.05),
          ),
          100,
        ),
        const SizedBox(height: 20),
        enter(
          Text(
            PortfolioContent.tagline,
            style: AppFonts.body(
              size: 22,
              weight: FontWeight.w600,
              color: AppColors.deepMustard,
            ),
          ),
          220,
        ),
        const SizedBox(height: 16),
        enter(
          Text(
            PortfolioContent.introduction,
            style: AppFonts.body(size: 16, color: AppColors.muted, height: 1.6),
          ),
          340,
        ),
        const SizedBox(height: 30),
        enter(
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(
                onPressed: () => go('work'),
                child: const Text('View my work'),
              ),
              OutlinedButton(
                onPressed: downloadCv,
                child: const Text('Download CV'),
              ),
            ],
          ),
          460,
        ),
      ],
    );
    final artwork = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.paper.withValues(alpha: 0.86),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.warmGray),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepMustard.withValues(alpha: 0.12),
                blurRadius: 52,
                offset: const Offset(0, 24),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              widget.isDark
                  ? 'assets/brand/haya-logo-dark.png'
                  : 'assets/brand/haya-logo-original.png',
              width: narrow ? 460 : 480,
              semanticLabel: 'Haya Obaid monogram brand artwork',
            ),
          ),
        ),
        const Positioned.fill(child: FloatingTechCloud()),
        Positioned(
          bottom: -16,
          right: narrow ? 8 : -20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            decoration: BoxDecoration(
              color: AppColors.paper,
              border: Border.all(color: AppColors.warmGray),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 9, color: AppColors.deepMustard),
                const SizedBox(width: 9),
                Text(
                  'DESIGN  /  DEVELOP  /  DELIVER',
                  style: AppFonts.mono(size: narrow ? 8 : 9),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: narrow ? 20 : 48,
        vertical: narrow ? 68 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: narrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RevealOnScroll(style: RevealStyle.fromLeft, child: copy),
                    const SizedBox(height: 40),
                    Center(
                      child: RevealOnScroll(
                        style: RevealStyle.scale,
                        child: artwork,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: RevealOnScroll(
                        style: RevealStyle.fromLeft,
                        child: copy,
                      ),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 5,
                      child: RevealOnScroll(
                        style: RevealStyle.scale,
                        child: artwork,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget tag(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: AppColors.paper,
      border: Border.all(color: AppColors.warmGray),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(label, style: AppFonts.body(size: 11, weight: FontWeight.w600)),
  );
}
