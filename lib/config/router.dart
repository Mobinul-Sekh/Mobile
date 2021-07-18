import 'package:bitecope/logic/authentication/authentication_bloc.dart';
import 'package:bitecope/screens/splash_screen/splash_screen.dart';
import 'package:bitecope/screens/not_found/not_found.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
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
