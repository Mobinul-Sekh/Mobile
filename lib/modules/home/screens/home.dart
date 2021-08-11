// Flutter imports:
import 'package:bitecope/config/routes/route_names.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/components/gradient_button.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';
import 'package:bitecope/core/common/components/rounded_wide_button.dart';
import 'package:bitecope/core/common/components/underlined_title.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const UnderlinedTitle(
          title: "Home",
          underlineOvershoot: 0,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 18),
            Expanded(
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  GradientButton(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.suppliers);
                    },
                    gradient: AppGradients.primaryLinear,
                    child: Text(
                      "Suppliers",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            RoundedWideButton(
              onTap: () async {
                final bool? _isLoggedOut =
                    await context.read<AuthenticationBloc>().logout();
                if (_isLoggedOut != null && _isLoggedOut) {
                  Navigator.of(context)
                      .pushReplacementNamed(RouteName.splashScreen);
                }
              },
              child: GradientWidget(
                gradient: AppGradients.primaryLinear,
                child: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
