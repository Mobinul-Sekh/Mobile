// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/gradient_button.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';

class OperationNotification extends StatelessWidget {
  final String iconPath;
  final String title;
  final Gradient? titleGradient;
  final String message;
  final String splashImagePath;
  final Widget? postText;
  final String nextText;
  final GestureTapCallback nextCallback;

  const OperationNotification({
    Key? key,
    required this.iconPath,
    required this.title,
    this.titleGradient,
    required this.message,
    required this.splashImagePath,
    this.postText,
    required this.nextText,
    required this.nextCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(iconPath),
                  const SizedBox(width: 12),
                  GradientWidget(
                    gradient: titleGradient ?? AppGradients.primaryLinear,
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppColors.shadowText),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(splashImagePath),
                        if (postText != null) ...[
                          const SizedBox(height: 50),
                          postText!,
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GradientButton(
                gradient: AppGradients.primaryLinear,
                onTap: nextCallback,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      nextText,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: AppColors.white),
                    ),
                    const SizedBox(width: 24),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.lightBlue1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
