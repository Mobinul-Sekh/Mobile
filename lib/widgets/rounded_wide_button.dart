import 'package:flutter/material.dart';

class RoundedWideButton extends StatelessWidget {
  const RoundedWideButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.width,
    this.fillColor,
    this.border,
  }) : super(key: key);

  final Widget child;
  final GestureTapCallback onTap;
  final double? width;
  final Color? fillColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: Ink(
            width: width ?? 220,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: fillColor ?? Theme.of(context).primaryColor,
              border: border,
              borderRadius: BorderRadius.circular(100),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
