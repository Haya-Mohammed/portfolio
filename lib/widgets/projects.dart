import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/common/tag.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const _initialCount = 6;
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _move(double distance) {
    if (!_scroll.hasClients) return;
    final target = (_scroll.offset + distance).clamp(
      0.0,
      _scroll.position.maxScrollExtent,
    );
    _scroll.animateTo(
      target,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = PortfolioContent.projects;
    return LayoutBuilder(
      builder: (context, box) => SizedBox(
        width: box.maxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'SWIPE THROUGH THE APPS',
                    style: AppFonts.mono(size: 10),
                  ),
                ),
                IconButton(
                  tooltip: 'Previous projects',
                  onPressed: () => _move(-256),
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  tooltip: 'Next projects',
                  onPressed: () => _move(256),
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 470,
              child: SingleChildScrollView(
                controller: _scroll,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final project in projects.take(_initialCount)) ...[
                      SizedBox(
                        width: 240,
                        child: ProjectCard(project: project),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ],
                ),
              ),
            ),
            if (projects.length > _initialCount) ...[
              const SizedBox(height: 20),
              Align(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const AllProjectsScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('See all projects'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AllProjectsScreen extends StatelessWidget {
  const AllProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Brand.ivory,
    appBar: AppBar(
      backgroundColor: Brand.paper,
      foregroundColor: Brand.charcoal,
      title: Text('Projects', style: AppFonts.display(size: 22)),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All projects',
                style: AppFonts.display(size: 40),
              ),
              const SizedBox(height: 12),
              Text(
                'Explore the apps and the work behind them.',
                style: AppFonts.body(size: 16, color: Brand.muted),
              ),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  for (final project in PortfolioContent.projects)
                    SizedBox(width: 240, child: ProjectCard(project: project)),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ProjectCard extends StatelessWidget {
  final PortfolioProject project;

  const ProjectCard({super.key, required this.project});

  Future<void> _openCode() async {
    await launchUrl(
      Uri.parse(project.url!),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _showProject(BuildContext context) async {
    final controller = PageController();
    var selected = 0;
    try {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            final screen = MediaQuery.sizeOf(dialogContext);
            return Dialog(
              backgroundColor: Brand.paper,
              insetPadding: const EdgeInsets.all(16),
              child: SizedBox(
                width: math.min(screen.width - 32, 900),
                height: math.min(screen.height - 32, 700),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              project.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.display(size: 22),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Close project',
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    if (project.hasImages)
                      Expanded(
                        flex: 3,
                        child: PageView.builder(
                          controller: controller,
                          itemCount: project.images.length,
                          onPageChanged: (index) =>
                              setDialogState(() => selected = index),
                          itemBuilder: (context, index) => ColoredBox(
                            color: Brand.ivory,
                            child: Image.asset(
                              project.images[index],
                              fit: BoxFit.contain,
                              semanticLabel:
                                  '${project.title} image ${index + 1} of ${project.images.length}',
                              errorBuilder: (_, _, _) => const Center(
                                child: Text('Image unavailable'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (project.images.length > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              tooltip: 'Previous image',
                              onPressed: selected == 0
                                  ? null
                                  : () => controller.previousPage(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeOut,
                                    ),
                              icon: const Icon(Icons.chevron_left),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                '${selected + 1} / ${project.images.length}',
                                style: AppFonts.body(size: 13),
                              ),
                            ),
                            IconButton(
                              tooltip: 'Next image',
                              onPressed: selected == project.images.length - 1
                                  ? null
                                  : () => controller.nextPage(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      curve: Curves.easeOut,
                                    ),
                              icon: const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      flex: project.hasImages ? 2 : 1,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (project.description != null)
                              Text(
                                project.description!,
                                style: AppFonts.body(size: 15, height: 1.55),
                              ),
                            if (project.tags.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  for (final tag in project.tags)
                                    CustomTag(label: tag),
                                ],
                              ),
                            ],
                            if (project.hasUrl) ...[
                              const SizedBox(height: 16),
                              TextButton.icon(
                                onPressed: _openCode,
                                icon: const Icon(Icons.open_in_new, size: 16),
                                label: const Text('View code'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 470,
    child: Material(
      color: Brand.deviceFrame,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Brand.warmGray),
        borderRadius: BorderRadius.circular(34),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showProject(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                width: 62,
                height: 5,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Brand.deviceDetail,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: ColoredBox(
                    color: Brand.paper,
                    child: Column(
                      children: [
                        _ProjectPreview(project: project),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 13, 14, 8),
                            child: _ProjectSummary(project: project),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 42,
                height: 4,
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Brand.deviceDetail,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _ProjectSummary extends StatelessWidget {
  const _ProjectSummary({required this.project});

  final PortfolioProject project;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        project.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.display(size: 20),
      ),
      if (project.contribution != null) ...[
        const SizedBox(height: 5),
        Text(
          project.contribution!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFonts.body(
            size: 11,
            color: Brand.deepMustard,
            weight: FontWeight.w700,
          ),
        ),
      ],
      const SizedBox(height: 7),
      Text(
        project.summary ?? project.description ?? '',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.body(size: 12, color: Brand.muted, height: 1.35),
      ),
      if (project.tags.isNotEmpty) ...[
        const SizedBox(height: 8),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            for (final tag in project.tags.take(2)) CustomTag(label: tag),
          ],
        ),
      ],
      const Spacer(),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            project.images.length > 1
                ? 'View ${project.images.length} images'
                : 'View project',
            style: AppFonts.body(
              size: 12,
              weight: FontWeight.w700,
              color: Brand.deepMustard,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_forward, size: 15, color: Brand.deepMustard),
        ],
      ),
    ],
  );
}

class _ProjectPreview extends StatelessWidget {
  const _ProjectPreview({required this.project});

  final PortfolioProject project;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 145,
    width: double.infinity,
    child: ColoredBox(
      color: Brand.oatmeal,
      child: project.hasImages
          ? Image.asset(
              project.images.first,
              fit: BoxFit.contain,
              semanticLabel: '${project.title} cover image',
              errorBuilder: (_, _, _) =>
                  const Center(child: Text('Image unavailable')),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Brand.oatmeal, Brand.paper],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CASE STUDY  /  APP', style: AppFonts.mono(size: 9)),
                  const Spacer(),
                  Icon(
                    Icons.phone_iphone_rounded,
                    size: 32,
                    color: Brand.deepMustard,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.body(size: 14, weight: FontWeight.w700),
                  ),
                  Container(
                    width: 48,
                    height: 3,
                    margin: const EdgeInsets.only(top: 8),
                    color: Brand.deepMustard,
                  ),
                ],
              ),
            ),
    ),
  );
}
