// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/verify_email/screens/verify_email.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';

class EmailNotVerified extends StatelessWidget {
  final String username;

  const EmailNotVerified({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height * 0.2,
                child: Center(
                  child: GradientWidget(
                    gradient: AppGradients.primaryGradient,
                    child: Text(
                      AppLocalizations.of(context)!.checkInbox.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.emailNotVerified,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Theme.of(context).errorColor),
                  ),
                  const SizedBox(height: 18),
                  Text(AppLocalizations.of(context)!.verifyToSignIn),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: RoundedWideButton(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/verifyEmail', ModalRoute.withName('/'),
                          arguments: VerifyEmailArguments(
                            username: username,
                          ));
                    },
                    child: GradientWidget(
                      gradient: AppGradients.primaryGradient,
                      child: Text(
                        AppLocalizations.of(context)!.verify,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
