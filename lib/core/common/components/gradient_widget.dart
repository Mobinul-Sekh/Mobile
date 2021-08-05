// Flutter imports:
import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Gradient gradient;
  final Widget child;

  const GradientWidget({
    Key? key,
    required this.gradient,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        final rect = Rect.fromLTRB(0, 0, bounds.width, bounds.height);
        return gradient.createShader(rect);
      },
      child: child,
    );
  }
}
