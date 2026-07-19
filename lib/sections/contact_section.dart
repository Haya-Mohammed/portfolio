import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/animated_reveal.dart';
import 'package:my_portfolio/widgets/contact_section/contact_button.dart';
import 'package:my_portfolio/widgets/contact_section/freelance_links.dart';
import 'package:my_portfolio/widgets/contact_section/social_links.dart';

import '../theme/app_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      child: Column(
        children: [
          Container(height: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 120),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Column(
                  children: [
                    AnimatedReveal(
                      key: const ValueKey('contact-kicker'),
                      child: Text(
                        'GET IN TOUCH',
                        style: AppFonts.mono(size: 10, color: AppColors.gold, letterSpacing: 0.22),
                      ),
                    ),
                    const SizedBox(height: 28),
                    AnimatedReveal(
                      key: const ValueKey('contact-heading'),
                      delay: const Duration(milliseconds: 100),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppFonts.serif(size: 72, height: 1.0, letterSpacing: -0.02),
                          children: const [
                            TextSpan(text: "Let's build\nsomething "),
                            TextSpan(
                              text: 'great.',
                              style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.gold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AnimatedReveal(
                      key: const ValueKey('contact-sub'),
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        'Whether you have a project in mind or just want to explore '
                        'possibilities, I\'d love to hear from you.',
                        textAlign: TextAlign.center,
                        style: AppFonts.sans(size: 15.5, color: AppColors.muted, height: 1.8),
                      ),
                    ),
                    const SizedBox(height: 48),
                    AnimatedReveal(
                      key: const ValueKey('contact-btn'),
                      delay: const Duration(milliseconds: 300),
                      child: ContactButton(),
                    ),
                    const SizedBox(height: 48),
                    AnimatedReveal(
                      key: const ValueKey('contact-links'),
                      delay: const Duration(milliseconds: 400),
                      child: SocialLinks(),
                    ),
                    const SizedBox(height: 20),
                    AnimatedReveal(
                      key: const ValueKey('freelance-links'),
                      delay: const Duration(milliseconds: 400),
                      child: FreelanceLinks(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
