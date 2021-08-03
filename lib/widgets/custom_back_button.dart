// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/widgets/gradient_widget.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    this.icon = Icons.keyboard_arrow_left_rounded,
    this.size = 42,
    this.gradient = AppGradients.primaryLinear,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return GradientWidget(
      gradient: gradient,
      child: IconButton(
        icon: Icon(icon, size: size),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    );
  }
}
