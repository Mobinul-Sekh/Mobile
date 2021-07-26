import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/otp_text_fields.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:bitecope/widgets/underlined_title.dart';
import 'package:flutter/material.dart';

// TODO String Literals => AppLoalization
class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: Column(
            children: [
              const UnderlinedTitle(
                title: "Verify Email",
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GradientWidget(
                          gradient: AppGradients.primaryGradient,
                          child: Text(
                            "please check your email inbox".toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(height: 36),
                        const Text("Please enter the OTP"),
                        const SizedBox(height: 18),
                        const OTPTextFields(digitCount: 9),
                        const SizedBox(height: 18),
                        const Text("Resend OTP/Timer"),
                        const SizedBox(height: 36),
                        RoundedWideButton(
                          child: Text(
                            "Confirm",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Text(
                "If you need any help, please reach out to us at support@bitecope.in",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
