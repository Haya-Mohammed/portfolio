import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class Section extends StatelessWidget {
  final String label;
  final String title;
  final Widget child;
  final bool shaded;

  const Section({
    super.key,
    required this.label,
    required this.title,
    required this.child,
    required this.shaded,
  });

  Widget eyebrow(String label) =>
      Text(label, style: AppFonts.mono(size: 12, color: Brand.deepMustard));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: shaded ? Brand.oatmeal : Brand.paper,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width < 600 ? 20 : 48,
        vertical: MediaQuery.sizeOf(context).width < 600 ? 58 : 84,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              eyebrow(label),
              const SizedBox(height: 15),
              Text(
                title,
                style: AppFonts.display(
                  size: MediaQuery.sizeOf(context).width < 600 ? 34 : 41,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 38),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
