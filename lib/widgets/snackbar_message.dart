// Flutter imports:
import "package:flutter/material.dart";

// Project imports:
import 'package:bitecope/config/themes/theme.dart';

ScaffoldFeatureController snackbarMessage(
  BuildContext context,
  String message,
  MessageType type,
) {
  final Color _color = _getColor(type);
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 2000),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getIcon(type), color: _color),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: _color),
            ),
          ),
        ],
      ),
    ),
  );
}

IconData _getIcon(MessageType type) {
  switch (type) {
    case MessageType.normal:
      return Icons.circle_outlined;
    case MessageType.success:
      return Icons.check_circle_rounded;
    case MessageType.warning:
      return Icons.warning_rounded;
    case MessageType.failed:
      return Icons.error_rounded;
  }
}

Color _getColor(MessageType type) {
  switch (type) {
    case MessageType.normal:
      return AppColors.lightBlue1;
    case MessageType.success:
      return AppColors.green;
    case MessageType.failed:
      return AppColors.red;
    case MessageType.warning:
      return AppColors.orange1;
  }
}

enum MessageType { normal, success, failed, warning }
