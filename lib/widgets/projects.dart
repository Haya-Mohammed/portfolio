import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/common/tag.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final columns = box.maxWidth >= 900
          ? 3
          : box.maxWidth >= 560
          ? 2
          : 1;
      final width = (box.maxWidth - (columns - 1) * 20) / columns;
      return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          for (final project in PortfolioContent.projects)
            SizedBox(
              width: width,
              child: ProjectCard(project: project),
            ),
        ],
      );
    },
  );
}

class ProjectCard extends StatelessWidget {
  final PortfolioProject project;

  const ProjectCard({super.key, required this.project});

  Future<void> _openCode() async {
    await launchUrl(Uri.parse(project.url!), mode: LaunchMode.externalApplication);
  }

  Future<void> _showImages(BuildContext context) async {
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
                            tooltip: 'Close images',
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: controller,
                        itemCount: project.images.length,
                        onPageChanged: (index) => setDialogState(() => selected = index),
                        itemBuilder: (context, index) => ColoredBox(
                          color: Brand.ivory,
                          child: Image.asset(
                            project.images[index],
                            fit: BoxFit.contain,
                            semanticLabel:
                                '${project.title} image ${index + 1} of ${project.images.length}',
                            errorBuilder: (_, _, _) =>
                                const Center(child: Text('Image unavailable')),
                          ),
                        ),
                      ),
                    ),
                    if (project.images.length > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              tooltip: 'Previous image',
                              onPressed: selected == 0
                                  ? null
                                  : () => controller.previousPage(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeOut,
                                    ),
                              icon: const Icon(Icons.chevron_left),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeOut,
                                    ),
                              icon: const Icon(Icons.chevron_right),
                            ),
                          ],
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
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 265),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Brand.ivory,
      border: Border.all(color: Brand.warmGray),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (project.hasImages)
          InkWell(
            onTap: () => _showImages(context),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    project.images.first,
                    fit: BoxFit.cover,
                    semanticLabel: '${project.title} cover image',
                    errorBuilder: (_, _, _) => const Center(child: Text('Image unavailable')),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Brand.paper,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        project.images.length > 1
                            ? 'View ${project.images.length} images'
                            : 'View image',
                        style: AppFonts.body(size: 11, weight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 36, height: 4, color: Brand.mustard),
              const SizedBox(height: 21),
              Text(project.title, style: AppFonts.display(size: 25)),
              if (project.description != null) ...[
                const SizedBox(height: 10),
                Text(
                  project.description!,
                  style: AppFonts.body(size: 14, color: Brand.muted, height: 1.55),
                ),
              ],
              if (project.tags.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: project.tags.map((tag) => CustomTag(label: tag)).toList(),
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
      ],
    ),
  );
}
