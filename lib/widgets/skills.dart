import 'package:flutter/material.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/theme/app_theme.dart';
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
            for (final s in PortfolioContent.skills)
              SizedBox(
                width: width,
                child: Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: Brand.paper,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.title, style: AppFonts.display(size: 25)),
                      if (s.description != null) ...[
                        const SizedBox(height: 8),
                        Text(s.description!, style: AppFonts.body(size: 14, color: Brand.muted)),
                      ],
                      if (s.tags.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Wrap(spacing: 6, runSpacing: 6, children: s.tags.map(tag).toList()),
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
