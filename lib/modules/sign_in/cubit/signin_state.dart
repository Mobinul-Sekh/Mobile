part of 'siginin_cubit.dart';

class SignInState {
  late final BlocFormField<String> username;
  late final BlocFormField<String> password;
  LocaleString? error;
  late SignInStatus signInStatus;

  SignInState(
      {BlocFormField<String>? username,
      BlocFormField<String>? password,
      this.error,
      this.signInStatus = SignInStatus.signIn}) {
    this.username = username ?? BlocFormField();
    this.password = password ?? BlocFormField();
  }

  SignInState copyWith(
      {BlocFormField<String>? username,
      BlocFormField<String>? password,
      LocaleString? error,
      SignInStatus? signInStatus}) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      error: error ?? this.error,
      signInStatus: signInStatus ?? this.signInStatus,
    );
  }
}

enum SignInStatus {
  signIn,
  signingIn,
  verify,
  activate,
  ownerInitialize,
  workerInitialize,
  signedIn,
}
