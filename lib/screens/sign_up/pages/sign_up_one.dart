import 'package:bitecope/config/theme.dart';
import 'package:bitecope/logic/sign_up/sign_up_bloc.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpOne extends StatefulWidget {
  const SignUpOne({Key? key}) : super(key: key);

  @override
  _SignUpOneState createState() => _SignUpOneState();
}

class _SignUpOneState extends State<SignUpOne> {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _usernameNode = FocusNode();
  final FocusNode _phoneNumberNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {},
      builder: (context, state) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: state.email.value,
                    focusNode: _emailNode,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _usernameNode.requestFocus(),
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: formFieldDecoration(
                      labelText: "Email",
                      errorText: state.email.error,
                      suffixIcon: Icons.mail_outline_rounded,
                    ),
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    initialValue: state.username.value,
                    focusNode: _usernameNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _phoneNumberNode.requestFocus(),
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: formFieldDecoration(
                      labelText: "Username",
                      errorText: state.username.error,
                      suffixIcon: Icons.person,
                    ),
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    initialValue: state.phoneNumber.value,
                    focusNode: _phoneNumberNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _passwordNode.requestFocus(),
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: formFieldDecoration(
                      labelText: "Phone Number",
                      errorText: state.phoneNumber.error,
                      suffixIcon: Icons.phone_outlined,
                    ),
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    initialValue: state.password.value,
                    focusNode: _passwordNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        _confirmPasswordNode.requestFocus(),
                    obscureText: _hidePassword,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: formFieldDecoration(
                      labelText: "Password",
                      errorText: state.password.error,
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
                  TextFormField(
                    initialValue: state.confirmPassword.value,
                    focusNode: _confirmPasswordNode,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                    obscureText: _hideConfirmPassword,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: formFieldDecoration(
                      labelText: "Confirm Password",
                      errorText: state.confirmPassword.error,
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
              context.read<SignUpBloc>().validatePageOne();
            },
            child: GradientWidget(
              gradient: AppGradients.primaryGradient,
              child: Text(
                "Next",
                style: Theme.of(context).primaryTextTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration formFieldDecoration({
    required String labelText,
    required IconData suffixIcon,
    String? errorText,
    VoidCallback? onTap,
  }) {
    return InputDecoration(
      errorText: errorText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: labelText,
      labelStyle: Theme.of(context).textTheme.bodyText1,
      suffixIcon: IconButton(
        onPressed: onTap,
        icon: Icon(
          suffixIcon,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
