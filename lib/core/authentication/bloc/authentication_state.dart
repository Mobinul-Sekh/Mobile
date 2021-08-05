part of 'authentication_bloc.dart';

class AuthenticationState {
  AuthenticationStatus status;
  _AuthenticationData? authData;

  AuthenticationState({
    this.status = AuthenticationStatus.loading,
    this.authData,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    _AuthenticationData? authData,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      authData: authData ?? this.authData,
    );
  }
}

enum AuthenticationStatus {
  loading,
  loggedIn,
  loggedOut,
  ownerActivate,
  ownerInitialize,
  ownerInactive,
  workerInitialize,
}
