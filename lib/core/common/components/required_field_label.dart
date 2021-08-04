// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';

RichText requiredFieldLabel(
  BuildContext context, {
  required String labelText,
  bool isRequired = true,
}) {
  return RichText(
    text: TextSpan(
      style: Theme.of(context).textTheme.caption,
      children: [
        TextSpan(
          text: labelText,
        ),
        if (isRequired)
          TextSpan(
            text: " *",
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: AppColors.orange1),
          ),
      ],
    ),
  );
}
