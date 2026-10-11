import 'package:flutter/material.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  Widget eyebrow(String label) =>
      Text(label, style: AppFonts.mono(size: 12, color: Brand.deepMustard));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in PortfolioContent.experience)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(color: Brand.paper, borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.dates != null) ...[eyebrow(item.dates!), const SizedBox(height: 8)],
                Text(item.role, style: AppFonts.display(size: 25)),
                if (item.organization != null)
                  Text(item.organization!, style: AppFonts.body(size: 14, weight: FontWeight.w700)),
                if (item.description != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    item.description!,
                    style: AppFonts.body(size: 14, color: Brand.muted, height: 1.55),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
