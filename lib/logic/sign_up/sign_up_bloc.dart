import 'package:bitecope/config/typedefs.dart';
import 'package:bitecope/data/models/user.dart';
import 'package:bitecope/logic/utils/bloc_form_field.dart';
import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpState());

  bool validatePageOne({
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
    ));

    return !_errors.values.any((_error) => _error != null);
  }

  bool validatePageTwo({
    String? recoveryQuestion,
    String? recoveryAnswer,
    UserType? userType,
    String? ownerName,
  }) {
    final Map<String, LocaleString?> _errors = {
      "recoveryQuestion": _validateRecoveryQuestion(recoveryQuestion),
      "recoveryAnswer": _validateRecoveryAnswer(recoveryAnswer),
      "userType": _validateUserType(userType),
      "ownerName": _validateOwnerName(userType, ownerName),
    };

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
      ownerName: BlocFormField(
        ownerName,
        _errors["ownerName"],
      ),
    ));

    return !_errors.values.any((_error) => _error != null);
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

  LocaleString? _validateOwnerName(UserType? userType, String? ownerName) {
    if (userType == UserType.worker &&
        (ownerName == null || ownerName.trim() == "")) {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.ownerNameEmpty;
    }
    return null;
  }
}
