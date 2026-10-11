import 'package:flutter/material.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  final bool narrow;
  const AboutSection({super.key, required this.narrow});

  @override
  Widget build(BuildContext context) {
    final bio = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(PortfolioContent.about, style: AppFonts.body(size: 18, height: 1.7)),
        const SizedBox(height: 26),
        Text('Education', style: AppFonts.display(size: 27)),
        const SizedBox(height: 8),
        for (final edu in PortfolioContent.education)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(edu.headline, style: AppFonts.body(size: 15)),
                if (edu.details != null)
                  Text(edu.details!, style: AppFonts.body(size: 14, color: Brand.muted)),
              ],
            ),
          ),
        const SizedBox(height: 8),
        Text('Languages: Arabic and English', style: AppFonts.body(size: 14, color: Brand.muted)),
      ],
    );
    final certificates = Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(color: Brand.ivory, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Certificates', style: AppFonts.display(size: 27)),
          const SizedBox(height: 16),
          for (final item in PortfolioContent.certificates)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                '•  ${item.summary}',
                style: AppFonts.body(size: 13, color: Brand.muted, height: 1.4),
              ),
            ),
        ],
      ),
    );
    return narrow
        ? Column(children: [bio, const SizedBox(height: 30), certificates])
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: bio),
              const SizedBox(width: 48),
              Expanded(child: certificates),
            ],
          );
  }
}
