// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/gen/assets.gen.dart';
import 'package:bitecope/gen/fonts.gen.dart';
import 'package:bitecope/modules/owner_subscription/screens/owner_subscription.dart';
import 'package:bitecope/utils/ui_utils/wave_clipper.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  gradient: AppGradients.primaryLinear,
                ),
              ),
            ),
            Column(
              children: [
                SvgPicture.asset(Assets.images.logo, width: 125, height: 125),
                Text(
                  AppLocalizations.of(context)!.appName,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: AppColors.white,
                        fontFamily: FontFamily.righteous,
                      ),
                ),
                Text(
                  AppLocalizations.of(context)!.appSlogan,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  _handleListen(context, state);
                },
                builder: (context, state) {
                  if (state.status != AuthenticationStatus.loading) {
                    return Column(
                      children: [
                        RoundedWideButton(
                          width: 310,
                          fillColor: AppColors.lightBlue1,
                          border: Border.all(
                            color: AppColors.lightBlue1,
                            width: 2,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed("/signIn");
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.signIn,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        RoundedWideButton(
                          width: 310,
                          border: Border.all(
                            color: AppColors.lightBlue1,
                            width: 2,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/signUp');
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.signUp,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleListen(
    BuildContext context,
    AuthenticationState state,
  ) {
    switch (state.status) {
      case AuthenticationStatus.loading:
      case AuthenticationStatus.loggedOut:
        break;
      case AuthenticationStatus.loggedIn:
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case AuthenticationStatus.ownerActivate:
        Navigator.of(context).pushNamed(
          '/ownerSubscription',
          arguments: OwnerSubscriptionArguments(username: state.username!),
        );
        break;
      case AuthenticationStatus.ownerInitialize:
        //TODO Push to owner initialize; pushing to home for now
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case AuthenticationStatus.ownerInactive:
        //TODO Push to owner inactive error page for woker sign-in; pushing to home for now
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case AuthenticationStatus.workerInitialize:
        Navigator.of(context).pushNamed('/workerInitialize');
        break;
    }
  }
}
