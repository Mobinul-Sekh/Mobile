import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
}
