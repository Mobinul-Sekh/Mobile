// Flutter imports:
import 'package:flutter/material.dart';

InputDecoration formFieldDecoration(
  BuildContext context, {
  required String labelText,
  IconData? suffixIcon,
  Color? iconColor,
  double? iconSize,
  String? errorText,
  bool suppressError = false,
  VoidCallback? onTap,
}) {
  return InputDecoration(
    errorText: errorText == null
        ? errorText
        : suppressError
            ? ""
            : errorText,
    errorMaxLines: 2,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelText: labelText,
    labelStyle: Theme.of(context).textTheme.bodyText1,
    contentPadding: const EdgeInsets.only(top: 6),
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
