import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants.dart';
import 'package:my_portfolio/sections/social_link.dart';

class FreelanceLinks extends StatelessWidget {
  static const _links = [
    ('Upwork', AppConstants.upwork),
    ('Freelancer', AppConstants.freelancer),
    ('Mostaqel', AppConstants.mostaql),
    ('Khamsat', AppConstants.khamsat),
    ('BrightGaza', AppConstants.brightgaza),
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
