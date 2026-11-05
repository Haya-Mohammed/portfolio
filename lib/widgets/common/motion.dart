import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';

enum RevealStyle { rise, fromLeft, fromRight, scale }

/// Plays once when its content first enters the viewport.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.style = RevealStyle.rise,
  });

  final Widget child;
  final RevealStyle style;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _visible = false;
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_visible) return;
    final next = Scrollable.maybeOf(context)?.position;
    if (_position != next) {
      _position?.removeListener(_checkVisibility);
      _position = next;
      _position?.addListener(_checkVisibility);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _checkVisibility() {
    if (!mounted || _visible) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final bottom = top + box.size.height;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    if (bottom > 0 && top < viewportHeight) {
      setState(() => _visible = true);
      _position?.removeListener(_checkVisibility);
      _position = null;
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final target = _visible || reduceMotion ? 1.0 : 0.0;
    return TweenAnimationBuilder<double>(
      tween: Tween(end: target),
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 680),
      curve: Curves.easeOutCubic,
      child: widget.child,
      builder: (context, value, child) {
        final offset = switch (widget.style) {
          RevealStyle.rise => Offset(0, 24 * (1 - value)),
          RevealStyle.fromLeft => Offset(-32 * (1 - value), 0),
          RevealStyle.fromRight => Offset(32 * (1 - value), 0),
          RevealStyle.scale => Offset.zero,
        };
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: offset,
            child: Transform.scale(
              scale: widget.style == RevealStyle.scale
                  ? 0.96 + 0.04 * value
                  : 1,
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// Keeps card dimensions stable while making hover obvious on desktop.
class HoverSurface extends StatefulWidget {
  const HoverSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(26),
    this.radius = 20,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? color;

  @override
  State<HoverSurface> createState() => _HoverSurfaceState();
}

class _HoverSurfaceState extends State<HoverSurface> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.color ?? AppColors.paper,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(
            color: _hovered
                ? AppColors.deepMustard.withValues(alpha: 0.75)
                : AppColors.warmGray,
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: AppColors.isDark ? 0.28 : 0.12,
                    ),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ]
              : const [],
        ),
        child: widget.child,
      ),
    );
  }
}
