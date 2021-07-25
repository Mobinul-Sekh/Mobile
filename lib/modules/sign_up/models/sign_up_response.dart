// Dart imports:
import 'dart:convert';

class SignUpResponse {
  String? token;
  String? emailErr;
  String? usernameErr;
  String? phoneNumberErr;
  String? passwordErr;
  String? confirmPasswordErr;
  String? recoveryQuestionErr;
  String? recoveryAnswerErr;
  String? userTypeErr;

  SignUpResponse({
    this.token,
    this.emailErr,
    this.usernameErr,
    this.phoneNumberErr,
    this.passwordErr,
    this.confirmPasswordErr,
    this.recoveryQuestionErr,
    this.recoveryAnswerErr,
    this.userTypeErr,
  });

  factory SignUpResponse.fromMap(Map<String, dynamic> map) {
    return SignUpResponse(
      token: map['token'] != null ? map['token'][0] as String : null,
      emailErr: map['email'] != null ? map['email'][0] as String : null,
      usernameErr:
          map['username'] != null ? map['username'][0] as String : null,
      phoneNumberErr:
          map['phone_no'] != null ? map['phone_no'][0] as String : null,
      passwordErr:
          map['password'] != null ? map['password'][0] as String : null,
      confirmPasswordErr: map['confirm_password'] != null
          ? map['confirm_password'][0] as String
          : null,
      recoveryQuestionErr: map['recovery_question'] != null
          ? map['recovery_question'][0] as String
          : null,
      recoveryAnswerErr: map['recovery_answer'] != null
          ? map['recovery_answer'][0] as String
          : null,
      userTypeErr:
          map['user_type'] != null ? map['user_type'][0] as String : null,
    );
  }

  factory SignUpResponse.fromJson(String source) =>
      SignUpResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
