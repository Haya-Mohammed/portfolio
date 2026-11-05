import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/content/freelance_profiles_data.dart';
import 'package:my_portfolio/content/social_links_data.dart';
import 'package:my_portfolio/core/constants/constants.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';
import 'package:my_portfolio/models/contact_link.dart';
import 'package:my_portfolio/widgets/common/motion.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _open(String url) =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: AppConstants.email));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Email address copied')));
  }

  Widget _callout(BuildContext context) => Container(
    key: const Key('contact-callout'),
    constraints: const BoxConstraints(minHeight: 390),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: AppColors.isDark ? AppColors.deviceFrame : const Color(0xFF292720),
      borderRadius: BorderRadius.circular(28),
    ),
    child: Stack(
      children: [
        for (final (size, top, right, opacity) in [
          (360.0, -128.0, -96.0, 0.48),
          (230.0, -54.0, -24.0, 0.25),
        ])
          Positioned(
            top: top,
            right: right,
            child: IgnorePointer(
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mustard.withValues(alpha: opacity * 0.2),
                  border: Border.all(
                    color: AppColors.mustard.withValues(alpha: opacity),
                  ),
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mustard,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Text(
                    'OPEN TO NEW IDEAS',
                    style: AppFonts.mono(size: 10, color: AppColors.mustard),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              const Icon(
                Icons.mark_email_unread_outlined,
                size: 44,
                color: AppColors.mustard,
              ),
              const SizedBox(height: 22),
              Text(
                'Have something in mind?\nLet’s talk.',
                style: AppFonts.display(
                  size: 38,
                  height: 1.12,
                ).copyWith(color: const Color(0xFFF7F2E9)),
              ),
              const SizedBox(height: 15),
              Text(
                'Flutter roles, freelance projects, or a good idea worth building—I’d love to hear from you.',
                style: AppFonts.body(
                  size: 15,
                  color: const Color(0xFFDED7CA),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.mustard,
                      foregroundColor: const Color(0xFF25231E),
                    ),
                    onPressed: () => _open('mailto:${AppConstants.email}'),
                    icon: const Icon(Icons.arrow_outward_rounded, size: 18),
                    label: const Text('Email me'),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFF7F2E9),
                      side: BorderSide(
                        color: const Color(0xFFF7F2E9).withValues(alpha: 0.55),
                      ),
                    ),
                    onPressed: () => _copyEmail(context),
                    icon: const Icon(Icons.copy_outlined, size: 17),
                    label: const Text('Copy email'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SelectableText(
                AppConstants.email,
                style: AppFonts.body(size: 13, color: const Color(0xFFDED7CA)),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _socialCard(
    String title,
    String subtitle,
    IconData icon,
    String url,
  ) => HoverSurface(
    padding: EdgeInsets.zero,
    radius: 18,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _open(url),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.oatmeal,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: AppColors.deepMustard, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFonts.body(size: 15, weight: FontWeight.w700),
                    ),
                    Text(
                      subtitle,
                      style: AppFonts.body(size: 12, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_outward_rounded,
                color: AppColors.deepMustard,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _socialLinks() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('FIND ME ONLINE', style: AppFonts.mono(size: 11)),
      const SizedBox(height: 10),
      Text('More places to connect', style: AppFonts.display(size: 26)),
      const SizedBox(height: 10),
      Text(
        'Follow the work, say hello, or start a conversation.',
        style: AppFonts.body(size: 14, color: AppColors.muted),
      ),
      const SizedBox(height: 20),
      _socialCard(
        'LinkedIn',
        'Let’s connect professionally',
        Icons.work_outline,
        AppConstants.linkedIn,
      ),
      const SizedBox(height: 12),
      _socialCard(
        'GitHub',
        'Explore my code',
        Icons.code_rounded,
        AppConstants.github,
      ),
      const SizedBox(height: 12),
      _socialCard(
        'WhatsApp',
        'Send a quick message',
        Icons.chat_bubble_outline,
        AppConstants.whatsapp,
      ),
    ],
  );

  Widget _secondaryLink(ContactLink item) => ActionChip(
    avatar: Icon(
      Icons.arrow_outward_rounded,
      size: 16,
      color: AppColors.deepMustard,
    ),
    label: Text(item.label),
    onPressed: () => _open(item.url),
  );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final wide = box.maxWidth >= 760;
      final callout = _callout(context);
      final links = _socialLinks();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: callout),
                const SizedBox(width: 34),
                Expanded(flex: 4, child: links),
              ],
            )
          else ...[
            callout,
            const SizedBox(height: 34),
            links,
          ],
          const SizedBox(height: 22),
          Material(
            color: AppColors.oatmeal.withValues(
              alpha: AppColors.isDark ? 0.6 : 0.45,
            ),
            borderRadius: BorderRadius.circular(16),
            child: ExpansionTile(
              shape: const Border(),
              collapsedShape: const Border(),
              tilePadding: const EdgeInsets.symmetric(horizontal: 18),
              childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
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
                      for (final item in kSocialLinks.skip(2))
                        if (item.label != 'WhatsApp') _secondaryLink(item),
                      for (final item in kFreelanceProfiles)
                        _secondaryLink(item),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
