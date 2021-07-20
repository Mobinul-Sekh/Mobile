import 'package:bitecope/screens/sign_up/components/sign_up_wrapper.dart';
import 'package:bitecope/screens/sign_up/pages/sign_up_one.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignUpWrapper(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 40,
        ),
        child: SignUpOne(),
      ),
    );
  }
}
