import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants.dart';
import 'package:my_portfolio/sections/social_link.dart';

class SocialLinks extends StatelessWidget {
  static const _links = [
    ('GitHub', AppConstants.github),
    ('LinkedIn', AppConstants.linkedIn),
    ('Linktree', AppConstants.linktree),
    ('Whatsapp', AppConstants.whatsapp),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _links.map((l) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SocialLink(label: l.$1, url: l.$2),
        );
      }).toList(),
    );
  }
}
