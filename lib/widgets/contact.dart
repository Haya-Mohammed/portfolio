import 'package:flutter/material.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/core/constants.dart';
import 'package:my_portfolio/models/contact_link.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _open(String url) async =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  Widget _secondaryLink(ContactLink item) => TextButton.icon(
    onPressed: () => _open(item.url),
    icon: const Icon(Icons.open_in_new, size: 16),
    label: Text(item.label),
  );

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        key: const Key('contact-callout'),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Brand.isDark ? Brand.deviceFrame : Brand.oatmeal,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HAVE A PROJECT OR OPPORTUNITY?',
              style: AppFonts.mono(size: 11),
            ),
            const SizedBox(height: 16),
            Text(
              'Let’s make something useful together.',
              style: AppFonts.display(size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              'I’m open to Flutter roles, freelance projects, and thoughtful collaborations.',
              style: AppFonts.body(size: 16, color: Brand.muted, height: 1.5),
            ),
            const SizedBox(height: 26),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: () => _open('mailto:${AppConstants.email}'),
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('Email me'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _open(AppConstants.linkedIn),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('LinkedIn'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _open(AppConstants.github),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('GitHub'),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Material(
        color: Colors.transparent,
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(bottom: 8),
          title: Text(
            'More ways to connect',
            style: AppFonts.body(size: 14, weight: FontWeight.w700),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final item in PortfolioContent.socialLinks.skip(2))
                    _secondaryLink(item),
                  for (final item in PortfolioContent.freelanceProfiles)
                    _secondaryLink(item),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
