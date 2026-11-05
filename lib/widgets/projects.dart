import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/content/projects_data.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/widgets/common/tag.dart';
import 'package:my_portfolio/widgets/project_details.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const _cardExtent = 256.0;
  final ScrollController _scroll = ScrollController();
  Timer? _advanceTimer;
  bool _visible = false;
  bool _manuallyControlled = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_updateProgress);
  }

  void _updateProgress() => setState(() {});

  @override
  void dispose() {
    _advanceTimer?.cancel();
    _scroll.dispose();
    super.dispose();
  }

  void _move(double distance) {
    _manuallyControlled = true;
    _advanceTimer?.cancel();
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

  void _updateVisibility(VisibilityInfo info) {
    _visible = info.visibleFraction > 0.1;
    if (!_visible ||
        _manuallyControlled ||
        MediaQuery.disableAnimationsOf(context)) {
      _advanceTimer?.cancel();
      _advanceTimer = null;
      return;
    }
    _advanceTimer ??= Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_scroll.hasClients) return;
      final max = _scroll.position.maxScrollExtent;
      if (_scroll.offset >= max - 1) {
        _advanceTimer?.cancel();
        _advanceTimer = null;
        return;
      }
      _scroll.animateTo(
        (_scroll.offset + _cardExtent).clamp(0.0, max),
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = _scroll.hasClients && _scroll.position.maxScrollExtent > 0
        ? _scroll.offset / _scroll.position.maxScrollExtent
        : 0.0;
    final current =
        _scroll.hasClients &&
            _scroll.offset >= _scroll.position.maxScrollExtent - 1
        ? kProjects.length
        : ((_scroll.hasClients ? _scroll.offset : 0) / _cardExtent).round() + 1;
    return VisibilityDetector(
      key: const Key('projects-carousel-visibility'),
      onVisibilityChanged: _updateVisibility,
      child: LayoutBuilder(
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
                child: NotificationListener<ScrollStartNotification>(
                  onNotification: (notification) {
                    if (notification.dragDetails != null) {
                      _manuallyControlled = true;
                      _advanceTimer?.cancel();
                      _advanceTimer = null;
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    controller: _scroll,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final (index, project) in kProjects.indexed) ...[
                          SizedBox(
                            width: 240,
                            child: ProjectCard(project: project)
                                .animate(
                                  delay: Duration(milliseconds: index * 65),
                                )
                                .fadeIn(
                                  duration: const Duration(milliseconds: 450),
                                )
                                .slideX(begin: 0.08, end: 0),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    '${current.toString().padLeft(2, '0')} / ${kProjects.length.toString().padLeft(2, '0')}',
                    style: AppFonts.mono(size: 11),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        minHeight: 3,
                        backgroundColor: AppColors.warmGray,
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.deepMustard,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (kProjects.isNotEmpty) ...[
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
      ),
    );
  }
}

class AllProjectsScreen extends StatelessWidget {
  const AllProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.ivory,
    appBar: AppBar(
      backgroundColor: AppColors.paper,
      foregroundColor: AppColors.charcoal,
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
              Text('All projects', style: AppFonts.display(size: 40)),
              const SizedBox(height: 12),
              Text(
                'Explore the apps and the work behind them.',
                style: AppFonts.body(size: 16, color: AppColors.muted),
              ),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  for (final project in kProjects)
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

class ProjectCard extends StatefulWidget {
  final PortfolioProject project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  PortfolioProject get project => widget.project;
  bool _hovered = false;

  Future<void> _showProject(BuildContext context) =>
      showProjectDetails(context, project);

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 470,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedSlide(
        offset: _hovered && !MediaQuery.disableAnimationsOf(context)
            ? const Offset(0, -0.025)
            : Offset.zero,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        child: Material(
          color: AppColors.deviceFrame,
          elevation: _hovered ? 12 : 0,
          shadowColor: AppColors.deepMustard.withValues(alpha: 0.5),
          animationDuration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 240),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: _hovered ? AppColors.deepMustard : AppColors.warmGray,
              width: _hovered ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(34),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onHover: (value) {
              if (_hovered != value) setState(() => _hovered = value);
            },
            onFocusChange: (value) => setState(() => _hovered = value),
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
                      color: AppColors.deviceDetail,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: ColoredBox(
                        color: AppColors.paper,
                        child: Column(
                          children: [
                            _ProjectPreview(project: project),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  14,
                                  13,
                                  14,
                                  8,
                                ),
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
                      color: AppColors.deviceDetail,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
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
            color: AppColors.deepMustard,
            weight: FontWeight.w700,
          ),
        ),
      ],
      const SizedBox(height: 7),
      Text(
        project.summary ?? project.description ?? '',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.body(size: 12, color: AppColors.muted, height: 1.35),
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
              color: AppColors.deepMustard,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_forward, size: 15, color: AppColors.deepMustard),
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
    child: Hero(
      tag: 'project-${project.id ?? project.title}',
      child: ColoredBox(
        color: AppColors.oatmeal,
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
                    colors: [AppColors.oatmeal, AppColors.paper],
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
                      color: AppColors.deepMustard,
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
                      color: AppColors.deepMustard,
                    ),
                  ],
                ),
              ),
      ),
    ),
  );
}
