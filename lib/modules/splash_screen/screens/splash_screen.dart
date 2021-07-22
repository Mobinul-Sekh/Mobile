import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/utils/ui_utils/wave_clipper.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  gradient: AppGradients.primaryGradient,
                ),
              ),
            ),
            Column(
              children: [
                SvgPicture.asset('assets/images/logo.svg'),
                Text(
                  AppLocalizations.of(context)!.appName,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Righteous',
                      ),
                ),
                Text(
                  AppLocalizations.of(context)!.appSlogan,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Poppins',
                      ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state.status == AuthenticationStatus.loggedIn) {
                    //* Navigator.of(context).pushReplacementNamed("/home");
                  }
                },
                builder: (context, state) {
                  if (state.status == AuthenticationStatus.loggedOut) {
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
                            //* Push Sign In Page
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.signIn,
                              style: Theme.of(context).textTheme.headline6,
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
                              style: Theme.of(context).textTheme.headline6,
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
}
