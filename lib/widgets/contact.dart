import 'package:flutter/material.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/core/constants.dart';
import 'package:my_portfolio/models/contact_link.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Widget link(ContactLink item) =>
      OutlinedButton(onPressed: () => open(item.url), child: Text(item.label));

  Future<void> open(String url) async =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Have a Flutter role or an app idea? I’d be glad to hear about it.',
          style: AppFonts.body(size: 18, color: Brand.muted),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () => open('mailto:${AppConstants.email}'),
          icon: const Icon(Icons.mail_outline),
          label: const Text('Email Haya'),
        ),
        const SizedBox(height: 24),
        Wrap(spacing: 8, runSpacing: 8, children: PortfolioContent.socialLinks.map(link).toList()),
        const SizedBox(height: 18),
        Text('Freelance profiles', style: AppFonts.body(size: 14, weight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PortfolioContent.freelanceProfiles.map(link).toList(),
        ),
      ],
    );
  }
}
