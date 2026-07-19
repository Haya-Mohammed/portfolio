import 'package:flutter/material.dart';

import '../models/skill.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_reveal.dart';
import '../widgets/section_label.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedReveal(
            key: const ValueKey('skills-label'),
            child: const SectionLabel('Expertise'),
          ),
          const SizedBox(height: 36),
          AnimatedReveal(
            key: const ValueKey('skills-heading'),
            delay: const Duration(milliseconds: 100),
            child: Text(
              'What I bring\nto the table.',
              style: AppFonts.serif(size: 40, height: 1.2),
            ),
          ),
          const SizedBox(height: 56),
          AnimatedReveal(
            key: const ValueKey('skills-grid'),
            delay: const Duration(milliseconds: 200),
            child: _SkillGrid(),
          ),
        ],
      ),
    );
  }
}

class _SkillGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border)),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final columns = constraints.maxWidth > 700 ? 2 : 1;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: columns == 2 ? 2.1 : 3.0,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemCount: sampleSkills.length,
            itemBuilder: (_, i) => _SkillCard(skill: sampleSkills[i]),
          );
        },
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Skill skill;
  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: _hovered ? AppColors.bg3 : AppColors.bg,
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.skill.icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 14),
            Text(
              widget.skill.name,
              style: AppFonts.serif(size: 18, weight: FontWeight.w600, color: AppColors.cream),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                widget.skill.description,
                style: AppFonts.sans(size: 13, color: AppColors.muted, height: 1.7),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.skill.tags.map((t) => _Tag(t)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(border: Border.all(color: AppColors.border)),
      child: Text(
        label.toUpperCase(),
        style: AppFonts.mono(size: 9, color: AppColors.goldDim, letterSpacing: 0.1),
      ),
    );
  }
}
