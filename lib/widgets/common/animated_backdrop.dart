import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';

/// A continuously moving canvas shared by every portfolio section.
class AnimatedBackdrop extends StatefulWidget {
  const AnimatedBackdrop({super.key});

  @override
  State<AnimatedBackdrop> createState() => _AnimatedBackdropState();
}

class _AnimatedBackdropState extends State<AnimatedBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _motion = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 24),
  );

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
        builder: (context, _) => CustomPaint(
          key: const Key('animated-backdrop'),
          painter: _BackdropPainter(
            progress: _motion.value,
            dark: AppColors.isDark,
          ),
          size: Size.infinite,
        ),
      ),
    ),
  );
}

class _BackdropPainter extends CustomPainter {
  const _BackdropPainter({required this.progress, required this.dark});

  final double progress;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const [Color(0xFF1B1C1B), Color(0xFF25221C), Color(0xFF191C1D)]
              : const [Color(0xFFF8F3E9), Color(0xFFECE5DB), Color(0xFFF2ECE5)],
        ).createShader(rect),
    );

    final phase = progress * math.pi * 2;
    final scale = size.shortestSide;
    void glow(Offset center, double radius, Color color) {
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ).createShader(Rect.fromCircle(center: center, radius: radius)),
      );
    }

    glow(
      Offset(
        size.width * (0.13 + 0.09 * math.sin(phase)),
        size.height * (0.20 + 0.10 * math.cos(phase)),
      ),
      scale * 0.68,
      const Color(0xFFDCA028).withValues(alpha: dark ? 0.25 : 0.32),
    );
    glow(
      Offset(
        size.width * (0.86 + 0.06 * math.cos(phase + 1.3)),
        size.height * (0.72 + 0.12 * math.sin(phase + 1.3)),
      ),
      scale * 0.75,
      const Color(0xFF8A9D91).withValues(alpha: dark ? 0.20 : 0.30),
    );

    glow(
      Offset(
        size.width * (0.45 + 0.13 * math.cos(phase + 2.4)),
        size.height * (0.95 + 0.08 * math.sin(phase + 2.4)),
      ),
      scale * 0.55,
      const Color(0xFFCB9175).withValues(alpha: dark ? 0.12 : 0.20),
    );

    final line = Paint()
      ..color = (dark ? const Color(0xFFD6B980) : const Color(0xFF8A795D))
          .withValues(alpha: dark ? 0.22 : 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25;
    final orbitCenter = Offset(
      size.width * 0.82 + 42 * math.sin(phase),
      size.height * 0.36 + 36 * math.cos(phase),
    );
    for (final radius in [scale * 0.25, scale * 0.38, scale * 0.52]) {
      canvas.drawCircle(orbitCenter, radius, line);
    }

    final sweepingLine = Path()
      ..moveTo(-scale * 0.2, size.height * 0.72)
      ..cubicTo(
        size.width * 0.18,
        size.height * (0.45 + 0.05 * math.sin(phase)),
        size.width * 0.42,
        size.height * (1.04 + 0.06 * math.cos(phase)),
        size.width * 0.75,
        size.height * 0.83,
      );
    canvas.drawPath(sweepingLine, line);
    canvas.drawPath(
      sweepingLine.shift(const Offset(0, 22)),
      line..color = line.color.withValues(alpha: line.color.a * 0.55),
    );

    final dot = Paint()
      ..color = (dark ? const Color(0xFFE7C17C) : const Color(0xFF8F7345))
          .withValues(alpha: dark ? 0.42 : 0.38);
    for (var i = 0; i < 36; i++) {
      final x = (i * 0.61803398875) % 1;
      final y = (i * 0.38196601125) % 1;
      canvas.drawCircle(
        Offset(
          size.width * x + 9 * math.sin(phase + i),
          size.height * y + 11 * math.cos(phase + i),
        ),
        i % 5 == 0 ? 2.5 : 1.5,
        dot,
      );
    }
  }

  @override
  bool shouldRepaint(_BackdropPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.dark != dark;
}
