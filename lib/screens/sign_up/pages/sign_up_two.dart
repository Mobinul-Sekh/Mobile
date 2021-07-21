import 'package:bitecope/config/constants.dart';
import 'package:bitecope/config/theme.dart';
import 'package:bitecope/data/models/user.dart';
import 'package:bitecope/logic/sign_up/sign_up_bloc.dart';
import 'package:bitecope/screens/sign_up/components/form_field_decoration.dart';
import 'package:bitecope/screens/sign_up/components/sign_up_wrapper.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpTwo extends StatefulWidget {
  const SignUpTwo({Key? key}) : super(key: key);

  @override
  _SignUpTwoState createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  late List<String> _recoveryQuestions;

  final TextEditingController _recoveryAnswerController =
      TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();

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
    _ownerNameController.text = state.ownerName.value ?? "";
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
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
                        style: Theme.of(context).textTheme.subtitle2,
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
                            margin: const EdgeInsets.symmetric(vertical: 6),
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
                        style: Theme.of(context).textTheme.subtitle2,
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
                      if (_userType == UserType.worker) ...[
                        const SizedBox(height: 18),
                        TextField(
                          controller: _ownerNameController,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: formFieldDecoration(
                            context,
                            labelText: AppLocalizations.of(context)!.ownerName,
                            errorText: state.ownerName.error != null
                                ? state.ownerName.error!(context)
                                : null,
                            suffixIcon: Icons.person,
                          ),
                        ),
                        const SizedBox(height: 18),
                      ]
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    leading: Checkbox(
                      value: _agreedTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreedTerms = !_agreedTerms;
                        });
                      },
                    ),
                    title: RichText(
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
                                launch(AppConstants.tncURL);
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
                                launch(AppConstants.privacyURL);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  signUpButton(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget signUpButton() {
    if (_agreedTerms) {
      return RoundedWideButton(
        onTap: () {
          final bool _isValid = context.read<SignUpBloc>().validatePageTwo(
                recoveryQuestion: _selectedQuestion,
                recoveryAnswer: _recoveryAnswerController.text,
                userType: _userType,
                ownerName: _ownerNameController.text,
              );
          if (_isValid) {
            Navigator.of(context).pop();
          }
        },
        child: GradientWidget(
          gradient: AppGradients.primaryGradient,
          child: Text(
            AppLocalizations.of(context)!.signUp,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return RoundedWideButton(
        fillColor: Theme.of(context).disabledColor,
        child: Text(
          AppLocalizations.of(context)!.signUp,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  @override
  void dispose() {
    _recoveryAnswerController.dispose();
    _ownerNameController.dispose();
    super.dispose();
  }
}
