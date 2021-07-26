// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/verify_email/bloc/verify_email_bloc.dart';
import 'package:bitecope/modules/verify_email/components/otp_text_fields.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:bitecope/widgets/underlined_title.dart';

// TODO String Literals => AppLoalization
class VerifyEmail extends StatelessWidget {
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  VerifyEmail({Key? key}) : super(key: key);

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
                        OTPTextFields(
                          digitCount: 9,
                          formKey: _otpFormKey,
                        ),
                        const SizedBox(height: 18),
                        BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
                          builder: (context, state) {
                            if (state.timeout == null) {
                              return RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  children: [
                                    const TextSpan(
                                      text: "Did not get the OTP? ",
                                    ),
                                    TextSpan(
                                      text: "Resend OTP",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              color: AppColors.lightBlue1),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("OTP Resent"),
                                            ),
                                          );
                                          context
                                              .read<VerifyEmailBloc>()
                                              .resendOTP();
                                        },
                                    ),
                                  ],
                                ),
                              );
                            }
                            return RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyText2,
                                children: [
                                  const TextSpan(
                                    text: "Resend option will be available in ",
                                  ),
                                  TextSpan(
                                    text: '0:${state.timeout} sec',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(color: AppColors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 36),
                        RoundedWideButton(
                          onTap: () {
                            _otpFormKey.currentState?.validate();
                          },
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
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    const TextSpan(
                      text: "If you need any help, please reach out to us at ",
                    ),
                    TextSpan(
                      text: "support@bitecope.in",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppColors.lightBlue1),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(AppURLs.supportEmail);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
