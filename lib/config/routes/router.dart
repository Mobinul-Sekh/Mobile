// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bitecope/modules/home/screens/home.dart';
import 'package:bitecope/modules/not_found/screens/not_found.dart';
import 'package:bitecope/modules/sign_in/cubit/siginin_cubit.dart';
import 'package:bitecope/modules/sign_in/repositories/sign_in_repository.dart';
import 'package:bitecope/modules/sign_in/screens/sign_in.dart';
import 'package:bitecope/modules/sign_up/bloc/sign_up_bloc.dart';
import 'package:bitecope/modules/sign_up/repositories/sign_up_repository.dart';
import 'package:bitecope/modules/sign_up/screens/sign_up_one.dart';
import 'package:bitecope/modules/splash_screen/screens/splash_screen.dart';

class AppRouter {
  // Declare blocs here

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/signIn':
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(SignInRepository()),
              child: const SignIn(),
            );
          },
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      case '/signUp':
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(SignUpRepository()),
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
