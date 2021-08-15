// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';

class BlockButton extends StatelessWidget {
  final BlockPosition position;
  final Widget child;
  final GestureTapCallback? onTap;
  final bool singleButton;

  const BlockButton({
    Key? key,
    this.position = BlockPosition.center,
    required this.child,
    this.onTap,
    this.singleButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _setMargin(),
      child: InkWell(
        onTap: onTap,
        borderRadius: _setBorderRadius(),
        child: Ink(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: _setBorderRadius(),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowBlack,
                blurRadius: 12,
                spreadRadius: 1,
                offset: _setShadowOffset(),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  BorderRadius? _setBorderRadius() {
    if (singleButton) {
      return BorderRadius.circular(12);
    }
    switch (position) {
      case BlockPosition.center:
        return null;
      case BlockPosition.left:
        return const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        );
      case BlockPosition.right:
        return const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        );
      default:
        return null;
    }
  }

  Offset _setShadowOffset() {
    if (singleButton) {
      return const Offset(0, 0);
    }
    switch (position) {
      case BlockPosition.center:
        return const Offset(0, 0);
      case BlockPosition.left:
        return const Offset(-3, 0);
      case BlockPosition.right:
        return const Offset(3, 0);
      default:
        return const Offset(0, 0);
    }
  }

  EdgeInsets _setMargin() {
    if (singleButton) {
      return const EdgeInsets.symmetric(horizontal: 1.5);
    }
    switch (position) {
      case BlockPosition.center:
        return const EdgeInsets.symmetric(horizontal: 1.5);
      case BlockPosition.left:
        return const EdgeInsets.only(right: 1.5);
      case BlockPosition.right:
        return const EdgeInsets.only(left: 1.5);
      default:
        return const EdgeInsets.symmetric(horizontal: 1.5);
    }
  }
}

enum BlockPosition {
  left,
  center,
  right,
}
