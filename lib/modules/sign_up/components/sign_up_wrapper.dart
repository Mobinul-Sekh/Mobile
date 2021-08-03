// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/widgets/custom_back_button.dart';
import 'package:bitecope/widgets/gradient_widget.dart';

class SignUpWrapper extends StatelessWidget {
  const SignUpWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.nearBlack,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.nearBlack,
          centerTitle: false,
          leading: const CustomBackButton(),
          title: GradientWidget(
            gradient: AppGradients.primaryLinear,
            child: Text(
              AppLocalizations.of(context)!.signUp,
              style: Theme.of(context).appBarTheme.textTheme?.headline5,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 30),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 40.0,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
