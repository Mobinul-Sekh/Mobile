// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/sign_up/bloc/sign_up_bloc.dart';
import 'package:bitecope/modules/sign_up/components/sign_up_wrapper.dart';
import 'package:bitecope/modules/sign_up/screens/sign_up_two.dart';
import 'package:bitecope/widgets/form_field_decoration.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';

class SignUpOne extends StatefulWidget {
  const SignUpOne({Key? key}) : super(key: key);

  @override
  _SignUpOneState createState() => _SignUpOneState();
}

class _SignUpOneState extends State<SignUpOne> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _usernameNode = FocusNode();
  final FocusNode _phoneNumberNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    final state = context.read<SignUpBloc>().state;
    _emailController.text = state.email.value ?? "";
    _usernameController.text = state.username.value ?? "";
    _phoneNumberController.text = state.phoneNumber.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SignUpWrapper(
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.signUpStatus == SignUpStatus.pageOneValidated) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<SignUpBloc>(),
                  child: const SignUpTwo(),
                ),
              ),
            );
          }
        },
        builder: (context, state) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      focusNode: _emailNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _usernameNode.requestFocus(),
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText: AppLocalizations.of(context)!.email,
                        errorText: state.email.error != null
                            ? state.email.error!(context)
                            : null,
                        suffixIcon: Icons.mail_outline_rounded,
                      ),
                    ),
                    const SizedBox(height: 36),
                    TextField(
                      controller: _usernameController,
                      focusNode: _usernameNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _phoneNumberNode.requestFocus(),
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText: AppLocalizations.of(context)!.username,
                        errorText: state.username.error != null
                            ? state.username.error!(context)
                            : null,
                        suffixIcon: Icons.person,
                      ),
                    ),
                    const SizedBox(height: 36),
                    TextField(
                      controller: _phoneNumberController,
                      focusNode: _phoneNumberNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _passwordNode.requestFocus(),
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText: AppLocalizations.of(context)!.phoneNumber,
                        errorText: state.phoneNumber.error != null
                            ? state.phoneNumber.error!(context)
                            : null,
                        suffixIcon: Icons.phone_outlined,
                      ),
                    ),
                    const SizedBox(height: 36),
                    TextField(
                      controller: _passwordController,
                      focusNode: _passwordNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          _confirmPasswordNode.requestFocus(),
                      obscureText: _hidePassword,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText: AppLocalizations.of(context)!.password,
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
                    const SizedBox(height: 36),
                    TextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordNode,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      obscureText: _hideConfirmPassword,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText:
                            AppLocalizations.of(context)!.confirmPassword,
                        errorText: state.confirmPassword.error != null
                            ? state.confirmPassword.error!(context)
                            : null,
                        suffixIcon: _hideConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onTap: () {
                          setState(() {
                            _hideConfirmPassword = !_hideConfirmPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            RoundedWideButton(
              onTap: () {
                context.read<SignUpBloc>().validatePageOne(
                      email: _emailController.text,
                      username: _usernameController.text,
                      phoneNumber: _phoneNumberController.text,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text,
                    );
              },
              child: GradientWidget(
                gradient: AppGradients.primaryLinear,
                child: Text(
                  AppLocalizations.of(context)!.next,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailNode.dispose();
    _usernameController.dispose();
    _usernameNode.dispose();
    _phoneNumberController.dispose();
    _phoneNumberNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }
}
