// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/common/models/user.dart';
import 'package:bitecope/modules/sign_up/bloc/sign_up_bloc.dart';
import 'package:bitecope/modules/sign_up/components/sign_up_wrapper.dart';
import 'package:bitecope/modules/sign_up/screens/sign_up_complete.dart';
import 'package:bitecope/widgets/form_field_decoration.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';

class SignUpTwo extends StatefulWidget {
  const SignUpTwo({Key? key}) : super(key: key);

  @override
  _SignUpTwoState createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  late List<String> _recoveryQuestions;

  final TextEditingController _recoveryAnswerController =
      TextEditingController();

  String? _selectedQuestion;
  UserType? _userType;

  bool _agreedTerms = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<SignUpBloc>().state;
    _selectedQuestion = state.recoveryQuestion.value;
    _recoveryAnswerController.text = state.recoveryAnswer.value ?? "";
    _userType = state.userType.value;
  }

  @override
  void didChangeDependencies() {
    _recoveryQuestions = [
      AppLocalizations.of(context)!.recoveryQuestion1,
      AppLocalizations.of(context)!.recoveryQuestion2,
      AppLocalizations.of(context)!.recoveryQuestion3,
      AppLocalizations.of(context)!.recoveryQuestion4,
      AppLocalizations.of(context)!.recoveryQuestion5,
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpWrapper(
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.signUpStatus == SignUpStatus.pageOne) {
            Navigator.of(context).maybePop();
          } else if (state.signUpStatus == SignUpStatus.done) {
            // TODO Push to post-sign-up module when it is complete
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SignUpComplete(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.recoveryQuestion,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      DropdownButton<String>(
                        value: _selectedQuestion,
                        isExpanded: true,
                        underline: Container(
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              bottom: BorderSide(
                                color: AppColors.shadowText,
                              ),
                            ),
                          ),
                        ),
                        onChanged: (_question) {
                          setState(() {
                            _selectedQuestion = _question;
                          });
                        },
                        icon: GradientWidget(
                          gradient: AppGradients.primaryGradient,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: const Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 42,
                            ),
                          ),
                        ),
                        items: _recoveryQuestions
                            .map(
                              (_question) => DropdownMenuItem<String>(
                                value: _question,
                                child: Text(
                                  _question,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      if (state.recoveryQuestion.error != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            state.recoveryQuestion.error!(context)!,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: Theme.of(context).errorColor),
                          ),
                        ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _recoveryAnswerController,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: formFieldDecoration(
                          context,
                          labelText:
                              AppLocalizations.of(context)!.recoveryAnswer,
                          errorText: state.recoveryAnswer.error != null
                              ? state.recoveryAnswer.error!(context)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Text(
                        AppLocalizations.of(context)!.userType,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          if (state.userType.error != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                state.userType.error!(context)!,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: Theme.of(context).errorColor),
                              ),
                            ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context)!.owner,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: _userType == UserType.owner
                                        ? AppColors.lightBlue1
                                        : null,
                                  ),
                            ),
                            leading: Radio<UserType>(
                              value: UserType.owner,
                              groupValue: _userType,
                              onChanged: (value) {
                                setState(() {
                                  _userType = value;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.all(0),
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context)!.worker,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: _userType == UserType.worker
                                        ? AppColors.lightBlue1
                                        : null,
                                  ),
                            ),
                            leading: Radio<UserType>(
                              value: UserType.worker,
                              groupValue: _userType,
                              onChanged: (value) {
                                setState(() {
                                  _userType = value;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.all(0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _agreedTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreedTerms = !_agreedTerms;
                          });
                        },
                      ),
                      const SizedBox(width: 12),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.caption,
                          children: [
                            TextSpan(
                                text: AppLocalizations.of(context)!.agreeTerms),
                            TextSpan(
                              text: AppLocalizations.of(context)!.tnc,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: AppColors.lightBlue1,
                                        decoration: TextDecoration.underline,
                                      ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(AppURLs.tnc);
                                },
                            ),
                            TextSpan(text: AppLocalizations.of(context)!.and),
                            TextSpan(
                              text: AppLocalizations.of(context)!.privacyPolicy,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: AppColors.lightBlue1,
                                        decoration: TextDecoration.underline,
                                      ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(AppURLs.privacy);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  signUpButton(state.signUpStatus),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget signUpButton(SignUpStatus status) {
    if (_agreedTerms) {
      return RoundedWideButton(
        onTap: status != SignUpStatus.registering
            ? () {
                context.read<SignUpBloc>().validatePageTwo(
                      recoveryQuestion: _selectedQuestion,
                      recoveryAnswer: _recoveryAnswerController.text,
                      userType: _userType,
                    );
              }
            : null,
        child: status != SignUpStatus.registering
            ? GradientWidget(
                gradient: AppGradients.primaryGradient,
                child: Text(
                  AppLocalizations.of(context)!.signUp,
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
    } else {
      return RoundedWideButton(
        fillColor: Theme.of(context).disabledColor,
        child: Text(
          AppLocalizations.of(context)!.signUp,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  @override
  void dispose() {
    _recoveryAnswerController.dispose();
    super.dispose();
  }
}
