part of 'authentication_bloc.dart';

class AuthenticationState {
  AuthenticationStatus status;
  String? username;
  String? token;

  AuthenticationState({
    this.status = AuthenticationStatus.loading,
    this.username,
    this.token,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    String? username,
    String? token,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      username: username ?? this.username,
      token: token ?? this.token,
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
