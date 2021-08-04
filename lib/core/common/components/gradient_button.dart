// Flutter imports:
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? color;
  final Gradient? gradient;

  const GradientButton({
    Key? key,
    required this.child,
    this.onTap,
    this.margin,
    this.padding,
    this.borderRadius,
    this.color,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 100,
        minHeight: 33,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 6),
        child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
            color: color,
            gradient: gradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
