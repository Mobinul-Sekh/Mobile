part of 'authentication_bloc.dart';

class AuthenticationState with EquatableMixin {
  AuthenticationStatus status;
  String? username;
  String? token;

  AuthenticationState({
    this.status = AuthenticationStatus.loading,
    this.username,
    this.token,
  });

  @override
  List<Object?> get props => [status, username, token];
}

enum AuthenticationStatus {
  loading,
  loggedIn,
  loggedOut,
}
