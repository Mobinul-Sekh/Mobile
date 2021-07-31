// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/core/common/models/account_status_response.dart';
import 'package:bitecope/modules/sign_in/models/signin_reponse_model.dart';
import 'package:bitecope/modules/sign_in/repositories/sign_in_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'signin_state.dart';

class SignInBloc extends Cubit<SignInState> {
  final SignInRepository _signInRepository;

  SignInBloc(this._signInRepository) : super(SignInState());

  Future<void> validateSignInPage({
    String? username,
    String? password,
  }) async {
    final String? _username = username?.trim();

    final Map<String, LocaleString?> _errors = {
      "username": _validateUsername(_username),
      "password": _validatePassword(password),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(state.copyWith(
      username: BlocFormField(
        _username,
        _errors["username"],
      ),
      password: BlocFormField(
        password,
        _errors["password"],
      ),
      error: _isValid
          ? null
          : (BuildContext context) =>
              AppLocalizations.of(context)!.signInFieldEmpty,
      signInStatus: _isValid ? SignInStatus.signingIn : SignInStatus.signIn,
    ));

    if (_isValid) {
      final AccountStatusResponse? response =
          await _signInRepository.accountStatus(
        username: _username!,
      );
      if (response == null) {
        return;
      }
      if (!response.status) {
        String? _error(BuildContext context) => response.error;

        emit(state.copyWith(
          username: state.username.copyWith(error: _error),
          password: state.password.copyWith(error: _error),
          error: _error,
          signInStatus: SignInStatus.signIn,
        ));
        return;
      }

      final bool _emailStatus = _isEmailVerified(response);
      final bool _activeStatus = _isActive(response);
      if (_emailStatus && _activeStatus) {
        _loginUser();
      }
    }
  }

  bool _isEmailVerified(AccountStatusResponse accountStatus) {
    if (!accountStatus.mailStatus!) {
      emit(state.copyWith(signInStatus: SignInStatus.verify));
      return false;
    }
    return true;
  }

  bool _isActive(AccountStatusResponse accountStatus) {
    if (!accountStatus.activeStatus!) {
      if (accountStatus.userType == 0) {
        emit(state.copyWith(
          signInStatus: SignInStatus.ownerActivate,
        ));
      } else {
        emit(state.copyWith(
          error: (BuildContext context) =>
              AppLocalizations.of(context)!.inactiveOwner,
          signInStatus: SignInStatus.ownerInactive,
        ));
      }
      return false;
    }
    return true;
  }

  Future<void> _loginUser() async {
    final SignInResponseModel? response =
        await _signInRepository.signInWithUserNameAndPassword(
      username: state.username.value!,
      password: state.password.value!,
    );
    if (response != null) {
      if (response.token != null) {
        emit(state.copyWith(
          signInStatus: SignInStatus.signedIn,
          token: response.token,
          expiresIn: response.expiresIn,
        ));
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
    String? _error(BuildContext context) {
      return response.error;
    }

    emit(
      state.copyWith(
        username: state.username.copyWith(
          error: _error,
        ),
        password: state.password.copyWith(
          error: _error,
        ),
        error: _error,
        signInStatus: SignInStatus.signIn,
      ),
    );
  }
}
