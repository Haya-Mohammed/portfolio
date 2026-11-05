import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';

/// Small floating skill badges that sit over the hero artwork.
class FloatingTechCloud extends StatefulWidget {
  const FloatingTechCloud({super.key});

  @override
  State<FloatingTechCloud> createState() => _FloatingTechCloudState();
}

class _FloatingTechCloudState extends State<FloatingTechCloud>
    with SingleTickerProviderStateMixin {
  late final AnimationController _motion = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 7),
  );

  static const _icons = [
    Icons.flutter_dash_rounded,
    Icons.code_rounded,
    Icons.local_fire_department_rounded,
    Icons.account_tree_rounded,
  ];
  static const _positions = [
    Alignment(-0.78, -0.82),
    Alignment(0.82, -0.42),
    Alignment(-0.82, 0.48),
    Alignment(0.54, 0.49),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _motion.stop();
      _motion.value = 0;
    } else if (!_motion.isAnimating) {
      _motion.repeat();
    }
  }

  @override
  void dispose() {
    _motion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: RepaintBoundary(
      child: AnimatedBuilder(
        animation: _motion,
        builder: (context, _) => Stack(
          key: const Key('floating-tech-cloud'),
          children: [
            for (final (index, label) in PortfolioContent.featuredTech.indexed)
              Align(
                alignment: _positions[index],
                child: Transform.translate(
                  offset: Offset(
                    5 * math.sin(_motion.value * math.pi * 2 + index * 1.4),
                    8 * math.cos(_motion.value * math.pi * 2 + index * 1.4),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.paper.withValues(alpha: 0.95),
                      border: Border.all(
                        color: AppColors.deepMustard.withValues(alpha: 0.45),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _icons[index],
                          size: 17,
                          color: AppColors.deepMustard,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: AppFonts.body(
                            size: 11,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
