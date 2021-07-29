// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

InputDecoration formFieldDecoration(
  BuildContext context, {
  String? labelText,
  String? suffixSvgPath,
  IconData? suffixIcon,
  Color? iconColor,
  double? iconSize,
  bool isDense = false,
  String? errorText,
  bool suppressError = false,
  VoidCallback? onTap,
}) {
  return InputDecoration(
    isDense: isDense,
    errorText: errorText == null
        ? errorText
        : suppressError
            ? ""
            : errorText,
    errorMaxLines: 2,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelText: labelText,
    labelStyle: Theme.of(context).textTheme.bodyText1,
    contentPadding: const EdgeInsets.only(top: 6, bottom: 3),
    suffixIcon: suffixSvgPath != null
        ? GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                suffixSvgPath,
                width: iconSize ?? 24,
                height: iconSize ?? 24,
              ),
            ),
          )
        : suffixIcon != null
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
