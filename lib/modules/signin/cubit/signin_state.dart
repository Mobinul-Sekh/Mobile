part of 'siginin_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInSuccessful extends SignInState {}

class SignInFailed extends SignInState {}

class Loading extends SignInState {}
