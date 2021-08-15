// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';

class ActionButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final Gradient? gradient;

  const ActionButton({
    Key? key,
    this.onTap,
    this.gradient,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      child: Container(
        height: 80,
        width: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.darkShadowBlack,
              blurRadius: 12,
              spreadRadius: 1,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Ink(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient ??
                const RadialGradient(
                  colors: <Color>[
                    AppColors.lightBlue2,
                    AppColors.lightBlue1,
                  ],
                  stops: [
                    0.80,
                    1.00,
                  ],
                  center: Alignment(0.0, 0.15),
                ),
          ),
          child: child,
        ),
      ),
    );
  }
}
