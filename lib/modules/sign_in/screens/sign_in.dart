// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/sign_in/cubit/siginin_cubit.dart';
import 'package:bitecope/widgets/custom_back_button.dart';
import 'package:bitecope/widgets/form_field_decoration.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    final state = context.read<SignInBloc>().state;
    _usernameController.text = state.username.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.nearBlack,
        appBar: AppBar(
          elevation: 0,
          leading: const CustomBackButton(),
          centerTitle: false,
          title: GradientWidget(
            gradient: AppGradients.primaryGradient,
            child: Text(
              AppLocalizations.of(context)!.signIn,
              style: Theme.of(context).appBarTheme.textTheme?.headline4,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 30),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 40.0,
            ),
            child: BlocConsumer<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state.signInStatus == SignInStatus.signedIn) {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              focusNode: _usernameNode,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  _passwordNode.requestFocus(),
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: formFieldDecoration(
                                context,
                                labelText:
                                    AppLocalizations.of(context)!.username,
                                errorText: state.username.error != null
                                    ? state.username.error!(context)
                                    : null,
                                suffixIcon: Icons.person,
                              ),
                            ),
                            const SizedBox(height: 36),
                            TextField(
                              controller: _passwordController,
                              focusNode: _passwordNode,
                              textInputAction: TextInputAction.done,
                              obscureText: _hidePassword,
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: formFieldDecoration(
                                context,
                                labelText:
                                    AppLocalizations.of(context)!.password,
                                errorText: state.password.error != null
                                    ? state.password.error!(context)
                                    : null,
                                suffixIcon: _hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                onTap: () {
                                  setState(() {
                                    _hidePassword = !_hidePassword;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // TODO Push to forgot password page
                                  },
                                  child: GradientWidget(
                                    gradient: AppGradients.primaryGradient,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .forgotPassword,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    signInButton(state.signInStatus),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget signInButton(SignInStatus status) {
    return RoundedWideButton(
      onTap: status == SignInStatus.signIn
          ? () {
              context.read<SignInBloc>().validateSignInPage(
                    username: _usernameController.text,
                    password: _passwordController.text,
                  );
            }
          : null,
      child: status == SignInStatus.signIn
          ? GradientWidget(
              gradient: AppGradients.primaryGradient,
              child: Text(
                AppLocalizations.of(context)!.signIn,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            )
          : const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }
}
