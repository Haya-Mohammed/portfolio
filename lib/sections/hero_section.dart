import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final nameSize = (w * 0.1).clamp(48.0, 96.0);

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: AppColors.bg,
      child: Stack(
        children: [
          // Grid background
          _GridBackground(),

          // Glow overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.4, -0.2),
                  radius: 0.9,
                  colors: [AppColors.gold.withOpacity(0.05), Colors.transparent],
                ),
              ),
            ),
          ),

          // Main content — bottom-left
          Positioned(
            left: 56,
            bottom: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'AVAILABLE FOR WORK · 2026',
                  style: AppFonts.mono(size: 10, color: AppColors.gold, letterSpacing: 0.2),
                ).animate().fadeIn(delay: 300.ms, duration: 700.ms).slideY(begin: 0.3, end: 0),

                const SizedBox(height: 20),

                RichText(
                  text: TextSpan(
                    style: AppFonts.serif(
                      size: nameSize,
                      weight: FontWeight.w300,
                      height: 0.92,
                      letterSpacing: -0.02,
                    ),
                    children: const [
                      TextSpan(text: 'Haya\n'),
                      TextSpan(
                        text: 'Obaid',
                        style: TextStyle(color: AppColors.gold, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 500.ms, duration: 800.ms).slideY(begin: 0.3, end: 0),

                const SizedBox(height: 32),

                SizedBox(
                  width: 460,
                  child: Text(
                    'A creative developer who builds purposeful, '
                    'elegant digital experiences — where craft meets function.',
                    style: AppFonts.sans(size: 16, color: AppColors.muted, height: 1.85),
                  ),
                ).animate().fadeIn(delay: 750.ms, duration: 800.ms).slideY(begin: 0.2, end: 0),
              ],
            ),
          ),

          // Right meta column
          Positioned(
            right: 56,
            bottom: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Based in', style: AppFonts.mono()),
                const SizedBox(height: 4),
                Text('Gaza, Palestine', style: AppFonts.mono(color: AppColors.goldDim)),
                const SizedBox(height: 12),
                Text('Flutter Developer · Mobile Application Developer', style: AppFonts.mono()),
              ],
            ).animate().fadeIn(delay: 1200.ms, duration: 900.ms),
          ),

          // Scroll hint
          Positioned(
            bottom: 28,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: 1,
                  height: 48,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.goldDim, Colors.transparent],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('SCROLL', style: AppFonts.mono(size: 9, letterSpacing: 0.2)),
              ],
            ).animate().fadeIn(delay: 1500.ms, duration: 900.ms),
          ),
        ],
      ),
    );
  }
}

class _GridBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: CustomPaint(painter: _GridPainter()));
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold.withOpacity(0.028)
      ..strokeWidth = 0.5;

    const step = 80.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}
