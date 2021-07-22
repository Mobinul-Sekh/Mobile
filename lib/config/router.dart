import 'package:bitecope/data/repositories/account_repository.dart';
import 'package:bitecope/logic/sign_up/sign_up_bloc.dart';
import 'package:bitecope/screens/sign_up/pages/sign_up_one.dart';
import 'package:bitecope/screens/splash_screen/splash_screen.dart';
import 'package:bitecope/screens/not_found/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  // Declare blocs here

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/signUp':
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(
                accountRepository: AccountRepository(),
              ),
              child: const SignUpOne(),
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
    // Dispose blocs here
  }
}
