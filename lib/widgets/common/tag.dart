import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_fonts.dart';

class CustomTag extends StatelessWidget {
  final String label;
  const CustomTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.paper,
        border: Border.all(color: AppColors.warmGray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppFonts.body(size: 11, weight: FontWeight.w600),
      ),
    );
  }
}
