import 'package:bitecope/core/authentication/authentication_bloc.dart';
import 'package:bitecope/modules/signin/cubit/siginin_cubit.dart';
import 'package:bitecope/modules/signin/repositories/signin_repositiry.dart';
import 'package:bitecope/modules/signin/screens/signinpage.dart';
import 'package:bitecope/modules/splash_screen/splash_screen.dart';
import 'package:bitecope/modules/not_found/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/Signin':
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                signInRepository: SignInRepository(),
              ),
              child: const SignInPage(),
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const NotFound(),
        );
    }
  }

  void dispose() {
    _authenticationBloc.close();
  }
}
