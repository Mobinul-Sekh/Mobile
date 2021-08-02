// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';

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
          title: const Text('Homepage'),
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/suppliers');
                      },
                      child: const Text("Suppliers"),
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
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                },
                child: GradientWidget(
                  gradient: AppGradients.primaryGradient,
                  child: Text(
                    "Logout",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ));
  }
}
