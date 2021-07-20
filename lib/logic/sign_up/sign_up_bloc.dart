import 'package:bitecope/data/models/user.dart';
import 'package:bitecope/logic/utils/bloc_form_field.dart';
import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpState());

  void validatePageOne() {
    emit(state.copyWith(
      email: BlocFormField(
        state.email.value,
        _validateEmail(state.email.value),
      ),
      username: BlocFormField(
        state.username.value,
        _validateUsername(state.username.value),
      ),
      phoneNumber: BlocFormField(
        state.phoneNumber.value,
        _validatePhoneNumber(state.phoneNumber.value),
      ),
      password: BlocFormField(
        state.password.value,
        _validatePassword(state.password.value),
      ),
      confirmPassword: BlocFormField(
        state.confirmPassword.value,
        _validateConfirmPassword(
          state.password.value,
          state.confirmPassword.value,
        ),
      ),
    ));
  }

  String? _validateEmail(String? email) {
    if (email == null || email == "") {
      return "Please enter email";
    }
    if (!EmailValidator.validate(email)) {
      return "Please enter a valid email";
    }
    //TODO Check if email exists
    return null;
  }

  String? _validateUsername(String? username) {
    if (username == null || username == "") {
      return "Please enter username";
    }
    //TODO Check if username exists
    return null;
  }

  String? _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber == "") {
      return "Please enter phone number";
    }
    //TODO Check if phone number exists
    return null;
  }

  String? _validatePassword(String? password) {
    if (password == null || password == "") {
      return "Please enter a password";
    }
    if (password.length < 6) {
      return "Password too short";
    }
    return null;
  }

  String? _validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword == "") {
      return "Please re-enter the password";
    }
    if (confirmPassword != password) {
      return "Passwords do not match";
    }
    return null;
  }
}
