import 'package:flutter/material.dart';
import 'package:my_portfolio/content/certificates_data.dart';
import 'package:my_portfolio/content/education_data.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';
import 'package:my_portfolio/models/certificate.dart';
import 'package:my_portfolio/widgets/common/motion.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificateEntry extends StatelessWidget {
  final Certificate certificate;

  const CertificateEntry({super.key, required this.certificate});

  @override
  Widget build(BuildContext context) {
    final item = certificate;
    final metadata = [
      item.issuer ?? '',
      item.date ?? '',
      if (item.hours case final hours?) '$hours hours',
    ].where((value) => value.isNotEmpty).join(' · ');
    final skills =
        item.skills?.where((skill) => skill.trim().isNotEmpty).toList() ?? [];
    final uri = Uri.tryParse(item.url?.trim() ?? '');
    final hasLink =
        uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_outlined, size: 18, color: AppColors.deepMustard),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppFonts.body(size: 14, weight: FontWeight.w700),
                ),
                if (metadata.isNotEmpty)
                  Text(
                    metadata,
                    style: AppFonts.body(size: 12, color: AppColors.muted),
                  ),
                if (item.details case final details?
                    when details.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    details,
                    style: AppFonts.body(size: 13, color: AppColors.muted),
                  ),
                ],
                if (skills.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final skill in skills)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.oatmeal,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(skill, style: AppFonts.body(size: 11)),
                        ),
                    ],
                  ),
                ],
                if (hasLink) ...[
                  const SizedBox(height: 7),
                  TextButton.icon(
                    onPressed: () =>
                        launchUrl(uri, mode: LaunchMode.externalApplication),
                    icon: const Icon(Icons.open_in_new, size: 15),
                    label: const Text('View certificate'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.deepMustard,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 36),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final bool narrow;
  const AboutSection({super.key, required this.narrow});

  @override
  Widget build(BuildContext context) {
    final bio = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioContent.about,
          style: AppFonts.body(size: 18, height: 1.7),
        ),
        const SizedBox(height: 26),
        Text('Education', style: AppFonts.display(size: 27)),
        const SizedBox(height: 8),
        for (final edu in kEducation)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(edu.headline, style: AppFonts.body(size: 15)),
                if (edu.details != null)
                  Text(
                    edu.details!,
                    style: AppFonts.body(size: 14, color: AppColors.muted),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        Text(
          'Languages: Arabic and English',
          style: AppFonts.body(size: 14, color: AppColors.muted),
        ),
      ],
    );
    final certificates = HoverSurface(
      color: AppColors.ivory,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Selected learning', style: AppFonts.display(size: 27)),
          const SizedBox(height: 16),
          for (final item in kCertificates.where((item) => item.featured))
            CertificateEntry(certificate: item),
          Material(
            color: Colors.transparent,
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: Text(
                'More certificates',
                style: AppFonts.body(size: 14, weight: FontWeight.w700),
              ),
              children: [
                for (final item in kCertificates.where(
                  (item) => !item.featured,
                ))
                  CertificateEntry(certificate: item),
              ],
            ),
          ),
        ],
      ),
    );
    return narrow
        ? Column(children: [bio, const SizedBox(height: 30), certificates])
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: bio),
              const SizedBox(width: 48),
              Expanded(child: certificates),
            ],
          );
  }
}
