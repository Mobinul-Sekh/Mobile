// Flutter imports:
import 'package:bitecope/config/constants/app_texts.dart';
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/routes/route_names.dart';
import 'package:bitecope/core/common/components/sized_cpi.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/components/custom_back_button.dart';
import 'package:bitecope/core/common/components/gradient_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  bool _confirmLogout = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _confirmLogout
            ? Container()
            : const CustomBackButton(
                icon: Icons.arrow_back_rounded,
              ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: _setContent(),
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.lightGrey,
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/support.svg'),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.support,
                ),
              ],
            ),
            const SizedBox(height: 12),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _setContent() {
    if (_confirmLogout) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.lightGrey,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowBlack,
              blurRadius: 7,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.loggedOut) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                  .pushReplacementNamed(RouteName.splashScreen);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.confirmLogout),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GradientButton(
                      onTap: state.status == AuthenticationStatus.loading
                          ? null
                          : () {
                              context.read<AuthenticationBloc>().logout();
                            },
                      child: state.status == AuthenticationStatus.loading
                          ? const SizedCPI(color: AppColors.lightBlue1)
                          : Text(
                              AppLocalizations.of(context)!.logout,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                      color: Theme.of(context).errorColor),
                            ),
                    ),
                    GradientButton(
                      onTap: () {
                        setState(() {
                          _confirmLogout = false;
                        });
                      },
                      color: AppColors.green,
                      child: Text(
                        AppLocalizations.of(context)!.no,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      );
    }
    return SizedBox(
      child: TextButton(
        onPressed: () {
          setState(() {
            _confirmLogout = true;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/logout.svg'),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context)!.logout,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Theme.of(context).errorColor),
            ),
          ],
        ),
      ),
    );
  }
}
