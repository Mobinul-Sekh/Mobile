// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bitecope/config/routes/route_names.dart';
import 'package:bitecope/modules/home/screens/home.dart';
import 'package:bitecope/modules/not_found/screens/not_found.dart';
import 'package:bitecope/modules/owner_subscription/bloc/owner_subscription_bloc.dart';
import 'package:bitecope/modules/owner_subscription/repositories/owner_subscription_repository.dart';
import 'package:bitecope/modules/owner_subscription/screens/owner_subscription.dart';
import 'package:bitecope/modules/sign_in/cubit/siginin_cubit.dart';
import 'package:bitecope/modules/sign_in/repositories/sign_in_repository.dart';
import 'package:bitecope/modules/sign_in/screens/sign_in.dart';
import 'package:bitecope/modules/sign_up/bloc/sign_up_bloc.dart';
import 'package:bitecope/modules/sign_up/repositories/sign_up_repository.dart';
import 'package:bitecope/modules/sign_up/screens/sign_up_one.dart';
import 'package:bitecope/modules/splash_screen/screens/splash_screen.dart';
import 'package:bitecope/modules/suppliers/bloc/supplier_list_bloc.dart';
import 'package:bitecope/modules/suppliers/repositories/supplier_repository.dart';
import 'package:bitecope/modules/suppliers/screens/suppliers_list.dart';
import 'package:bitecope/modules/verify_email/bloc/verify_email_bloc.dart';
import 'package:bitecope/modules/verify_email/repositories/verify_email_repository.dart';
import 'package:bitecope/modules/verify_email/screens/verify_email.dart';
import 'package:bitecope/modules/worker_initialize/bloc/worker_initialize_bloc.dart';
import 'package:bitecope/modules/worker_initialize/repositories/worker_initialize_repository.dart';
import 'package:bitecope/modules/worker_initialize/screens/worker_initialize.dart';
import 'package:bitecope/modules/workers/bloc/worker_list_bloc.dart';
import 'package:bitecope/modules/workers/repositories/worker_repository.dart';
import 'package:bitecope/modules/workers/screens/workers_list.dart';

class AppRouter {
  // Declare blocs here

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SplashScreen(),
        );
      case RouteName.signUp:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(SignUpRepository()),
              child: const SignUpOne(),
            );
          },
        );
      case RouteName.verifyEmail:
        //! Requires VerifyEmailArguments
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            final VerifyEmailArguments _verifyEmailArguments =
                routeSettings.arguments! as VerifyEmailArguments;
            return BlocProvider<VerifyEmailBloc>(
              create: (context) => VerifyEmailBloc(
                VerifyEmailRepository(),
                username: _verifyEmailArguments.username,
              ),
              child: const VerifyEmail(),
            );
          },
        );
      case RouteName.ownerSubscription:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            final OwnerSubscriptionArguments _ownerSubscriptionArguments =
                routeSettings.arguments! as OwnerSubscriptionArguments;
            return BlocProvider<OwnerSubscriptionBloc>(
              create: (context) => OwnerSubscriptionBloc(
                OwnerSubscriptionRepository(),
                username: _ownerSubscriptionArguments.username,
              ),
              child: OwnerSubscription(),
            );
          },
        );
      case RouteName.signIn:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(SignInRepository()),
              child: const SignIn(),
            );
          },
        );
      case RouteName.workerInitialize:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BlocProvider<WorkerInitializeBloc>(
            create: (context) =>
                WorkerInitializeBloc(WorkerInitializeRepository()),
            child: WorkerInitialize(),
          ),
        );
      case RouteName.home:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Home(),
        );
      case RouteName.suppliers:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BlocProvider<SupplierListBloc>(
            create: (context) => SupplierListBloc(SupplierRepository()),
            child: const SuppliersList(),
          ),
        );
      case RouteName.workers:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BlocProvider<WorkerListBloc>(
            create: (context) => WorkerListBloc(WorkerRepository()),
            child: const WorkersList(),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const NotFound(),
        );
    }
  }

  void dispose() {
    // Dispose blocs here
  }
}
