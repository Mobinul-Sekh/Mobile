class SignUpRequest {
  String email;
  String username;
  String phoneNumber;
  String password;
  String confirmPassword;
  String recoveryQuestion;
  String recoveryAnswer;
  String userType;

  SignUpRequest({
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.recoveryQuestion,
    required this.recoveryAnswer,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'phone_no': phoneNumber,
      'password': password,
      'confirm_password': confirmPassword,
      'recovery_question': recoveryQuestion,
      'recovery_answer': recoveryAnswer,
      'user_type': userType,
    };
  }
}
