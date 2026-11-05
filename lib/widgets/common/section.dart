import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';
import 'package:my_portfolio/widgets/common/motion.dart';

class Section extends StatelessWidget {
  final String label;
  final String title;
  final Widget child;
  final bool shaded;
  final RevealStyle revealStyle;

  const Section({
    super.key,
    required this.label,
    required this.title,
    required this.child,
    required this.shaded,
    this.revealStyle = RevealStyle.rise,
  });

  Widget eyebrow(String label) =>
      Text(label, style: AppFonts.mono(size: 12, color: AppColors.deepMustard));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: (shaded ? AppColors.oatmeal : AppColors.paper).withValues(
        alpha: AppColors.isDark ? 0.72 : 0.62,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width < 600 ? 20 : 48,
        vertical: MediaQuery.sizeOf(context).width < 600 ? 58 : 84,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RevealOnScroll(
                style: revealStyle,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    eyebrow(label),
                    const SizedBox(height: 15),
                    Text(
                      title,
                      style: AppFonts.display(
                        size: MediaQuery.sizeOf(context).width < 600 ? 34 : 41,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 38),
              RevealOnScroll(style: revealStyle, child: child),
            ],
          ),
        ),
      ),
    );
  }
}
