import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bitecope/config/router.dart';
import 'package:bitecope/config/theme.dart';
import 'package:bitecope/screens/splash_screen/splash_screen.dart';
import 'package:bitecope/logic/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BiteCope());
}

class BiteCope extends StatefulWidget {
  @override
  _BiteCopeState createState() => _BiteCopeState();
}

class _BiteCopeState extends State<BiteCope> {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
        theme: AppTheme.of(context),
        onGenerateRoute: appRouter.onGenerateRoute,
        home: const SplashScreen(),
      ),
    );
  }

  @override
  void dispose() {
    appRouter.dispose();
    super.dispose();
  }
}
