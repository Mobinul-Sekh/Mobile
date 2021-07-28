// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/routes/router.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/splash_screen/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BiteCope());
}

class BiteCope extends StatefulWidget {
  @override
  _BiteCopeState createState() => _BiteCopeState();
}

class _BiteCopeState extends State<BiteCope> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(CommonRepository()),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
        theme: AppTheme.of(context),
        onGenerateRoute: _appRouter.onGenerateRoute,
        home: const SplashScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
