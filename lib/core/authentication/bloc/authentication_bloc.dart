// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bitecope/core/common/models/logout_response.dart';
import 'package:bloc/bloc.dart';

// Project imports:
import 'package:bitecope/core/common/models/account_status_response.dart';
import 'package:bitecope/core/common/repositories/common_repository.dart';

// Project imports:

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  final CommonRepository _commonRepository;

  AuthenticationBloc(this._commonRepository) : super(AuthenticationState()) {
    setStatus();
  }

  Future<void> setStatus([_AuthenticationData? _authenticationData]) async {
    _AuthenticationData? _authData;
    if (_authenticationData == null) {
      final String? _username = await _commonRepository.getUsername();
      final String? _token = await _commonRepository.getToken();
      final DateTime? _expiry =
          DateTime.tryParse(await _commonRepository.getExpiry() ?? "");
      if (_username != null && _token != null && _expiry != null) {
        _authData = _AuthenticationData(_username, _token, _expiry);
      }
    } else {
      _authData = _authenticationData;
      await _commonRepository.setToken(_authData.token);
      await _commonRepository.setUsername(_authData.username);
      await _commonRepository.setExpiry(_authData.expiry.toString());
    }
    if (_authData == null) {
      emit(
        AuthenticationState(
          status: AuthenticationStatus.loggedOut,
        ),
      );
    } else {
      final AccountStatusResponse? response =
          await _commonRepository.accountStatus(username: _authData.username);
      if (response == null || !response.status) {
        return;
      } else {
        if (response.userType == 0) {
          if (!response.activeStatus!) {
            emit(state.copyWith(status: AuthenticationStatus.ownerActivate));
            return;
          }
          if (response.ownerStatus == null) {
            emit(state.copyWith(status: AuthenticationStatus.ownerInitialize));
            return;
          }
        } else if (response.userType == 1) {
          if (response.workerStatus == null) {
            emit(state.copyWith(status: AuthenticationStatus.workerInitialize));
            return;
          }
          if (!response.activeStatus!) {
            emit(state.copyWith(status: AuthenticationStatus.ownerInactive));
            return;
          }
        }
        emit(state.copyWith(status: AuthenticationStatus.loggedIn));
      }
    }
  }

  void signedIn(String username, String token, String expiresIn) {
    final int _duration = double.parse(expiresIn).toInt();
    final DateTime _expiry = DateTime.now().add(Duration(seconds: _duration));
    final _AuthenticationData _authenticationData =
        _AuthenticationData(username, token, _expiry);
    setStatus(_authenticationData);
  }

  Future<bool?> logout() async {
    final LogoutResponse? response = await _commonRepository.logout();
    if (response != null) {
      if (response.status) {
        emit(AuthenticationState(status: AuthenticationStatus.loggedOut));
      }
      return response.status;
    }
  }
}

class _AuthenticationData {
  String username;
  String token;
  DateTime expiry;

  _AuthenticationData(this.username, this.token, this.expiry);
}
