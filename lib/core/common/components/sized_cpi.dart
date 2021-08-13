import 'package:bitecope/config/themes/theme.dart';
import 'package:flutter/material.dart';

class SizedCPI extends StatelessWidget {
  final Color? color;

  const SizedCPI({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            color: color ?? AppColors.white,
          ),
        ),
      ],
    );
  }
}
