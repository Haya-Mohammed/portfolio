import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/animated_reveal.dart';
import '../widgets/section_label.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg2,
      child: Column(
        children: [
          Container(height: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 100),
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                final isWide = constraints.maxWidth > 700;
                return isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _LeftColumn()),
                          const SizedBox(width: 80),
                          Expanded(child: _RightColumn()),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_LeftColumn(), const SizedBox(height: 48), _RightColumn()],
                      );
              },
            ),
          ),
          Container(height: 1, color: AppColors.border),
        ],
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedReveal(
      key: const ValueKey('about-left'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel('About'),
          const SizedBox(height: 36),
          RichText(
            text: TextSpan(
              style: AppFonts.serif(size: 40, height: 1.15),
              children: const [
                TextSpan(text: 'Crafting '),
                TextSpan(
                  text: 'beautiful',
                  style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.gold),
                ),
                TextSpan(text: '\nthings with intention.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RightColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedReveal(
      key: const ValueKey('about-right'),
      delay: const Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            "I’m a Flutter Developer passionate about crafting beautiful, scalable, and high-performance mobile experiences. I specialize in transforming ideas into polished applications by combining modern Flutter development practices with clean architecture, intuitive UI design, and efficient state management.",
            style: AppFonts.sans(),
          ),
          const SizedBox(height: 20),
          Text(
            "With a strong foundation in Dart, Flutter, and software engineering principles, I build applications that are not only visually engaging but also maintainable, reliable, and ready to grow. I enjoy solving problems, exploring new technologies, and continuously improving my skills to deliver impactful digital solutions.",
            style: AppFonts.sans(),
          ),
          const SizedBox(height: 20),
          Text(
            "My goal is to create mobile experiences that make a difference — blending creativity, technology, and thoughtful engineering to bring meaningful ideas to life.",
            style: AppFonts.sans(),
          ),
          const SizedBox(height: 40),

          Container(height: 1, color: AppColors.border),
          const SizedBox(height: 28),
          Row(
            children: const [
              _Stat(num: '3+', label: 'Years exp.'),
              SizedBox(width: 40),
              _Stat(num: '10+', label: 'Projects'),
              SizedBox(width: 40),
              // _Stat(num: '3', label: 'Clients'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String num;
  final String label;
  const _Stat({required this.num, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          num,
          style: AppFonts.serif(size: 38, color: AppColors.gold, weight: FontWeight.w300),
        ),
        const SizedBox(height: 4),
        Text(label.toUpperCase(), style: AppFonts.mono(size: 9, letterSpacing: 0.15)),
      ],
    );
  }
}
