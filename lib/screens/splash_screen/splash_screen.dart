import 'package:bitecope/config/theme.dart';
import 'package:bitecope/logic/authentication/authentication_bloc.dart';
import 'package:bitecope/screens/splash_screen/components/wave_clipper.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryGradient,
                ),
              ),
            ),
            Column(
              children: [
                Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
                Text(
                  "Bitecope",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: AppColors.white,
                        fontFamily: 'Righteous',
                      ),
                ),
                Text(
                  "Connecting every bit",
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
                          child: Center(
                            child: Text(
                              "Sign IN",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          width: 310,
                          fillColor: AppColors.lightBlue1,
                          border: Border.all(
                            color: AppColors.lightBlue1,
                            width: 2,
                          ),
                          onTap: () {
                            //* Push Sign In Page
                          },
                        ),
                        const SizedBox(height: 24),
                        RoundedWideButton(
                          child: Center(
                            child: Text(
                              "Sign UP",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          width: 310,
                          border: Border.all(
                            color: AppColors.lightBlue1,
                            width: 2,
                          ),
                          onTap: () {
                            //* Push Sign Up Page
                          },
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
