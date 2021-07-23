part of 'sign_up_bloc.dart';

class SignUpState with EquatableMixin {
  late final BlocFormField<String> username;
  late final BlocFormField<String> email;
  late final BlocFormField<String> phoneNumber;
  late final BlocFormField<String> password;
  late final BlocFormField<String> confirmPassword;
  late final BlocFormField<String> recoveryQuestion;
  late final BlocFormField<String> recoveryAnswer;
  late final BlocFormField<UserType> userType;
  late final BlocFormField<String> ownerName;
  SignUpStatus signUpStatus;

  SignUpState({
    BlocFormField<String>? username,
    BlocFormField<String>? email,
    BlocFormField<String>? phoneNumber,
    BlocFormField<String>? password,
    BlocFormField<String>? confirmPassword,
    BlocFormField<String>? recoveryQuestion,
    BlocFormField<String>? recoveryAnswer,
    BlocFormField<UserType>? userType,
    BlocFormField<String>? ownerName,
    this.signUpStatus = SignUpStatus.pageOne,
  }) {
    this.username = username ?? BlocFormField();
    this.email = email ?? BlocFormField();
    this.phoneNumber = phoneNumber ?? BlocFormField();
    this.password = password ?? BlocFormField();
    this.confirmPassword = confirmPassword ?? BlocFormField();
    this.recoveryQuestion = recoveryQuestion ?? BlocFormField();
    this.recoveryAnswer = recoveryAnswer ?? BlocFormField();
    this.ownerName = ownerName ?? BlocFormField();
    this.userType = userType ?? BlocFormField();
  }

  @override
  List<Object> get props => [
        username,
        email,
        phoneNumber,
        password,
        confirmPassword,
        recoveryQuestion,
        recoveryAnswer,
        userType,
        ownerName,
        signUpStatus,
      ];

  SignUpState copyWith({
    BlocFormField<String>? username,
    BlocFormField<String>? email,
    BlocFormField<String>? phoneNumber,
    BlocFormField<String>? password,
    BlocFormField<String>? confirmPassword,
    BlocFormField<String>? recoveryQuestion,
    BlocFormField<String>? recoveryAnswer,
    BlocFormField<UserType>? userType,
    BlocFormField<String>? ownerName,
    SignUpStatus? signUpStatus,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      recoveryQuestion: recoveryQuestion ?? this.recoveryQuestion,
      recoveryAnswer: recoveryAnswer ?? this.recoveryAnswer,
      userType: userType ?? this.userType,
      ownerName: ownerName ?? this.ownerName,
      signUpStatus: signUpStatus ?? this.signUpStatus,
    );
  }
}

enum SignUpStatus {
  pageOne,
  pageOneValidated,
  pageTwo,
  pageTwoValidated,
  registering,
  done,
}
