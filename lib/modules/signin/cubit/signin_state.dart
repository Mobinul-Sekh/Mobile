part of 'siginin_cubit.dart';

abstract class SignInState extends Equatable {
  SignInState(this.userName, this.password);
  String? userName;
  String? password;
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {
  SignInInitial(String? userName, String? password) : super(userName, password);
}

class SignInLoading extends SignInState {
  SignInLoading(String? userName, String? password) : super(userName, password);
}

class SignInSuccessful extends SignInState {
  SignInSuccessful(String? userName, String? password)
      : super(userName, password);
}

class SignInFailed extends SignInState {
  SignInFailed(String? userName, String? password) : super(userName, password);
}
