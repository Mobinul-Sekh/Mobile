part of 'siginin_cubit.dart';

class SignInState {
  late final BlocFormField<String> username;
  late final BlocFormField<String> password;
  late final String? token;
  late final String? expiresIn;
  LocaleString? error;
  late SignInStatus signInStatus;

  SignInState(
      {BlocFormField<String>? username,
      BlocFormField<String>? password,
      this.token,
      this.expiresIn,
      this.error,
      this.signInStatus = SignInStatus.signIn}) {
    this.username = username ?? BlocFormField();
    this.password = password ?? BlocFormField();
  }

  SignInState copyWith(
      {BlocFormField<String>? username,
      BlocFormField<String>? password,
      String? token,
      String? expiresIn,
      LocaleString? error,
      SignInStatus? signInStatus}) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      expiresIn: expiresIn ?? this.expiresIn,
      error: error ?? this.error,
      signInStatus: signInStatus ?? this.signInStatus,
    );
  }
}

enum SignInStatus {
  signIn,
  signingIn,
  verify,
  ownerActivate,
  ownerInactive,
  signedIn,
}
