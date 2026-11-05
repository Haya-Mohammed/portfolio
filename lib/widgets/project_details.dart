import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/widgets/common/tag.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showProjectDetails(
  BuildContext context,
  PortfolioProject project,
) => Navigator.of(context).push<void>(
  PageRouteBuilder<void>(
    opaque: false,
    barrierDismissible: true,
    barrierLabel: 'Close project',
    barrierColor: Colors.black.withValues(alpha: 0.65),
    transitionDuration: MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 420),
    pageBuilder: (_, _, _) => ProjectDetailsDialog(project: project),
    transitionsBuilder: (_, animation, _, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.06),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  ),
);

class ProjectDetailsDialog extends StatefulWidget {
  const ProjectDetailsDialog({super.key, required this.project});

  final PortfolioProject project;

  @override
  State<ProjectDetailsDialog> createState() => _ProjectDetailsDialogState();
}

class _ProjectDetailsDialogState extends State<ProjectDetailsDialog> {
  static const _interval = Duration(seconds: 4);
  static const _slideDuration = Duration(milliseconds: 650);

  late final PageController _controller;
  Timer? _timer;
  late int _page;
  bool _playing = true;

  int get _count => widget.project.images.length;
  int get _selected => _count == 0 ? 0 : _page % _count;

  @override
  void initState() {
    super.initState();
    _page = _count > 1 ? _count * 500 : 0;
    _controller = PageController(initialPage: _page);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) _playing = false;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    if (_count < 2 || !_playing) return;
    _timer = Timer.periodic(_interval, (_) => _move(1, automatic: true));
  }

  void _move(int delta, {bool automatic = false}) {
    if (!mounted || !_controller.hasClients) return;
    _controller.animateToPage(
      _page + delta,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : _slideDuration,
      curve: Curves.easeInOutCubic,
    );
    if (!automatic) _startTimer();
  }

  void _select(int index) {
    final delta = index - _selected;
    if (delta != 0) _move(delta);
  }

  Future<void> _open(String url) =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final screen = MediaQuery.sizeOf(context);
    return Dialog(
      backgroundColor: AppColors.paper,
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: math.min(screen.width - 32, 900),
        height: math.min(screen.height - 32, 700),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 8, 8),
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
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            if (project.hasImages)
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _count > 1 ? _count * 1000 : 1,
                    onPageChanged: (page) => setState(() => _page = page),
                    itemBuilder: (context, page) => AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final current = _controller.positions.length == 1
                            ? _controller.page ?? _page.toDouble()
                            : _page.toDouble();
                        final distance = (current - page).abs().clamp(0.0, 1.0);
                        return Opacity(
                          opacity: 1 - distance * 0.25,
                          child: Transform.scale(
                            scale: 1 - distance * 0.06,
                            child: child,
                          ),
                        );
                      },
                      child: HeroMode(
                        enabled: page == (_count > 1 ? _count * 500 : 0),
                        child: Hero(
                          tag: 'project-${project.id ?? project.title}',
                          child: ColoredBox(
                            color: AppColors.ivory,
                            child: Image.asset(
                              project.images[page % _count],
                              fit: BoxFit.contain,
                              semanticLabel:
                                  '${project.title} image ${page % _count + 1} of $_count',
                              errorBuilder: (_, _, _) => const Center(
                                child: Text('Image unavailable'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (_count > 1) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: 'Previous image',
                    onPressed: () => _move(-1),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    '${_selected + 1} / $_count',
                    style: AppFonts.body(size: 13),
                  ),
                  IconButton(
                    tooltip: 'Next image',
                    onPressed: () => _move(1),
                    icon: const Icon(Icons.chevron_right),
                  ),
                  IconButton(
                    tooltip: _playing ? 'Pause slideshow' : 'Play slideshow',
                    onPressed: () {
                      setState(() => _playing = !_playing);
                      _startTimer();
                    },
                    icon: Icon(
                      _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var index = 0; index < _count; index++)
                    InkWell(
                      key: Key('image-dot-$index'),
                      onTap: () => _select(index),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 240),
                        width: index == _selected ? 22 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: index == _selected
                              ? AppColors.deepMustard
                              : AppColors.warmGray,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                ],
              ),
            ],
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
                          for (final tag in project.tags) CustomTag(label: tag),
                        ],
                      ),
                    ],
                    if (project.hasGithubUrl || project.hasCustomUrl) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (project.hasGithubUrl)
                            OutlinedButton.icon(
                              onPressed: () => _open(project.githubUrl!),
                              icon: const Icon(Icons.code_rounded, size: 17),
                              label: const Text('View on GitHub'),
                            ),
                          if (project.hasCustomUrl)
                            FilledButton.icon(
                              onPressed: () => _open(project.customUrl!),
                              icon: const Icon(Icons.open_in_new, size: 17),
                              label: const Text('Visit project'),
                            ),
                        ],
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
  }
}
