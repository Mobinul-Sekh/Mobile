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
}

enum AuthenticationStatus {
  loading,
  loggedIn,
  loggedOut,
}
