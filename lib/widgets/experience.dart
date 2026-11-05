import 'package:flutter/material.dart';
import 'package:my_portfolio/content/experience_data.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';
import 'package:my_portfolio/widgets/common/motion.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  Widget eyebrow(String label) =>
      Text(label, style: AppFonts.mono(size: 12, color: AppColors.deepMustard));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in kExperience)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: HoverSurface(
              radius: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.dates != null) ...[
                    eyebrow(item.dates!),
                    const SizedBox(height: 8),
                  ],
                  Text(item.role, style: AppFonts.display(size: 25)),
                  if (item.organization != null)
                    Text(
                      item.organization!,
                      style: AppFonts.body(size: 14, weight: FontWeight.w700),
                    ),
                  if (item.description != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      item.description!,
                      style: AppFonts.body(
                        size: 14,
                        color: AppColors.muted,
                        height: 1.55,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
