// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/owner_subscription/screens/owner_subscription.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';

class OwnerNotSubscribed extends StatelessWidget {
  final String username;

  const OwnerNotSubscribed({Key? key, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.notSubscribed,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Theme.of(context).errorColor),
                        ),
                        const SizedBox(height: 18),
                        Text(AppLocalizations.of(context)!.subscribeToUse),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: RoundedWideButton(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/ownerSubscription', ModalRoute.withName('/'),
                        arguments: OwnerSubscriptionArguments(
                          username: username,
                        ));
                  },
                  child: GradientWidget(
                    gradient: AppGradients.primaryLinear,
                    child: Text(
                      AppLocalizations.of(context)!.subscribe,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
