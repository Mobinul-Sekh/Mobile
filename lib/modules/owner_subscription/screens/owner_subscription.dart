// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:bitecope/config/constants/app_texts.dart';
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/components/form_field_decoration.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';
import 'package:bitecope/core/common/components/rounded_wide_button.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';
import 'package:bitecope/core/common/screens/operation_notification.dart';
import 'package:bitecope/modules/owner_subscription/bloc/owner_subscription_bloc.dart';

class OwnerSubscriptionArguments {
  String username;

  OwnerSubscriptionArguments({required this.username});
}

class OwnerSubscription extends StatelessWidget {
  final TextEditingController _keyController = TextEditingController();

  OwnerSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              UnderlinedTitle(
                title: AppLocalizations.of(context)!.subscription,
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: BlocConsumer<OwnerSubscriptionBloc,
                        OwnerSubscriptionState>(
                      listener: (context, state) {
                        _handleListen(context, state);
                      },
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GradientWidget(
                              gradient: AppGradients.primaryLinear,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .checkInbox
                                    .toUpperCase(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            const SizedBox(height: 72),
                            TextField(
                              controller: _keyController,
                              style: Theme.of(context).textTheme.bodyText2,
                              textInputAction: TextInputAction.done,
                              decoration: formFieldDecoration(
                                context,
                                labelText:
                                    AppLocalizations.of(context)!.activationKey,
                                errorText: state.activationKey.error != null
                                    ? state.activationKey.error!(context)
                                    : null,
                                suffixSvgPath:
                                    'assets/images/activation_key.svg',
                              ),
                            ),
                            const SizedBox(height: 36),
                            _activateButton(context, state),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.contactSupport,
                    ),
                    TextSpan(
                      text: AppTexts.supportEmail,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppColors.lightBlue1),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(AppURLs.supportEmail);
                        },
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

  void _handleListen(BuildContext context, OwnerSubscriptionState state) {
    if (state.ownerSubscriptionStatus == OwnerSubscriptionStatus.done) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return OperationNotification(
            iconPath: 'assets/images/party_hat.svg',
            title: "Congratulations",
            message: AppLocalizations.of(context)!.accountActivated,
            splashImagePath: 'assets/images/celebration.svg',
            postText: _successPagePostText(context),
            nextText: AppLocalizations.of(context)!.backToLogin,
            nextCallback: () {
              Navigator.of(context).pushReplacementNamed('/signIn');
            },
          );
        }),
        ModalRoute.withName('/'),
      );
    }
  }

  RoundedWideButton _activateButton(
    BuildContext context,
    OwnerSubscriptionState state,
  ) {
    return RoundedWideButton(
      onTap: state.ownerSubscriptionStatus == OwnerSubscriptionStatus.activating
          ? null
          : () {
              context
                  .read<OwnerSubscriptionBloc>()
                  .validateKey(activationKey: _keyController.text);
            },
      child: state.ownerSubscriptionStatus == OwnerSubscriptionStatus.activating
          ? const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(),
            )
          : Text(
              AppLocalizations.of(context)!.activate,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: AppColors.white),
            ),
    );
  }

  RichText _successPagePostText(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText2,
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!.choosingBitecope,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.continueServices,
          ),
        ],
      ),
    );
  }
}
