part of 'sign_up_bloc.dart';

class SignUpState with EquatableMixin {
  late final BlocFormField<String> username;
  late final BlocFormField<String> email;
  late final BlocFormField<String> phoneNumber;
  late final BlocFormField<UserType> userType;
  late final BlocFormField<String> password;
  late final BlocFormField<String> confirmPassword;
  late final BlocFormField<String> recoveryQuestion;
  late final BlocFormField<String> recoveryAnswer;
  late final bool agreedTerms;

  SignUpState({
    BlocFormField<String>? username,
    BlocFormField<String>? email,
    BlocFormField<String>? phoneNumber,
    BlocFormField<UserType>? userType,
    BlocFormField<String>? password,
    BlocFormField<String>? confirmPassword,
    BlocFormField<String>? recoveryQuestion,
    BlocFormField<String>? recoveryAnswer,
    this.agreedTerms = false,
  }) {
    this.username = username ?? BlocFormField();
    this.email = email ?? BlocFormField();
    this.phoneNumber = phoneNumber ?? BlocFormField();
    this.userType = userType ?? BlocFormField();
    this.password = password ?? BlocFormField();
    this.confirmPassword = confirmPassword ?? BlocFormField();
    this.recoveryQuestion = recoveryQuestion ?? BlocFormField();
    this.recoveryAnswer = recoveryAnswer ?? BlocFormField();
  }

  @override
  List<Object> get props => [
        username,
        email,
        phoneNumber,
        userType,
        password,
        confirmPassword,
        recoveryQuestion,
        recoveryAnswer,
        agreedTerms
      ];

  SignUpState copyWith({
    BlocFormField<String>? username,
    BlocFormField<String>? email,
    BlocFormField<String>? phoneNumber,
    BlocFormField<UserType>? userType,
    BlocFormField<String>? password,
    BlocFormField<String>? confirmPassword,
    BlocFormField<String>? recoveryQuestion,
    BlocFormField<String>? recoveryAnswer,
    bool? agreedTerms,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userType: userType ?? this.userType,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      recoveryQuestion: recoveryQuestion ?? this.recoveryQuestion,
      recoveryAnswer: recoveryAnswer ?? this.recoveryAnswer,
      agreedTerms: agreedTerms ?? this.agreedTerms,
    );
  }
}
