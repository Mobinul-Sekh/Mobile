// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:bitecope/config/constants/app_texts.dart';
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/config/utils/extensions/int_extension.dart';
import 'package:bitecope/modules/verify_email/bloc/verify_email_bloc.dart';
import 'package:bitecope/modules/verify_email/components/otp_text_fields.dart';
import 'package:bitecope/widgets/gradient_button.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:bitecope/widgets/snackbar_message.dart';
import 'package:bitecope/widgets/successfully_completed.dart';
import 'package:bitecope/widgets/underlined_title.dart';

class VerifyEmailArguments {
  String username;

  VerifyEmailArguments({required this.username});
}

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> with WidgetsBindingObserver {
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  bool _runStatusCheck = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {
          _runStatusCheck = true;
        });
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        setState(() {
          _runStatusCheck = false;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: Column(
            children: [
              UnderlinedTitle(
                title: AppLocalizations.of(context)!.verifyEmail,
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
                      listener: (context, state) {
                        _handleListen(context, state);
                      },
                      builder: (context, state) {
                        context
                            .read<VerifyEmailBloc>()
                            .checkStatus(run: _runStatusCheck);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GradientWidget(
                              gradient: AppGradients.primaryLinear,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .checkInbox
                                    .toUpperCase(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            const SizedBox(height: 36),
                            Text(AppLocalizations.of(context)!.enterOTP),
                            const SizedBox(height: 18),
                            OTPTextFields(
                              digitCount: 9,
                              formKey: _otpFormKey,
                              controller: _otpController,
                              error: state.otp.error != null
                                  ? state.otp.error!(context)
                                  : null,
                            ),
                            const SizedBox(height: 18),
                            _resendOTP(context, state),
                            const SizedBox(height: 36),
                            _confirmButton(context, state),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.contactSupport,
                    ),
                    TextSpan(
                      text: AppTexts.supportEmail,
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

  void _handleListen(BuildContext context, VerifyEmailState state) {
    if (state.resendOTPStatus == ResendOTPStatus.success) {
      snackbarMessage(
        context,
        AppLocalizations.of(context)!.resentOTP,
        MessageType.success,
      );
    } else if (state.resendOTPStatus == ResendOTPStatus.fail) {
      snackbarMessage(
        context,
        AppLocalizations.of(context)!.resendOTPFailed,
        MessageType.failed,
      );
    }
    if (state.verifyEmailStatus == VerifyEmailStatus.done) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return SuccessfullyCompleted(
            successTitle: AppLocalizations.of(context)!.emailVerified,
            nextText: AppLocalizations.of(context)!.backToLogin,
            nextCallback: () =>
                Navigator.of(context).pushReplacementNamed('/signIn'),
          );
        }),
        ModalRoute.withName('/'),
      );
    }
  }

  RichText _resendOTP(BuildContext context, VerifyEmailState state) {
    if (state.timeout == null) {
      return RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            TextSpan(
              text: AppLocalizations.of(context)!.noOTP,
            ),
            TextSpan(
              text: AppLocalizations.of(context)!.resendOTP,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: AppColors.lightBlue1),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: context.read<VerifyEmailBloc>(),
                      child: _confirmResendOTP(),
                    ),
                  );
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
          TextSpan(
            text: AppLocalizations.of(context)!.resendOTPTimer,
          ),
          TextSpan(
            text: state.timeout!.toMinSec(),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }

  RoundedWideButton _confirmButton(
    BuildContext context,
    VerifyEmailState state,
  ) {
    return RoundedWideButton(
      onTap: state.verifyEmailStatus == VerifyEmailStatus.verifying
          ? null
          : () {
              if (_otpFormKey.currentState!.validate()) {
                context
                    .read<VerifyEmailBloc>()
                    .validateOTP(_otpController.text);
              }
            },
      child: state.verifyEmailStatus == VerifyEmailStatus.verifying
          ? const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(),
            )
          : Text(
              AppLocalizations.of(context)!.confirm,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: AppColors.white),
            ),
    );
  }

  Widget _confirmResendOTP() {
    return BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
      listener: (context, state) {
        if (state.resendOTPStatus == ResendOTPStatus.success ||
            state.resendOTPStatus == ResendOTPStatus.fail) {
          Navigator.of(context).maybePop();
        }
      },
      builder: (context, state) {
        return AlertDialog(
          elevation: 18.0,
          title: Text(
            "${AppLocalizations.of(context)!.resendOTP}?",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Text(
            AppLocalizations.of(context)!.confirmResendOTP,
            style: Theme.of(context).textTheme.caption,
          ),
          actions: [
            GradientButton(
              onTap: () => Navigator.of(context).maybePop(),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: AppColors.red),
              ),
            ),
            GradientButton(
              onTap: state.resendOTPStatus != ResendOTPStatus.resending
                  ? () => context.read<VerifyEmailBloc>().resendOTP()
                  : null,
              backgroundGradient: AppGradients.primaryLinear,
              child: state.resendOTPStatus != ResendOTPStatus.resending
                  ? Text(
                      AppLocalizations.of(context)!.resend,
                      style: Theme.of(context).textTheme.button,
                    )
                  : const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
