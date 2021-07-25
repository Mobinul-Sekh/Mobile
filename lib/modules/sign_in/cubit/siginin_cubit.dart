// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/modules/sign_in/models/signin_reponse_model.dart';
import 'package:bitecope/modules/sign_in/repositories/sign_in_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'signin_state.dart';

class SignInBloc extends Cubit<SignInState> {
  SignInRepository signInRepository;
  SignInBloc({required this.signInRepository}) : super(SignInState());

  void validateSignInPage({
    String? username,
    String? password,
  }) {
    final Map<String, LocaleString?> _errors = {
      "username": _validateUsername(username),
      "password": _validatePassword(password),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(state.copyWith(
      username: BlocFormField(
        username,
        _errors["username"],
      ),
      password: BlocFormField(
        password,
        _errors["password"],
      ),
      signInStatus: _isValid ? SignInStatus.signingIn : SignInStatus.signIn,
    ));

    if (_isValid) {
      loginUser();
    }
  }

  Future<void> loginUser() async {
    final SignInResponseModel? response =
        await signInRepository.signInWithUserNameAndPassword(
      username: state.username.value!,
      password: state.password.value!,
    );
    if (response != null) {
      if (response.token != null) {
        // TODO We'll set the token when we have logout ready
        // signInRepository.setToken(response.token!);
        emit(state.copyWith(signInStatus: SignInStatus.signedIn));
      } else {
        _setErrors(response);
      }
    }
  }

  LocaleString? _validateUsername(String? username) {
    if (username == null || username.trim() == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.usernameEmpty;
    }
    return null;
  }

  LocaleString? _validatePassword(String? password) {
    if (password == null || password == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.passwordEmpty;
    }
    return null;
  }

  void _setErrors(SignInResponseModel response) {
    //TODO Need a list of possible API errors for each field to localize them; for now returning the errors as they are.
    emit(
      state.copyWith(
        username: state.username.copyWith(
          error: response.error != null
              ? (BuildContext context) => response.error
              : null,
        ),
        password: state.password.copyWith(
          error: response.error != null
              ? (BuildContext context) => response.error
              : null,
        ),
        signInStatus: SignInStatus.signIn,
      ),
    );
  }
}
