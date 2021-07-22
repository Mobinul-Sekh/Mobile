import 'package:flutter/material.dart';

InputDecoration formFieldDecoration(
  BuildContext context, {
  required String labelText,
  IconData? suffixIcon,
  Color? iconColor,
  double? iconSize,
  String? errorText,
  VoidCallback? onTap,
}) {
  return InputDecoration(
    errorText: errorText,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelText: labelText,
    labelStyle: Theme.of(context).textTheme.bodyText1,
    suffixIcon: suffixIcon != null
        ? IconButton(
            onPressed: onTap,
            icon: Icon(
              suffixIcon,
              size: iconSize,
              color: iconColor ?? Theme.of(context).primaryColor,
            ),
          )
        : null,
  );
}
