import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 40, height: 1, color: AppColors.goldDim),
        const SizedBox(width: 12),
        Text(
          text.toUpperCase(),
          style: AppFonts.mono(size: 10, color: AppColors.gold, letterSpacing: 0.22),
        ),
      ],
    );
  }
}
