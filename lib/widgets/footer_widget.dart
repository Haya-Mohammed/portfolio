import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg2,
      child: Column(
        children: [
          Container(height: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2026 Haya Obaid. All rights reserved.',
                  style: AppFonts.mono(size: 10, letterSpacing: 0.12),
                ),
                Text('Built with Flutter', style: AppFonts.mono(size: 10, letterSpacing: 0.12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
