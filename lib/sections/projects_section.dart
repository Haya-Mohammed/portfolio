import 'package:flutter/material.dart';

import '../models/project.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_reveal.dart';
import '../widgets/section_label.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg2,
      child: Column(
        children: [
          Container(height: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.fromLTRB(56, 100, 56, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedReveal(
                  key: const ValueKey('projects-label'),
                  child: const SectionLabel('Selected Work'),
                ),
                const SizedBox(height: 36),
                AnimatedReveal(
                  key: const ValueKey('projects-heading'),
                  delay: const Duration(milliseconds: 100),
                  child: RichText(
                    text: TextSpan(
                      style: AppFonts.serif(size: 40, height: 1.2),
                      children: const [
                        TextSpan(text: 'Projects that\n'),
                        TextSpan(
                          text: 'matter.',
                          style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.gold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                ...sampleProjects.asMap().entries.map(
                  (e) => AnimatedReveal(
                    key: ValueKey('project-${e.key}'),
                    delay: Duration(milliseconds: 80 * e.key),
                    child: _ProjectRow(project: e.value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectRow extends StatefulWidget {
  final Project project;
  const _ProjectRow({required this.project});

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {}, // Link to project
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: _hovered ? AppColors.gold.withOpacity(0.04) : Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Number
                  SizedBox(
                    width: 64,
                    child: Text(
                      widget.project.number,
                      style: AppFonts.mono(size: 10, color: AppColors.goldDim, letterSpacing: 0.12),
                    ),
                  ),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: AppFonts.serif(
                            size: 22,
                            weight: FontWeight.w400,
                            color: _hovered ? AppColors.gold : AppColors.cream,
                          ),
                          child: Text(widget.project.title),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.project.description,
                          style: AppFonts.sans(size: 13.5, color: AppColors.muted, height: 1.6),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Tags + arrow
                  Row(
                    children: [
                      ...widget.project.tags.map(
                        (t) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(border: Border.all(color: AppColors.border)),
                            child: Text(
                              t.toUpperCase(),
                              style: AppFonts.mono(
                                size: 9,
                                color: AppColors.goldDim,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: _hovered ? 1.0 : 0.0,
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 250),
                          offset: _hovered ? Offset.zero : const Offset(-0.3, 0),
                          child: Text(
                            '→',
                            style: AppFonts.sans(size: 18, color: AppColors.gold, height: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(height: 1, color: AppColors.border),
          ],
        ),
      ),
    );
  }
}
