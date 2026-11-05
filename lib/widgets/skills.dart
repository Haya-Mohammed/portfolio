import 'package:flutter/material.dart';
import 'package:my_portfolio/content/skills_data.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';
import 'package:my_portfolio/widgets/common/motion.dart';
import 'package:my_portfolio/widgets/common/tag.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  Widget tag(String label) => CustomTag(label: label);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final cols = box.maxWidth >= 720 ? 2 : 1;
        final width = (box.maxWidth - (cols - 1) * 20) / cols;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            for (final (index, s) in kSkills.indexed)
              SizedBox(
                width: width,
                child: HoverSurface(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: AppColors.oatmeal,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          [
                            Icons.phone_iphone_rounded,
                            Icons.layers_outlined,
                            Icons.cloud_sync_outlined,
                            Icons.code_rounded,
                          ][index],
                          color: AppColors.deepMustard,
                        ),
                      ),
                      Text(s.title, style: AppFonts.display(size: 25)),
                      if (s.description != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          s.description!,
                          style: AppFonts.body(
                            size: 14,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                      if (s.tags.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: s.tags.map(tag).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
