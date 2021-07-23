// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/core/authentication/models/user.dart';
import 'package:bitecope/modules/sign_up/models/sign_up_response.dart';
import 'package:bitecope/modules/sign_up/repositories/sign_up_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpRepository accountRepository;

  SignUpBloc({required this.accountRepository}) : super(SignUpState());

  void validatePageOne({
    String? email,
    String? username,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
  }) {
    final Map<String, LocaleString?> _errors = {
      "email": _validateEmail(email),
      "username": _validateUsername(username),
      "phoneNumber": _validatePhoneNumber(phoneNumber),
      "password": _validatePassword(password),
      "confirmPassword": _validateConfirmPassword(password, confirmPassword),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(state.copyWith(
      email: BlocFormField(
        email,
        _errors["email"],
      ),
      username: BlocFormField(
        username,
        _errors["username"],
      ),
      phoneNumber: BlocFormField(
        phoneNumber,
        _errors["phoneNumber"],
      ),
      password: BlocFormField(
        password,
        _errors["password"],
      ),
      confirmPassword: BlocFormField(
        confirmPassword,
        _errors["confirmPassword"],
      ),
      signUpStatus:
          _isValid ? SignUpStatus.pageOneValidated : SignUpStatus.pageOne,
    ));
  }

  void validatePageTwo({
    String? recoveryQuestion,
    String? recoveryAnswer,
    UserType? userType,
  }) {
    final Map<String, LocaleString?> _errors = {
      "recoveryQuestion": _validateRecoveryQuestion(recoveryQuestion),
      "recoveryAnswer": _validateRecoveryAnswer(recoveryAnswer),
      "userType": _validateUserType(userType),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(state.copyWith(
      recoveryQuestion: BlocFormField(
        recoveryQuestion,
        _errors["recoveryQuestion"],
      ),
      recoveryAnswer: BlocFormField(
        recoveryAnswer,
        _errors["recoveryAnswer"],
      ),
      userType: BlocFormField(
        userType,
        _errors["userType"],
      ),
      signUpStatus:
          _isValid ? SignUpStatus.pageTwoValidated : SignUpStatus.pageTwo,
    ));

    if (_isValid) {
      registerUser();
    }
  }

  Future<void> registerUser() async {
    emit(state.copyWith(signUpStatus: SignUpStatus.registering));

    final SignUpResponse? response = await accountRepository.registerUser(
      username: state.username.value!,
      email: state.email.value!,
      phoneNumber: state.phoneNumber.value!,
      password: state.password.value!,
      confirmPassword: state.confirmPassword.value!,
      recoveryQuestion: state.recoveryQuestion.value!,
      recoveryAnswer: state.recoveryAnswer.value!,
      userType: state.userType.value!,
    );
    if (response != null) {
      if (response.token != null) {
        // TODO Set token after home and post-sign-up/in modules are complete
        // accountRepository.setToken(response.token!);
        emit(state.copyWith(signUpStatus: SignUpStatus.done));
      } else {
        _setErrors(response);
      }
    }
  }

  LocaleString? _validateEmail(String? email) {
    if (email == null || email == "") {
      return (BuildContext context) => AppLocalizations.of(context)!.emailEmpty;
    }
    if (!EmailValidator.validate(email.trim())) {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.emailInvalid;
    }
    return null;
  }

  LocaleString? _validateUsername(String? username) {
    if (username == null || username.trim() == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.usernameEmpty;
    }
    return null;
  }

  LocaleString? _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim() == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.phoneNumberEmpty;
    }
    return null;
  }

  LocaleString? _validatePassword(String? password) {
    if (password == null || password == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.passwordEmpty;
    }
    if (password.length < 6) {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.passwordWeak;
    }
    return null;
  }

  LocaleString? _validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.confirmPasswordEmpty;
    }
    if (confirmPassword != password) {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.confirmPasswordMismatch;
    }
    return null;
  }

  LocaleString? _validateRecoveryQuestion(String? recoveryQuestion) {
    if (recoveryQuestion == null || recoveryQuestion.trim() == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.recoveryQuestionEmpty;
    }
    return null;
  }

  LocaleString? _validateRecoveryAnswer(String? recoveryAnswer) {
    if (recoveryAnswer == null || recoveryAnswer.trim() == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.recoveryAnswerEmpty;
    }
    return null;
  }

  LocaleString? _validateUserType(UserType? userType) {
    if (userType == null) {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.userTypeEmpty;
    }
    return null;
  }

  void _setErrors(SignUpResponse response) {
    //TODO Need a list of possible API errors for each field to localize them; for now returning the errors as they are.
    bool _goToPageOne = false;
    emit(state.copyWith(
      email: state.email.copyWith(
        error: response.emailErr != null
            ? () {
                _goToPageOne = true;
                return (BuildContext context) => response.emailErr;
              }()
            : null,
      ),
      username: state.username.copyWith(
        error: response.usernameErr != null
            ? () {
                _goToPageOne = true;
                return (BuildContext context) => response.usernameErr;
              }()
            : null,
      ),
      phoneNumber: state.phoneNumber.copyWith(
        error: response.phoneNumberErr != null
            ? () {
                _goToPageOne = true;
                return (BuildContext context) => response.phoneNumberErr;
              }()
            : null,
      ),
      password: state.password.copyWith(
        error: response.passwordErr != null
            ? () {
                _goToPageOne = true;
                return (BuildContext context) => response.passwordErr;
              }()
            : null,
      ),
      confirmPassword: state.confirmPassword.copyWith(
        error: response.confirmPasswordErr != null
            ? () {
                _goToPageOne = true;
                return (BuildContext context) => response.confirmPasswordErr;
              }()
            : null,
      ),
      recoveryQuestion: state.recoveryQuestion.copyWith(
        error: response.recoveryQuestionErr != null
            ? (BuildContext context) => response.recoveryQuestionErr
            : null,
      ),
      recoveryAnswer: state.recoveryAnswer.copyWith(
        error: response.recoveryAnswerErr != null
            ? (BuildContext context) => response.recoveryAnswerErr
            : null,
      ),
      userType: state.userType.copyWith(
        error: response.userTypeErr != null
            ? (BuildContext context) => response.userTypeErr
            : null,
      ),
      signUpStatus: _goToPageOne ? SignUpStatus.pageOne : SignUpStatus.pageTwo,
    ));
  }
}
