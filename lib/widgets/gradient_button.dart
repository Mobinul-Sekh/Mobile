// Flutter imports:
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  const GradientButton({
    Key? key,
    required this.child,
    this.onTap,
    this.margin,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.backgroundGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 6),
        child: Ink(
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
            color: backgroundColor,
            gradient: backgroundGradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
