import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/about.dart';
import 'package:my_portfolio/widgets/common/section.dart';
import 'package:my_portfolio/widgets/contact.dart';
import 'package:my_portfolio/widgets/experience.dart';
import 'package:my_portfolio/widgets/projects.dart';
import 'package:my_portfolio/widgets/skills.dart';
import 'package:url_launcher/url_launcher.dart';

import 'content/portfolio_content.dart';
import 'core/cv_download_stub.dart' if (dart.library.html) 'core/cv_download_web.dart' as cv;
import 'theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const HomeScreen({super.key, required this.isDark, required this.onToggleTheme});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scroll = ScrollController();
  final keys = <String, GlobalKey>{
    for (final name in ['work', 'skills', 'about', 'experience', 'contact']) name: GlobalKey(),
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
      Text(label, style: AppFonts.mono(size: 12, color: Brand.deepMustard));

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
    backgroundColor: Brand.ivory,
    body: LayoutBuilder(
      builder: (context, box) {
        final narrow = box.maxWidth < 900;
        return Column(
          children: [
            header(narrow),
            Expanded(
              child: SingleChildScrollView(
                controller: scroll,
                child: Column(
                  children: [
                    hero(narrow),
                    Section(
                      label: '01 / SELECTED WORK',
                      title: 'Apps shaped by real problems',
                      key: keys['work']!,
                      shaded: false,
                      child: const ProjectsSection(),
                    ),
                    Section(
                      label: '02 / WHAT I DO',
                      title: 'Building with care',
                      key: keys['skills']!,
                      shaded: true,
                      child: const SkillsSection(),
                    ),
                    Section(
                      label: '03 / ABOUT',
                      title: 'A developer who cares about the details',
                      key: keys['about']!,
                      shaded: false,
                      child: AboutSection(narrow: narrow),
                    ),
                    Section(
                      label: '04 / EXPERIENCE',
                      title: 'Where I have contributed',
                      key: keys['experience']!,
                      shaded: true,
                      child: const ExperienceSection(),
                    ),
                    Section(
                      label: '05 / CONTACT',
                      title: 'Let’s build something thoughtful',
                      key: keys['contact']!,
                      shaded: false,
                      child: const ContactSection(),
                    ),
                    Container(
                      width: double.infinity,
                      color: Brand.footer,
                      padding: const EdgeInsets.all(28),
                      child: Text(
                        '© 2026 Haya Obaid · ${PortfolioContent.tagline}',
                        textAlign: TextAlign.center,
                        style: AppFonts.body(size: 13, color: Brand.footerText),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
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
    return Container(
      color: Brand.paper,
      padding: EdgeInsets.symmetric(horizontal: narrow ? 12 : 48, vertical: 10),
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
                child: Text('Haya Obaid', style: AppFonts.body(size: 18, weight: FontWeight.w700)),
              ),
              const Spacer(),
              IconButton(
                tooltip: widget.isDark ? 'Switch to light mode' : 'Switch to dark mode',
                onPressed: widget.onToggleTheme,
                icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
              ),
              if (narrow)
                PopupMenuButton<String>(
                  tooltip: 'Open navigation menu',
                  icon: const Icon(Icons.menu),
                  onSelected: go,
                  itemBuilder: (_) => links.entries
                      .map((e) => PopupMenuItem(value: e.value, child: Text(e.key)))
                      .toList(),
                )
              else
                for (final e in links.entries)
                  TextButton(onPressed: () => go(e.value), child: Text(e.key)),
            ],
          ),
        ),
      ),
    );
  }

  Widget hero(bool narrow) {
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrow(PortfolioContent.title.toUpperCase()),
        const SizedBox(height: 22),
        Text(
          PortfolioContent.headline,
          style: AppFonts.display(size: narrow ? 47 : 75, height: 1.05),
        ),
        const SizedBox(height: 20),
        Text(
          PortfolioContent.tagline,
          style: AppFonts.body(size: 22, weight: FontWeight.w600, color: Brand.deepMustard),
        ),
        const SizedBox(height: 16),
        Text(
          PortfolioContent.introduction,
          style: AppFonts.body(size: 16, color: Brand.muted, height: 1.6),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(onPressed: () => go('work'), child: const Text('View my work')),
            OutlinedButton(onPressed: downloadCv, child: const Text('Download CV')),
          ],
        ),
      ],
    );
    final artwork = ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: ColoredBox(
        color: widget.isDark ? Colors.white : Colors.transparent,
        child: Image.asset(
          'assets/brand/haya-logo-original.png',
          width: narrow ? 460 : 480,
          semanticLabel: 'Original Haya Obaid monogram brand artwork',
        ),
      ),
    );
    return Container(
      width: double.infinity,
      color: Brand.ivory,
      padding: EdgeInsets.symmetric(horizontal: narrow ? 20 : 48, vertical: narrow ? 68 : 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: narrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    copy,
                    const SizedBox(height: 40),
                    Center(child: artwork),
                  ],
                )
              : Row(
                  children: [
                    Expanded(flex: 6, child: copy),
                    const SizedBox(width: 50),
                    Expanded(flex: 5, child: artwork),
                  ],
                ),
        ),
      ),
    );
  }

  Widget tag(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: Brand.paper,
      border: Border.all(color: Brand.warmGray),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(label, style: AppFonts.body(size: 11, weight: FontWeight.w600)),
  );
}
